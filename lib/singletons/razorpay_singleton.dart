import "package:flutter/material.dart";
import "package:flutter_razorpay_demo/constant/string_constants.dart";
import "package:flutter_razorpay_demo/model/razorpay_response.dart";
import "package:flutter_razorpay_demo/screen/razorpay_screen.dart";
import "package:flutter_razorpay_demo/singletons/dio_singleton.dart";
import "package:flutter_razorpay_demo/singletons/navigation_singleton.dart";
import "package:intl/intl.dart";

class RazorpaySingleton {
  factory RazorpaySingleton() {
    return _singleton;
  }

  RazorpaySingleton._internal();
  static final RazorpaySingleton _singleton = RazorpaySingleton._internal();

  Future<void> makePayment({
    required double amount,
    required Function(String) successAcknowledgement,
    required Function(String) failureAcknowledgement,
  }) async {
    final Locale locale = WidgetsBinding.instance.window.locale;
    final String currencyName = NumberFormat.simpleCurrency(
          locale: locale.toString(),
        ).currencyName ??
        "USD";

    String errorMessage = "";

    Map<String, dynamic> paymentIntent = <String, dynamic>{};
    paymentIntent = await DioSingleton().makePaymentIntent(
      amount: amount,
      currency: currencyName,
      errorMessageFunction: (String error) {
        errorMessage = error;
      },
    );

    if (errorMessage == "") {
      final Order order = Order.fromJson(paymentIntent);
      final Map<String, dynamic> checkoutOptionsMap = checkoutOptions(order);

      await Navigator.push(
        NavigationSingleton().navigatorKey.currentContext!,
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return RazorpayScreen(
              checkoutOptionsMap: checkoutOptionsMap,
              successAcknowledgement: successAcknowledgement,
              failureAcknowledgement: failureAcknowledgement,
            );
          },
        ),
      );
    } else {
      failureAcknowledgement(errorMessage);
    }
    return Future<void>.value();
  }

  Map<String, dynamic> checkoutOptions(Order order) {
    final Map<String, dynamic> options = <String, dynamic>{
      "key": StringConstants().publishableKey,
      "amount": order.amount ?? 0,
      "name": "Business Name",
      "order_id": order.id ?? "",
      "description": "Description",
      "timeout": 60,
      "prefill": <String, dynamic>{
        "name": "Dharam Budh",
        "email": "dharambudh1@gmail.com",
        "contact": "+919999999999"
      },
    };
    return options;
  }
}
