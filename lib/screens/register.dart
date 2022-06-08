import 'dart:ui';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/services/response/login_response.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/input.dart';

import 'package:argon_flutter/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

enum LoginStatus {notSignIn, signIn}

class _RegisterState extends State<Register> implements LoginCallBack {
  bool _checkboxValue = false;
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username;
  String password;

  LoginResponse _response;

  _RegisterState(){
     _response = new LoginResponse(this);
  }

  final double height = window.physicalSize.height;

    void _submit(){
    final form = formKey.currentState;

    if (form.validate()){
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_username, password);
      });
    }
  }

  void _showSnackBar(String text){
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text)
    ));
  }
  var value;
  getPref() async {

     var value;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
             value = preferences.getInt("value");
      _loginStatus= value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {

    setState(() {
        User.signOut();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

    @override
  void initState() {
    super.initState();
    getPref();

  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus){
      case LoginStatus.notSignIn : 
          _ctx = context;
    var loginForm = new Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        new Form(
          key: formKey,
          child: new  Column(
          children: [
              Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: TextFormField(
            onSaved: (val) => _username = val,
          cursorColor: ArgonColors.muted,
          style:
              TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
          textAlignVertical: TextAlignVertical(y: 0.6),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
              filled: true,
              fillColor: ArgonColors.white,
              hintStyle: TextStyle(
                color: ArgonColors.muted,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: ArgonColors.white,
                      width: 1.0, style: BorderStyle.solid)),
              focusedBorder: OutlineInputBorder(
                
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: ArgonColors.white, width: 1.0, style: BorderStyle.solid)),
                  hintText : "Nom d'utilisateur"
                  
            ))
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,),
          child: TextFormField(
            obscureText: true,
            onSaved: (val) => password = val,
          cursorColor: ArgonColors.muted,
          style:
              TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
          textAlignVertical: TextAlignVertical(y: 0.6),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
              filled: true,
              fillColor: ArgonColors.white,
              hintStyle: TextStyle(
                color: ArgonColors.muted,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: ArgonColors.white,
                      width: 1.0, style: BorderStyle.solid)),
              focusedBorder: OutlineInputBorder(
                
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: ArgonColors.white, width: 1.0, style: BorderStyle.solid)),
                  hintText : "Mot de passe"
                  
            ))
        ),
         Padding(
         padding: const EdgeInsets.all(0.0),
         child: Row(
           mainAxisAlignment:
               MainAxisAlignment.start,
           children: [
             Checkbox(
                 activeColor:
                     ArgonColors.primary,
                 onChanged: (bool newValue) =>
                     setState(() =>
                         _checkboxValue =
                             newValue),
                 value: _checkboxValue),
             Text("Se Souvenir de moi",
                 style: TextStyle(
                     color: ArgonColors.muted,
                     fontWeight:
                         FontWeight.w200)),
             GestureDetector(
                 onTap: () {
                   Navigator.pushNamed(
                       context, '/home');
                 },
                 child: Container(
                   margin:
                       EdgeInsets.only(left: 5),
                   // child: Text("Privacy Policy",
                   //     style: TextStyle(
                   //         color: ArgonColors
                   //             .primary)
                   // ),
                 )
             ),
           ],
         ),
       ),

        Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Center(
            child: FlatButton(
              textColor: ArgonColors.white,
              color: ArgonColors.primary,
              onPressed: _submit,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(4.0),
              ),
              child: Padding(
                  padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 12,
                      bottom: 12),
                  child: Text("Allez-y",
                      style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                          fontSize: 16.0))),
            ),
          ),
        )
    
          ],
        )),
        ],
    );
    return Scaffold(
        key: scaffoldKey,
        drawer: ArgonDrawer(currentPage: "Account"),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/forest1.jpg"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 130, left: 24.0, right: 24.0, bottom: 70),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  color: ArgonColors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: ArgonColors.muted))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text("AUTHENTIFICATION",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 22.0, fontWeight: FontWeight.w900)),
                                  )),
                                  // Divider()
                                ],
                              )),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.50,
                              color: Color.fromRGBO(244, 245, 247, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      loginForm                                    
                                
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                ),
              ]),
            )
          ],
        ));

      break;
      case LoginStatus.signIn :
        
         return Home(signOut);
        //return Home();
    }
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) {
    // TODO: implement onLoginSuccess
        if(user != null){
      setState(() {
         _isLoading = true;
        User.savePref(1,user);
      });      
      _loginStatus = LoginStatus.signIn;
    }else{
      _showSnackBar("Utilisateur ou mot de passe incorrect");
      setState(() {
        _isLoading = false;
      });
    }
  }
}


// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   bool _checkboxValue = false;

//   final double height = window.physicalSize.height;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: Navbar(transparent: true, title: ""),
//         extendBodyBehindAppBar: true,
//         drawer: ArgonDrawer(currentPage: "Account"),
//         body: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage("assets/img/register-bg.png"),
//                       fit: BoxFit.cover)),
//             ),
//             SafeArea(
//               child: ListView(children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       top: 16, left: 24.0, right: 24.0, bottom: 32),
//                   child: Card(
//                       elevation: 5,
//                       clipBehavior: Clip.antiAlias,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4.0),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                               height: MediaQuery.of(context).size.height * 0.15,
//                               decoration: BoxDecoration(
//                                   color: ArgonColors.white,
//                                   border: Border(
//                                       bottom: BorderSide(
//                                           width: 0.5,
//                                           color: ArgonColors.muted))),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Center(
//                                       child: Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Text("Sign up with",
//                                         style: TextStyle(
//                                             color: ArgonColors.text,
//                                             fontSize: 16.0)),
//                                   )),
//                                   Padding(
//                                     padding: const EdgeInsets.only(bottom: 8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Container(
//                                           // width: 0,
//                                           height: 36,
//                                           child: RaisedButton(
//                                               textColor: ArgonColors.primary,
//                                               color: ArgonColors.secondary,
//                                               onPressed: () {},
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(4)),
//                                               child: Padding(
//                                                   padding: EdgeInsets.only(
//                                                       bottom: 10,
//                                                       top: 10,
//                                                       left: 14,
//                                                       right: 14),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceAround,
//                                                     children: [
//                                                       Icon(
//                                                           FontAwesomeIcons
//                                                               .github,
//                                                           size: 13),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       Text("GITHUB",
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               fontSize: 13))
//                                                     ],
//                                                   ))),
//                                         ),
//                                         Container(
//                                           // width: 0,
//                                           height: 36,
//                                           child: RaisedButton(
//                                               textColor: ArgonColors.primary,
//                                               color: ArgonColors.secondary,
//                                               onPressed: () {},
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(4)),
//                                               child: Padding(
//                                                   padding: EdgeInsets.only(
//                                                       bottom: 10,
//                                                       top: 10,
//                                                       left: 8,
//                                                       right: 8),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceAround,
//                                                     children: [
//                                                       Icon(
//                                                           FontAwesomeIcons
//                                                               .facebook,
//                                                           size: 13),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       Text("FACEBOOK",
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               fontSize: 13))
//                                                     ],
//                                                   ))),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   // Divider()
//                                 ],
//                               )),
//                           Container(
//                               height: MediaQuery.of(context).size.height * 0.63,
//                               color: Color.fromRGBO(244, 245, 247, 1),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Center(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 24.0, bottom: 24.0),
//                                         child: Center(
//                                           child: Text(
//                                               "Or sign up with the classic way",
//                                               style: TextStyle(
//                                                   color: ArgonColors.text,
//                                                   fontWeight: FontWeight.w200,
//                                                   fontSize: 16)),
//                                         ),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Input(
//                                               placeholder: "Name",
//                                               prefixIcon: Icon(Icons.school),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Input(
//                                                 placeholder: "Email",
//                                                 prefixIcon: Icon(Icons.email)),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Input(
//                                                 placeholder: "Password",
//                                                 prefixIcon: Icon(Icons.lock)),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 24.0),
//                                             child: RichText(
//                                                 text: TextSpan(
//                                                     text: "password strength: ",
//                                                     style: TextStyle(
//                                                         color:
//                                                             ArgonColors.muted),
//                                                     children: [
//                                                   TextSpan(
//                                                       text: "strong",
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: ArgonColors
//                                                               .success))
//                                                 ])),
//                                           ),
//                                         ],
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8.0, top: 0, bottom: 16),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Checkbox(
//                                                 activeColor:
//                                                     ArgonColors.primary,
//                                                 onChanged: (bool newValue) =>
//                                                     setState(() =>
//                                                         _checkboxValue =
//                                                             newValue),
//                                                 value: _checkboxValue),
//                                             Text("I agree with the",
//                                                 style: TextStyle(
//                                                     color: ArgonColors.muted,
//                                                     fontWeight:
//                                                         FontWeight.w200)),
//                                             GestureDetector(
//                                                 onTap: () {
//                                                   Navigator.pushNamed(
//                                                       context, '/pro');
//                                                 },
//                                                 child: Container(
//                                                   margin:
//                                                       EdgeInsets.only(left: 5),
//                                                   child: Text("Privacy Policy",
//                                                       style: TextStyle(
//                                                           color: ArgonColors
//                                                               .primary)),
//                                                 )),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: 16),
//                                         child: Center(
//                                           child: FlatButton(
//                                             textColor: ArgonColors.white,
//                                             color: ArgonColors.primary,
//                                             onPressed: () {
//                                               // Respond to button press
//                                               Navigator.pushNamed(
//                                                   context, '/home');
//                                             },
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(4.0),
//                                             ),
//                                             child: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     left: 16.0,
//                                                     right: 16.0,
//                                                     top: 12,
//                                                     bottom: 12),
//                                                 child: Text("REGISTER",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         fontSize: 16.0))),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ))
//                         ],
//                       )),
//                 ),
//               ]),
//             )
//           ],
//         ));
//   }
// }
