import "dart:async";
import "dart:convert";
import "dart:developer";

import "package:after_layout/after_layout.dart";
import "package:crypto/crypto.dart";
import "package:flutter/material.dart";
import "package:flutter_razorpay_demo/constant/string_constants.dart";
import "package:flutter_razorpay_demo/singletons/navigation_singleton.dart";
import "package:razorpay_flutter/razorpay_flutter.dart";

class RazorpayScreen extends StatefulWidget {
  const RazorpayScreen({
    required this.checkoutOptionsMap,
    required this.successAcknowledgement,
    required this.failureAcknowledgement,
    super.key,
  });

  final Map<String, dynamic> checkoutOptionsMap;
  final Function(String) successAcknowledgement;
  final Function(String) failureAcknowledgement;

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen>
    with AfterLayoutMixin<RazorpayScreen> {
  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay
      ..on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess)
      ..on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError)
      ..on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    log("handlePaymentSuccess()");
    log("razorpay_payment_id: ${response.paymentId}");
    log("razorpay_order_id: ${response.orderId}");
    log("razorpay_signature: ${response.signature}");
    log("Payment Signature Verified?: ${verifyPaymentSignature(response)}");
    widget.successAcknowledgement("razorpay_payment_id: ${response.paymentId}");
    Navigator.pop(NavigationSingleton().navigatorKey.currentContext!);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    log("handlePaymentError()");
    log("code: ${response.code}");
    log("message: ${response.message}");
    log("error: ${response.error}");
    widget.failureAcknowledgement("message: ${response.message}");
    Navigator.pop(NavigationSingleton().navigatorKey.currentContext!);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    log("handleExternalWallet()");
    log("walletName: ${response.walletName}");
    widget.successAcknowledgement("walletName: ${response.walletName}");
    Navigator.pop(NavigationSingleton().navigatorKey.currentContext!);
  }

  bool verifyPaymentSignature(PaymentSuccessResponse response) {
    final String combinedSting = "${response.orderId}|${response.paymentId}";
    final List<int> encodedCombination = utf8.encode(combinedSting);
    final List<int> secret = utf8.encode(StringConstants().secretKey);
    final Hmac hmacSha256 = Hmac(sha256, secret);
    final Digest digest = hmacSha256.convert(encodedCombination);
    final bool isVerified = digest.toString() == response.signature;
    return isVerified;
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    //
    final Map<String, dynamic> checkoutOptionsMap = widget.checkoutOptionsMap;
    _razorpay.open(checkoutOptionsMap);
    //
    return Future<void>.value();
  }
}
