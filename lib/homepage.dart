// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_task/api.dart';
import 'package:flutter_task/details.dart';
import 'package:flutter_task/model.dart';
import 'package:ndialog/ndialog.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Search futureSearch;
  bool _hasBeenPressed1 = false;
  bool _hasBeenPressed2 = false;
  bool _hasBeenPressed3 = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  showLoaderDialog(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Please wait for a moment"),
        title: Text("Updating Membership"));
    progressDialog.setLoadingWidget(CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.blue),
    ));
    progressDialog.show();
  }

  @override
  void initState() {
    showLoaderDialog(context);
    fetchSearch().then((value) {
      setState(() {
        futureSearch = value;
      });

      // ignore: unrelated_type_equality_checks
      if (futureSearch.response == 'True') {
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(top: 15),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/r.jpg"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Chelsea Brett",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey.shade800,
                          border: InputBorder.none,
                          hintText: 'Search'),
                      maxLines: 1,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: _hasBeenPressed1
                            ? Colors.pink
                            : Colors.grey.shade800, // This is what you need!
                      ),
                      onPressed: () => {
                            setState(() {
                              _hasBeenPressed1 = !_hasBeenPressed1;
                            }),
                            _hasBeenPressed1
                                ? setState(() {
                                    _hasBeenPressed2 = false;
                                    _hasBeenPressed3 = false;
                                  })
                                : ""
                          },
                      child: Text("Movies")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: _hasBeenPressed2
                            ? Colors.pink
                            : Colors.grey.shade800, // This is what you need!
                      ),
                      onPressed: () => {
                            setState(() {
                              _hasBeenPressed2 = !_hasBeenPressed2;
                            }),
                            _hasBeenPressed2
                                ? setState(() {
                                    _hasBeenPressed1 = false;
                                    _hasBeenPressed3 = false;
                                  })
                                : ""
                          },
                      child: const Text("Shows")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: _hasBeenPressed3
                            ? Colors.pink
                            : Colors.grey.shade800, // This is what you need!
                      ),
                      onPressed: () => {
                            setState(() {
                              _hasBeenPressed3 = !_hasBeenPressed3;
                            }),
                            _hasBeenPressed3
                                ? setState(() {
                                    _hasBeenPressed1 = false;
                                    _hasBeenPressed2 = false;
                                  })
                                : ""
                          },
                      child: const Text("Music")),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "NEW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctx, int index) {
                          /*  return Text(futureSearch.search[index].poster,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      )); */
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details(
                                            title: futureSearch
                                                .search[index].title,
                                          )),
                                );
                              },
                              child: Image.network(
                                  futureSearch.search[index].poster,
                                  width: 130),
                            ),
                          );
                        },
                        itemCount: futureSearch.search.length,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "POPULAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctx, int index) {
                          /*  return Text(futureSearch.search[index].poster,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      )); */
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details(
                                            title: futureSearch
                                                .search[index].title,
                                          )),
                                );
                              },
                              child: Image.network(
                                  futureSearch.search[index].poster,
                                  width: 130),
                            ),
                          );
                        },
                        itemCount: futureSearch.search.length,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "TRENDING",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctx, int index) {
                          /*  return Text(futureSearch.search[index].poster,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      )); */
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details(
                                            title: futureSearch
                                                .search[index].title,
                                          )),
                                );
                              },
                              child: Image.network(
                                  futureSearch.search[index].poster,
                                  width: 130),
                            ),
                          );
                        },
                        itemCount: futureSearch.search.length,
                      ),
                    ),
                  ]))),

              /*  Center(
                child: FutureBuilder<Search>(
                  future: futureSearch as Future<Search>,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!.response);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ), */
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            //backgroundColor: Colors.grey.shade800,
            //fixedColor: Colors.grey.shade800,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  backgroundColor: Colors.grey.shade800,
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  backgroundColor: Colors.grey.shade800,
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  backgroundColor: Colors.grey.shade800,
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  backgroundColor: Colors.grey.shade800,
                  label: ''),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.pink[400],
            iconSize: 35,
            onTap: _onItemTapped,
            elevation: 5),
      ),
    );
  }
}

moviebutton() {}
