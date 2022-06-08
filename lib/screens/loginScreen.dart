// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:argon_flutter/models/user.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/services/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';



class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum LoginStatus {notSignIn, signIn}

class _LoginScreenState extends State<LoginScreen> implements LoginCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username;
  String password;

  
  LoginResponse _response;

  _LoginScreenState(){
    _response = new LoginResponse(this);
  }


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

  bool isRememberMe = false;

  @override
  void initState() {
    super.initState();
    getPref();

  }


Widget buildEmail(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Utilisateur',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.person,
              color: Color(0xff5ac18e),
            ),
            hintText: 'login utilisateur',
            hintStyle: TextStyle(
              color: Colors.black38,
            )
          ),
        ),
      )
    ],
  );
}

Widget buildPassword(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Password',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xff5ac18e),
            ),
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Colors.black38,
            )
          ),
        ),
      )
    ],
  );
}

Widget buildForgetPassBtn() {
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () => print("Forgot Password pressed"),
      padding: EdgeInsets.only(right: 0),
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
    ),
  );
}

Widget buildRememberCb(){
  return Container(
    height: 20,
    child: Row(
      children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white), 
          child: Checkbox(
            value: isRememberMe, 
            onChanged: (value) {
              setState(() {
                 isRememberMe = value; 
              });
             },
            checkColor: Colors.green,
            activeColor: Colors.white,
          )
        ),
        Text(
          "Remember me",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        )
      ]
    ),
  );
}

Widget buildLoginBtn(){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5,
      onPressed:_submit,
   
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      color: Colors.white,
      child: Text(
        'Allez-y',
        style: TextStyle(
          color: Color(0xff5ac18e),
          fontSize: 18,
          fontWeight: FontWeight.bold

        ),
      ),
    ),
  );
}

Widget buildSignUpBtn(){
  return GestureDetector(
    onTap: () => print("Sign Up pressed"),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an Account ?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500
            )
          ),
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold

            
            )
          )
        ]
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus){
      case LoginStatus.notSignIn : 
          _ctx = context;
          // var loginBtn = new RaisedButton(
          //   elevation: 5,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(5)
          //   ),
          //   onPressed: _submit,
          //   child: new Text("Login",
          //     style: TextStyle(
          //       fontSize: 18,
          //       fontWeight: FontWeight.bold

          //     ),
            
          //   ),
          //   color: Colors.green,
            
          // );

           var loginForm = new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        onSaved: (val) => _username = val,
                        decoration: new InputDecoration(
                          contentPadding:EdgeInsets.only(top: 14),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 233, 236, 234),
                          ),
                          hintText: 'Utilisateur',
                          hintStyle: TextStyle(
                            color: Colors.black38,
                          )
                          ),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextFormField(
                        onSaved: (val) => password = val,
                        decoration: new InputDecoration(
                          contentPadding:EdgeInsets.only(top: 14),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 233, 236, 234),
                          ),
                          hintText: 'Mot de passe',
                          hintStyle: TextStyle(
                            color: Colors.black38,
                          )
                        ),
                        obscureText: true,
                      ),
                    )
                  ],
                ),
              ),
              buildLoginBtn()
            ],
          );



      return Scaffold(
        key: scaffoldKey,
      appBar: AppBar(
        backgroundColor :Color(0xcc5ac1Be),
        actions: [
          // IconButton(icon: Icon(Icons.refresh_sharp)),
          // IconButton(icon: Icon(Icons.language))
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x665ac1Be),
                      Color(0x995ac1Be),
                      Color(0xcc5ac1Be),
                      Color(0xff5ac1Be),
                    ]
                  )
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120
                  ),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Connexion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 50),
                   loginForm,
                  //  SizedBox(height: 50),
                    // buildForgetPassBtn(),
                    // buildRememberCb(),
                  
                    //buildSignUpBtn()

                  ]
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
      break;
      case LoginStatus.signIn :
        
         return Home(signOut);
        //return Home();
    }

  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

    @override
  void onLoginSuccess(User user) async {  
    // print(user.email)  ;

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


