import 'dart:io';

import 'package:app_firebase/classes/animal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
class FormAnimal extends StatefulWidget{
  @override
  String title;
  Animal animal;
  FormAnimal(this.title,this.animal);
  State<StatefulWidget> createState()=> new FormAnimalState();
}

class FormAnimalState extends State<FormAnimal>{
  var nameController=TextEditingController();
  var ageController=TextEditingController();
  File galleryFile;
  String urlImage;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
       title: new Text(widget.title),
    ),
      body: new SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child:getFormAnimal(),
      ),
    );
  }

  void initState(){
    if(widget.animal!=null) {
      nameController.text = widget.animal.name;
      ageController.text = widget.animal.age;
    }
  }

  Widget getFormAnimal(){
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration:  InputDecoration(icon: Icon(Icons.pets),
          hintText: 'Cual es el nombre del animal',
          labelText: 'Nombre'),
          controller:nameController ,
        ),
        new TextFormField(
          decoration:  InputDecoration(icon: Icon(Icons.cake),
              hintText: 'Cual es la edad',
              labelText: 'Edad'),
          controller: ageController,
        ),
        new RaisedButton(onPressed: imageSelectorGallery,child: new Text('Selecona una imagen'),)
        ,new SizedBox(
          child:showImage()
        ),new RaisedButton(onPressed: sendData,child: Text('Guardar'),)

      ],
    );
  }

  sendData(){
    saveFirebase(nameController.text).then((_){
      DatabaseReference db=FirebaseDatabase.instance.reference().child('Animal');
      if(widget.animal!=null){
        db.child(widget.animal.key).set(getAnimal()).then((_){
          Navigator.pop(context);
        });
      }else{
        db.push().set(getAnimal()).then((_){
          Navigator.pop(context);
        });
      }
    }
    );

  }

 Map<String,dynamic> getAnimal(){
   Map<String,dynamic> data=new Map();
   data['name']=nameController.text;
   data['age']=ageController.text;
   if(widget.animal!=null && galleryFile==null){
     data['image']=widget.animal.image;
   }else{
     data['image']=urlImage!=null?urlImage:"";
   }
   return data;
 }
 
 Future<void>saveFirebase(String imageId) async{
    if(galleryFile!=null){
      StorageReference reference=FirebaseStorage.instance.ref().child('animal').child(imageId);
      StorageUploadTask uploadTask=reference.putFile(galleryFile);
      StorageTaskSnapshot downloadUrl=(await uploadTask.onComplete);
      urlImage=(await downloadUrl.ref.getDownloadURL());
    }
 }

  showImage(){
    if(galleryFile!=null)
      return new Image.file(galleryFile);
    else{
      if(widget.animal!=null){
        return FadeInImage.assetNetwork(
          placeholder: "img/cody.jpg",
            image: widget.animal.image,
        height: 800.0,
        width: 700.0,);
      }else {
        return new Text('Imagen no seleccionada');
      }
    }
  }
  imageSelectorGallery() async{
    galleryFile= await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800.0,
      maxWidth: 700.0,
    );
    setState(() {
    });
  }
}