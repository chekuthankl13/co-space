import 'dart:async';
import 'package:co_workspace/core/config/config.dart';
import 'package:co_workspace/core/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {


  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  // ..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

   @override
  void initState() {
    Timer(const Duration(seconds: 2), (){
       navigatorKey.currentState!.pushReplacementNamed("/home");
    });
    super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScaleTransition(scale: _animation, 
      child: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/build.jpg",width: sW(context)/1.5,),
            RichText(text:TextSpan(
              text: "CO-SPACE ",
              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Config.baseClr),
              children: [
                TextSpan(text: ".",style: TextStyle(color: Config.greenClr,fontSize: 50,fontWeight: FontWeight.bold))
              ]
            )),
            spaceHeight(5),
            loading(clr: Config.greenClr)
          ],
        )
        //Image.asset("",width: sW(context)/1.5,) ,
        //Text("CO-SPACE",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
        
      ),
      ),
    );
  }
}