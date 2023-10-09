

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
   Timer(Duration(seconds: 4), () { 
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
   });
    
    
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
    
     body : Column(

      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('images/splash_pic.jpg' ,
        width: width * .99,
        height: height * .5,
        fit: BoxFit.cover,),
        SizedBox(
          height: height * .04,
        ),
        Text('TOP HEADLINES' , style: GoogleFonts.abel(fontSize: 50, letterSpacing: .6 , color: Colors.grey.shade700 , fontWeight: FontWeight.bold),),
           SizedBox(
          height: height * .06,
        ),
        const SpinKitChasingDots(
          color: Colors.amber,
          size: 40,

        )
      ],
    ));
  }
}