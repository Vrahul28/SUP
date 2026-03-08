import 'package:acp/company/companymethods.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Provider/Company/DataTable_Provider.dart';
import '../Provider/Company/Insert_Company_Provider.dart';


class DatatableInsert extends StatefulWidget {
  final int? towerID;
  final int length;
  final List<String> towers;
  final List<String> floors;
  final List<String> unitNos;
  final List<String> areas;
  final List<String> occupancies;
  final List<String> staffNos;
  final bool? isUpdate;
  const DatatableInsert({
    this.towerID,
    required this.length,
    required this.towers,
    required this.floors,
    required this.unitNos,
    required this.areas,
    required this.occupancies,
    required this.staffNos,
    this.isUpdate,
    super.key});

  @override
  State<DatatableInsert> createState() => _DatatableInsertState();
}

class _DatatableInsertState extends State<DatatableInsert> {
  @override
  Widget build(BuildContext context) {
    final company= context.read<InsertCompanyProvider>();
    return Consumer<DatatableProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(
                  color: Colors.black,
                  width: 1,
                ),
                columns: const [
                  DataColumn(label: Text('Tower')),
                  DataColumn(label: Text('Floor')),
                  DataColumn(label: Text('Unit No')),
                  DataColumn(label: Text('Area')),
                  DataColumn(label: Text('Occupancy')),
                  DataColumn(label: Text('Staff No')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: List.generate(
                  provider.towers.length,
                      (index) => DataRow(
                    cells: [
                      DataCell(Text(provider.towers[index])),
                      DataCell(Text(provider.floors[index])),
                      DataCell(Text(provider.unitnos[index])),
                      DataCell(Text(provider.areas[index])),
                      DataCell(Text(provider.occupancys[index])),
                      DataCell(Text(provider.staffnos[index])),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {
                              showMenu(
                                  context: context,
                                  position:  const RelativeRect.fromLTRB(350.0, 700.0, 0.0, 0.0),
                                  items: [
                                    if (widget.isUpdate == true)
                                      PopupMenuItem(
                                        value: 'edit',
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
                                          company.isEdited = true;
                                          company.id1 = provider.ids[index];

                                          company.towerCompany.text = provider.towers[index];
                                          company.floor.text = provider.floors[index];
                                          company.unitNo.text = provider.unitnos[index];
                                          company.area.text = provider.areas[index];
                                          company.occupancy.text = provider.occupancys[index];
                                          company.staffNo.text = provider.staffnos[index];
                                        },
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
                                        onTap: () {
                                          provider.deleteCompanyDataWithApi(index);
                                          // Provider.of<DatatableProvider>(context, listen: false).deleteCompanyDataWithApi(index);
                                          if(provider.add){
                                            provider.deleteCompanyData(index);
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ]
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                dataRowHeight: 80,
                showBottomBorder: true,
                headingTextStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
                headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => kDarkblueColor, // Replace with your color
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
