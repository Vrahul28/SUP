import 'package:acp/blacklist/addblacklist/addblacklist.dart';
import 'package:acp/blacklist/addblacklist/addblacklistmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Provider/Blacklist/Insert_Blacklist_Provider.dart';
import '../../Provider/Blacklist/Visitor_BlackList_Provider.dart';
import '../../appDashboard/dashboard/dashboard.dart';
import '../../staff/database/dbhelper.dart';
import '../../utils/colors.dart';


class AddBlackListData extends StatefulWidget {
  const AddBlackListData({super.key});

  @override
  State<AddBlackListData> createState() => _AddBlackListDataState();
}

class _AddBlackListDataState extends State<AddBlackListData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  DBHelper db= DBHelper.db;
  @override
  Widget build(BuildContext context) {
    final visitor= context.read<VisitorBlacklistProvider>();
    final insertBlacklist= context.read<InsertBlacklistProvider>();
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
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
                      insertBlacklist.clearController();

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
                            child: SizedBox(
                                width: (MediaQuery.of(context).size.width),
                                height: (MediaQuery.of(context).size.height),
                                child:  FutureBuilder(
                                  future: db.getAllBlackList(visitor.documentNo.text,visitor.visitorName.text),
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
                                                return Consumer<InsertBlacklistProvider>(
                                                    builder: (context, value, child) {
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
                                                                            builder: (BuildContext context) => AddBlacklist(),
                                                                          ),
                                                                        );
                                                                        value.visitor.text= black.visitorName!;
                                                                        value.document.text= black.documentNumber!;
                                                                        value.viewBlacklist= true;

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
                                                                            builder: (BuildContext context) => AddBlacklist(),
                                                                          ),
                                                                        );
                                                                        // blackListid= black.visitorBlackListId!;
                                                                        value.visitor.text= black.visitorName!;
                                                                        value.document.text= black.documentNumber!;

                                                                        value.isUpdateBlacklist= true;
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
                                                                        var black11= AddBackListModel(visitorBlackListId: black.visitorBlackListId);
                                                                        db.deleteBlacklist(black11);
                                                                        Navigator.pop(context);
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
                                                                    Text("Visitor Name :", style: GoogleFonts.poppins(
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
