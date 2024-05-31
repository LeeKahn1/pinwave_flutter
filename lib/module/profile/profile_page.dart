import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.png'), // Add your image asset
              ),
              const SizedBox(height: 20),
              const Text(
                'Arif Muhammad',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text('Arif Muhammad'),
              const Text('0 Pengikut · 0 Mengikuti'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Edit Profil'),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const TabBar(
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
                      child: const TabBarView(
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
  const CreatedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
  const SavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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