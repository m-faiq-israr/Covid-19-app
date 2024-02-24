import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/Services/api_data_fetch.dart';
import 'package:flutter_application_2/main_screen.dart';
import 'package:shimmer/shimmer.dart';

class contries_list_screen extends StatefulWidget {
  const contries_list_screen({super.key});

  @override
  State<contries_list_screen> createState() => _contries_list_screenState();
}

class _contries_list_screenState extends State<contries_list_screen> {
  TextEditingController search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: search_controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: statesServices.contrieslistApi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Shimmer.fromColors(
                    //shimmer is for showing loading list animation
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade800,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                            )
                          ],
                        );
                      },
                    ));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(snapshot.data![index]['country']),
                          subtitle:
                              Text(snapshot.data![index]['cases'].toString()),
                          leading: Image(
                              image: NetworkImage(snapshot.data![index]
                                  ['countryInfo']['flag'])),
                        )
                      ],
                    );
                  },
                );
              }
            },
          ))
        ]),
      ),
    );
  }
}
