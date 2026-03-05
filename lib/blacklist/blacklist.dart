import 'package:acp/Provider/Blacklist/Visitor_BlackList_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Provider/Blacklist/Insert_Blacklist_Provider.dart';
import '../appDashboard/dashboard/dashboard.dart';
import '../utils/Textform_field.dart';
import '../utils/colors.dart';
import 'addblacklist/addblacklist.dart';


class Blacklist extends StatefulWidget {
  const Blacklist({super.key});

  @override
  State<Blacklist> createState() => _BlacklistState();
}

class _BlacklistState extends State<Blacklist> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final visitor= context.read<VisitorBlacklistProvider>();
    return PopScope(
      canPop: false,
      child: Material(
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: CustomScrollView(
                slivers:<Widget>[
                  SliverAppBar(
                    // pinned: true,
                    // expandedHeight: 65.0,
                    backgroundColor: kDarkblueColor,
                    title: Text("Blacklist",
                      style: GoogleFonts.poppins(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    centerTitle: true,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        visitor.clearController();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Dashboard(),
                          ),
                        );
                      },
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) => const AddBlacklist(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                  child: CustomTextfield(
                                    Icons: Icons.search,
                                    obsuretext: false,
                                    lines: 1,
                                    errorMsg: '',
                                    hinttext: 'Document number',
                                    controller: visitor.documentNo,
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                  child: CustomTextfield(
                                    Icons: Icons.perm_contact_cal_sharp,
                                    obsuretext: false,
                                    lines: 1,
                                    errorMsg: '',
                                    hinttext: 'Visitor name',
                                    controller: visitor.visitorName,
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 0.0),
                                  child: SizedBox(
                                      width: (MediaQuery.of(context).size.width),
                                      height: (MediaQuery.of(context).size.height * 0.75),
                                      child:  FutureBuilder(
                                        future: visitor.getBlacklistData(visitor.documentNo.text,visitor.visitorName.text),
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
                                              children: [
                                                Row(
                                                  children: [
                                                    // if(company.text.isEmpty && staffcodeclass.text.isEmpty)
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                      child: Consumer<VisitorBlacklistProvider>(
                                                        builder: (BuildContext context, VisitorBlacklistProvider value, Widget? child) {
                                                          return Text(
                                                            "Total : ${value.count}",
                                                            style: GoogleFonts.poppins(
                                                              color: kDarkblueColor,
                                                              fontSize: 18.0,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Consumer<VisitorBlacklistProvider>(
                                                    builder: (BuildContext context, value, Widget? child) {
                                                      return ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        controller: _scrollController,
                                                        itemCount: value.allBlacklistData.length,
                                                        itemBuilder:(context, index) {
                                                          final data= value.allBlacklistData[index];
                                                          return Consumer<InsertBlacklistProvider>(
                                                              builder: (context, value, child) {
                                                                return Card(
                                                                  color: kGinColor,
                                                                  child:  Padding(
                                                                    padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
                                                                    child: Stack(
                                                                      children: [
                                                                        ExpansionTile(
                                                                          trailing: const SizedBox.shrink(),
                                                                          title: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Icon(Icons.person,),
                                                                                  const SizedBox(width: 10,),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      "${data.visitorName}",
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
                                                                              const SizedBox(height: 15,),
                                                                              Row(
                                                                                children: [
                                                                                  Icon(Icons.document_scanner,),
                                                                                  SizedBox(width: 10,),
                                                                                  Text("${data.documentNumber}",
                                                                                    style: GoogleFonts.poppins(
                                                                                      color: Colors.black,
                                                                                      fontSize:15.0,
                                                                                    ),
                                                                                  ),

                                                                                ],
                                                                              ),
                                                                              const SizedBox(height: 15,),
                                                                              Row(
                                                                                children: [
                                                                                  Icon(Icons.calendar_month_outlined,),
                                                                                  SizedBox(width: 10,),
                                                                                  Text("${data.blacklistDate}",
                                                                                    style: GoogleFonts.poppins(
                                                                                      color: Colors.black,
                                                                                      fontSize: 15.0,
                                                                                    ),
                                                                                    overflow: TextOverflow.ellipsis, // Clip the text if it overflows.
                                                                                    maxLines: null,
                                                                                  ),
                                                                                ],
                                                                              ),

                                                                              // SizedBox(height: 20.0),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                            top: 2.0,
                                                                            right: 8.0,
                                                                            child: SizedBox(
                                                                              child: PopupMenuButton(
                                                                                icon: Icon(Icons.more_horiz),
                                                                                itemBuilder: (context) {
                                                                                  return [
                                                                                    PopupMenuItem(
                                                                                      value: 'view',
                                                                                      child: InkWell(
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Icon(Icons.remove_red_eye, size: 20,color: kDarkblueColor,),
                                                                                            const SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Text('View', style: GoogleFonts.poppins(
                                                                                              color: Colors.black,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 17.0,
                                                                                            )),
                                                                                          ],
                                                                                        ),
                                                                                        onTap: () async{
                                                                                          visitor.blackListID= data.visitorBlackListId!;
                                                                                          await visitor.viewBlackList(visitor.blackListID);

                                                                                          if(visitor.addVisitorList.isNotEmpty){
                                                                                            Navigator.of(context).pushReplacement(
                                                                                              MaterialPageRoute(
                                                                                                builder: (BuildContext context) => const AddBlacklist(),
                                                                                              ),
                                                                                            );
                                                                                            value.visitor.text= data.visitorName!;
                                                                                            value.document.text= data.documentNumber!;
                                                                                            value.viewBlacklist= true;
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    ),

                                                                                    PopupMenuItem(
                                                                                      value: 'edit',
                                                                                      child: InkWell(
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Icon(Icons.edit, size: 20,color: kDarkblueColor,),
                                                                                            const SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Text('Edit', style: GoogleFonts.poppins(
                                                                                              color: Colors.black,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 17.0,
                                                                                            )),
                                                                                          ],
                                                                                        ),
                                                                                        onTap: () async{
                                                                                          visitor.blackListID= data.visitorBlackListId!;
                                                                                          value.blackListId= visitor.blackListID;
                                                                                          await visitor.viewBlackList(visitor.blackListID);
                                                                                          if(visitor.addVisitorList.isNotEmpty){
                                                                                            Navigator.of(context).pushReplacement(
                                                                                              MaterialPageRoute(
                                                                                                builder: (BuildContext context) => const AddBlacklist(),
                                                                                              ),
                                                                                            );

                                                                                            value.visitor.text= data.visitorName!;
                                                                                            value.document.text= data.documentNumber!;
                                                                                            value.isUpdateBlacklist= true;
                                                                                          }

                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    PopupMenuItem(
                                                                                      value: 'delete',
                                                                                      child: InkWell(

                                                                                        child: Row(
                                                                                          children: [
                                                                                            Icon(Icons.delete, size: 20,color: kDarkblueColor,),
                                                                                            const SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Text('Delete', style: GoogleFonts.poppins(
                                                                                              color: Colors.black,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 17.0,
                                                                                            )),
                                                                                          ],
                                                                                        ),
                                                                                        onTap: () async{
                                                                                          visitor.blackListID= data.visitorBlackListId!;
                                                                                          await visitor.deleteVisitor(visitor.blackListID);
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                      ),
                                                                                    )
                                                                                  ];
                                                                                },

                                                                              ),
                                                                            )
                                                                        )
                                                                      ],

                                                                    ),


                                                                  ),

                                                                );
                                                              },
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
                              ],
                            ),

                        ]
                    ),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}
