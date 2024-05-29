import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.png'), // Add your image asset
              ),
              SizedBox(height: 20),
              Text(
                'Arif Muhammad',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Arif Muhammad'),
              Text('0 Pengikut · 0 Mengikuti'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Edit Profil'),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black,
                      indicatorWeight: 3.0,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      labelPadding: EdgeInsets.symmetric(horizontal: 10.0), 
                      tabs: [
                        Tab(text: 'Dibuat'),
                        Tab(text: 'Disimpan'),
                      ],
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 10.0), 
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: TabBarView(
                        children: [
                          CreatedTab(),
                          SavedTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreatedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 6, // Number of items in the grid
      itemBuilder: (context, index) {
        return Image.asset('assets/sample_image.png'); // Replace with your images
      },
    );
  }
}

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 6, // Number of items in the grid
      itemBuilder: (context, index) {
        return Image.asset('assets/sample_image.png'); // Replace with your images
      },
    );
  }
}
