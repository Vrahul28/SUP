// Facility Booking
import 'package:acp/facilitybookingpage/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../utils/colors.dart';
import '../utils/sizeconfig.dart';
import 'add_service.dart';


List<String> onecomp= [];

class Booking extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;
  const Booking(
      {Key? key,
        required this.controller1,
        required this.hint,
      })
      : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
      child: TypeAheadField<String>(
        hideWithKeyboard: true,
        controller:widget.controller1,
        builder: (context, controller, focusNode) {
          return TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a company';
              }
              return null;
            },
            style: GoogleFonts.poppins(
              color: kDarkblueColor,
              // fontSize: 10.0,
            ),
            controller:widget.controller1,
            decoration: InputDecoration(
              filled: true,
              fillColor:  Colors.transparent,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: kDarkblueColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: kDarkblueColor),
              ),

              hintText: widget.hint,
              hintStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: kDarkblueColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  )),

            ),
          );
        },
        suggestionsCallback: (pattern) async {
          onecomp= ['Hall booking', 'Car Parking', 'Swimming'];
          return onecomp;
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion, style: GoogleFonts.poppins(
              color: kbluelightColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            )),
          );
        },
        emptyBuilder: (context) => SizedBox(
          height: 30,
          child: Center(
            child: Text(
                'No other booking option found.',
                style: GoogleFonts.poppins(
                  color: kbluelightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                )
            ),
          ),
        ),
        onSelected: (suggestion){
          title.text = suggestion;
          setState(() {
            showfield();
          });

          // unitno.text= suggestion.unitNO?? '';

        },
      ),

    );
  }
  void showfield() {
    if (title.text == "Swimming") {
      setState(() {
        isSwimmingSelected = true;
      });
    } else if(title.text == "Car Parking"){
      iscarparkingselected = true;
    }
    else {
      setState(() {
        isSwimmingSelected = false;
      });
    }
  }
}



class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kDarkblueColor,
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: kDarkblueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 14),
            // width: SizeConfig.screenWidth,
            height: 52,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: kDarkblueColor,
                )),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: controller,
                      autofocus: false,
                      readOnly: widget != null ? true : false,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: kDarkblueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      cursorColor: kDarkblueColor,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: kDarkblueColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              // ignore: deprecated_member_use
                              color: kDarkblueColor,
                            )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              // ignore: deprecated_member_use
                              color: kDarkblueColor,
                              width: 0,
                            )),
                      ),
                    )),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  const ServiceTile(this.service, {Key? key}) : super(key: key);

   final Service service;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20)),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,

      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kDarkblueColor),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title!,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${service.name}',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.grey[100],
                                fontSize: 10,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${service.date}',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.grey[100],
                                fontSize: 10,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${service.startTime} - ${service.endTime}',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.grey[100],
                                fontSize: 10,
                              )),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // Text(
                    //   service.note!,
                    //   style: GoogleFonts.poppins(
                    //       textStyle: TextStyle(
                    //         color: Colors.grey[100],
                    //         fontSize: 15,
                    //       )),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                service.isCompleted == 0 ? 'TODO' : 'Completed',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}


