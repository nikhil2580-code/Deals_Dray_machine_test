
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    Text("Home Page"),
    Text("Categories Page"),
    Text("Deals Page"),
    Text("Cart Page"),
    Text("Profile Page"),

  ];

  @override
  State<Landingpage> createState() => _LandingPageState();
}

class _LandingPageState extends State<Landingpage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Expanded(
            child: Container(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  hintText:"Search here",
                    hintStyle: TextStyle(fontSize: 18),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 11),
                  prefixIcon: SizedBox(
                    width: 20,
                    height: 20,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, top: 2, bottom: 3, right: 4),
                      child: Image.asset("assets/svg/searchlogo.png",
                      fit: BoxFit.cover,),
                    ),
                  ),
                  suffixIcon: Icon(Icons.search)
                ),
              ),
            ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              CupertinoIcons.bell,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mqh * .03,
            ),
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                ),
                items: [
                  CardItem(color: Colors.red),
                  CardItem(color: Colors.blue),
                  CardItem(color: Colors.green),
                  CardItem(color: Colors.orange),
                  CardItem(color: Colors.purple),
                ],
              ),
            ),
            SizedBox(
              height: mqh * .03,
            ),
            Container(
              height: mqh * .28,
              width: mqw * .9,
              decoration: BoxDecoration(
                  color: Colors.cyan.shade900,
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: mqh * .03,
                    ),
                    Text(
                      "KYC Pending",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: mqh * .02,
                    ),
                    Text(
                      "You need to provide the required\ndocuments for your account activation",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: mqh * .03,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "CLICK HERE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mqh * .03,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAvatar(
                        'Mobile', Icons.phone_android, Colors.cyan.shade900),
                    _buildAvatar('Laptop', Icons.laptop, Colors.greenAccent),
                    _buildAvatar('Camera', Icons.camera_alt, Colors.pinkAccent),
                    _buildAvatar('LED', Icons.lightbulb, Colors.orangeAccent),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mqh * .03,
            ),
            Container(
              height: mqh * .55,
              color: Colors.lightBlueAccent,
              child: Column(
                children: [
                  SizedBox(
                    height: mqh * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EXCLUSIVE FOR YOU",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right,
                          size: 25,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mqh * .04,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                          child: Row(
                            children: List.generate(8, (index) {
                              // Generate a container with a random color
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                height: mqh * .8,
                                width: mqw * 0.5,
                                // Set the width of each item
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/svg/product.png"),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          'Rs. 1000',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          'Mobile phone demo',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                              overflow: TextOverflow.ellipsis),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: mqh * .02,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Deals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
class CardItem extends StatelessWidget {
  final Color color;

  const CardItem({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Image.asset(
              "assets/svg/headphone.jpg",
              fit: BoxFit.contain,
            )
          // Text(
          //   'Deals Dray',
          //   style: TextStyle(
          //     fontSize: 24.0,
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ),
      ),
    );
  }
}

Widget _buildAvatar(String name, IconData iconData, Color color) {
  return Column(
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: color,
        child: Icon(
          iconData,
          size: 30,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 10),
      Text(
        name,
        style: TextStyle(fontSize: 15),
      ),
    ],
  );
}