import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PitScoutPage extends StatefulWidget {
  _PitScoutPageState createState() => _PitScoutPageState();
}

class _PitScoutPageState extends State<PitScoutPage> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  void initState() {
    super.initState();
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
                          //formField: ,
                        )
                      ],
                    ),
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
