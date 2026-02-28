import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_app/models/album_model.dart';

import 'package:http/http.dart' as http;

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  List<AlbumModel> _albums = [];
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchAlbums() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Delay simulation
    await Future.delayed(Duration(seconds: 2));

    try {
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/albums"),
        headers: {"Accept": "applicaiton/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final albums = jsonData.map((e) => AlbumModel.fromJson(e)).toList();

        if (!context.mounted) return;
        setState(() {
          _albums = albums;
        });
      } else {
        throw Exception(
          'Exception: ${response.statusCode} and ${response.body}',
        );
      }
    } on SocketException catch (e) {
      if (!context.mounted) return;
      setState(() {
        _error = "No internet connection: ${e.message}";
      });
    } catch (e) {
      if (!context.mounted) return;
      setState(() {
        _error = "An unknown error occurred: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // To load the albums when the build method is called
  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Albums from API"),
        elevation: 1,
        surfaceTintColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        titleTextStyle: TextStyle(fontSize: 16),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white, size: 24),
        actions: [
          IconButton(
            onPressed: () async {
              await _fetchAlbums();
            },
            icon: Icon(Icons.download_rounded),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 10),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
            colors: [Colors.pink.shade300, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: _isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        // backgroundColor: Colors.white,
                        color: Colors.black,
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Loading albums"),
                  ],
                ),
              )
            : _error != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(height: 10),
                    Text("$_error"),
                  ],
                ),
              )
            : _albums.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.insert_page_break_rounded),
                    SizedBox(height: 10),
                    Text(
                      "No albums yet.\nPlease fetch Tap the button to fetch the data",
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _albums.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("${_albums[index].id}"),
                      ),
                      title: Text(_albums[index].title),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
