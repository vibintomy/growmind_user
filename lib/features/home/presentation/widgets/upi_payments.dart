import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:growmind/features/home/domain/entities/section_entity.dart';
import 'package:growmind/features/home/presentation/pages/curriculum.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentScreen extends StatefulWidget {
  final String courseId;
  final String createdBy;
  final String courseName;
  final int coursePrice;
   final List<SectionEntity> section;

  PaymentScreen({
    required this.courseId,
    required this.createdBy,
    required this.courseName,
    required this.coursePrice,
    required this.section
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      openCheckout();
    });
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_F94zuwkEe8DLrJ',
      'amount': widget.coursePrice * 100,
      'name': 'Your App Name',
      'description': 'Payment for Course #${widget.courseId}',
      'prefill': {
        'contact': '9876543210',
        'email': 'user@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        String userId = user.uid;
        String courseId = widget.courseId;
        String courseName = widget.courseName;
        int coursePrice = widget.coursePrice;
        DateTime now = DateTime.now();

        await _firestore.collection('users').doc(userId).set({
          'mentor': FieldValue.arrayUnion([widget.createdBy]),
          'purchasedCourses': FieldValue.arrayUnion([courseId])
        }, SetOptions(merge: true));

        DocumentReference courseRef =
            _firestore.collection('courses').doc(courseId);
        await _firestore.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(courseRef);
          int currentCount =
              snapshot.exists ? (snapshot['purchasesCount'] ?? 0) : 0;
          transaction.set(courseRef, {'purchasesCount': currentCount + 1},
              SetOptions(merge: true));
        });

        DocumentReference tutorRef =
            _firestore.collection('tutors').doc(widget.createdBy);
        await _firestore.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(tutorRef);
          List<dynamic> joiners =
              snapshot.exists ? (snapshot['joiners'] ?? []) : [];
          int totalUsers = snapshot.exists ? (snapshot['totalusers'] ?? 0) : 0;
          joiners.add(userId);
          transaction.set(
              tutorRef,
              {
                'joiners': joiners,
                'totalusers': totalUsers + 1,
                'joinDateTime': {userId: now.toIso8601String()}
              },
              SetOptions(merge: true));
        });

        DocumentReference adminRef =
            _firestore.collection('admin').doc('stats');

        // **Step 1: Ensure 'admin/stats' exists**
        DocumentSnapshot adminSnapshot = await adminRef.get();
        if (!adminSnapshot.exists) {
          await adminRef.set({'totalRevenue': 0, 'courses': {}});
          print("✅ 'admin/stats' document created successfully.");
        }

        // **Step 2: Get 'admin/stats' after creation**
        adminSnapshot = await adminRef.get();
        if (!adminSnapshot.exists) {
          throw Exception("❌ Failed to create 'admin/stats'.");
        }

        // **Step 3: Extract fields safely**
        int currentRevenue =
            (adminSnapshot.data() as Map<String, dynamic>)['totalRevenue'] ?? 0;
        Map<String, dynamic> courses =
            (adminSnapshot.data() as Map<String, dynamic>)['courses'] ?? {};

        // **Step 4: Update Firestore inside transaction**
        await _firestore.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(adminRef);

          if (!snapshot.exists) {
            throw Exception(
                "❌ 'admin/stats' document is missing inside transaction.");
          }

          int newRevenue = (snapshot['totalRevenue'] ?? 0) + coursePrice;
          if (courses.containsKey(courseId)) {
            courses[courseId]['purchases'] =
                (courses[courseId]['purchases'] ?? 0) + 1;
            courses[courseId]['revenue'] =
                (courses[courseId]['revenue'] ?? 0) + coursePrice;
          } else {
            courses[courseId] = {
              'name': courseName,
              'purchases': 1,
              'revenue': coursePrice
            };
          }

          transaction.set(
              adminRef,
              {'totalRevenue': newRevenue, 'courses': courses},
              SetOptions(merge: true));
        });

        print("✅ Payment processed successfully!");
      } catch (e) {
        print("❌ Firestore Error: $e");
        throw Exception("❌ Firestore Error: $e");
      }
    } else {
      throw Exception("❌ No authenticated user found.");
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Course Purchased',
        message: 'You are sucessfully purchased the course',
        contentType: ContentType.success,
      ),
    ));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Curriculum(
                section: widget.section,
                courseId: widget.courseId,
                coursePrice: widget.coursePrice.toString())));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.code} - ${response.message}');
    Navigator.pop(context, false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Processing Payment...')),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
