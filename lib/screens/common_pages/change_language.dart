import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/material.dart';

class ChangeLangage extends StatefulWidget {
  const ChangeLangage({super.key});

  @override
  State<ChangeLangage> createState() => _ChangeLangageState();
}

class _ChangeLangageState extends State<ChangeLangage> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: colorWhite,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorWhite),
        backgroundColor: mainColor,
        title: Text(
        "Language",
          style: TextStyle(color: colorWhite),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/splash.png", height: 150),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 16),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                 
                      'Select Language',
                ),
              ),
            ),

            // ListTile for English
            // ListTile for English
            ListTile(
              onTap: () {
              //  languageProvider.changeLanguage('en'); // Change to English
              },
              trailing: Icon(
                Icons.radio_button_checked,
                  
                color: colorBlack,
                size: 20,
              ),
              title: Text(
               "English",
                style: TextStyle(color: colorBlack),
              ),
            ),
            // ListTile for French
            ListTile(
              onTap: () {
           //     languageProvider.changeLanguage('fr'); // Change to Frenchs
              },
              trailing: Icon(
              
                     Icons.radio_button_off,
                color: colorBlack,
                size: 20,
              ),
              title: Text("Français", style: TextStyle(color: colorBlack)),
            ),

            // ListTile for Portuguese
            ListTile(
              onTap: () {
                //languageProvider.changeLanguage('pt'); // Change to French
              },
              trailing: Icon(
               
                     Icons.radio_button_off,
                color: colorBlack,
                size: 20,
              ),
              title: Text("Português", style: TextStyle(color: colorBlack)),
            ),
            // ListTile for Spanish
            ListTile(
              onTap: () {
              //  languageProvider.changeLanguage('es'); // Change to French
              },
              trailing: Icon(
                Icons.radio_button_off,
                color: colorBlack,
                size: 20,
              ),
              title: Text("Español", style: TextStyle(color: colorBlack)),
            ),
            // ListTile for German
            ListTile(
              onTap: () {
               // languageProvider.changeLanguage('de'); // Change to French
              },
              trailing: Icon(
                Icons.radio_button_off,
                color: colorBlack,
                size: 20,
              ),
              title: Text("Deutsch", style: TextStyle(color: colorBlack)),
            ),
          ],
        ),
      ),
    );
  }
}
