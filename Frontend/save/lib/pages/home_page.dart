import 'package:flutter/material.dart';
import 'package:save/category_list.dart';
import 'package:save/pages/login_page.dart';
import 'package:save/pages/tambah_data.dart';
import 'package:save/pages/user_profile.dart';
import 'package:save/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height, width;

  List<String> imgData = [
    "assets/images/notes.png",
    "assets/images/box.png",
    "assets/images/plus.png",
    "assets/images/prof.png",
  ];

  List<String> titles = ["Category", "Produk", "Tambah Data", "Profile"];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

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
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent,
                      ),
                      child: Image.asset(
                        'assets/images/logoremo.png',
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
                      child: TextButton(
                        onPressed: () {
                          _showLogoutDialog(context);
                        },
                        child: Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: 25,
                        ),
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
                child: GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: imgData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        _navigateToPage(context, index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              imgData[index],
                              width: 100,
                            ),
                            SizedBox(height: 10),
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryList()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductList()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfile()),
        );
        break;
    }
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
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  }
}
