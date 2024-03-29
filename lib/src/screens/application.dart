import 'dart:io';

import 'package:dfmc/src/providers/appsate.dart';
import 'package:dfmc/src/screens/new_expenditure.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ApplicationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ApplicationtepperState();
  }
}

class ApplicationtepperState extends State<ApplicationScreen> {
  // init the step to 0th position
  AppState appState;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController dateCtl = TextEditingController();
  int currentstep = 0;
  List<String> errors = [];
  List<String> mstatus = ['Single', 'Married', 'Divorced'];
  List<String> idtype = ["Voter ID", "Driver License", "NHIS", "Ghana Card"];
  List<String> disabilityTypes = [
    "Visually Impaired",
    "Hearing Impaired",
    "Physically Disabled",
    "Mental or Intellectual",
    "Albino",
    "Others"
  ];
  List<String> educationLevels = [
    "None",
    "Basic Education",
    "Secondary Education",
    "Tertiary Education",
  ];
  String gender;
  String firstname;
  String surname;
  String maritalstatus;
  DateTime dob;
  String sidtype;
  String idnumber;
  String ismembergfd;

  List<String> disabilitytype = [];
  String otherdisabilitytype;

  String community;
  String postaladdress;
  String houseno;
  String phoneno;
  String streetname;
  String bizlocation;

  String education;

  String yearsinbusiness;
  String occupation;
  String dependants;

  List<String> reasons = [];

  bool chkboxVal = false;
  bool chkboxVal2 = false;
  bool chkboxVal3 = false;
  bool chkboxVal4 = false;
  bool chkboxVal5 = false;

  bool chkdisVal = false;
  bool chkdisVal2 = false;
  bool chkdisVal3 = false;
  bool chkdisVal4 = false;
  bool chkdisVal5 = false;

  String amount;
  String fundintents;
  String beneficiaries;

  File _image;
  Future<File> imageFile;
  String region;
  String district;

  String budgets;
  String agreed = 'accepted';
  var listOfFields = <Widget>[];
  int fieldCount = 1;
  List<List<TextEditingController>> listofInputControllers = [];

  List<Map<String, dynamic>> expenditure = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final iappState = Provider.of<AppState>(context);
    var itemControllers = [
      new TextEditingController(),
      new TextEditingController(),
      new TextEditingController(),
      new TextEditingController(),
    ];
    listofInputControllers.add(itemControllers);
    listOfFields.add(singleBreakdown(0));

    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text("Application Proccess"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Container(
          child: Stepper(
            currentStep: currentstep,
            steps: mysteps(context),
            type: StepperType.horizontal,
            onStepTapped: (step) {
              setState(() {
                appState = iappState;
                currentstep = step;
              });
            },
            onStepCancel: () {
              setState(() {
                if (currentstep > 0) {
                  currentstep = currentstep - 1;
                } else {
                  currentstep = 0;
                }
              });
            },
            onStepContinue: () {
              setState(() {
                if (currentstep < mysteps(context).length - 1) {
                  appState = iappState;
                  if (currentstep == 0) {
                    if (_image == null) {
                      showLoginError("Passport Picture is required");
                    } else {
                      currentstep = currentstep + 1;
                    }
                  } else {
                    currentstep = currentstep + 1;
                  }
                } else {
                  currentstep = 0;
                  appState = iappState;
                }
              });
              // print(currentstep);
            },
          ),
        ),
      ),
    );
  }

  List<Step> mysteps(context) {
    List<Step> allsteps = [
      Step(
          title: Text(""),
          content: imageField(),
          isActive: this.currentstep == 0 ? true : false),
      Step(
          title: Text(""),
          content: personalInfo(context),
          isActive: this.currentstep == 1 ? true : false),
      Step(
          title: Text(""),
          content: disabilityType(),
          state: StepState.indexed,
          isActive: this.currentstep == 2 ? true : false),
      Step(
          title: Text(""),
          content: contactDetails(),
          state: StepState.indexed,
          isActive: currentstep == 3 ? true : false),
      Step(
          title: Text(""),
          content: educationBKG(),
          state: StepState.indexed,
          isActive: currentstep == 4 ? true : false),
      Step(
          title: Text(""),
          content: socialInstitution(),
          state: StepState.indexed,
          isActive: currentstep == 5 ? true : false),
      Step(
          title: Text(""),
          content: reasonForRequest(),
          state: StepState.indexed,
          isActive: currentstep == 6 ? true : false),
      Step(
          title: Text(""),
          content: requestingAmount(),
          state: StepState.indexed,
          isActive: currentstep == 7 ? true : false),
      Step(
          title: Text(""),
          content: allBudget(),
          state: StepState.complete,
          isActive: currentstep == 8 ? true : false),
    ];
    return allsteps;
  }

  Widget personalInfo(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "Personal Information",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // imageField(),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: firstnameField(),
              ),
              Container(
                margin: const EdgeInsets.all(3),
              ),
              Expanded(
                flex: 1,
                child: lastnameField(),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: maritalStatus(),
              ),
              Container(
                margin: const EdgeInsets.all(3),
              ),
              Expanded(
                flex: 1,
                child: genderFn(),
              )
            ],
          ),
          idType(),
          idNumberField(),
          dobField(context),
          isMemberOfgfd(),
        ],
      ),
    );
  }

  Widget disabilityType() {
    return Container(
        child: Column(
      children: <Widget>[
        Text(
          "Choose a Disability Type",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  if (value == true) {
                    setState(() {
                      chkdisVal = value;
                      addToDisability("Visually Impaired");
                    });
                  } else {
                    setState(() {
                      chkdisVal = value;
                      removeFromDisability("Visually Impaired");
                    });
                  }
                },
                value: chkdisVal,
              ),
              Text("Visually Impaired")
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  if (value == true) {
                    setState(() {
                      chkdisVal2 = value;
                      addToDisability("Hearing Impaired");
                    });
                  } else {
                    setState(() {
                      chkdisVal2 = value;
                      removeFromDisability("Hearing Impaired");
                    });
                  }
                },
                value: chkdisVal2,
              ),
              Text("Hearing Impaired")
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  if (value == true) {
                    setState(() {
                      chkdisVal3 = value;
                      addToDisability("Physically Disabled");
                    });
                  } else {
                    setState(() {
                      chkdisVal3 = value;
                      removeFromDisability("Physically Disabled");
                    });
                  }
                },
                value: chkdisVal3,
              ),
              Text("Physically Disabled")
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  if (value == true) {
                    setState(() {
                      chkdisVal4 = value;
                      addToDisability("Mental / Intellectual");
                    });
                  } else {
                    setState(() {
                      chkdisVal4 = value;
                      removeFromDisability("Mental / Intellectual");
                    });
                  }
                },
                value: chkdisVal4,
              ),
              Text("Mental / Intellectual")
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  if (value == true) {
                    setState(() {
                      chkdisVal5 = value;
                      addToDisability("Albino");
                    });
                  } else {
                    setState(() {
                      chkdisVal5 = value;
                      removeFromDisability("Albino");
                    });
                  }
                },
                value: chkdisVal5,
              ),
              Text("Albino")
            ],
          ),
        ),
      ],
    ));
  }

  otherDisabilityType() {
    if (this.disabilitytype == "Others") {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Enter Disability',
          hintText: 'Disability',
        ),
        onChanged: (String value) {
          setState(() {
            otherdisabilitytype = value;
          });
        },
        onSaved: (String value) {},
      );
    } else {
      return Container();
    }
  }

  addToDisability(String res) {
    disabilitytype.add(res);
    print(disabilitytype);
  }

  removeFromDisability(String res) {
    disabilitytype.removeWhere((item) => item == res);
    print(disabilitytype);
  }

  Widget contactDetails() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "Contact Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Community Name',
                hintText: 'Community',
              ),
              onChanged: (String value) {
                setState(() {
                  community = value;
                });
              },
              onSaved: (String value) {},
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'House no.',
                    hintText: 'Your House No',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      houseno = value;
                    });
                  },
                  onSaved: (String value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 2, right: 2),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Postal Address',
                    hintText: 'Your Postal Address',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      postaladdress = value;
                    });
                  },
                  onSaved: (String value) {},
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone No',
                    hintText: 'Your Phone No',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      phoneno = value;
                    });
                  },
                  onSaved: (String value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 2, right: 2),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Street Name',
                    hintText: 'Street name',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      streetname = value;
                    });
                  },
                  onSaved: (String value) {},
                ),
              )
            ],
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Business Location',
                hintText: 'Business Location(If Applicable)',
              ),
              onChanged: (String value) {
                setState(() {
                  bizlocation = value;
                });
              },
              onSaved: (String value) {},
            ),
          ),
          FutureBuilder(
              future: AppState.getRegions(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 20.0,
                          ),
                          width: double.infinity,
                          child: DropdownButton<String>(
                            value: region,
                            hint: Text('Region'),
                            underline: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            items: AppState.regions
                                .map((Map<String, dynamic> value) {
                              return new DropdownMenuItem<String>(
                                value: value["name"],
                                child: new Text(value["name"]),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              AppState.setDistrict(newValue);
                              setState(() {
                                region = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 20.0,
                          ),
                          width: double.infinity,
                          child: DropdownButton<String>(
                            value: district,
                            hint: Text('District'),
                            underline: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            items: AppState.districts
                                .map((Map<String, dynamic> value) {
                              return new DropdownMenuItem<String>(
                                value: value["name"],
                                child: new Text(value["name"]),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                district = newValue;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget educationBKG() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "Edicational Background",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 15.0,
            ),
            width: double.infinity,
            child: DropdownButton<String>(
              value: education,
              hint: Text('Educational Background'),
              underline: Container(
                height: 1,
                color: Colors.grey,
              ),
              items: educationLevels.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  education = newValue;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget socialInstitution() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "Social Institution",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            child: TextFormField(
              initialValue: occupation,
              decoration: InputDecoration(
                labelText: 'Occupation',
                hintText: 'Your Occupation',
              ),
              onChanged: (String value) {
                setState(() {
                  occupation = value;
                });
              },
              onSaved: (String value) {},
            ),
          ),
          Container(
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: yearsinbusiness,
              decoration: InputDecoration(
                labelText: 'Years In Business',
                hintText: 'No. Of Years In Business',
              ),
              onChanged: (String value) {
                setState(() {
                  yearsinbusiness = value;
                });
              },
            ),
          ),
          Container(
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: dependants,
              decoration: InputDecoration(
                labelText: 'Dependants',
                hintText: 'No. Of Dependants',
              ),
              onChanged: (String value) {
                setState(() {
                  dependants = value;
                });
              },
              onSaved: (String value) {},
            ),
          )
          // lastnameField()
        ],
      ),
    );
  }

  reasonForRequest() {
    return Container(
        child: Column(
      children: <Widget>[
        Text(
          "Which of the following objective area are you seeking the fund to undertake?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  if (value == true) {
                    setState(() {
                      chkboxVal = value;
                      addToReason("Income Generation");
                    });
                  } else {
                    setState(() {
                      chkboxVal = value;
                      removeFromReason("Income Generation");
                    });
                  }
                },
                value: chkboxVal,
              ),
              Text("Income Generation")
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  if (value == true) {
                    setState(() {
                      chkboxVal2 = value;
                      addToReason("Medical/Assistive devices");
                    });
                  } else {
                    setState(() {
                      chkboxVal2 = value;
                      removeFromReason("Medical/Assistive devices");
                    });
                  }
                },
                value: chkboxVal2,
              ),
              Text("Medical/Assistive devices")
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  if (value == true) {
                    setState(() {
                      chkboxVal3 = value;
                      addToReason("Educational support");
                    });
                  } else {
                    setState(() {
                      chkboxVal3 = value;
                      removeFromReason("Educational support");
                    });
                  }
                },
                value: chkboxVal3,
              ),
              Text("Educational support")
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  if (value == true) {
                    setState(() {
                      chkboxVal4 = value;
                      addToReason("Skills Training/Apprenticeship");
                    });
                  } else {
                    setState(() {
                      chkboxVal4 = value;
                      removeFromReason("Skills Training/Apprenticeship");
                    });
                  }
                },
                value: chkboxVal4,
              ),
              Text("Skills Training/Apprenticeship")
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  if (value == true) {
                    setState(() {
                      chkboxVal5 = value;
                      addToReason("Organizational development");
                    });
                  } else {
                    setState(() {
                      chkboxVal5 = value;
                      removeFromReason("Organizational development");
                    });
                  }
                },
                value: chkboxVal5,
              ),
              Text("Organizational development")
            ],
          ),
        ),
      ],
    ));
  }

  requestingAmount() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "Requesting Amount",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Total Amount Reuested(GHC)',
                hintText: 'Enter Amount',
              ),
              onChanged: (String value) {
                setState(() {
                  amount = value;
                });
              },
              onSaved: (String value) {},
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
          ),
          Container(
            child: TextFormField(
              maxLines: 5,
              initialValue: fundintents,
              decoration: InputDecoration(
                  labelText: "Fund Intents",
                  hintText:
                      "Describe briefly what you intend to do with the fund ",
                  border: OutlineInputBorder()),
              onChanged: (String text) {
                setState(() {
                  fundintents = text;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
          ),
          Container(
            child: TextFormField(
              maxLines: 5,
              initialValue: beneficiaries,
              decoration: InputDecoration(
                  labelText: "Group Application",
                  hintText: "Eg. John Doe, Jane Doe etc",
                  border: OutlineInputBorder()),
              onChanged: (String text) {
                setState(() {
                  beneficiaries = text;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  allBudget() {
    return Container(
      child: Column(
        children: <Widget>[
          heading(),
          renderExpenditure(),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 20),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExpenditureScreen()));
                if (result != null) {
                  setState(() {
                    expenditure.add(result);
                  });
                }
              },
              child: Text("ADD EXPENDITURE"),
            ),
          ),
          submitButtonField()
        ],
      ),
    );
  }

  renderExpenditure() {
    if (expenditure.length <= 0) {
      return Container(
        margin: const EdgeInsets.all(15.0),
        child: Text('No Expenditure Added'),
      );
    } else {
      return Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: expenditure.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemRow(expenditure[index]);
            }),
      );
    }
  }

  Widget ItemRow(Map<String, dynamic> item) {
    return Container(
      // margin: const EdgeInsets.only(b: 5.0, right: 5.0),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.lightBlue[800],
      )),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              child: Center(child: Text("${item["item"]}")),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              child: Center(child: Text("${item["qty"]}")),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              child: Center(child: Text("${item["unitcost"]}")),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              child: Center(child: Text("${item["totalcost"]}")),
            ),
          )
        ],
      ),
    );
  }

  allBudgetold() {
    return Column(
      children: <Widget>[
        ListView.builder(
            shrinkWrap: true,
            itemCount: fieldCount,
            itemBuilder: (context, index) {
              return listOfFields[index];
            }),
        Container(
          margin: const EdgeInsets.only(
            top: 15.0,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red),
                    ),
                    onPressed: () {
                      var itemControllers = [
                        new TextEditingController(),
                        new TextEditingController(),
                        new TextEditingController(),
                        new TextEditingController(),
                      ];
                      listofInputControllers.add(itemControllers);

                      listOfFields.add(
                          singleBreakdown(listofInputControllers.length - 1));
                      setState(() {
                        fieldCount += 1;
                      });

                      print(listOfFields.toString());
                    },
                    child: Text("NEW FIELD")),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
              ),
              Expanded(
                flex: 1,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    color: Colors.red,
                    onPressed: () {
                      listOfFields.removeAt(fieldCount - 1);
                      setState(() {
                        fieldCount -= 1;
                      });

                      print(listOfFields.toString());
                    },
                    child: Text("DELETE FIELD")),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: submitButtonField(),
        ),
      ],
    );
  }

  Widget heading() {
    return Container(
      height: 40.0,
      // margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue[800],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              "Item",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              "Qty",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              "Unit Cost",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              "Total Cost",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
          ),
        ],
      ),
    );
  }

  Widget singleBreakdown(int fieldCnt) {
    // return Text("Hellow World");
    return Column(
      children: <Widget>[
        new Container(
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: TextField(
                      controller: listofInputControllers[fieldCnt][0],
                      decoration: new InputDecoration(
                        labelText: "item",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          borderSide: new BorderSide(),
                        ),
                      ),

                      // decoration: InputDecoration(
                      //   labelText: 'Item Name',
                      //   hintText: 'Enter Item',
                      // ),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                  ),
                  new Expanded(
                    flex: 1,
                    child: TextField(
                      controller: listofInputControllers[fieldCnt][1],
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        hintText: 'Enter Quantity',
                      ),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: TextField(
                      controller: listofInputControllers[fieldCnt][2],
                      decoration: InputDecoration(
                        labelText: 'Unit Cost',
                        hintText: 'Enter Item',
                      ),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                  ),
                  new Expanded(
                    flex: 1,
                    child: TextField(
                      controller: listofInputControllers[fieldCnt][3],
                      decoration: InputDecoration(
                        labelText: 'Total Cost',
                        hintText: 'Enter Total Cost',
                      ),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 3,
        )
      ],
    );
  }

  Widget submitButtonField() {
    if (expenditure.length >= 1) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10.0),
        height: 50.0,
        child: RaisedButton(
          onPressed: () async {
            Map<String, dynamic> user = {
              'firstname': firstname,
              'lastname': surname,
              'file': _image,
              'gender': gender,
              'maritalstatus': maritalstatus,
              'idtype': sidtype,
              'dob': dateCtl.text,
              'idnumber': idnumber,
              'gfdmember': ismembergfd,
              'disabilitytype': disabilitytype,
              'communityname': community,
              'houseno': houseno,
              'postaladdress': postaladdress,
              'phoneno': phoneno,
              'streenname': streetname,
              'bizlocation': bizlocation,
              'education': education,
              'occupation': occupation,
              'yearsinbusiness': yearsinbusiness,
              'dependants': dependants,
              'objective': reasons,
              'totalamount': amount,
              'fundintents': fundintents,
              'groupapplication': beneficiaries,
              'budgets': expenditure,
              'region': region,
              'district': district,
              'agreed': agreed
            };
            if (formKey.currentState.validate()) {
              formKey.currentState.save();

              if (validateAllInput() == true) {
                loadingBar();
                appState.applying(user).then((response) {
                  _scafoldKey.currentState.removeCurrentSnackBar();
                  if (response == "1") {
                    showSuccessinfo("Application Successfully sent");
                  } else {
                    showLoginError("Unable to Send Application.  Try again");
                  }
                });
              } else {
                showLoginError(errors[0]);
              }
            }
          },
          color: Colors.lightBlue[800],
          child: Text(
            "APPLY NOW",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  loadingBar() {
    _scafoldKey.currentState.removeCurrentSnackBar();
    _scafoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Color(0xFF1DAE3A),
      duration: new Duration(minutes: 1),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(
            " Senging Application... Please wait",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ));
  }

  showLoginError(String message) {
    return _scafoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.red,
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new Icon(Icons.close),
          new Text(
            " $message ",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ));
  }

  showSuccessinfo(String message) {
    return _scafoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.green,
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new Icon(Icons.close),
          new Text(
            " $message ",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ));
  }

  Widget imageField() {
    return Column(
      children: <Widget>[
        Text(
          "Passport Photo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              FutureBuilder<File>(
                future: imageFile,
                builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null) {
                    return Container(
                      height: 200,
                      width: 200,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.file(
                          snapshot.data,
                          // width: 70.0,
                          // height: 70.0,
                        ),
                      ),
                    );
                  } else if (snapshot.error != null) {
                    return Text(
                      'Error Picking Image',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: 200.0,
                      height: 200.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("lib/assets/images/user.png"),
                        ),
                      ),
                    );
                  }
                },
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF6B1024),
                  ),
                  child: IconButton(
                    onPressed: () {
                      getImage();
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  getImage() async {
    //  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      // _image = image;
      imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      imageFile.then((onValue) {
        _image = onValue;
      });
    });
  }

  Widget firstnameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'First Name',
        hintText: 'John',
      ),
      initialValue: firstname,
      onChanged: (String name) {
        setState(() {
          firstname = name;
        });
      },
      onSaved: (String value) {},
    );
  }

  Widget lastnameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Last Name',
        hintText: 'Doe',
      ),
      initialValue: surname,
      onChanged: (String name) {
        setState(() {
          surname = name;
        });
      },
      onSaved: (String value) {},
    );
  }

  Widget maritalStatus() {
    return Container(
      margin: const EdgeInsets.only(
        top: 15.0,
      ),
      width: double.infinity,
      child: DropdownButton<String>(
        value: maritalstatus,
        hint: Text('Marital Status'),
        underline: Container(
          height: 1,
          color: Colors.grey,
        ),
        items: mstatus.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            maritalstatus = newValue;
          });
        },
      ),
    );
  }

  Widget genderFn() {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
      ),
      width: double.infinity,
      child: DropdownButton<String>(
        value: gender,
        hint: Text('Gender'),
        underline: Container(
          height: 1,
          color: Colors.grey,
        ),
        items: ["Male", "Female"].map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            gender = newValue;
          });
        },
      ),
    );
  }

  Widget idType() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      width: double.infinity,
      child: DropdownButton<String>(
        value: sidtype,
        hint: Text('ID Type'),
        underline: Container(
          height: 1,
          color: Colors.grey,
        ),
        items: idtype.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            sidtype = newValue;
          });
        },
      ),
    );
  }

  Widget idNumberField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        initialValue: idnumber,
        decoration: InputDecoration(
          labelText: 'ID Number',
          hintText: '12345656',
        ),
        onChanged: (String text) {
          setState(() {
            idnumber = text;
          });
        },
        onSaved: (String value) {},
      ),
    );
  }

  Widget dobField(context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextFormField(
          controller: dateCtl,
          // initialValue: selectedDate.toString(),
          readOnly: true,
          keyboardType: TextInputType.datetime,
          // style: Theme.of(context).textTheme.body1,
          decoration: InputDecoration(
            labelText: 'Date Of Birth',
            contentPadding:
                const EdgeInsets.fromLTRB(6, 6, 48, 6), // 48 -> icon width
          ),
        ),
        IconButton(
          icon: Icon(Icons.calendar_today, color: const Color(0xfff96800)),
          onPressed: () async {
            final DateTime picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(1950, 8),
                lastDate: DateTime(2050));
            if (picked != null) {
              dateCtl.text = picked.toString();
              // setState(() {
              //   dob = picked;
              // });
            }

            //print(date);
          },
        ),
      ],
    );
  }

  isMemberOfgfd() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
      ),
      width: double.infinity,
      child: DropdownButton<String>(
        value: ismembergfd,
        hint: Text('Are You Memebr of GFD?'),
        underline: Container(
          height: 1,
          color: Colors.grey,
        ),
        items: ['Yes', 'No'].map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            ismembergfd = newValue;
          });
        },
      ),
    );
  }

  removeFromReason(String res) {
    reasons.removeWhere((item) => item == res);
    print(reasons);
  }

  addToReason(String res) {
    reasons.add(res);
    print(reasons);
  }

  validateAllInput() {
    if (_image == null) {
      errors.add("Passport Photo is required. Select passport size photo");
      return false;
    } else {
      return true;
    }
  }

  // showLoginError(String message) {
  //   return _scafoldKey.currentState.showSnackBar(new SnackBar(
  //     backgroundColor: Colors.red,
  //     duration: new Duration(seconds: 10),
  //     content: new Row(
  //       children: <Widget>[
  //         new Icon(Icons.close),
  //         new Text(
  //           " $message ",
  //           style: TextStyle(color: Colors.white),
  //         )
  //       ],
  //     ),
  //   ));
  // }
}
