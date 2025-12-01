import 'package:acp/blacklist/addblacklist/addblacklist.dart';
import 'package:acp/blacklist/addblacklist/addblacklistmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../appDashboard/dashboard/dashboard.dart';
import '../../staff/database/dbhelper.dart';
import '../../utils/colors.dart';
import '../blacklist.dart';

class Addblacklistdata extends StatefulWidget {
  const Addblacklistdata({super.key});

  @override
  State<Addblacklistdata> createState() => _AddblacklistdataState();
}

class _AddblacklistdataState extends State<Addblacklistdata> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  DBhelper db= DBhelper.db;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Form(
          key: this._formKey,
          child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  // pinned: true,
                  // expandedHeight: 65.0,
                  backgroundColor: kDarkblueColor,
                  title: Text("Blacklisted",
                    style: GoogleFonts.poppins(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,

                    ),
                    onPressed: () {
                      vistor.clear();
                      document.clear();

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => Dashboard(),
                        ),
                      );

                    },
                  ),
                ),

                SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 0.0),
                            child: Container(
                                width: (MediaQuery.of(context).size.width),
                                height: (MediaQuery.of(context).size.height),
                                child:  FutureBuilder(
                                  future: db.getAllblacklist(documentnumber.text,vistorname.text),
                                  builder: (context, snapshot) {
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }else if(snapshot.hasError){
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    }else{
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Padding(
                                              //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                              //   child: Text(
                                              //     "Total Company : " + allresult.text,
                                              //     style: GoogleFonts.poppins(
                                              //       color: kDarkblueColor,
                                              //       fontSize: 18.0,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // if(allresult.text == "0")
                                          //   Text(
                                          //     "No records found ",
                                          //     style: GoogleFonts.poppins(
                                          //       color: kDarkblueColor,
                                          //       fontSize: 18.0,
                                          //     ),
                                          //   ),
                                          Expanded(
                                            child: ListView.builder(
                                              controller: _scrollController,
                                              itemCount: blacklisted.length,
                                              itemBuilder:(context, index) {
                                                final black= blacklisted[index];
                                                return Card(
                                                  child:  Padding(
                                                    padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
                                                    child: ExpansionTile(
                                                      trailing: PopupMenuButton(
                                                        itemBuilder: (context) {
                                                          return [
                                                            PopupMenuItem(
                                                              value: 'view',
                                                              child: InkWell(
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.remove_red_eye, size: 20,color: kDarkblueColor,),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text('View', style: GoogleFonts.poppins(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 17.0,
                                                                    )),
                                                                  ],
                                                                ),
                                                                onTap: () {
                                                                  Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder: (BuildContext context) => Addblacklist(),
                                                                    ),
                                                                  );
                                                                  vistor.text= black.visitorName!;
                                                                  document.text= black.documentNumber!;
                                                                  setState(() {
                                                                    viewblacklist= true;
                                                                  });

                                                                },
                                                              ),
                                                            ),

                                                            PopupMenuItem(
                                                              value: 'edit',
                                                              child: InkWell(
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.edit, size: 20,color: kDarkblueColor,),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text('Edit', style: GoogleFonts.poppins(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 17.0,
                                                                    )),
                                                                  ],
                                                                ),
                                                                onTap: () {

                                                                  Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder: (BuildContext context) => Addblacklist(),
                                                                    ),
                                                                  );
                                                                  // blackListid= black.visitorBlackListId!;
                                                                  vistor.text= black.visitorName!;
                                                                  document.text= black.documentNumber!;

                                                                  isupdateblacklist= true;


                                                                  setState(() {

                                                                  });


                                                                },
                                                              ),
                                                            ),
                                                            PopupMenuItem(
                                                              value: 'delete',
                                                              child: InkWell(

                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.delete, size: 20,color: kDarkblueColor,),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text('Delete', style: GoogleFonts.poppins(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 17.0,
                                                                    )),
                                                                  ],
                                                                ),
                                                                onTap: () {
                                                                  var black11= Addbacklistmodel(visitorBlackListId: black.visitorBlackListId);
                                                                  db.deleteBlacklist(black11);
                                                                  Navigator.pop(context);
                                                                  setState(() { });

                                                                },
                                                              ),
                                                            )
                                                          ];
                                                        },

                                                      ),
                                                      title: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text("Vistor Name :", style: GoogleFonts.poppins(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 17.0,
                                                              )
                                                              ),
                                                              SizedBox(width: 5,),
                                                              Expanded(
                                                                child: Text(
                                                                  "${black.visitorName}",
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors.black,
                                                                      fontSize: 15.0
                                                                  ),
                                                                  maxLines: 4,
                                                                  overflow: TextOverflow.visible,
                                                                ),

                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text("Document Number :", style: GoogleFonts.poppins(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 17.0,
                                                              )),
                                                              SizedBox(width: 5,),
                                                              Expanded(
                                                                  child: SingleChildScrollView(
                                                                    scrollDirection: Axis.horizontal,
                                                                    child: Text("${black.documentNumber}",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors.black,
                                                                        fontSize:15.0,
                                                                      ),
                                                                    ),
                                                                  )
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text("Blacklist Date :", style: GoogleFonts.poppins(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 17.0,
                                                              )),
                                                              SizedBox(width: 5,),
                                                              Expanded(
                                                                child: Text("${black.blackListDate}",
                                                                  style: GoogleFonts.poppins(
                                                                    color: Colors.black,
                                                                    fontSize: 15.0,
                                                                  ),
                                                                  overflow: TextOverflow.ellipsis, // Clip the text if it overflows.
                                                                  maxLines: null,
                                                                ),
                                                              )
                                                            ],
                                                          ),


                                                          // SizedBox(height: 20.0),
                                                        ],
                                                      ),


                                                    ),
                                                  ),

                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );

                                    }

                                  },
                                )

                            ),
                          )
                        ]
                    )
                )
              ]
          ),
        ),
      ),
    );
  }
}
