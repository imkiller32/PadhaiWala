import 'package:flutter/material.dart';
// import 'package:iitism2k16/themes/theme.dart';
// import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String semester = '7th';
  String branch = 'Computer Science and Engineering';
  String college = 'IIT Dhanbad (IITDHN)';

  @override
  Widget build(BuildContext context) {
    //ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Filter'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    child: Icon(
                      Icons.add,
                      size: 0.0,
                    ),
                    tag: "Filter",
                  ),
                  Text(
                    'Select College',
                    style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  DropdownButton<String>(
                    value: college,
                    items: <String>[
                      'IIT Madras (IITM)',
                      'IIT Delhi (IITD)',
                      'IIT Bombay (IITB)',
                      'IIT Kharagpur (IITKGP)',
                      'IIT Kanpur (IITK)',
                      'IIT Roorkee (IITR)',
                      'IIT Guwahati (IITG)',
                      'IIT Hyderabad (IITH)',
                      'IIT (BHU) Varanasi',
                      'IIT Indore (IITI)',
                      'IIT Dhanbad (IITDHN)',
                      'IIT Bhubaneswar (IITBBS)',
                      'IIT Mandi',
                      'IIT Patna (IITP)',
                      'IIT Gandhinagar (IITGN)',
                      'IIT Ropar (IITRPR)',
                      'IIT Jodhpur (IITJ)',
                      'IIT Tirupati (IITTP)',
                      'IIT Bhilai (IIT C)',
                      'IIT Goa',
                      'IIT Jammu',
                      'IIT Dharwad',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Column(
                          children: <Widget>[
                            Text(value,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                )),
                            Divider(),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String getCollege) {
                      setState(() {
                        college = getCollege;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  Text(
                    'Select Semester',
                    style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  DropdownButton<String>(
                    value: semester,
                    items: <String>[
                      '1st',
                      '2nd',
                      '3rd',
                      '4th',
                      '5th',
                      '6th',
                      '7th',
                      '8th',
                      '9th',
                      '10th',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Column(
                          children: <Widget>[
                            Text(value,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                )),
                            Divider(),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String getSemester) {
                      setState(() {
                        semester = getSemester;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  Text(
                    'Select Branch',
                    style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  DropdownButton<String>(
                    value: branch,
                    items: <String>[
                      'Chemical Engineering',
                      'Civil Engineering',
                      'Computer Science and Engineering',
                      'Electrical Engineering',
                      'Electronics and Communication Engineering',
                      'Engineering Physics',
                      'Environmental Engineering',
                      'Mechanical Engineering',
                      'Mineral Engineering',
                      'Mining Engineering',
                      'Mining Machinery Engineering',
                      'Petroleum Engineering',
                      'Applied Geology',
                      'Applied Geophysics',
                      'Mathematics and Computing'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Column(
                          children: <Widget>[
                            Text(
                              value,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String getBranch) {
                      setState(() {
                        branch = getBranch;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
