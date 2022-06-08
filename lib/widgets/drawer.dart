import 'package:argon_flutter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:argon_flutter/constants/Theme.dart';

import 'package:argon_flutter/widgets/drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {
  final String currentPage;
  final VoidCallback signOut;
  final VoidCallback testSync;

  ArgonDrawer({this.currentPage,this.signOut,this.testSync});

  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ArgonColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Image.asset("assets/img/logo.png"),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(signOut)));
                  },
                  iconColor: ArgonColors.primary,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              // DrawerTile(
              //     icon: Icons.holiday_village,
              //     onTap: () {
              //       if (currentPage != "Cooperatives")
              //        Navigator.pushReplacementNamed(context, '/cooperatives');
              //     },
              //     iconColor: ArgonColors.success,
              //     title: "Cooperatives",
              //     isSelected: currentPage == "Cooperatives" ? true : false),
             DrawerTile(
                  icon: Icons.person_pin,
                  onTap: () {
                    if (currentPage != "Producteurs")
                      Navigator.pushReplacementNamed(context, '/producteurs');
                  },
                  iconColor: ArgonColors.info,
                  title: "Producteurs",
                  isSelected: currentPage == "Producteurs" ? true : false),
              DrawerTile(
                  icon: Icons.map,
                  onTap: () {
                    if (currentPage != "Parcelles")
                      Navigator.pushReplacementNamed(context, '/parcelles');
                  },
                  iconColor: ArgonColors.info,
                  title: "Parcelles",
                  isSelected: currentPage == "Parcelles" ? true : false),

              DrawerTile(
                  icon: Icons.sync_alt,
                  onTap:testSync,
                  iconColor: ArgonColors.info,
                  title: "Lab sync",
                  isSelected: currentPage == "Lab sync" ? true : false),
              // DrawerTile(
              //     icon: Icons.category,
              //     onTap: () {
              //       if (currentPage != "Productions")
              //         Navigator.pushReplacementNamed(context, '/productions');
              //     },
              //     iconColor: ArgonColors.primary,
              //     title: "Productions",
              //     isSelected: currentPage == "Productions" ? true : false),
              //              DrawerTile(
              //     icon: Icons.list_sharp,
              //     onTap: () {
              //       if (currentPage != "Plantings")
              //         Navigator.pushReplacementNamed(context, '/plantings');
              //     },
              //     iconColor: ArgonColors.error,
              //     title: "Plantings",
              //     isSelected: currentPage == "Plantings" ? true : false),
              // DrawerTile(
              //     icon: Icons.apps,
              //     onTap: () {
              //       if (currentPage != "Monitorings")
              //         Navigator.pushReplacementNamed(context, '/monitorings');
              //     },
              //     iconColor: ArgonColors.primary,
              //     title: "Monitorings",
              //     isSelected: currentPage == "Monitorings" ? true : false),

              // DrawerTile(
              //     icon: Icons.place_sharp,
              //     onTap: () {
              //       if (currentPage != "Carte")
              //         Navigator.pushReplacementNamed(context, '/carte');
              //     },
              //     iconColor: ArgonColors.primary,
              //     title: "Carte Parcelles",
              //     isSelected: currentPage == "Carte" ? true : false),
           
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("PARAMETRES",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.vpn_lock_sharp,
                      onTap: signOut,
                      iconColor: ArgonColors.muted,
                      title: "Deconnexion",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
