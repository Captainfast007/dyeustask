import 'package:dyeustask/AppTextStyles.dart';
import 'package:dyeustask/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({Key? key, required this.number});

  final String number;
  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> with CodeAutoFill {
  late String _verificationCode;
  OtpFieldController otpController = OtpFieldController();
  String pin = '';
  bool otpEntered = false;
  bool isDisabled = false;
  bool isLoading = true;
  int counter = 30;
  bool isCounting = false;

  @override
  void initState() {
    super.initState();
    listen();
    verifyPhone();
  }

  listen() {
    SmsAutoFill().listenForCode;
  }

  @override
  void codeUpdated() {
    print("Update code $code");
    setState(() {
      print("codeUpdated");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 28,
                )),
          ],
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Otp',
                      style: AppStyles.heading,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'An five digit has been code sent to +91 ${widget.number}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    Row(children: [
                      const Text('Incorrect number?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Change',
                            style: TextStyle(color: AppStyles.themeColor),
                          )),
                    ]),
                    const SizedBox(
                      height: 55,
                    ),
                    PinFieldAutoFill(
                      //  autoFocus: true,
                      decoration: UnderlineDecoration(
                          colorBuilder:
                              PinListenColorBuilder(Colors.black, Colors.grey),
                          textStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      currentCode: pin,
                      codeLength: 6,
                      onCodeChanged: (code) {
                        setState(() {
                          pin = code.toString();
                          if (pin.length == 6) {
                            otpEntered = true;
                          } else
                            otpEntered = false;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        height: 48,
                        width: 338,
                        decoration: BoxDecoration(
                          color: AppStyles.themeColor,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: otpEntered
                            ? TextButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance
                                      .signInWithCredential(
                                          PhoneAuthProvider.credential(
                                              verificationId: _verificationCode,
                                              smsCode: pin))
                                      .then((usercred) async {
                                    Fluttertoast.showToast(
                                        msg: "Verified Successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()));
                                    ;
                                  });
                                },
                                child: const Text(
                                  'Done',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ))
                            : MaterialButton(
                                disabledColor: const Color(0xFFEDFFD0),
                                onPressed: isDisabled
                                    ? () {
                                        verifyPhone();
                                      }
                                    : null,
                                child: const Text(
                                  'Resend OTP',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                )),
                      ),
                    ),
                    isCounting
                        ? Center(
                          child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Resend OTP in $counter s',style: TextStyle(fontWeight: FontWeight.w500),)
                              ],
                            ),
                        )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    otpEntered && !isCounting
                        ? Column(
                            children: [
                              const Center(
                                  child: Text(
                                'Don\'t you receive any code?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              )),
                              TextButton(
                                  onPressed: verifyPhone,
                                  child: const Text(
                                    'Resend Code',
                                    style: TextStyle(
                                        color: Color(0xFFBFFB62),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ))
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
    );
  }

  verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.number}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
            print(value.user!.uid);
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(
              msg: "Verified failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            isLoading = false;
            isDisabled = true;
          });
        },
        codeSent: (String verificationID, int? resendToken) async {
          setState(() {
            isLoading = false;
            isDisabled = false;
            print('Code Sent');
            _verificationCode = verificationID;
          });
          for (int i =29;i >=0;i--) {
            isCounting = true;
            await Future.delayed(const Duration(seconds: 1));
            setState(() {
              counter = i;
            });
          }
          setState(() {
            isCounting = false;
            isDisabled = true;
          });
        },
        codeAutoRetrievalTimeout: (String verficationID) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        timeout: const Duration(seconds: 60));
  }
}
