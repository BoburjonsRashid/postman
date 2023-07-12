import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:postman/service/model/users_model.dart';

import '../service/http_service.dart';

import '../service/log_service.dart';
import '../service/model/cars_resonse.dart';

import 'info_page.dart';

class NetworkPage extends StatefulWidget {
  static const String id = "/network_page";
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  var isLoading = false;
  var users=[];

  @override
  void initState() {
    super.initState();
    _apiPostList();

  }

  void _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      users = Network.parsePostList(response) ;
      setState(() {});
    }

    setState(() {
      isLoading = false;
    });
    print(response);
  }

  void _apiPostGet(Cars cars) {
    Network.POST(Network.API_GET, Network.paramsEmpty()).then((response) => {});
  }

  void _apiPostCreate(Cars cars) {
    Network.POST(Network.API_CREATE, Network.paramsCreate(cars))
        .then((response) => {
      _apiPostList(),
    });
  }

  void _apiPostUpdate(Users users) {
    Network.PUT(Network.API_UPDATE + users.name.toString(),
        Network.paramsUpdate(users))
        .then((response) => {
      LogService.i(response.toString()),
    });
  }

  void _apiPostDelete(Users? users) {
    Network.DEL(Network.API_DELETE + (users?.id.toString() ?? ""),
        Network.paramsEmpty())
        .then((response) => {_apiPostList(), print(response)});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Networking'),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: users.length,
              itemBuilder: (ctx, index) {
                return itemHomePost(users[index]);

              },
            ),
            isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : const SizedBox.shrink(),
          ],
        ));
  }

  Widget itemHomePost(Users? users) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              _apiPostDelete(users);
            },
            flex: 3,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EmployeeInfoPage(name: users?.name??'',language: users?.language??'',);
          }));
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                users?.name??'jj',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                users?.language??'jj',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ), // SizedBox
              Text(users?.name ?? '')
            ],
          ),
        ),
      ),
    );
  }
}