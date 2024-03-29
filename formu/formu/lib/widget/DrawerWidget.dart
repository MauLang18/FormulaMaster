import 'package:flutter/material.dart';
import 'package:formu/page/compuestos.dart';
import 'package:formu/page/constantes.dart';
import 'package:formu/page/conversiones.dart';
import 'package:formu/page/perfil.dart';
import 'package:formu/provider/NavigationProvider.dart';
import 'package:formu/data/Drawer_items.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../model/Drawer_item.dart';

class DrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = provider.isCollapsed;

    return Container(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
        child: Container(
          color: Color(0xff1a2f45),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
                width: double.infinity,
                color: Colors.white12,
                child: buildHeader(isCollapsed),
              ),
              buildList(items: itemsFirst, isCollapsed: isCollapsed),
              const SizedBox(
                height: 24,
              ),
              Divider(
                color: Colors.white70,
              ),
              const SizedBox(
                height: 24,
              ),
              Spacer(),
              buildCollapseIcon(context, isCollapsed),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList({
    required bool isCollapsed,
    required List<DrawerItem> items,
    int indexOffset = 0,
  }) =>
      ListView.separated(
        padding: isCollapsed ? EdgeInsets.zero : padding,
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () => selectItem(context, index),
          );
        },
      );

  void selectItem(BuildContext context, int index) {
    /*final navigateTo = (page) => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => page,
        ));*/

    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => constantes()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => conversiones()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => compuestos()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => perfil()));
        break;
    }
  }

  Widget buildMenuItem({
    required bool isCollapsed,
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final leading = Icon(icon, color: color);

    return Material(
      color: Colors.transparent,
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onClicked,
            )
          : ListTile(
              leading: leading,
              title: Text(
                text,
                style: TextStyle(color: color, fontSize: 16),
              ),
              onTap: onClicked,
            ),
    );
  }

  Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
    final double size = 52;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: width,
            height: size,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          onTap: () {
            final provider =
                Provider.of<NavigationProvider>(context, listen: false);
            provider.toggleIsCollapsed();
          },
        ),
      ),
    );
  }

  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? const FlutterLogo(
          size: 0,
        )
      : Row(
          children: const [
            SizedBox(
              width: 24,
            ),
            Text(
              'Formulas',
              style: TextStyle(fontSize: 32, color: Colors.white),
            )
          ],
        );
}
