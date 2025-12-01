import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import 'invitation.dart';

class Viewinvitation extends StatefulWidget {
  const Viewinvitation({super.key});

  @override
  State<Viewinvitation> createState() => _ViewinvitationState();
}

class _ViewinvitationState extends State<Viewinvitation> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Colors.black12
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.grey, size: 28),
        title: Text("View Inviation", style: TextStyle(color: kDarkblueColor, fontWeight: FontWeight.w600),),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Invitation()),
                );
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,),
            );
          },
        ),
        actions: [
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Expanded(
                            flex: 0,
                            child: Container(
                              height: (MediaQuery.of(context).size.height),
                                child:  Column(
                                  children: [
                                    Container(
                                      width: (MediaQuery.of(context).size.width),
                                      height: 145,
                                      child: Card(
                                              color: kGinColor,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.date_range, size: 20),
                                                        SizedBox(width: 10),
                                                        Text("24/01/2024 - 24/01/2024", style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600
                                                        ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.mail,size: 20),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Text("********@temasektrust.org.sg",
                                                            softWrap: true,
                                                            maxLines: 4,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600
                                                          ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.calendar_month,size: 20),
                                                        SizedBox(width: 10),
                                                        Text("24/01/2024", style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600
                                                        ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.create,size: 20),
                                                        SizedBox(width: 10,),
                                                        Expanded(
                                                          child: Text("marcuschia@temasekfoundation.org.sg",
                                                            softWrap: true,
                                                            maxLines: 4,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600
                                                          ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),
                                    ),
                                    Container(
                                      width: (MediaQuery.of(context).size.width),
                                      height: 145,
                                      child: Card(
                                        color: kGinColor,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.date_range,size: 20),
                                                  SizedBox(width: 10),
                                                  Text("06/02/2024 - 06/02/2024", style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.mail,size: 20),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text("********an@apmasia.com.sg",
                                                      softWrap: true,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.calendar_month,size: 20),
                                                  SizedBox(width: 10),
                                                  Text("24/01/2024", style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.create,size: 20),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text("ngyongquan@apmasia.com.sg",
                                                      softWrap: true,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                            
                            
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: (MediaQuery.of(context).size.width),
                                      height: 145,
                                      child: Card(
                                        color: kGinColor,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.date_range,size: 20),
                                                  SizedBox(width: 10),
                                                  Text("26/01/2024 - 26/01/2024", style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.mail,size: 20),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text("********n.karuppiah@synapxe.sg",
                                                      softWrap: true,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.calendar_month,size: 20),
                                                  SizedBox(width: 10),
                                                  Text("24/01/2024", style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.create,size: 20),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text("angeline.koh@nutanix.com",
                                                      softWrap: true,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                            
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: (MediaQuery.of(context).size.width),
                                      height: 145,
                                      child: Card(
                                        color: kGinColor,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.date_range,size: 20),
                                                  SizedBox(width: 10),
                                                  Text("26/01/2024 - 26/01/2024", style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.mail,size: 20),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text("********.kwang@synapxe.sg",
                                                      softWrap: true,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.calendar_month,size: 20),
                                                  SizedBox(width: 10),
                                                  Text("24/01/2024", style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.create,size: 20),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text("angeline.koh@nutanix.com",
                                                      softWrap: true,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                            
                            
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            
                            ),
                          ),

                        ],
                      ),
                    )
                  ]
              )
          )
        ],
      ),
    );
  }
}
