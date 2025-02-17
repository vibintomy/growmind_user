import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentScreen extends StatefulWidget {
  final String courseId; // Course ID passed when opening this screen

  PaymentScreen({required this.courseId});

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
      'amount': 1000, // Amount in paise (1000 paise = ₹10)
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
    print('Payment Success: ${response.paymentId}');

    // Get current user
    User? user = _auth.currentUser;
    if (user != null) {
      // Update Firestore collection 'users'
      await _firestore.collection('users').doc(user.uid).set({
        'purchasedCourses': FieldValue.arrayUnion([widget.courseId])
      }, SetOptions(merge: true));

      print("Course ${widget.courseId} added to purchasedCourses.");
    }

    Navigator.pop(context, true);
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
      appBar: AppBar(title: Text('Processing Payment...')),
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      ),
    );
  }
}
