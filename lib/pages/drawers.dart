//dependencies
import 'dart:developer';

import 'package:band_front/cores/widgetutils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//pages
import '../cores/router.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: LayoutBuilder(builder: (context, constraints) {
        double parentWidth = constraints.maxWidth;

        return Padding(
          padding: const EdgeInsets.fromLTRB(32, 64, 32, 32),
          child: Column(
            children: [
              InkWell(
                onTap: () => context.push(RouterPath.myProfilePage),
                child: Material(
                  elevation: 10,
                  shape: const CircleBorder(),
                  shadowColor: Colors.black.withOpacity(1),
                  child: CircleAvatar(
                    radius: parentWidth * 0.3,
                    backgroundImage:
                        const AssetImage('assets/images/empty.png'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                width: parentWidth,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('app setting'),
                ),
              ),
              SizedBox(
                width: parentWidth,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('log out'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xFFFF4040)),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
