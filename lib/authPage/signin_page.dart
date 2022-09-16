import 'package:dyeustask/AppTextStyles.dart';
import 'package:dyeustask/verify/otp_verify.dart';
import 'package:flutter/material.dart';

class SignINPage extends StatelessWidget {
  SignINPage({Key? key}) : super(key: key);

  String number = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Welcome Back!!',
          style: AppStyles.heading,
        ),
        const SizedBox(
          height: 50,
        ),
        const Text(
          'Please login with your phone number.',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 8.0),
              child: TextFormField(
                onChanged: (value) => number = value,
                autofocus: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    prefix: SizedBox(
                      width: 90,
                      height: 40,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/tiranga.png',
                            width: 32,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            '+91',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 3.0, bottom: 3.0),
                            child: Container(
                              color: Colors.grey,
                              width: 2,
                            ),
                          )
                        ],
                      ),
                    ),
                    hintText: 'Phone Number',
                    hintStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            )),
        const SizedBox(
          height: 35,
        ),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppStyles.themeColor,
            borderRadius: BorderRadius.circular(24.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtpVerify(
                              number: number,
                            )));
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              )),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 145,
              height: 1.8,
              color: Colors.grey[300],
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'OR',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 145,
              height: 1.8,
              color: Colors.grey[300],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFF5FFF3),
            border: Border.all(color: const Color(0xFFE2E2E2)),
            borderRadius: BorderRadius.circular(24.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: TextButton(
              onPressed: () {},
              child: const Text(
                'Connect to MetaMask',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              )),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFF5FFF3),
            border: Border.all(color: const Color(0xFFE2E2E2)),
            borderRadius: BorderRadius.circular(24.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: TextButton(
              onPressed: () {},
              child: const Text(
                'Connect to Google',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              )),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF100F0F),
            borderRadius: BorderRadius.circular(24.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: TextButton(
              onPressed: () {},
              child: const Text(
                'Connect to Apple',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              )),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Don\'t have an account?',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Signup',
                  style: TextStyle(
                      color: Color(0xFFBFFB62), fontWeight: FontWeight.w500),
                ))
          ],
        )
      ],
    );
  }
}
