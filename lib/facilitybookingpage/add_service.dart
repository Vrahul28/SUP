import 'package:acp/facilitybookingpage/service.dart';
import 'package:acp/staff/database/dbhelper.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'bookingmethods.dart';
import 'facilitybooking.dart';


TextEditingController title = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController vehicleNumber = TextEditingController();
bool isSwimmingSelected = false;
bool iscarparkingselected= false;

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  // final TaskController _taskController = Get.put(TaskController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 TextEditingController person = TextEditingController();
 TextEditingController date = TextEditingController();
 TextEditingController starttime = TextEditingController();
 TextEditingController endtime = TextEditingController();
 TextEditingController remind = TextEditingController();
 TextEditingController duration = TextEditingController();
 int count= 0;
 double tax= 1.25;
 late double pay;
 late double total;
 late double differenceInHours;
 late int differenceInMinutes;

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(hours: 1)))
      .toString();

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = '1hr';
  List<String> repeatList = ['1hr','2hr'];

  int _selectedColor = 0;

 _validateData() async {
   if (title.text.isNotEmpty && name.text.isNotEmpty) {
     DBHelper db= DBHelper.db;
     bool bookingExists = await db.checkExistingBooking(DateFormat.yMd().format(_selectedDate),_startTime, _endTime,title.text);
     if(bookingExists){
       Fluttertoast.showToast(msg: "The time slot is already booked, please change the booking timing");
     }else{
       if(title.text == "Hall booking" || title.text == "Swimming"){
         Service s= Service(title: title.text, name: name.text, phonenumber: phone.text, emailaddress: email.text,isCompleted: 0, date:DateFormat.yMd().format(_selectedDate), startTime: _startTime, endTime: _endTime);
         db.createService(s);
       }else if(title.text == "Car Parking"){
         Service s= Service(title: title.text, name: name.text, phonenumber: phone.text, emailaddress: email.text, vehiclenumber: vehicleNumber.text,isCompleted: 0, date:DateFormat.yMd().format(_selectedDate), startTime: _startTime, endTime: _endTime);
         db.createService(s);
       }
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => FacilityBooking()),
       );
       title.clear();
       name.clear();
       phone.clear();
       email.clear();
       duration.clear();
       vehicleNumber.clear();
       isSwimmingSelected = false;
       iscarparkingselected= false;
     }
   } else if (title.text.isNotEmpty || name.text.isNotEmpty) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text(
           'All fields are required!',
           style: GoogleFonts.poppins(
             color: kDarkblueColor,
             fontWeight: FontWeight.w600,
             fontSize: 15.0,
           ),
         ),
         backgroundColor: Colors.white,
         duration: Duration(seconds: 2), // Adjust the duration as per your requirement
         action: SnackBarAction(
           label: 'Close',
           onPressed: () {
             // Some action to be performed when 'Close' is pressed.
           },
         ),

       ),
     );
   } else {
     print(
         '############################ SOMETHING WRONG HAPPENED #############################');
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.white,
        title: Text("Booking",
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: kDarkblueColor,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Colors.black12
            ),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.grey, size: 28),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                title.clear();
                name.clear();
                duration.clear();
                phone.clear();
                email.clear();
                vehicleNumber.clear();
                isSwimmingSelected=false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FacilityBooking()),
                );
              },
              icon: Icon(Icons.arrow_back, color: Colors.black,),
            );
          },
        ),
        actions: [
        ],
      ),
      body: Form(
        key: this._formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // InputField(
                //   title: 'Title',
                //   hint: 'Enter title here',
                //   controller: title,
                // ),
                Text(
                 "Service",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: kDarkblueColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                SizedBox(height: 10),

                Booking(hint: "Select Service",controller1: title),
                InputField(
                  title: 'Name',
                  hint: 'Enter name',
                  controller: name,
                ),
                InputField(
                  title: 'Phone number',
                  hint: 'Enter phone number',
                  controller: phone,
                ),
                InputField(
                  title: 'Email address',
                  hint: 'Enter email address',
                  controller: email,
                ),
                InputField(
                  title: 'Date',
                  controller: date,
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () => _getDateFromUser(),
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: _startTime,
                        controller: starttime,
                        widget: IconButton(
                          onPressed: () => _getTimeFromUser(isStartTime: true),
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: _endTime,
                        controller: endtime,
                        widget: IconButton(
                          onPressed: () => _getTimeFromUser(isStartTime: false),
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                InputField(
                  title: 'Duration',
                  hint: _selectedRepeat,
                  controller: duration,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: repeatList
                            .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.white),
                                )))
                            .toList(),
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(
                          height: 0,
                        ),
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: kDarkblueColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRepeat = newValue!;
                            duration.text= newValue;
                            if(title.text=="Swimming"){
                              isSwimmingSelected=true;
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Visibility(
                  visible: isSwimmingSelected,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Person",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: kDarkblueColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: kDarkblueColor,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if(count>0){
                                      count--;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove_circle,size: 40,color: kDarkblueColor,)
                            ),
                            Text(count.toString(), style: TextStyle(fontSize: 18),),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                                icon: Icon(Icons.add_circle,size: 40,color: kDarkblueColor,)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: iscarparkingselected,
                  child: InputField(
                    title: 'Vehicle registration number',
                    hint: 'Enter registration number',
                    controller: vehicleNumber,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: (MediaQuery.of(context).size.height*0.07),
                    child: ElevatedButton(
                      onPressed: () async {

                        differenceInHours = differenceInMinutes / 60;
                        if(title.text=="Swimming"){
                          pay= differenceInHours*30*count;
                        }else{
                          pay= differenceInHours*30;
                        }
                        print('Difference: $differenceInHours hours');
                        print("Payment: $pay");
                        total= pay+tax;

                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Container(
                                margin: const EdgeInsets.all(16.0),
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 0, 16.0, 16.0),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    // boxShadow: shadow,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                width: MediaQuery.of(context).size.width,
                                height: 330,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text('Tax', style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                      ),),
                                      trailing: Text(
                                        "\$"+tax.toString(),
                                        style: const TextStyle(
                                            fontSize: 15
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Subtotal',style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                      ),),
                                      trailing: Text(
                                        "\$"+pay.toString(),
                                        style: const TextStyle(
                                            fontSize: 15
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text(
                                        'Total',
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      ),
                                      trailing: Text(
                                        '\$'+total.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _validateData();
                                        });
                                      },
                                      child: Container(
                                        height: 80,
                                        width: MediaQuery.of(context).size.width / 1.5,
                                        decoration: BoxDecoration(
                                            color: kDarkblueColor,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0, 0.16),
                                                offset: Offset(0, 5),
                                                blurRadius: 10.0,
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(9.0)),
                                        child: Center(
                                          child: Text("Pay Now",
                                              style: GoogleFonts.poppins(
                                                  color: const Color(0xfffefefe),
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 20.0
                                          )),
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            );
                          },
                        );

                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kDarkblueColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: Text("Proceed",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
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



  // _addTasksToDb() async {
  //  DBhelper db1= DBhelper.db;
  //   try {
  //     int value = await db1.createService(
  //       Service(
  //         title: title.text,
  //         note: note.text,
  //         isCompleted: 0,
  //         date: DateFormat.yMd().format(_selectedDate),
  //         startTime: _startTime,
  //         endTime: _endTime,
  //         color: _selectedColor,
  //         repeat: _selectedRepeat,
  //       ),
  //     );
  //     print('Value: $value');
  //   } catch (e) {
  //     print('error: $e');
  //   }
  // }

  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: kDarkblueColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
                (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0,bottom: 8.0),
                child: CircleAvatar(
                  backgroundColor: index == 0
                      ? kDarkblueColor
                      : index == 1
                      ? kDarkblueColor
                      : kDarkblueColor,
                  radius: 14,
                  child: _selectedColor == index
                      ? const Icon(
                    Icons.done,
                    size: 16,
                    color: Colors.white,
                  )
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    } else {
      print('Please select correct date');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(hours: 1))),
    );

    // ignore: use_build_context_synchronously
    String formattedTime = pickedTime!.format(context);

    if (isStartTime) {
      setState(() => _startTime = formattedTime);
    } else if (!isStartTime) {
      setState(() => _endTime = formattedTime);
    } else {
      print('Something went wrong !');
    }
    if (_startTime.isNotEmpty && _endTime.isNotEmpty) {
      int startHour = int.parse(_startTime.split(":")[0]);
      int startMinute = int.parse(_startTime.split(":")[1].split(" ")[0]);
      String startPeriod = _startTime.split(":")[1].split(" ")[1];
      int endHour = int.parse(_endTime.split(":")[0]);
      int endMinute = int.parse(_endTime.split(":")[1].split(" ")[0]);
      String endPeriod = _endTime.split(":")[1].split(" ")[1];

      // Adjust hour based on period (AM/PM)
      if (startPeriod == 'PM' && startHour != 12) {
        startHour += 12;
      }
      if (endPeriod == 'PM' && endHour != 12) {
        endHour += 12;
      }

      // Calculate time in minutes
      int startTimeInMinutes = startHour * 60 + startMinute;
      int endTimeInMinutes = endHour * 60 + endMinute;

      // Calculate difference
      differenceInMinutes = endTimeInMinutes - startTimeInMinutes;
      differenceInHours = (differenceInMinutes / 60 * 10.0)/10.0;
      duration.text= differenceInHours.toString();
    }
  }
}

