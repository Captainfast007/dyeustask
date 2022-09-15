import 'package:dyeustask/signin_page.dart';
import 'package:dyeustask/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});



  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  int? page=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget>[
                const SizedBox(height: 30,),
                ToggleSwitch(
                  borderColor: const [Color(0xFFE2E2E2)],
                  borderWidth: 1.8,
                  minWidth: 100.0,
                  minHeight: 50,
                  cornerRadius: 35.0,
                  activeBgColors: const [[Color(0xFFBFFB62)], [Color(0xFFBFFB62)]],
                  activeFgColor: Colors.black,
                  inactiveFgColor: Colors.black,
                  inactiveBgColor: Colors.white,
                  initialLabelIndex: page,
                  totalSwitches: 2,
                  labels: const ['Signin', 'Signup'],
                  radiusStyle: true,
                  customTextStyles: const [TextStyle(fontSize: 14,fontWeight: FontWeight.w500)],
                  onToggle: (index) {
                    setState(() {
                     page=index;
                    });
                    print('switched to: $index');
                  },
                ),
                const SizedBox(height: 65,),
                page==0? SignINPage():SignUpPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}