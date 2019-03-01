import 'package:app_firebase/classes/auth_firebase.dart';
import 'package:app_firebase/pages/animal_form_page.dart';
import 'package:app_firebase/widgets/listview_animal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  HomePage({this.onSignIn,this.authFirebase});
  final VoidCallback onSignIn;
  final  AuthFirebase authFirebase;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[new FlatButton(onPressed:signOut, child: new Text('Cerrar Sesión'))],
        title: new Text('Home'),
    ),
    floatingActionButton: new FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (contex)=>FormAnimal('Nuevo animal',null)));
        },
    shape: StadiumBorder(),
      backgroundColor: Colors.redAccent,
      child: Icon(Icons.add,size: 20.0,),
    ),
    body: new ListViewAnimal(context));

  }

  void signOut(){
    authFirebase.signOut();
    onSignIn();
  }

}