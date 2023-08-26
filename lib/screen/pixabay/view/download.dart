import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixabay_api/screen/pixabay/contoller/pixabay_contoller.dart';
import 'package:pixabay_api/screen/pixabay/model/pixabay_model.dart';
import 'package:timer_snackbar/timer_snackbar.dart';

class DownloadScrren extends StatefulWidget {
  const DownloadScrren({super.key});

  @override
  State<DownloadScrren> createState() => _DownloadScrrenState();
}

class _DownloadScrrenState extends State<DownloadScrren> {
  final key = GlobalKey();



  PixabayContoller contoller = Get.put(PixabayContoller());

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.black, Colors.white]),
            ),
          ),
          title: Text(
            "Download",
            style: TextStyle(color: Colors.yellow),
          ),
          centerTitle: true,
        ),
        // body: FutureBuilder(
        //   future: contoller.Call(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Text("${snapshot.error}");
        //     } else if (snapshot.hasData) {
        //       PixabayModel? c1 = snapshot.data;
        //
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           return Padding(
        //             padding: const EdgeInsets.all(12),
        //             child: Column(
        //               children: [
        //                 Container(
        //                     height: 300,
        //                     width: double.infinity,
        //                     child: Image.network(
        //                         "${c1.hits![index].largeImageUrl}")),
        //                 Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: InkWell(
        //                     onTap: () async {
        //                       final boundary = key.currentContext
        //                           ?.findRenderObject() as RenderRepaintBoundary?;
        //                       final image =
        //                           await boundary?.toImage(pixelRatio: 3.0);
        //                       final byteData = await image?.toByteData(
        //                           format: ImageByteFormat.png);
        //                       final imageBytes = byteData?.buffer.asUint8List();
        //
        //                       if (imageBytes != null) {
        //                         final directory =
        //                             await getApplicationDocumentsDirectory();
        //                         final imagePath = await File(
        //                                 '${directory.path}/container_image.png')
        //                             .create();
        //                         await imagePath.writeAsBytes(imageBytes);
        //                       }
        //
        //                       timerSnackbar(
        //                           context: context,
        //                           contentText: "success 🎉 Save",
        //                           afterTimeExecute: () => print("object"),
        //                           second: 3);
        //                     },
        //                     child: Container(
        //                       height: 50,
        //                       width: 125,
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(15),
        //                           color: Colors.blue.shade200),
        //                       child: Center(
        //                         child: Text(
        //                           "Save",
        //                           style: TextStyle(
        //                               color: Colors.white, fontSize: 30),
        //
        //                           // TextStyle(
        //                           //     fontSize: 24,
        //                           //     fontWeight: FontWeight.bold,
        //                           //     color: Colors.white),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           );
        //         },
        //         itemCount: c1!.hits!.length,
        //       );
        //     }
        //     return Container(child: CircularProgressIndicator());
        //   },
        // ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RepaintBoundary(
                key: key,
                child: FutureBuilder(
                    future: contoller.Call(contoller.animal.value),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        PixabayModel? c1 = snapshot.data;

                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Container(
                                      height: 300,
                                      width: double.infinity,
                                      child: Image.network(
                                          "${c1.hits![index].largeImageUrl}")),
                                ],
                              ),
                            );
                          },
                          itemCount: c1!.hits!.length,
                        );
                      }
                      return Container(child: CircularProgressIndicator());
                    },
                  ),
              ),
            ),
            SizedBox(
              height: 10,
            ),


            InkWell(
              onTap: () async {
                final boundary = key.currentContext?.findRenderObject()
                as RenderRepaintBoundary?;
                final image = await boundary?.toImage(pixelRatio: 3.0);
                final byteData =
                await image?.toByteData(format: ImageByteFormat.png);
                final imageBytes = byteData?.buffer.asUint8List();

                if (imageBytes != null) {
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                  await File('${directory.path}/container_image.png')
                      .create();
                  await imagePath.writeAsBytes(imageBytes);
                }

                timerSnackbar(
                    context: context,
                    contentText: "Congratulations 🎉 Save",
                    afterTimeExecute: () => print("object"),
                    second: 3);
              },
              child: Container(
                height: 50,
                width: 125,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black),
                child: Center(
                  child: Text(
                    "Save",
                    style:
                    TextStyle(color: Colors.white, fontSize: 30),

                    // TextStyle(
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
