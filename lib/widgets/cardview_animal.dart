import 'package:app_firebase/classes/animal.dart';
import 'package:app_firebase/pages/animal_form_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardViewAnimal extends StatelessWidget{
  Animal animal;
  BuildContext context;
  CardViewAnimal(this.animal,this.context);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: (){
       Navigator.push(context,
       MaterialPageRoute(builder: (context)=>FormAnimal('Editar Animal',animal)));
    },
        child:new Card(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 144.0,
            width: 500.0,
            color: Colors.green,
            child: FadeInImage.assetNetwork(
              placeholder: "img/cody.jpg",
                image: animal.image,
            height: 144.0,
            width: 160.0,),
          ),new Padding(padding: new EdgeInsets.all(7.0),
          child: new Row(
            children: <Widget>[
          new Padding(padding: new EdgeInsets.all(7.0),
          child: new  Icon(Icons.pets)),
          new Padding(padding: new EdgeInsets.all(7.0),
              child: new Text(animal.name,
              style: new TextStyle(fontSize: 18.0))),
          new Padding(padding: new EdgeInsets.all(7.0),
              child: new  Icon(Icons.cake)),
          new Padding(padding: new EdgeInsets.all(7.0),
              child: new Text(animal.age,
                  style: new TextStyle(fontSize: 18.0)))
            ],

          ),)



        ],

      ),

    ));
  }

}