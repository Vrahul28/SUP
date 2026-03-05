import 'package:acp/Provider/Blacklist/Insert_Blacklist_Provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/Textform_field.dart';
import '../../utils/colors.dart';
import '../blacklist.dart';

class AddBlacklist extends StatefulWidget {
  const AddBlacklist({super.key});

  @override
  State<AddBlacklist> createState() => _AddBlacklistState();
}


class _AddBlacklistState extends State<AddBlacklist> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSwitchOn = false;
  bool isSwitchOn2 = false;
  bool isSwitchOn3 = false;

  DateTime d = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final insertBlacklist= context.read<InsertBlacklistProvider>();
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
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
                      insertBlacklist.viewBlacklist = false;
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
                                errorMsg: 'Visitor Name Required',
                                hinttext: 'Visitor Name',
                                controller: insertBlacklist.visitor,
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
                                controller: insertBlacklist.document,
                              )
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if(insertBlacklist.viewBlacklist == false)
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: (MediaQuery.of(context).size.height*0.07),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if(_formKey.currentState!.validate()){

                                        if(insertBlacklist.isUpdateBlacklist == false && insertBlacklist.viewBlacklist == false){
                                          bool isSuccess= await insertBlacklist.addBlacklist(insertBlacklist.visitor.text, insertBlacklist.document.text);
                                          if(isSuccess){
                                            Fluttertoast.showToast(msg: "Data Inserted successfully", textColor: kDarkblueColor,fontSize: 12.0,backgroundColor: Colors.white);
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => Blacklist(),
                                              ),
                                            );
                                            insertBlacklist.clearController();
                                          }

                                        } else if(insertBlacklist.isUpdateBlacklist == true){
                                          insertBlacklist.isUpdateBlacklist = false;
                                          debugPrint("updated");
                                          await insertBlacklist.updateBlacklist(insertBlacklist.blackListId, insertBlacklist.visitor.text, insertBlacklist.document.text);
                                          Fluttertoast.showToast(msg: "Data updated successfully", textColor: kDarkblueColor, fontSize: 12.0,backgroundColor: Colors.white);

                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => Blacklist(),
                                            ),
                                          );
                                          insertBlacklist.clearController();
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
