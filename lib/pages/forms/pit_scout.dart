// 2019 SPECIFIC
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:punk_picks/routes.dart';

// This page is _extremely_ hacky at the moment, due to me needing to implement a FirebaseStorage image submission
// form from scratch. Sorry in advance to those trying to understand this

class PitScoutPage extends StatefulWidget {
  _PitScoutPageState createState() => _PitScoutPageState();
}

class _PitScoutPageState extends State<PitScoutPage> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  File _image;
  String imageTaken = 'Image has not been taken.';

  void initState() {
    super.initState();
  }

  Future<File> pickImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    return image;
  }

  Future<String> uploadImage(File image, context) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('rpd')
        .child(image.lastModifiedSync().toString());
    StorageUploadTask storageUploadTask = storageReference.putFile(image);
    StorageTaskSnapshot storageTaskSnapshot =
        await storageUploadTask.onComplete;
    do {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Uploading...'),
      ));
    } while (storageUploadTask.isInProgress);
    String photoUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return photoUrl;
  }

  void submitForm(context) async {
    formKey.currentState.value.remove('imageRef');
    String teamNumber = formKey.currentState.value['teamNumber'].toString();
    DocumentReference matchDocument =
        Firestore.instance.collection('rpd').document(teamNumber + 'pd');
    DocumentSnapshot snapshot = await matchDocument.get().catchError((e) {
      debugPrint('ERROR: ' + e.toString());
      debugPrint('FIRESTORE DOWNLOAD ERROR, CHECK YOUR CONNECTION');
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Download error, check your wifi or data connection'),
      ));
    });
    if (!snapshot.exists) {
      await matchDocument
          .setData(formKey.currentState.value)
          .then((_) => navigateHome(context))
          .catchError((e) {
        debugPrint('ERROR: ' + e.toString());
        debugPrint('FIRESTORE UPLOAD ERROR, CHECK YOUR CONNECTION');
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Upload error, check your wifi or data connection.'),
          duration: Duration(seconds: 10),
        ));
      });
    } else {
      debugPrint(
          'SCOUTING DATA ALREADY EXISTS IN FIRESTORE! HOW DID YOU MANAGE TO SCREW UP THIS BADLY?');
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Scouting results for this team\'s pit already exist.'),
        duration: Duration(seconds: 10),
      ));
    }
  }

  void navigateHome(context) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Successfully submitted scouting results!'),
      duration: Duration(seconds: 10),
      action: SnackBarAction(
        label: 'Home',
        onPressed: () {
          router.navigateTo(context, '/home',
              transition: TransitionType.fadeIn);
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pit Scout Form')),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: formKey,
                    autovalidate: false,
                    initialValue: {
                      'scoutName': '',
                      // teamNumber : 0,  see match_scout.dart as to why this is commented out
                      'driveTrain': 'tank',
                      'progLang': 'java',
                      'hasCamera': false,
                      'imageRef': '',
                      'imageUrl': '',
                    },
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          attribute: 'scoutName',
                          decoration: InputDecoration(labelText: 'Scout Name'),
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                        ),
                        FormBuilderTextField(
                          attribute: 'teamNumber',
                          decoration: InputDecoration(labelText: 'Team Number'),
                          keyboardType: TextInputType.number,
                          valueTransformer: (text) => num.tryParse(text),
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.maxLength(4),
                          ],
                        ),
                        FormBuilderDropdown(
                          attribute: 'driveTrain',
                          decoration:
                              InputDecoration(labelText: 'Drivetrain Type'),
                          items: [
                            DropdownMenuItem(
                              value: 'tank',
                              child: Text('Tank'),
                            ),
                            DropdownMenuItem(
                              value: 'mecanum',
                              child: Text('Mecanum'),
                            ),
                            DropdownMenuItem(
                              value: 'butterfly',
                              child: Text('Butterfly'),
                            ),
                            DropdownMenuItem(
                              value: 'swerve',
                              child: Text('Swerve'),
                            ),
                            DropdownMenuItem(
                              value: 'other',
                              child: Text('Other'),
                            )
                          ],
                        ),
                        FormBuilderDropdown(
                          attribute: 'progLang',
                          decoration: InputDecoration(
                              labelText: 'Programming Language'),
                          items: [
                            DropdownMenuItem(
                              value: 'java',
                              child: Text('Java'),
                            ),
                            DropdownMenuItem(
                              value: 'cpp',
                              child: Text('C++'),
                            ),
                            DropdownMenuItem(
                              value: 'labview',
                              child: Text('LabVIEW'),
                            ),
                            DropdownMenuItem(
                              value: 'python',
                              child: Text('Python'),
                            ),
                            DropdownMenuItem(
                              value: 'other',
                              child: Text('Other'),
                            )
                          ],
                        ),
                        FormBuilderCheckbox(
                          attribute: 'hasCamera',
                          label: Text('Has camera(s)?'),
                        ),
                        FormBuilderCustomField(
                          attribute: 'imageRef',
                          validators: [FormBuilderValidators.required()],
                          formField: FormField(
                            enabled: true,
                            builder: (FormFieldState<dynamic> field) {
                              return new Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RaisedButton(
                                    child: Text('Take picture'),
                                    onPressed: () async {
                                      File image = await pickImage();
                                      if (image != null) {
                                        field.setValue(image
                                            .path); //for some reason this generates a warning, not sure how else to do this
                                        setState(() {
                                          imageTaken = 'Image has been saved.';
                                          _image = image;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(imageTaken),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () async {
                      formKey.currentState.save();
                      if (formKey.currentState.validate()) {
                        String imageUrl = await uploadImage(_image, context);
                        formKey.currentState
                            .setAttributeValue('imageUrl', imageUrl);
                        submitForm(context);
                      } else {
                        debugPrint('FORM IS INVALID!');
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Make sure your form is correctly filled out!'),
                        ));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
