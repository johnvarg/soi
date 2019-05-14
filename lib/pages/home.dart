import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soi/constant/images.dart';
import 'package:soi/ui/card_more_widget.dart';
import 'package:soi/ui/card_widget.dart';
import 'package:soi/ui/home_page_custom_shape.dart';
import 'package:soi/ui/likebutton/LikeButton.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  PageController _pageController;

  int _tabbarIndex = 0;
  bool selectedColor = true;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: _tabbarIndex);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _tabbarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: buildBottomNavigationBar(),
      endDrawer: Stack(
        children: <Widget>[
          Theme(
            data: ThemeData(canvasColor: Colors.transparent),
            child: Container(
              width: 80,
              height: 150,
              child: Drawer(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      width: 80,
                      height: 75,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      height: 75,
                      width: 80,
                      child: Icon(
                        Icons.contact_phone,
                        color: Colors.white,
                        size: 32,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 42,
            top: -10,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: _media.width,
                height: _media.height,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            buildHeaderStack(_media),
                            buildHomeMainContainer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Container(
                width: _media.width,
                height: _media.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: _media.height,
                      width: double.infinity,
                      child: Container(),
                    ),
                    Container(
                      child: Center(child: Text('Map will display here')),
                    ),
                    buildHeaderStack(_media),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Stack buildHeaderStack(Size _media) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: Platform.isIOS ? 200 : 150,
            width: _media.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlue,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Padding(
          padding: Platform.isAndroid
              ? EdgeInsets.only(left: 20, top: 30, right: 10)
              : EdgeInsets.only(left: 20, top: 50, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'SOI',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print('Filter Pressed');
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.tune,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print('Filter Pressed');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        buildPositionedButtons(),
      ],
    );
  }

  Container buildHomeMainContainer() {
    return Container(
        child: Center(
      child: Center(
        child: Center(
          child: _tabbarIndex == 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, bottom: 10),
                      child: Text(
                        "Featured Kitchens in Atlanta, GA",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Container(
                        height: 280,
                        child: NotificationListener(
                          onNotification: (overscroll) {
                            overscroll.disallowGlow();
                          },
                          child: ListView.builder(
                            padding: EdgeInsets.only(right: 20),
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: AppImages.image1.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CardListWidget(
                                heartIcon: LikeButton(
                                  key: ObjectKey(index.toString()),
                                  width: 70,
                                ),
                                image: AppImages.image1[index],
                                foodDetail: "Food title/description",
                                foodName: "Kitchen Name",
                                vote: 4.5,
                                foodTime: "May 14",
                                distance: 3.4,
                                price: 7.99,
                                quantity: 5,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      height: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 22.0, bottom: 10),
                      child: Text(
                        "More Kitchens in Atlanta, GA",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    CardMoreWidget(
                        image: AppImages.image1[1],
                        foodDetail: "Desert - Fast Food - Alcohol",
                        foodName: "Cafe De Ankara",
                        vote: 4.5,
                        status: "CLOSED",
                        statusColor: Colors.red,
                        heartIcon: LikeButton(
                          width: 70,
                        ),
                        foodTime: "May 14",
                        distance: 3.4,
                        price: 7.99,
                        quantity: 5),
                    CardMoreWidget(
                      heartIcon: LikeButton(
                        width: 70,
                      ),
                      image: AppImages.image1[0],
                      foodDetail: "Desert - Fast Food - Alcohol",
                      foodName: "Cafe De NewYork",
                      vote: 4.5,
                      status: "OPEN",
                      statusColor: Colors.green,
                      foodTime: "May 14",
                      distance: 3.4,
                      price: 7.99,
                      quantity: 5,
                    ),
                  ],
                )
              : _tabbarIndex == 1
                  ? Text('Shopping Cart Screen')
                  : _tabbarIndex == 2
                      ? Text('Store/Kitchen Screen')
                      : Text('Messages Screen'),
        ),
      ),
    ));
  }

  Widget buildFloatingActionButton() {
    return GestureDetector(
      onTap: () {
        print("This button will display order status");

        final snackBar =
            SnackBar(content: Text('This button will display order status'));

// Find the Scaffold in the Widget tree and use it to show a SnackBar
        _scaffoldKey.currentState.showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 12),
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.lightBlue.withOpacity(0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Colors.blue, blurRadius: 12, offset: Offset(0, 5)),
            ]),
        child: Icon(
          Icons.fastfood,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return SafeArea(
      child: TabBar(
          onTap: onTabTapped,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black.withOpacity(0.55),
          indicatorColor: Colors.blue,
          indicatorWeight: 3,
          indicator: UnderlineTabIndicator(
              insets: EdgeInsets.only(bottom: 46),
              borderSide: BorderSide(color: Colors.blue, width: 3)),
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(
                FontAwesomeIcons.home,
              ),
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.shoppingCart),
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.store),
            ),
            Tab(
              icon: Icon(Icons.chat_bubble),
            ),
          ]),
    );
  }

  Positioned buildPositionedButtons() {
    return Positioned(
      bottom: 10,
      left: 40,
      right: 40,
      child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 8,
                spreadRadius: 1,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (_pageController.page.abs() != 0) {
                    _pageController.jumpToPage(0);
                    setState(() {
                      selectedColor = true;
                    });
                  } else {
                    selectedColor = false;
                  }
                },
                child: Text(
                  "List View",
                  style: TextStyle(
                    color: selectedColor ? Colors.blue : Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VerticalDivider(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_pageController.page.abs() != 1) {
                    _pageController.jumpToPage(1);
                    setState(() {
                      selectedColor = false;
                    });
                  } else {
                    selectedColor = true;
                  }
                },
                child: Text(
                  "Map View",
                  style: TextStyle(
                    color: selectedColor ? Colors.grey : Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
