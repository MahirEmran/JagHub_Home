import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mad2_db_dataobjects/event_data.dart';
import 'package:mad2_db_dataobjects/prize_data.dart';
import 'package:mad2_db_dataobjects/user_data.dart';
import 'package:mad2_db_dataobjects/API.dart';
import 'package:mad2_home/user_eventpage.dart';
import 'package:mad2_shop/confirmation_page.dart';

class UserItemsView extends StatefulWidget {
  UserData currentUser;
  UserItemsView({Key? key, required this.currentUser}) : super(key: key);

  @override
  _UserItemsViewState createState() => _UserItemsViewState(currentUser);
}

class _UserItemsViewState extends State<UserItemsView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late UserData userInfo;
  late List<PrizeData> userPrizes = [];
  late List<Widget> prizeWidgetList = [];
  late List<String> userPrizeCodes = [];
  late List<String> userPrizeIds = [];
  late List<String> userPrizeDates = [];
  bool dataLoaded = false;
  late Widget body;
  _UserItemsViewState(currentUser) {
    userInfo = currentUser;
    userInfo.pendingPurchasedItems.forEach((key, value) {
      List<String> values = ((value as List).cast<String>());
      String expirationDate = values[1];
      DateFormat formatter = new DateFormat("MM-dd-yyyy");

      DateTime dt = formatter.parse(expirationDate);
      if (!dt.isBefore(DateTime.now())) {
        userPrizeCodes.add(key);
        userPrizeIds.add(values[0]);
        userPrizeDates.add(values[1]);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    API().getPrizes(userPrizeIds).then(
      (value) {
        userPrizes = value;
        for (int i = 0; i < userPrizes.length; i++) {
          prizeWidgetList.add(
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConfirmationPage(
                        code: userPrizeCodes[i],
                        comingFromBuyPage: false,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ListTile(
                              title: Text(
                                userPrizes[i].name,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                "Expires on " + userPrizeDates[i],
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color.fromARGB(255, 52, 51, 51),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              tileColor: Color(0xFFF5F5F5),
                              dense: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 85,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 75, 57, 239),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 5, 0),
                                  child: Icon(
                                    Icons.star_rounded,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                Text(
                                  userPrizes[i].pointCost.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (prizeWidgetList.length > 0) {
          body = Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.88,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  for (var item in prizeWidgetList) (item),
                  SizedBox(height: 15),
                ],
              ),
            ),
          );
        } else {
          body = Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.88,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'You have not bought any prizes yet. Earn some points and get some!',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    tileColor: Color(0xFFF5F5F5),
                    dense: false,
                  ),
                ],
              ),
            ),
          );
        }

        dataLoaded = true;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!dataLoaded) {
      body = CircularProgressIndicator(color: Colors.black);
    }
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    25, 30, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Text(
                                      'Bought Items',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ],
                                ),
                              ),
                              body,
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
