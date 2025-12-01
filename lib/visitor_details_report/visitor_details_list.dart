import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Provider/visitor_details_report_provider/visitor_details_report_provider.dart';
import '../utils/colors.dart';

class VisitorDetailsList extends StatelessWidget {
  const VisitorDetailsList({super.key});

  @override
  Widget build(BuildContext context) {
     final searchVisitor= Provider.of<VisitorDetailsReportProvider>(context, listen: false);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: kDarkblueColor,
            title: Text("Visitor Details List",
              style: GoogleFonts.poppins(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
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
                Navigator.pop(context);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
                future: searchVisitor.getVisitorDetailList(
                    searchVisitor.selectSource.text,
                    searchVisitor.companyName.text,
                    searchVisitor.visitorName.text,
                    searchVisitor.systemName.text,
                    searchVisitor.dateTimeRange.text,
                    searchVisitor.selectType.text
                ),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }else if(snapshot.hasError){
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }else{
                    if (searchVisitor.visitorList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            "No Record Found!",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: kDarkblueColor,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: searchVisitor.visitorList.length,
                      shrinkWrap: true,         // <-- important
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item= searchVisitor.visitorList[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Card(
                            color: kGinColor2,
                            child:  Padding(
                              padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
                              child: Stack(
                                children: [
                                  ExpansionTile(
                                    trailing: const SizedBox.shrink(),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context).size.width*0.73),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(LineAwesomeIcons.id_card),
                                                  SizedBox(width: 10,),
                                                  Expanded(
                                                    child: Text(
                                                      item.visitorName ?? '',
                                                      softWrap: true,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Icon(Icons.credit_card),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                item.cardNumber ?? '',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                ),
                                                maxLines: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(LineAwesomeIcons.phone_alt_solid),
                                            SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                item.contact ?? '',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context).size.width*0.73),
                                              // height: 50,
                                              child: Row(
                                                children: [
                                                  Icon(LineAwesomeIcons.building),
                                                  SizedBox(width: 5,),
                                                  Expanded(
                                                    child: Text(item.companyName ?? '',
                                                      softWrap: true,
                                                      style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize:15.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context).size.width*0.73),
                                              // height: 50,
                                              child: Row(
                                                children: [
                                                  Icon(LineAwesomeIcons.calendar),
                                                  SizedBox(width: 5,),
                                                  Expanded(
                                                    child: Text(item.registerDate.toString(),
                                                      style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize:15.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            SizedBox(
                                              width: (MediaQuery.of(context).size.width*0.73),
                                              // height: 50,
                                              child: Row(
                                                children: [
                                                  Icon(LineAwesomeIcons.user),
                                                  SizedBox(width: 5,),
                                                  Expanded(
                                                    child: Text(item.registeredSystemName.toString(),
                                                      style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize:15.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ),
                        );
                      },
                    );
                  }
                },
            ),
          )
        ],
      ),
    );
  }
}
