import 'package:dyeustask/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:toast/toast.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({Key? key, required this.number});

  final String number;
  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  late String _verificationCode;
  OtpFieldController otpController = OtpFieldController();
  String pin = '';
  bool otpEntered = false;

  @override
  void initState() {
    super.initState();
    verifyPhone();
  }

  @override
  void dispose() {
    super.dispose();
    otpController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Otp',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'An five digit has been code sent to +92 23983480 ',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Incorrect number? Change')),
              const SizedBox(
                height: 55,
              ),
              OTPTextField(
                  controller: otpController,
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 30,
                  fieldStyle: FieldStyle.underline,
                  outlineBorderRadius: 15,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  onChanged: (value) {
                    setState(() {
                      if (value.length != 6) otpEntered = false;
                    });
                    print("Changed: $value");
                  },
                  onCompleted: (value) {
                    pin = value;
                    print("Completed: ${pin}");
                    setState(() {
                      otpEntered = true;
                    });
                  }),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  height: 48,
                  width: 338,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBFFB62),
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
                               Toast.show('Verified Successfully',gravity: 0);
                               await Future.delayed(Duration(seconds: 1));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
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
                      : TextButton(
                          onPressed: () {
                            verifyPhone();
                          },
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          )),
                ),
              ),
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
            print(value.user!.uid);
          });
        },
        verificationFailed: (FirebaseAuthException e) {
      //   Toast.show('verification failed');
        },
        codeSent: (String verificationID, int? resendToken) {
          setState(() {
            print('Code Sent');
            _verificationCode = verificationID;
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
