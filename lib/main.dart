import 'package:flutter/material.dart';

import 'package:eghlflutter/eghlflutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _eghlPaymentResult = 'Awaiting for payment.';

  @override
  void initState() {
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void _Pay(BuildContext context) async {
    String result = '';
    String paymentId = 'SIT${DateTime.now().millisecondsSinceEpoch}';

    try {
      Map<String, dynamic> payment = {
        'TransactionType': 'SALE',
        'Amount': '1.00',
        'CurrencyCode': 'MYR',
        'PaymentId': paymentId,
        'OrderNumber': paymentId,
        'PaymentDesc': 'Testing Payment',
        'PymtMethod': 'ANY',
        'CustName': 'somebody',
        'CustEmail': 'somebody@someone.com',
        'CustPhone': '0123456789',
        'MerchantReturnURL': 'SDK',
        'MerchantCallBackURL': 'SDK',
        'ServiceId': 'XSC',
        'Password': 'xsc12345',
        'LanguageCode': 'EN',
        'PageTimeout': '600',
        'PaymentGateway': true,
        'EnableCardPage': false,
        'TriggerReturnURL': false,
        'WebViewZoom': false,
        'NumOfRequery': 12,
        'ForceClosePayment': true,
        'Loggable': true,
      };

      result = await Eghlflutter.executePayment(payment);
    } catch (e) {
      // result = e.message;
    }

    setState(() {
      _eghlPaymentResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_eghlPaymentResult),
              ElevatedButton(
                child: const Text("Pay"),
                onPressed: () {
                  _Pay(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}