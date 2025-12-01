
import 'package:acp/Provider/Blacklist/Edit_Blacklist_Provider.dart';
import 'package:acp/Provider/Blacklist/Insert_Blacklist_Provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/Textform_field.dart';
import '../../utils/colors.dart';
import '../blacklist.dart';

class Addblacklist extends StatefulWidget {
  const Addblacklist({super.key});

  @override
  State<Addblacklist> createState() => _AddblacklistState();
}
TextEditingController vistor= TextEditingController();
TextEditingController document= TextEditingController();
bool isupdateblacklist= false;
bool viewblacklist= false;
late String blackListid;

class _AddblacklistState extends State<Addblacklist> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSwitchOn = false;
  bool isSwitchOn2 = false;
  bool isSwitchOn3 = false;
  // DBhelper dBhelper1= DBhelper.db;

  DateTime d = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final insertBlacklist= Provider.of<InsertBlacklistProvider>(context, listen: false);
    final updateBlacklist= Provider.of<EditBlacklistProvider>(context, listen: false);
    return Material(
      child: Scaffold(
        body: Form(
          key: this._formKey,
          child: CustomScrollView(
            slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: kDarkblueColor,
                  title: Text("Add Blacklisted",
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
                      viewblacklist=false;
                      vistor.clear();
                      document.clear();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => Blacklist(),
                        ),
                      );

                    },
                  ),
                ),

              SliverList(
                  delegate: SliverChildListDelegate(
                      [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: CustomTextfield(
                                Icons: Icons.person,
                                obsuretext: false,
                                lines: 1,
                                errorMsg: 'Vistor Name Required',
                                hinttext: 'Vistor Name',
                                controller: vistor,
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: CustomTextfield(
                                Icons: Icons.document_scanner,
                                obsuretext: false,
                                lines: 1,
                                errorMsg: 'Document number Required',
                                hinttext: 'Document Number',
                                controller: document,
                              )
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if(viewblacklist == false)
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: (MediaQuery.of(context).size.height*0.07),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if(_formKey.currentState!.validate()){

                                        if(isupdateblacklist == false && viewblacklist == false){
                                          bool isSuccess= await insertBlacklist.addBlacklist(vistor.text, document.text);
                                          if(isSuccess){
                                            Fluttertoast.showToast(msg: "Data Inserted successfully", textColor: kDarkblueColor,fontSize: 12.0,backgroundColor: Colors.white);
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => Blacklist(),
                                              ),
                                            );
                                            vistor.clear();
                                            document.clear();
                                          }

                                        } else if(isupdateblacklist == true){
                                          isupdateblacklist = false;
                                          print("updated");
                                          await updateBlacklist.updateBlacklist(blackListid, vistor.text, document.text);
                                          Fluttertoast.showToast(msg: "Data updated successfully", textColor: kDarkblueColor, fontSize: 12.0,backgroundColor: Colors.white);

                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => Blacklist(),
                                            ),
                                          );
                                          vistor.clear();
                                          document.clear();
                                        }

                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kDarkblueColor,
                                        side: BorderSide.none,
                                        shape: const StadiumBorder()),
                                    child: Text("Submit",
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
                        )
                      ]
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
