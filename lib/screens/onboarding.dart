import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';


class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/forest1.jpg"),
                      fit: BoxFit.fill
                  ))),
          Padding(
            padding:
            const EdgeInsets.only(top: 73, left: 32, right: 32, bottom: 16),
            child: Container(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset("assets/img/Logo.jpg", scale: 1),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35.0),
                      child: Image.asset(
                        "assets/img/logo-nbs.png",
                        fit: BoxFit.contain,
                        width: 150,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 0.0),
                          child: Text.rich(TextSpan(
                            text: "FPM V1.0",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.w900),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 26.0),
                          child: Text(
                              "FOREST PROJECT MANAGEMENT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          textColor: ArgonColors.text,
                          color: ArgonColors.secondary,
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/account');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 50.0, right: 50.0, top: 12, bottom: 12),
                              child: Text("Démarrer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.0))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}


// class Onboarding extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(children: <Widget>[
//       Container(
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("assets/img/bg-2.jpg"),
//                   fit: BoxFit.cover))),
//       Padding(
//         padding:
//             const EdgeInsets.only(top: 73, left: 32, right: 32, bottom: 16),
//         child: Container(
//           child: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Image.asset("assets/img/logo.png", scale: 1),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 48.0),
//                       child: Text.rich(TextSpan(
//                         text: "Traceability V.1.0",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 38,
//                             fontWeight: FontWeight.w600),
//                       )),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 24.0),
//                       child: Text(
//                           "Système de Gestion de Traçability pour Coopératives",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700)),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16.0),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: FlatButton(
//                       textColor: ArgonColors.text,
//                       color: ArgonColors.secondary,
//                       onPressed: () {
//                         Navigator.pushReplacementNamed(context, '/account');
//                       },
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4.0),
//                       ),
//                       child: Padding(
//                           padding: EdgeInsets.only(
//                               left: 16.0, right: 16.0, top: 12, bottom: 12),
//                           child: Text("Démarrer",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16.0))),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       )
//     ]));
//   }
// }
