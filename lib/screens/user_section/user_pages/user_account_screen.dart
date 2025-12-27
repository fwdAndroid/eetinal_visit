import 'package:eetinal_visit/screens/common_pages/change_language.dart';
import 'package:eetinal_visit/screens/common_pages/contact_us.dart';
import 'package:eetinal_visit/screens/common_pages/profile_screen.dart';
import 'package:eetinal_visit/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';



class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
           "Settings",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
      ),

     

      body: SingleChildScrollView(
            child: Column(
              children: [
                /// PROFILE IMAGE OR LOGO
               Image.asset("assets/splash.png", height: 160),

             

                  _tile(
                    context,
                    Icons.person,                    
                        "Profile Setting",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    ),
                  ),

                _tile(
                  context,
                  Icons.language,
                      "Change Language",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ChangeLangage()),
                  ),
                ),

                _tile(
                  context,
                  Icons.payment,
                      "Subscription Page",
                  () {
                    
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const SubscriptionScreen(),
                      //   ),
                      // );
                    
                  },
                ),

                _tile(
                  context,
                  Icons.share,
                  
                      "Invite Friends",
                  () => shareApp(context),
                ),

              

                _tile(
                  context,
                  Icons.contact_mail,
                  
                      "Contact Us",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ContactUs()),
                  ),
                ),

                /// DELETE ACCOUNT
                  _tile(
                    context,
                    Icons.delete_forever,
                   
                        "Delete Account",
                    () => _showDeleteDialog(context),
                    color: Colors.red,
                  ),

                /// LOGOUT
                  _tile(
                    context,
                    Icons.logout,
                   "Log Out",
                    () => _showLogoutDialog(context),
                    color: Colors.red,
                  ),
              ],
            ),
          )
        
      
    );
  }

  /// LIST TILE
  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color color = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  /// iOS DELETE DIALOG
  void _showDeleteDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Delete Account"),
        content: const Text(
          "This will permanently delete your account. This action cannot be undone.",
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(context);
              await _deleteAccount(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  /// iOS LOGOUT DIALOG
  void _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(context);
           //   await AuthService().signOut(context);
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => const LanguageSelectionScreen(),
              //   ),
              //   (_) => false,
              // );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  /// DELETE ACCOUNT LOGIC
  Future<void> _deleteAccount(BuildContext context) async {

  }

  /// SHARE APP
  void shareApp(BuildContext context) {
    const androidLink =
        "https://play.google.com/store/apps/details?id=com.uaerealestate.app";
    const iosLink =
        "https://apps.apple.com/us/app/victoria-uae-real-estate/id6755954062";

    final box = context.findRenderObject() as RenderBox?;

    Share.share(
      "Download our app:\n\nAndroid: $androidLink\n\niOS: $iosLink",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
