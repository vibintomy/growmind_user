import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:growmind/features/home/domain/entities/section_entity.dart';
import 'package:growmind/features/home/presentation/pages/curriculum.dart';
import 'package:growmind/features/home/presentation/widgets/payment_services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class PaymentScreen extends StatefulWidget {
  final String courseId;
  final String createdBy;
  final String courseName;
  final int coursePrice;
  final List<SectionEntity> section;

  const PaymentScreen({
    Key? key,
    required this.courseId,
    required this.createdBy,
    required this.courseName,
    required this.coursePrice,
    required this.section,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  final PaymentService _paymentService = PaymentService();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Initiate payment after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initiatePayment();
    });
  }

  void _initiatePayment() {
    if (mounted) {
      setState(() {
        _isProcessing = true;
      });
    }

    try {
      final options = _paymentService.getRazorpayOptions(
        courseId: widget.courseId,
        coursePrice: widget.coursePrice,
      );
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error initiating payment: $e');
      _showErrorMessage('Failed to initiate payment. Please try again.');
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (mounted) {
      setState(() {
        _isProcessing = true;
      });
    }

    try {
      await _paymentService.processSuccessfulPayment(
        courseId: widget.courseId,
        createdBy: widget.createdBy,
        courseName: widget.courseName,
        coursePrice: widget.coursePrice,
      );

      if (mounted) {
        _showSuccessMessage('You have successfully purchased the course');
        
        // Navigate to curriculum page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Curriculum(
              section: widget.section,
              courseId: widget.courseId,
              coursePrice: widget.coursePrice.toString(),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Payment processing error: $e');
      if (mounted) {
        _showErrorMessage('Payment was successful, but course enrollment failed. Please contact support.');
        Navigator.pop(context);
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('Payment Error: ${response.code} - ${response.message}');
    if (mounted) {
      _showErrorMessage('Payment failed. Please try again.');
      setState(() {
        _isProcessing = false;
      });
      Navigator.pop(context);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: ${response.walletName}');
    // Handle external wallet payment if needed
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Course Purchased',
        message: message,
        contentType: ContentType.success,
      ),
    ));
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Payment Error',
        message: message,
        contentType: ContentType.failure,
      ),
    ));
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Processing Payment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              _isProcessing 
                  ? 'Processing your payment...' 
                  : 'Preparing payment gateway...',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}