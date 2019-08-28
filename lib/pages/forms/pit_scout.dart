import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

class PitScoutPage extends StatefulWidget {
  _PitScoutPageState createState() => _PitScoutPageState();
}

class _PitScoutPageState extends State<PitScoutPage> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  File _image;

  void initState() {
    super.initState();
  }

  Future<File> pickImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    return image;
  }

  Future<String> uploadImage(File image) async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('pit').child(image.lastModifiedSync().toString());
    StorageUploadTask storageUploadTask = storageReference.putFile(image);
    await storageUploadTask.onComplete;
    String photoUrl = await storageReference.getDownloadURL();
    return photoUrl;
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
                    autovalidate: true,
                    initialValue: {
                      'scoutName': '',
                      // teamNumber : 0,
                      'driveTrain': 'tank',
                      'progLang': 'java',
                      'hasOmniWheel': false,
                      'hasCamera': false,
                      'photoUrl': '',
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
                              child: Text('Tank/West Coast'),
                            ),
                            DropdownMenuItem(
                              value: 'mecanum',
                              child: Text('Mecanum'),
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
                          decoration: InputDecoration(labelText: 'Programming Language'),
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
                          attribute: 'hasOmniWheel',
                          label: Text('Has Omni Wheels?'),
                        ),
                        FormBuilderCheckbox(
                          attribute: 'hasCamera',
                          label: Text('Has Camera(s)?'),
                        ),
                        FormBuilderCustomField(
                          attribute: 'photoUrl',
                          formField: FormField(
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
                                      setState((){
                                        _image = image;
                                      });
                                      debugPrint('IMAGE VALUE: ' + _image.toString());
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            },
                            onSaved: (value) async {
                              String photoUrl = await uploadImage(_image);
                              value = photoUrl;
                            },
                          ),
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      formKey.currentState.save();
                      debugPrint('FORM KEY: ' + formKey.currentState.value.toString());
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
