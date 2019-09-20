// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter_masked_text/flutter_masked_text.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:iitism2k16/utils.dart';
// import 'package:iitism2k16/pages/Contact_Us.dart';
// import 'package:iitism2k16/pages/Help.dart';


// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   bool isMobile;
//   bool isLoading;
//   String countryCode;
//   String mobileNumber = "";
//   String smsCode;
//   TextEditingController loginController;
//   String verificationId;

//   @override
//   void initState() {
//     super.initState();
//     isMobile = true;
//     isLoading = false;
//     countryCode = "+91";
//     loginController = isMobile
//         ? MaskedTextController(mask: '0000000000')
//         : MaskedTextController(mask: '0-0-0-0-0-0');
//   }

//   setCountryCode(code) {
//     if (code.toString() != '+91')
//       setState(() {
//         countryCode = code.toString();
//       });
//   }

//   void onCountryChange(CountryCode countryCode) {
//     //Todo : manipulate the selected country code here
//     //setCountryCode(countryCode);
//     print("New Country selected: " + countryCode.toString());
//   }

//   Future<void> verifyPhone() async {
//     final PhoneCodeAutoRetrievalTimeout autoRetrive = (String verId) {
//       this.verificationId = verId;
//     };
//     final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
//       this.verificationId = verId;
//       setState(() {
//         isMobile = false;
//         isLoading = true;
//       });
//     };

//     final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
//       showDes('Verified');
//     };

//     final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
//       showDes('${exception.message}');
//     };

//     await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: "+91" + this.mobileNumber,
//         codeAutoRetrievalTimeout: autoRetrive,
//         codeSent: smsCodeSent,
//         timeout: const Duration(seconds: 5),
//         verificationCompleted: verifiedSuccess,
//         verificationFailed: verifiedFailed);
//   }

//   // Future<bool> smsCodeDialog(BuildContext context) {
//   //   return showDialog(
//   //       context: context,
//   //       barrierDismissible: false,
//   //       builder: (BuildContext context) {
//   //         return AlertDialog(
//   //           title: Text("Enter sms code"),
//   //           content: TextField(
//   //             onChanged: (value) {
//   //               this.smsCode = value;
//   //             },
//   //           ),
//   //           contentPadding: EdgeInsets.all(20),
//   //           actions: <Widget>[
//   //             FlatButton(
//   //               child: Text('Done'),
//   //               onPressed: () {
//   //                 FirebaseAuth.instance.currentUser().then((user) {
//   //                   if (user != null) {
//   //                     Navigator.of(context).pop();
//   //                     showName('hello');
//   //                     //Navigator.of(context).pushReplacementNamed('/homepage');

//   //                   } else {
//   //                     Navigator.of(context).pop();
//   //                     // signIn();
//   //                   }
//   //                 });
//   //               },
//   //             ),
//   //           ],
//   //         );
//   //       });
//   // }

//   signIn() {
//     FirebaseAuth.instance
//         .signInWithPhoneNumber(verificationId: verificationId, smsCode: smsCode)
//         .then((user) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Help()),
//       );
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: FloatingActionButton(
//         elevation: 2,
//         child: Icon(
//           Icons.navigate_next,
//           color: Colors.white,
//         ),
//         onPressed: isMobile
//             ? verifyPhone
//             : () {
//                 FirebaseAuth.instance.currentUser().then((user) {
//                   if (user != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ContactUs()),
//                     );
//                     showDes('hello');
//                   } else {
//                     showDes('CallOneMore');
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => Help()),);
//                     signIn();
//                   }
//                 });
//               },
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(30),
//           child: Column(
//             children: <Widget>[
//               Image.asset(
//                 'assets/iitism.png',
//                 fit: BoxFit.contain,
//                 height: 100.0,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 30),
//               ),
//               Text(
//                 isMobile
//                     ? "Enter your mobile number to get started"
//                     : "Please wait.\nWe will auto verify the OTP sent to your mobile number.",
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'Rock Salt',
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 30),
//               ),
//               Row(
//                 children: isMobile
//                     ? <Widget>[
//                         CountryCodePicker(
//                           textStyle: TextStyle(
//                               letterSpacing: 1.5, color: Colors.grey.shade700),
//                           onChanged: onCountryChange,
//                           initialSelection: '+91',
//                           favorite: ['+91', 'IN'],
//                         ),
//                         Expanded(
//                           child: TextField(
//                             controller: loginController,
//                             autofocus: true,
//                             decoration: new InputDecoration(
//                               hintText: isMobile ? "Enter Mobile" : "Enter OTP",
//                             ),
//                             obscureText: false,
//                             keyboardType: TextInputType.numberWithOptions(),
//                             onChanged: (value) {
//                               this.mobileNumber = value.toString();
//                               this.smsCode = value;
//                             },
//                           ),
//                         )
//                       ]
//                     : <Widget>[
//                         Expanded(
//                           child: TextField(
//                             controller: loginController,
//                             autofocus: true,
//                             decoration: new InputDecoration(
//                               hintText: isMobile ? "Enter Mobile" : "Enter OTP",
//                             ),
//                             obscureText: false,
//                             keyboardType: TextInputType.numberWithOptions(),
//                           ),
//                         )
//                       ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 30),
//               ),
//               Text(
//                 isMobile
//                     ? "Your mobile number is used for authentication. We do not share it with anyone."
//                     : "We have sent a verification code to +91-$mobileNumber",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w300,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10),
//                 child: isLoading
//                     ? FlatButton(
//                         onPressed: () {
//                           setState(() {
//                             mobileNumber = "";
//                             if (!isMobile) {
//                               isMobile = true;
//                               isLoading = false;
//                             }
//                           });
//                         },
//                         child: Text(
//                           "Change Mobile number.",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.blue,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       )
//                     : null,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
