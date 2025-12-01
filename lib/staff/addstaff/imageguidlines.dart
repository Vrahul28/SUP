
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class Imageguid extends StatelessWidget {
  final double radius;
  final String mdFileName;

  Imageguid({
    Key? key,
    this.radius = 8,
    required this.mdFileName,
  })  : assert(mdFileName.contains('.md'), 'The file must contain the .md extension'),
        super(key: key);

  MarkdownStyleSheet customStyleSheet = MarkdownStyleSheet(
    p: TextStyle(
      fontSize: 15.0, // Set the desired font size
      color: Colors.black, // Set the desired text color
    ),
    // You can define styles for other Markdown elements as needed.
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 150)).then((value) {
                  return rootBundle.loadString('assets/images/$mdFileName');
                }),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(
                        data:snapshot.data!, styleSheet: customStyleSheet
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(0),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
              ),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: Text(
                "OKAY",
                style: GoogleFonts.poppins(
                  color: kDarkblueColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}