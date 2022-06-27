import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sehetak2/widget/home-request.dart';

CollectionReference clinicappointment =
    FirebaseFirestore.instance.collection("clinic");
GlobalKey<FormState> formstate = new GlobalKey<FormState>();
var fullname, phonenumber, today, tomorrow;

class DoctorAppointation extends StatefulWidget {
  String name;
  String images;
  double rating;

  DoctorAppointation({
    this.name,
    this.images,
    this.rating,
  });



  @override
  State<DoctorAppointation> createState() => _DoctorAppointationState();
}
  requestClinic() async {
    var formdata = formstate.currentState;

    if (formdata.validate()) {
      formdata.save();

      await clinicappointment.add({
        "name": fullname,
        "number": phonenumber,
        "today": today,
        "tomorrow": tomorrow,
      });
    }
  }

class _DoctorAppointationState extends State<DoctorAppointation> {
  var fullNameController = TextEditingController();
  var phonenumberController = TextEditingController();
  var todayController = TextEditingController();
  var tomorrowController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        // appBar: AppBar(
        //  toolbarHeight: 30,
        //  elevation: 0.0,
        //  backgroundColor: Colors.blue,
        // ),
        body: SingleChildScrollView(
          child: Form(
            key: formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 35.h,
                      left: 14.w,
                    ),
                    child: InkWell(
                      child: Icon(Icons.arrow_back_ios_rounded,
                          size: 18.0, color: HexColor('#787575')),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Container(
                  color: Colors.blue[800],
                  height: 150.0,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: NetworkImage(widget.images),
                            height: 80.0,
                            width: 80.0,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    child: RatingBar.builder(
                                      initialRating: widget.rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                                onSaved: (value) {
                                  fullname = value;
                                },
                                controller: fullNameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: 'fullname',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                        SizedBox(
                          height: 20.0,
                        ),
                       TextFormField(
                                 onSaved: (value) {
                                  phonenumber = value;
                                },
                                controller: phonenumberController,
                                 keyboardType: TextInputType.phone,
                                 decoration: InputDecoration(
                                   labelText: 'phone',
                                  border: OutlineInputBorder(),
                                   prefixIcon: Icon(Icons.phone),
                                 ),
                               ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 1.0,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(8),
                                    ),
                                  ),
                                  width: 100.0,
                                  height: 35.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 22.0,
                                      top: 3,
                                    ),
                                    child: Text(
                                      'Today',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 5.0,
                                  ),
                                  child: Container(
                                    width: 75.0,
                                    height: 50.0,
                                    child: Text(
                                      '6.00pm To 10.00pm',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(8),
                                    ),
                                  ),
                                  height: 35.0,
                                  width: 100.0,
                                  child: TextFormField(
                                    onSaved: (value) {
                                      today = value;
                                    },
                                    controller: todayController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                  color: Colors.blue,
                                ),
                                width: 100.0,
                                height: 35.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 3.0,
                                  ),
                                  child: Text(
                                    'Tomorrow',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 5.0,
                                ),
                                child: Container(
                                  width: 75.0,
                                  height: 50.0,
                                  child: Text(
                                    '8.00pm To 12.00pm',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(8),
                                  ),
                                ),
                                height: 35.0,
                                width: 100.0,
                                child: TextFormField(
                                  onSaved: (value) {
                                    tomorrow = value;
                                  },
                                  controller: tomorrowController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                   left: 70.w,
                  ),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 231, height: 44),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#80B1FE'),
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      child: Text('Confirm'),
                      onPressed: ()async{
                        await requestClinic();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
