import 'package:acp/utils/colors.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../appDashboard/dashboard2/dashboard2.dart';
import '../staff/database/dbhelper.dart';
import '../utils/sizeconfig.dart';
import 'add_service.dart';
import 'bookingmethods.dart';
import 'package:acp/facilitybookingpage/service.dart';

DateTime _selectedDate = DateTime.now();
TextEditingController selectbooking= TextEditingController();
TextEditingController eventstartdate= TextEditingController();
TextEditingController selecteddate= TextEditingController();

class Facilitybooking extends StatefulWidget {
  const Facilitybooking({super.key});

  @override
  State<Facilitybooking> createState() => _FacilitybookingState();
}

class _FacilitybookingState extends State<Facilitybooking> {
  DBhelper dBhelper= DBhelper.db;
  late int eventid;

  _addDateBar() {
    selecteddate.text= "${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}";
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        initialSelectedDate: _selectedDate,
        selectedTextColor: Colors.white,
        selectionColor: kDarkblueColor,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            )),
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate;
            selecteddate.text= "${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}";
          });
        },

      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: subHeadingStyle,
              ),
            ],
          ),
          MyButton(
              label: '+ Add Booking',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTaskPage()),
                );
                // await Get.to(() => const AddTaskPage());
                // _taskController.getTasks();
              }),
        ],
      ),
    );
  }

  _showTasks() {
    return FutureBuilder(
        future: dBhelper.getAllevnts(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.hasError){
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }else{
            final List<Service> eventsOnSelectedDate = allevents.where((event) =>
            event.date == DateFormat.yMd().format(_selectedDate)
            ).toList();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    child: SizedBox(
                      width: (MediaQuery.of(context).size.width),
                      height: (MediaQuery.of(context).size.height),
                      child: ListView.builder(
                        scrollDirection: SizeConfig.orientation == Orientation.landscape
                            ? Axis.horizontal
                            : Axis.vertical,
                        itemCount: allevents.length,
                          itemBuilder: (context, index) {
                            var task = allevents[index];
                            if (task.payment == 'Daily' ||
                                task.date == DateFormat.yMd().format(_selectedDate) ||
                                (task.payment == 'Weekly' &&
                                    _selectedDate
                                        .difference(
                                        DateFormat.yMd().parse(task.date!))
                                        .inDays %
                                        7 ==
                                        0) ||
                                (task.payment == 'Monthly' &&
                                    DateFormat.yMd().parse(task.date!).day ==
                                        _selectedDate.day)){
                              try {
                                /*   var hour = task.startTime.toString().split(':')[0];
                          var minutes = task.startTime.toString().split(':')[1]; */
                                var date = DateFormat.jm().parse(task.startTime!);
                                var myTime = DateFormat('HH:mm').format(date);

                                // notifyHelper.scheduledNotification(
                                //   int.parse(myTime.toString().split(':')[0]),
                                //   int.parse(myTime.toString().split(':')[1]),
                                //   task,
                                // );

                              } catch (e) {
                                print('Error parsing time: $e');
                              }

                            }else{
                              Container();
                            }
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 1375),
                              child: SlideAnimation(
                                horizontalOffset: 300,
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      eventid= task.id!;
                                      _showBottomSheet(context, task);
                                    },
                                    child: ServiceTile(task),
                                  ),
                                ),
                              ),
                            );
                          },
                      ),
                    )
                ),
              ],
            );

          }
        },
    );
  }

  _showBottomSheet(BuildContext context, Service service) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 4),
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).orientation == Orientation.landscape)
                ? (service.isCompleted == 1
                ? MediaQuery.of(context).size.height * 0.6
                : MediaQuery.of(context).size.height * 0.8)
                : (service.isCompleted == 1
                ? MediaQuery.of(context).size.height * 0.30
                : MediaQuery.of(context).size.height * 0.39),
            color: kDarkblueColor,
            child: Column(
              children: [
                // Flexible(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 40,
                ),
                service.isCompleted == 1
                    ? Container()
                    : _buildBottomSheet(
                    label: 'Payment',
                    onTap: () {
                      // NotifyHelper().cancelNotification(task);
                      // _taskController.markTaskAsCompleted(task.id!);
                      // Navigator.of(context).pop();
                    },
                    clr: Colors.white),
                const SizedBox(height: 10),
                _buildBottomSheet(
                    label: 'Delete Task',
                    onTap: () {
                      var event= Service(id:eventid);
                      setState(() {
                        dBhelper.deletetask(event);
                      });
                      Navigator.of(context).pop();
                    },
                    clr: Colors.red[300]!),
                // Divider(color: Colors.white),
                _buildBottomSheet(
                    label: 'Cancel',
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    clr: Colors.white),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildBottomSheet(
      {required String label,
        required Function() onTap,
        required Color clr,
        bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kDarkblueColor,
            ),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : clr),
        child: Center(
          child: Text(
            label,
            style:
            isClose ? GoogleFonts.lato(
                textStyle: TextStyle(
                  color: kDarkblueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )) :
             GoogleFonts.lato(
                textStyle: TextStyle(
                  color: kDarkblueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Facility Booking",
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
                width: 2,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const Dashboard2()),
                );
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black,),
            );
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate(
                  [
                    _addTaskBar(),
                    _addDateBar(),
                    const SizedBox(
                      height: 20,
                    ),
                    _showTasks(),

                  ]
              )
          )
        ],
      ),
    );
  }
}


