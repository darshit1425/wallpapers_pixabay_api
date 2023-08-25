import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_api/screen/pixabay/contoller/pixabay_contoller.dart';
import 'package:pixabay_api/screen/pixabay/model/pixabay_model.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
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
                  colors: <Color>[Colors.white, Colors.black45]),
            ),
          ),
          title: Text(
            "Pixabay",style: TextStyle(color: Colors.yellow),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: contoller.Call(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              PixabayModel? c1 = snapshot.data;

              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                        height: 300,
                        width: double.infinity,
                        child:
                            Image.network("${c1.hits![index].largeImageUrl}")),
                  );
                },
                itemCount: c1!.hits!.length,
              );
            }
            return Container(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
