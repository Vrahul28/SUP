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
            future: company.viewCompanyList(company.companyListid),
            // future: db.getaddCompanydata1(companylistid),
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

  List<DataRow> _generateDataRows(List<Company> companyData) {
    final insertCompany= context.read<InsertCompanyProvider>();
    List<DataRow> rows = [];

    for (var dataRow in companyData) {
      List<String>? towers = dataRow.towerId?.split(', ');
      List<String>? floors = dataRow.floorId?.split(', ');
      List<String>? units = dataRow.unitNo?.split(', ');
      List<String>? areas = dataRow.area?.split(', ');
      List<String>? occupancies = dataRow.occupancy?.split(', ');
      List<String>? staffNumbers = dataRow.noOfStaff?.split(', ');

      // Create a new row for each tower
      for (int i = 0; i < towers!.length; i++) {
        rows.add(
          DataRow(
            cells: [
              DataCell(Text(towers[i])),
              DataCell(Text(i < floors!.length ? floors[i] : '')),
              DataCell(Text(i < units!.length ? units[i] : '')),
              DataCell(Text(i < areas!.length ? areas[i] : '')),
              DataCell(Text(i < occupancies!.length ? occupancies[i] : '')),
              DataCell(Text(i < staffNumbers!.length ? staffNumbers[i] : '')),
              if (insertCompany.viewCompany == false)
                DataCell(
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(350.0, 700.0, 0.0, 0.0),
                        items: [
                          PopupMenuItem(
                            value: 'edit',
                            child: InkWell(
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 20, color: kDarkblueColor),
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
                                insertCompany.isEdited= true;
                                insertCompany.id1= i;

                                insertCompany.towerCompany.text= towers[i];
                                insertCompany.floor.text = i < floors.length ? floors[i] : '';
                                insertCompany.unitNo.text = i < units.length ? units[i] : '';
                                insertCompany.area.text = i < areas.length ? areas[i] : '';
                                insertCompany.occupancy.text = i < occupancies.length ? occupancies[i] : '';
                                insertCompany.staffNo.text = i < staffNumbers.length ? staffNumbers[i] : '';

                                Navigator.pop(context);
                              },
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: InkWell(
                              child: Row(
                                children: [
                                  Icon(Icons.delete, size: 20, color: kDarkblueColor),
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
          ),
        );
      }
    }
    return rows;
  }
}



