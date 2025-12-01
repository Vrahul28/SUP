import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Provider/Company/DataTable_Provider.dart';
import 'addcompany/addcompany.dart';

class DatatableInsert extends StatefulWidget {
  final int length;
  final List<String> towers;
  final List<String> floors;
  final List<String> unitNos;
  final List<String> areas;
  final List<String> occupancies;
  final List<String> staffNos;
  const DatatableInsert({
    required this.length,
    required this.towers,
    required this.floors,
    required this.unitNos,
    required this.areas,
    required this.occupancies,
    required this.staffNos,
    super.key});

  @override
  State<DatatableInsert> createState() => _DatatableInsertState();
}

class _DatatableInsertState extends State<DatatableInsert> {
  Widget build(BuildContext context) {
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
                  widget.length,
                      (index) => DataRow(
                    cells: [
                      DataCell(Text(widget.towers[index])),
                      DataCell(Text(widget.floors[index])),
                      DataCell(Text(widget.unitNos[index])),
                      DataCell(Text(widget.areas[index])),
                      DataCell(Text(widget.occupancies[index])),
                      DataCell(Text(widget.staffNos[index])),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {
                              showMenu(
                                  context: context,
                                  position:  const RelativeRect.fromLTRB(350.0, 700.0, 0.0, 0.0),
                                  items: [
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
                                        onTap: () {
                                          isedited= true;
                                          id1= index;

                                          towercompany.text= widget.towers[index];
                                          floor.text= widget.floors[index];
                                          unitno.text= widget.unitNos[index];
                                          area.text= widget.areas[index];
                                          occupancy.text= widget.occupancies[index];
                                          staffno.text= widget.staffNos[index];
                                          Navigator.pop(context);
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
                                        onTap: () {
                                          Provider.of<DatatableProvider>(context, listen: false).deleteCompanyData(index);
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
