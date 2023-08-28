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
            "Pixabay",
            style: TextStyle(color: Colors.yellow),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey,
                height: 50,
                width: double.infinity,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  textAlign: TextAlign.center,
                  controller: contoller.txtanimal,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              contoller.animal.value = contoller.txtanimal.text;
                              contoller.Call("${contoller.txtanimal.text}");
                            });
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                      hintText: "search wallpaper",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
              ),
            ),
            FutureBuilder(
              future: contoller.Call(contoller.animal.value),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  PixabayModel? c1 = snapshot.data;

                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed("/Down", arguments: index);
                            },
                            child: Container(
                                height: 300,
                                width: double.infinity,
                                child: Image.network(
                                    "${c1.hits![index].largeImageUrl}")),
                          ),
                        );
                      },
                      itemCount: c1!.hits!.length,
                    ),
                  );
                }
                return Center(
                    child: Container(child: CircularProgressIndicator()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
