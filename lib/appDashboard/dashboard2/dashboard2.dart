import 'package:acp/Provider/Login/Login_Provider.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../login/login.dart';
import 'grid3.dart';


class Dashboard2 extends StatelessWidget {
  const Dashboard2({super.key});

  @override
  Widget build(BuildContext context) {
    final login= context.read<LoginProvider>();
    return PopScope(
      canPop: false,
      child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints){
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text("Applications",
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
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        onPressed: () {
                          login.usernameController.clear();
                          login.passwordController.clear();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => const Login(),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_back, color: kDarkblueColor,),
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
                                SizedBox(
                                  height: (MediaQuery.of(context).size.width*0.04),
                                ),
                                const Grid3()
                              ]
                          )
                      )
                  ],
                ),
              );
          }
      ),
    );
  }
}
