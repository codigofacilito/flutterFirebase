import 'package:app_firebase/classes/auth_firebase.dart';
import 'package:app_firebase/pages/home_page.dart';
import 'package:app_firebase/pages/login_page.dart';
import 'package:flutter/cupertino.dart';

class RootPage extends StatefulWidget{
RootPage({Key key,this.authFirebase}):super(key:key);
final AuthFirebase authFirebase;
  @override
  State<StatefulWidget> createState()=> new RootPageState();
}
enum AuthStatus{
  notSignedIn,
  signedIn,
}

class RootPageState extends State<RootPage>{
  AuthStatus authStatus=AuthStatus.notSignedIn;
  @override
  void initState() {
    widget.authFirebase.currentUser().then((userId){
      setState(() {
        authStatus=userId!=null?AuthStatus.signedIn:AuthStatus.notSignedIn;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(title:'Login',auth: widget.authFirebase,onSignIn: ()=>updateAuthStatus(AuthStatus.signedIn),);
      case AuthStatus.signedIn:
        return new HomePage(onSignIn: ()=>updateAuthStatus(AuthStatus.notSignedIn),authFirebase: widget.authFirebase,);
    }
  }

  void updateAuthStatus(AuthStatus auth){
    setState(() {
      authStatus=auth;
    });
  }

}