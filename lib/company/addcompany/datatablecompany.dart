import 'package:acp/Provider/Company/DataTable_Provider.dart';
import 'package:acp/Provider/Company/Insert_Company_Provider.dart';
import 'package:acp/Provider/Company/View_Company_Provider.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Provider/Company/Company_Provider.dart';
import '../companymodel.dart';
import '../companyscreen.dart';
import 'addcompany.dart';

class DatatableCompany extends StatefulWidget {
  const DatatableCompany({super.key});

  @override
  State<DatatableCompany> createState() => _DatatableCompanyState();
}

bool isFirstRow= false;
late int currentIndex;

class _DatatableCompanyState extends State<DatatableCompany> {
  @override
  Widget build(BuildContext context) {
    final company= context.read<CompanyProvider>();
    final insertCompany= context.read<InsertCompanyProvider>();
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Container(
          // height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
          child: FutureBuilder(
            future: company.viewCompanyList(company.companyListId),
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
                return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<CompanyProvider>(
                      builder: (context, value, child) {
                        return DataTable(
                        border: TableBorder.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        columns: [
                        DataColumn(label: Text('Tower')),
                        DataColumn(label: Text('Floor')),
                        DataColumn(label: Text('Unit No')),
                        DataColumn(label: Text('Area')),
                        DataColumn(label: Text('Occupancy')),
                        DataColumn(label: Text('Staff No')),
                          if(insertCompany.viewCompany == false)
                            DataColumn(label: Text('Action')),
                      ],
                        rows: _generateDataRows(value.viewCompanyData),
                        dataRowHeight: 80,
                        showBottomBorder: true,
                        headingTextStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                        headingRowColor: MaterialStateProperty.resolveWith(
                                (states) => kDarkblueColor
                        ),
                      );
                      },
                    ),
                  );
              }
            },
          ),
        ),
    );
  }

  List<DataRow> _generateDataRows(List<CompanyTowerList> companyData) {
    final insertCompany = context.read<InsertCompanyProvider>();

    return List.generate(companyData.length, (index) {
      final dataRow = companyData[index];
      return DataRow(
        cells: [
          DataCell(Text(dataRow.towerID.toString())),
          DataCell(Text(dataRow.floorID.toString())),
          DataCell(Text(dataRow.unitNo?? '')),
          DataCell(Text(dataRow.area ?? '')),
          DataCell(Text(dataRow.occupancy ?? '')),
          DataCell(Text(dataRow.noOfStaff ?? '')),

          if (insertCompany.viewCompany == false)
            DataCell(
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  showMenu(
                    context: context,
                    position:
                    const RelativeRect.fromLTRB(350.0, 700.0, 0.0, 0.0),
                    items: [
                      PopupMenuItem(
                        child: InkWell(
                          child: Row(
                            children: [
                              Icon(Icons.edit,
                                  size: 20, color: kDarkblueColor),
                              const SizedBox(width: 10),
                              Text(
                                'Edit',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            insertCompany.isEdited = true;
                            insertCompany.id1 = index;

                            insertCompany.towerCompany.text = dataRow.towerID.toString();
                            insertCompany.floor.text = dataRow.floorID.toString();
                            insertCompany.unitNo.text = dataRow.unitNo.toString();
                            insertCompany.area.text = dataRow.area.toString();
                            insertCompany.occupancy.text = dataRow.occupancy.toString();
                            insertCompany.staffNo.text = dataRow.noOfStaff.toString();

                            Navigator.pop(context);
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: InkWell(
                          child: Row(
                            children: [
                              Icon(Icons.delete,
                                  size: 20, color: kDarkblueColor),
                              const SizedBox(width: 10),
                              Text(
                                'Delete',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      );
    });
  }
}



