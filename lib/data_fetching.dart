import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/models/post_model.dart';

class DataFetching extends StatefulWidget {
  const DataFetching({super.key});

  @override
  State<DataFetching> createState() => _DataFetchingState();
}

class _DataFetchingState extends State<DataFetching> {
  List<dynamic> _posts = [];
  bool _isLoading = false;
  String? _error;

  Future<void> _getPosts() async {
    debugPrint("Fetching posts...");
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://jsonplaceholder.typicode.com/posts',
        ), // or 'https://dummyjson.com/posts'
        headers: {
          'Accept': 'application/json',
          'User-Agent':
              'Mozilla/5.0 (Linux; Android 14) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0 Mobile Safari/537.36',
        },
      );

      debugPrint("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final posts = jsonData.map((json) => Posts.fromJson(json)).toList();

        setState(() => _posts = posts);
        debugPrint("Loaded ${_posts.length} posts");
      } else {
        setState(() {
          _error =
              'Error ${response.statusCode}: ${response.body.substring(0, 150)}...';
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
      debugPrint("Exception: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Fetching (get)"), elevation: 1),
      backgroundColor: Colors.green.shade100,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(8),
        child: _isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Loading posts..."),
                  ],
                ),
              )
            : _error != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text("Error: $_error", textAlign: TextAlign.center),
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      onPressed: _getPosts,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Try Again"),
                    ),
                  ],
                ),
              )
            : _posts.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.insert_page_break,
                      size: 42,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "No posts yet.\nTap the button to fetch.",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _getPosts,
                      icon: const Icon(Icons.download_rounded),
                      label: const Text("Fetch Posts"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(
                        post.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : _getPosts, // disable when loading
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.download_rounded),
      ),
    );
  }
}
