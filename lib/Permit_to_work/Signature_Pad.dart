import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class SignaturePad extends StatefulWidget {
  const SignaturePad({super.key});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data = await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:
          BoxDecoration(border: Border.all(color: Colors.grey)),
          child: SfSignaturePad(
              key: signatureGlobalKey,
              backgroundColor: Colors.white,
              strokeColor: Colors.black,
              minimumStrokeWidth: 5.0,
              maximumStrokeWidth: 8.0
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: IconButton(
            icon: Icon(Icons.downloading, color: kDarkblueColor),
            onPressed: _handleSaveButtonPressed,
          ),
        ),
        Positioned(
          right: 50,
          top: 10,
          child: IconButton(
            icon: Icon(Icons.close, color: kDarkblueColor),
            onPressed: _handleClearButtonPressed,
          ),
        ),
      ],
    );


  }
}
