import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<SearchItem> _dummyResults = [
    SearchItem(title: 'Waifu', imageUrl: 'https://via.placeholder.com/150'),
    SearchItem(title: 'pp', imageUrl: 'https://via.placeholder.com/150'),
    SearchItem(title: 'Wallpaper', imageUrl: 'https://via.placeholder.com/150'),
    SearchItem(title: 'Meme', imageUrl: 'https://via.placeholder.com/150'),
    SearchItem(title: 'Bola', imageUrl: 'https://via.placeholder.com/150'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor : Colors.blue,
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search your Idea',
            icon: Icon(Icons.search),
            border: InputBorder.none,
          ),
          onSubmitted: (query) {
            setState(() {
              // In a real app, you would use the query to fetch results from an API.
              // Here, we just use dummy data.
            });
          },
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _dummyResults.length,
        itemBuilder: (context, index) {
          final item = _dummyResults[index];
          return Card(
            child: Column(
              children: [
                Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SearchItem {
  final String title;
  final String imageUrl;

  SearchItem({required this.title, required this.imageUrl});
}
