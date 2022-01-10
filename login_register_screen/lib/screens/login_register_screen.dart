/*
* Login & Register
* by: viniciosm
* */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_register_screen/components/tab_indicator_painter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen>
    with SingleTickerProviderStateMixin {
  late bool _passwordVisible;
  PageController? _pageController;
  int _selectedIndex = 0;
  Color left = Colors.black;
  Color right = Colors.white;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white70,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                color: Colors.white70,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.chevron_left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: _buildMenuBar(context),
              ),
              Expanded(
                flex: 1,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (i) {
                    if (i == 0) {
                      setState(() {
                        _selectedIndex = 0;
                        right = Colors.white;
                        left = Colors.black;
                      });
                    } else if (i == 1) {
                      setState(() {
                        _selectedIndex = 1;
                        right = Colors.black;
                        left = Colors.white;
                      });
                    }
                  },
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints.expand(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: _buildSignIn(context),
                      ),
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints.expand(),
                        child: Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: _buildSignUp(context),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(
            pageController: _pageController,
            selectedBackground: Colors.teal,
            indicatorWidth: 125,
            xPadding: 25,
            indicatorRadius: 20,
            yPadding: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: _onSignInButtonPress,
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.transparent,
                  shadowColor: Colors.transparent,
                  onSurface: Colors.transparent,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: _selectedIndex == 0
                          ? FontWeight.w700
                          : FontWeight.w600,
                      color: _selectedIndex == 0 ? Colors.white : Colors.black),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.transparent,
                  shadowColor: Colors.transparent,
                  onSurface: Colors.transparent,
                ),
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Register",
                  style: TextStyle(
                      fontWeight: _selectedIndex == 1
                          ? FontWeight.w700
                          : FontWeight.w600,
                      color: _selectedIndex == 1 ? Colors.white : Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.black26),
        ),
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding:
                  EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 32),
              child: Container(
                width: 340.0,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(letterSpacing: 0.1),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(letterSpacing: 0.1),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        style: TextStyle(letterSpacing: 0.1),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(letterSpacing: 0.1),
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_passwordVisible
                                ? MdiIcons.eyeOffOutline
                                : MdiIcons.eyeOutline),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: _passwordVisible,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      alignment: Alignment.centerRight,
                      child: Text("Forgot Password ?",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                //elevation: 0,
                //borderRadiusAll: 4,
                onPressed: () {},
                child: Text("LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.black26),
        ),
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 36),
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(fontWeight: FontWeight.w500),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: TextFormField(
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: TextFormField(
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: "Number",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500),
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: TextFormField(
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500),
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? MdiIcons.eyeOffOutline
                              : MdiIcons.eyeOutline),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: _passwordVisible,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                  //elevation: 0,
                  //borderRadiusAll: 4,
                  onPressed: () {},
                  child: Text("REGISTER",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5))),
            ),
          ],
        ),
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController!.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
