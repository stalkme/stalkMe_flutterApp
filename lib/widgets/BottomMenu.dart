import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:stalkme_app/tabs/friendTab.dart';
import 'package:stalkme_app/tabs/filterTab.dart';
import 'package:stalkme_app/widgets/navBar.dart';
import 'package:stalkme_app/util/deviceSize.dart';

class BottomMenu extends StatefulWidget {
  BottomMenu(
      {Key key,
      @required this.googleMapController,
      @required this.panelController})
      : super(key: key);
  final Completer<GoogleMapController> googleMapController;
  final PanelController panelController;

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.6 + 66,
      child: Column(
        children: <Widget>[
          NavBar(
            tabController: tabController,
            panelController: widget.panelController,
            controller: widget.googleMapController,
          ),
          SizedBox(height: 5),
          Expanded(
            child: ContextMenu(
              tabController: tabController,
              googleMapController: widget.googleMapController,
            ),
          ),
        ],
      ),
    );
  }
}

class ContextMenu extends StatefulWidget {
  ContextMenu(
      {Key key,
      @required this.tabController,
      @required this.googleMapController})
      : super(key: key);
  final TabController tabController;
  final Completer<GoogleMapController> googleMapController;
  @override
  _ContextMenuState createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return TabBarView(
      controller: widget.tabController,
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.tabController.animation,
          builder: (BuildContext context, snapshot) {
            return Transform.scale(
              alignment: Alignment.bottomCenter,
              scale: 1 - widget.tabController.animation.value * 0.05,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x26000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                ),
                child: FriendTab(
                  googleMapController: widget.googleMapController,
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: widget.tabController.animation,
          builder: (BuildContext context, snapshot) {
            return Transform.scale(
              alignment: Alignment.bottomCenter,
              scale: 1 - (1 - widget.tabController.animation.value) * 0.05,
              child: Container(
                height: size.height * 0.6,
                width: size.width,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x26000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                ),
                child: FilterTab(),
              ),
            );
          },
        ),
      ],
    );
  }
}
