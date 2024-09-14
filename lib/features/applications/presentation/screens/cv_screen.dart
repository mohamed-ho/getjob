import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:getjob/features/applications/data/data_source/application_remote_data_source.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';

class CvScreen extends StatefulWidget {
  const CvScreen({super.key, required this.filePath});
  final String filePath;
  @override
  State<CvScreen> createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen> {
  String? pdfPath;
  @override
  void initState() {
    super.initState();
    ls<ApplicationRemoteDataSource>().downloadCV(widget.filePath).then((file) {
      pdfPath = file.path;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: const Text(""),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.download))
          ],
        ),
        body: pdfPath == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PDFView(
                filePath: pdfPath,
              ));
  }
}
