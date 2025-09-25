// features/coins/controller/phonepe_pg.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:core';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

import 'package:rajakumari_scheme/core/coredata/core_data_model.dart';
import 'package:rajakumari_scheme/core/coredata/core_data_service.dart';
import 'package:rajakumari_scheme/core/services/package_info_service.dart';
import 'package:rajakumari_scheme/core/services/payment_guard_utlra.dart';
import 'package:rajakumari_scheme/features/gold_scheme/controller/invest_in_scheme_controller.dart';
import 'package:rajakumari_scheme/features/passbook/controller/invest_more_controller.dart';
import 'package:rajakumari_scheme/features/passbook/controller/monthly_payment_controller.dart';
import 'package:rajakumari_scheme/features/passbook/models/passbook_details_model.dart';
import 'package:rajakumari_scheme/features/phonepe/models/local_payment.dart';
import 'package:rajakumari_scheme/features/phonepe/services/payment_cache_service.dart';

class PhonepePg extends StatefulWidget {
  PhonepePg({
    super.key,
    required this.amount,
    required this.userid,
    required this.gateway,
    required this.schemeId,
    required this.passbookAddress,
    required this.passbookName,
    required this.merchantTransactionId,
    required this.passbookId,
    required this.userSubscriptionId,
    required this.userSubscriptionPaymentId,
    required this.actionType,
    this.payment,
  });
  final String packageName = PackageInfoService.packageName;
  final String amount;
  final String userid;
  final String merchantTransactionId;
  final String gateway;
  final String schemeId;
  final String passbookAddress;
  final String passbookName;
  final String passbookId;
  final String userSubscriptionId;
  final String userSubscriptionPaymentId;
  final int actionType; //0-joinschema,1-invest,2-monthlypay
  PassbookDetailsModel? payment;
  static Future<bool> startPaymentStatusPolling(
    String transactionId,
    String merchantId,
    String saltKey,
    String mode,
  ) async {
    bool paymentComplete = false;
    int attempts = 0;
    const maxAttempts = 10;
    const saltIndex = "1";

    while (!paymentComplete && attempts < maxAttempts) {
      await Future.delayed(const Duration(seconds: 2));

      try {
        final String dataToHash =
            '/pg/v1/status/$merchantId/$transactionId$saltKey';
        final String checksum =
            '${sha256.convert(utf8.encode(dataToHash))}###$saltIndex';
        debugPrint(
          "merchantId:$merchantId========================================= \n transactionId:$transactionId=========================================",
        );

        final url =
            mode == 'SANDBOX'
                ? 'https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/$merchantId/$transactionId'
                : 'https://api.phonepe.com/apis/hermes/pg/v1/status/$merchantId/$transactionId';

        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'X-MERCHANT-ID': merchantId,
            'X-VERIFY': checksum,
            'accept': 'application/json',
            'x-app-version': AppConfig.appVersion,
          },
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);

          if (responseData['success'] == true &&
              responseData['data']['state'] == 'COMPLETED') {
            paymentComplete = true;
            return true;
          } else if (responseData['success'] == false ||
              responseData['data']['state'] == 'FAILED' ||
              responseData['data']['state'] == 'CANCELLED') {
            paymentComplete = true;

            return false;
          }
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Payment Failed: please check your transaction status",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        return false;
      }

      attempts++;
    }

    if (!paymentComplete) {
      Fluttertoast.showToast(
        msg: "Payment Failed: please check your transaction status",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }

    return false; // Default return value if none of the above conditions are met
  }

  @override
  State<PhonepePg> createState() => _PhonepePgState();
}

class _PhonepePgState extends State<PhonepePg>
    with SingleTickerProviderStateMixin {
  late Future<CoreDataModel> coreDataFuture;
  String environment = '';
  String merchantId = '';
  bool enableLogging = false;
  String checksum = '';
  String saltKey = '';
  String saltIndex = "1";
  bool _isProcessing = false;
  double _progressValue = 0.0;

  String callbackUrl = '';

  String body = '';
  Object? result;
  String endpoint = '/pg/v1/pay';
  String transactionid = '';
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    transactionid = widget.merchantTransactionId;
    coreDataFuture = RsCoreDataService.fetchCoreData();
    coreDataFuture.then((coreData) {
      setState(() {
        environment = coreData.data?.first.phonepeMode ?? 'SANDBOX';
        merchantId = coreData.data?.first.phonepeMerchantId ?? '';
        saltKey = coreData.data?.first.phonepeSaltkey ?? '';
        // environment = 'PRODUCTION';
        // merchantId = 'M228LSILXY3C1';
        // saltKey = 'b26a4aca-614b-4546-9bc0-fd16d3384778';
      });
      body = getCheckSum().toString();

      phonePeinit();
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getCheckSum() {
    double amountInPaise = (double.parse(widget.amount) * 100.round());
    int convertedRate = amountInPaise.toInt();

    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": transactionid,
      "merchantUserId": widget.userid,
      "amount": convertedRate,
      "callbackUrl": callbackUrl,
      "mobileNumber": "",
      "paymentInstrument": {"type": "PAY_PAGE"},
    };

    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checksum =
        '${sha256.convert(utf8.encode(base64Body + endpoint + saltKey)).toString()}###$saltIndex';

    return base64Body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Pattern
            Positioned.fill(
              child: CustomPaint(painter: DottedPatternPainter()),
            ),
            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo and Title Section with Animation
                    Center(
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Opacity(
                              opacity: value,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.shade50,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.amber.withOpacity(0.2),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      "assets/images/phonepe.png",
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    "PhonePe Payment",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "₹${widget.amount}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Payment Button with Loading State
                    // Warning Message
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "⚠️ You're being redirected to a third-party payment gateway.\n"
                                  "⚠️ Please save the Transaction ID shown below for future reference.\n\n"
                                  "⚠️ നിങ്ങൾ ഒരു മൂന്നാംകക്ഷി പേയ്‌മെന്റ് ഗേറ്റുവേയ്‌ക്ക് റീഡയറക്ട് ചെയ്യപ്പെടുന്നതാണ്.\n"
                                  "⚠️ ദയവായി താഴെ കാണുന്ന ഇടപാട് ഐഡി (Transaction ID) സൂക്ഷിച്ച് വെക്കുക.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    ScaleTransition(
                      scale: _animation,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.amber.shade700,
                              Colors.amber.shade900,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed:
                              _isProcessing
                                  ? null
                                  : () {
                                    _controller.forward().then((_) async {
                                      _controller.reverse();
                                      setState(() {
                                        _isProcessing = true;
                                        _progressValue = 0.0;
                                      });
                                      _startPaymentAnimation();

                                      startPgtransaction(context);
                                    });
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child:
                              _isProcessing
                                  ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        "Processing...",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                  : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Pay Now",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Progress Indicator
                    if (_isProcessing)
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: _progressValue),
                        duration: const Duration(milliseconds: 500),
                        builder: (context, double value, child) {
                          return Column(
                            children: [
                              LinearProgressIndicator(
                                value: value,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.amber,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                minHeight: 8,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Processing Payment...",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    const SizedBox(height: 24),
                    // Transaction ID with Hover Effect
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.receipt_long_outlined,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Transaction ID",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    transactionid,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy_outlined, size: 20),
                              onPressed: () {
                                // Add copy functionality here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Transaction ID copied to clipboard',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void phonePeinit() async {
    final info = await PackageInfo.fromPlatform();
    String appId = info.packageName;
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then(
          (val) => {
            setState(() {
              result = 'PhonePe SDK Initialized - $val';
            }),
          },
        )
        .catchError((error) {
          handleError(error);
          return <dynamic>{};
        });
  }

  void startPgtransaction(BuildContext context) async {
    final ifJoin = widget.actionType == 0 ? 1 : 0;
    final ifMonthly = widget.actionType == 2 ? 1 : 0;
    final ifInvestment = widget.actionType == 1 ? 1 : 0;
    final tempTransactionId = '';
    final amountValue =
        (widget.amount.toString().trim().isNotEmpty &&
                double.tryParse(widget.amount.toString()) != null)
            ? double.parse(widget.amount.toString())
            : 0.0; // fallback value

    final schemeIdValue =
        (widget.schemeId.toString().trim().isNotEmpty &&
                int.tryParse(widget.schemeId.toString()) != null)
            ? int.parse(widget.schemeId.toString())
            : 0; // fallback value

    final res = await PaymentGuardUtlraService().submitPaymentBeforeData(
      userId: widget.userid,
      transactionId: tempTransactionId,
      merchantTransactionId: widget.merchantTransactionId,
      amount: amountValue,
      ifJoin: ifJoin,
      schemeId: schemeIdValue,
      ifMonthly: ifMonthly,
      passbookId: widget.passbookId.isNotEmpty ? widget.passbookId : '',
      userSubscriptionPaymentsId:
          widget.userSubscriptionPaymentId.isNotEmpty
              ? widget.userSubscriptionPaymentId
              : '',
      ifInvestment: ifInvestment,
      userSubscriptionId:
          widget.userSubscriptionId.isNotEmpty ? widget.userSubscriptionId : '',
    );

    if (res) {
      final paymentStauts = PhonePePaymentSdk.startTransaction(
            body,
            callbackUrl,
            checksum,
            widget.packageName,
          )
          .then((response) async {
            if (response != null) {
              String status = response['status'].toString();
              String error = response['error'].toString();

              if (status == 'SUCCESS') {
                final localPaymentObj = LocalPayment(
                  userId: widget.userid,
                  schemeId: widget.schemeId,
                  paymentId: widget.merchantTransactionId,
                  amount: widget.amount,
                  actionType: widget.actionType,
                  gateway: widget.gateway,
                  passbookName:
                      widget.actionType == 0 ? widget.passbookName : null,
                  passbookAddress:
                      widget.actionType == 0 ? widget.passbookAddress : null,
                  passbookId: widget.actionType != 0 ? widget.passbookId : null,
                  uniqId:
                      widget.actionType == 2 ? widget.payment!.uniqId : null,
                  status: 'completed',
                );

                // Store the payment
                await PaymentCacheService.storePendingPayment(localPaymentObj);

                // Optionally mark as completed immediately
                await PaymentCacheService.markPaymentAsCompleted(
                  widget.merchantTransactionId,
                );

                // Now update state synchronously
                if (mounted) {
                  setState(() {
                    result = "Flow Completed - Status: Success!";
                  });
                }

                final paymentResult = await _startPaymentStatusPolling(
                  transactionid,
                  merchantId,
                  saltKey,
                  environment,
                  context,
                );

                if (paymentResult) {
                  if (mounted) {
                    Navigator.pop(context, true);
                  }
                } else {
                  if (mounted) {
                    Navigator.pop(context, true);
                  }
                }
              } else {
                if (mounted) {
                  setState(() {
                    result =
                        "Flow Completed - Status: $status and Error: $error";
                  });
                  Navigator.pop(context, false);
                }
              }
            } else {
              if (mounted) {
                setState(() {
                  result = 'Flow incomplete';
                });
              }
            }
          })
          .catchError((error) {
            if (mounted) {
              setState(() {
                result = {"error": error};
              });
            }
            return <dynamic>{};
          });
    } else {
      if (context.mounted) {
        Navigator.pop(context, false);
      }
    }
  }

  Future<bool> _startPaymentStatusPolling(
    String transactionId,
    String merchantId,
    String saltKey,
    String mode,
    BuildContext context,
  ) async {
    bool paymentComplete = false;
    int attempts = 0;
    const maxAttempts = 10;

    final controller = context.read<InvestInSchemeController>();
    final investMoreController = Provider.of<InvestMoreController>(
      context,
      listen: false,
    );
    final monthlyPaymentController = Provider.of<MonthlyPaymentController>(
      context,
      listen: false,
    );
    while (!paymentComplete && attempts < maxAttempts) {
      await Future.delayed(const Duration(seconds: 2));

      try {
        final String dataToHash =
            '/pg/v1/status/$merchantId/$transactionId$saltKey';
        final String checksum =
            '${sha256.convert(utf8.encode(dataToHash))}###$saltIndex';

        final url =
            mode == 'SANDBOX'
                ? 'https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/$merchantId/$transactionId'
                : 'https://api.phonepe.com/apis/hermes/pg/v1/status/$merchantId/$transactionId';

        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'X-MERCHANT-ID': merchantId,
            'X-VERIFY': checksum,
            'accept': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);

          final success = responseData['success'] == true;
          final state =
              (responseData['data']?['state'] ?? '').toString().toUpperCase();

          if (success && state == 'COMPLETED') {
            paymentComplete = true;

            final res = await PaymentGuardUtlraService().submitPaymentAfterData(
              merchantTransactionId: widget.merchantTransactionId,
              userId: int.parse(widget.userid),
              onlinePaymentId: responseData['data']['transactionId'],
            );

            switch (widget.actionType) {
              case 0:
                await controller.joinScheme(
                  userId: widget.userid,
                  schemeId: widget.schemeId,
                  amount: widget.amount,
                  paymentId: widget.merchantTransactionId,
                  gateway: widget.gateway,
                  passbookName: widget.passbookName,
                  passbookAddress: widget.passbookAddress,
                );
                break;
              case 1:
                await investMoreController.processInvestment(
                  userId: widget.userid,
                  schemeId: widget.schemeId,
                  passbookId: widget.passbookId,
                  investAmount: widget.amount,
                  paymentId: widget.merchantTransactionId,
                  gateway: widget.gateway,
                );
                break;
              case 2:
                await monthlyPaymentController.processMonthlyPayment(
                  userId: widget.userid,
                  monthlyPaymentId: widget.payment!.id,
                  uniqId: widget.payment!.uniqId,
                  amount: widget.payment!.amount,
                  paymentId: widget.merchantTransactionId,
                  gateway: widget.gateway,
                );
                break;
            }

            return true;
          }
        } else {
          return false;
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Payment Failed: please check your transaction status",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        return false;
      }

      attempts++;
    }

    if (!paymentComplete) {
      Fluttertoast.showToast(
        msg: "Payment Failed: please check your transaction status",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }

    return false; // Default return value if none of the above conditions are met
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }

  void _startPaymentAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _progressValue = 0.3;
        });
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _progressValue = 0.6;
        });
      }
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _progressValue = 0.9;
        });
      }
    });
  }
}

// Custom Painter for Background Pattern
class DottedPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.amber.withOpacity(0.05)
          ..strokeWidth = 1;

    const spacing = 20.0;
    for (double i = 0; i < size.width; i += spacing) {
      for (double j = 0; j < size.height; j += spacing) {
        canvas.drawCircle(Offset(i, j), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
