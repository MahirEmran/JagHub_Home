import 'package:mad2_leaderboard/leaderboard.dart';
import 'package:mad2_login/authentication.dart';
import 'package:mad2_login/sign_in_screen.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'user_eventlistview.dart';
import 'user_eventpage.dart';
import 'user_itemsview.dart';
import 'user_stats_settings.dart';

import 'package:mad2_db_dataobjects/API.dart';
import 'package:mad2_db_dataobjects/event_data.dart';
import 'package:mad2_db_dataobjects/group_data.dart';
import 'package:mad2_db_dataobjects/prize_data.dart';
import 'package:mad2_db_dataobjects/user_data.dart';
import 'package:mad2_shop/shop_page.dart';
import 'package:mad2_browsepage/browse_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late UserData currentUser;
  late List<UserData> users;
  late int userPosition;
  late int eventsJoined;
  late int purchasedItemCount;
  late int currentUserPlace;
  bool _isSigningOut = false;
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    API().getCurrentUserData().then((value) {
      currentUser = value;
      eventsJoined =
          currentUser.currentEvents.length + currentUser.pastEvents.length;
      purchasedItemCount = currentUser.pendingPurchasedItems.length;
      API().getUserList().then((value) {
        users = value;
        users.sort((a, b) => b.points.compareTo(a.points));
        for (int i = 0; i < users.length; i++) {
          UserData user = users[i];
          if (user.userId == currentUser.userId) {
            currentUserPlace = i + 1;
            break;
          }
        }
        dataLoaded = true;
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (dataLoaded) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(30, 40, 0, 0),
                            child: Text(
                              'Welcome Back',
                              style: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30, 5, 0, 0),
                                  child: FittedBox(
                                    alignment: Alignment.topLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      currentUser.name,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 34,
                                            color: Colors.black,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.53,
                              height: 177,
                              constraints: BoxConstraints(
                                maxWidth: 153,
                                maxHeight: 177,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(34),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 45, 5, 0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text: currentUser.points.toString(),
                                      icon: Icon(
                                        Icons.star_rounded,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                      options: FFButtonOptions(
                                        elevation: 0,
                                        width: 130,
                                        color: Color.fromARGB(255, 75, 57, 239),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 48,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 8,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Total Points',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.53,
                              height: 177,
                              constraints: BoxConstraints(
                                maxWidth: 153,
                                maxHeight: 177,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                  255,
                                  241,
                                  244,
                                  248,
                                ),
                                borderRadius: BorderRadius.circular(34),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 35, 5, 0),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LeaderboardPage(),
                                            ),
                                          );
                                        },
                                        text: '#' + currentUserPlace.toString(),
                                        icon: Icon(
                                          Icons.bar_chart,
                                          size: 33,
                                          color: Colors.black,
                                        ),
                                        options: FFButtonOptions(
                                          elevation: 0,
                                          width: 130,
                                          color: Color.fromARGB(
                                            255,
                                            241,
                                            244,
                                            248,
                                          ),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .title1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 42,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius: 8,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'School Rank',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.53,
                              height: 177,
                              constraints: BoxConstraints(
                                maxWidth: 153,
                                maxHeight: 177,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                  255,
                                  241,
                                  244,
                                  248,
                                ),
                                borderRadius: BorderRadius.circular(34),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 35, 5, 0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserEventListView(
                                              currentUser: currentUser,
                                            ),
                                          ),
                                        );
                                      },
                                      text: eventsJoined.toString(),
                                      icon: Icon(
                                        Icons.place,
                                        size: 35,
                                      ),
                                      options: FFButtonOptions(
                                        elevation: 0,
                                        width: 130,
                                        color: Color.fromARGB(
                                          255,
                                          241,
                                          244,
                                          248,
                                        ),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 50,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 8,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Events Attended',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.53,
                              height: 177,
                              constraints: BoxConstraints(
                                maxWidth: 153,
                                maxHeight: 177,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                  255,
                                  241,
                                  244,
                                  248,
                                ),
                                borderRadius: BorderRadius.circular(34),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 35, 5, 0),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserItemsView(
                                                currentUser: currentUser,
                                              ),
                                            ),
                                          );
                                        },
                                        text: purchasedItemCount.toString(),
                                        icon: Icon(
                                          Icons.shopping_cart,
                                          size: 33,
                                          color: Colors.black,
                                        ),
                                        options: FFButtonOptions(
                                          elevation: 0,
                                          width: 130,
                                          color: Color.fromARGB(
                                            255,
                                            241,
                                            244,
                                            248,
                                          ),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .title1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 50,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius: 8,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Items Purchased',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.53,
                              height: 177,
                              constraints: BoxConstraints(
                                maxWidth: 153,
                                maxHeight: 177,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                  255,
                                  241,
                                  244,
                                  248,
                                ),
                                borderRadius: BorderRadius.circular(34),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        await _helpMenuDialog(context);
                                      },
                                      text: "",
                                      icon: Icon(
                                        Icons.question_mark_rounded,
                                        size: 60,
                                        color: Colors.black,
                                      ),
                                      options: FFButtonOptions(
                                        elevation: 0,
                                        width: 130,
                                        color: Color.fromARGB(
                                          255,
                                          241,
                                          244,
                                          248,
                                        ),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 55,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 8,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      'Help',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.53,
                              height: 177,
                              constraints: BoxConstraints(
                                maxWidth: 153,
                                maxHeight: 177,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                  255,
                                  241,
                                  244,
                                  248,
                                ),
                                borderRadius: BorderRadius.circular(34),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 25, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserStatsSettings(
                                              currentUser: currentUser,
                                            ),
                                          ),
                                        );
                                      },
                                      text: "",
                                      icon: Icon(
                                        Icons.query_stats_sharp,
                                        size: 60,
                                        color: Colors.black,
                                      ),
                                      options: FFButtonOptions(
                                        elevation: 0,
                                        width: 130,
                                        color: Color.fromARGB(
                                          255,
                                          241,
                                          244,
                                          248,
                                        ),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 55,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 8,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      'View Statistics',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _isSigningOut
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.redAccent,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isSigningOut = true;
                            });
                            await Authentication.signOut(context: context);
                            setState(() {
                              _isSigningOut = false;
                            });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                            child: Text(
                              'Sign Out',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Future<void> _helpMenuDialog(BuildContext context) async {
    bool okPressed = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            title: Text(
              'Help Menu',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Rubik_bold',
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .8,
                child: Column(
                  children: [
                    Text(
                      'Welcome to JagHub!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      'placehodlder',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        elevation: 2,
                        backgroundColor: Color.fromARGB(255, 76, 56, 239),
                      ),
                      child: Text('Ok'),
                      onPressed: () {
                        setState(() {
                          okPressed = true;
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }).then((val) async {
      if (!okPressed) {
        return;
      }

      setState(() {});
    });
  }
}
