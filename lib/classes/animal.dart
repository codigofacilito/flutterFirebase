import 'package:firebase_database/firebase_database.dart';

class Animal{
  String key;
  String name;
  String age;
  String image;

  Animal(this.key,this.name,this.age,this.image);

  Animal.getAnimal(DataSnapshot snap):
  key=snap.key,
  name=snap.value['name'],
  age=snap.value['age'],
  image=snap.value['image'];

}