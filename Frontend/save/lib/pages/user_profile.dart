import 'package:flutter/material.dart';
import 'package:save/pages/edit_profile.dart';
import 'package:save/pages/home_page.dart';
import 'package:save/pages/login_page.dart';


class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the screen height and width
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.yellow,
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: height * 0.25,
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent,
                      ),
                      child: Image.asset(
                        'assets/images/logoremo.png', // Ganti dengan path gambar Anda
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () {
                          _showLogoutDialog(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(65),
                    topRight: Radius.circular(65),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 75,
                        backgroundImage: AssetImage('assets/images/prof.png'), // Path to profile picture
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Remy',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'remy11@gmail.com',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfile()),
                          );
                        },
                        child: Text('Edit Profile'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Apakah Anda yakin ingin logout?"),
          actions: [
            TextButton(
              child: Text("Iya"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            TextButton(
              child: Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
