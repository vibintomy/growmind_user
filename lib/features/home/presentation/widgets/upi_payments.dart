import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentScreen extends StatefulWidget {
  final String courseId;
  final String createdBy;

  PaymentScreen({required this.courseId, required this.createdBy});

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

    // Event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Trigger payment automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      openCheckout();
    });
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_F94zuwkEe8DLrJ',
      'amount': 1000,
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
    print('✅ Payment Success: ${response.paymentId}');

    User? user = _auth.currentUser;
    if (user != null) {
      try {
        String userId = user.uid;
        String courseId = widget.courseId;
        DateTime now = DateTime.now();

        // ✅ Update 'purchasedCourses' in the users collection
        await _firestore.collection('users').doc(userId).set({
          'purchasedCourses': FieldValue.arrayUnion([courseId])
        }, SetOptions(merge: true));
        print("✅ Course $courseId added to user's purchasedCourses.");

        DocumentReference courseRef =
            _firestore.collection('courses').doc(courseId);

        await _firestore.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(courseRef);

          if (!snapshot.exists) {
            transaction.set(courseRef, {'purchasesCount': 1});
          } else {
            Map<String, dynamic> courseData =
                snapshot.data() as Map<String, dynamic>;
            if (!courseData.containsKey('purchasesCount')) {
              transaction.update(courseRef, {'purchasesCount': 1});
            } else {
              int currentCount = courseData['purchasesCount'] ?? 0;
              transaction
                  .update(courseRef, {'purchasesCount': currentCount + 1});
            }
          }
        });

        DocumentReference tutorRef =
            _firestore.collection('tutors').doc(widget.createdBy);

        await _firestore.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(tutorRef);

          if (!snapshot.exists) {
            transaction.set(tutorRef, {
              'totalusers': 1,
              'joiners': [userId],
              'joinDateTime': {userId: now.toIso8601String()}
            });
          } else {
            Map<String, dynamic> tutorData =
                snapshot.data() as Map<String, dynamic>;
            List<dynamic> joiners = tutorData['joiners'] ?? [];
            Map<String, dynamic> joinDateTime = tutorData['joinDateTime'] ?? {};
            int totaluser = (tutorData['totalusers'] ?? 0) as int;
            joiners.add(userId);
            joinDateTime[userId] = now.toIso8601String();
           
            transaction.update(tutorRef, {
              'joiners': joiners,
              'joinDateTime': joinDateTime,
              'totalusers': totaluser+1
            });

          
          }
        });
      } catch (e) {
        throw Exception("❌ Firestore Error: $e");
      }
    } else {
      throw Exception("❌ No authenticated user found.");
    }

    Navigator.pop(context, false);
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
    _razorpay.clear(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Processing Payment...')),
      body: const Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      ),
    );
  }
}
