import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/image_model.dart';
import 'package:http/http.dart' as http;

class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({super.key});

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

Widget _buildImageItem(ImageModel image) {
  debugPrint(image.downloadUrl);
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),

    child: CachedNetworkImage(
      imageUrl: image.downloadUrl,
      height: 100,
      width: 100,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.low,

      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),

      errorWidget: (context, url, error) => Container(
        color: Colors.grey[300],
        child: const Icon(Icons.broken_image, color: Colors.grey),
      ),
    ),
  );
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  List<ImageModel> _images = [];
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchImages() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.get(
        Uri.parse("https://picsum.photos/v2/list?page=1&limit=20"),
        headers: {"Accept": 'application/json'},
      );

      if (response.statusCode == 200) {
        debugPrint("Response Received");
        debugPrint("Body Previews: ${response.body.substring(0, 200)}");

        final List<dynamic> jsonData = jsonDecode(response.body);
        debugPrint('📋 Parsed ${jsonData.length} items');

        final images = jsonData.map((e) => ImageModel.fromJson(e)).toList();
        debugPrint('🎨 Converted to ${images.length} ImageModel objects');

        if (!context.mounted) return;

        setState(() {
          _images = images;
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
    } on FormatException catch (e) {
      if (!context.mounted) return;
      setState(() {
        _error = "Data format exception: ${e.message}";
      });
    } catch (e) {
      if (!context.mounted) return;
      setState(() {
        _error = "An unknown error occurred: $e";
      });
    } finally {
      if (context.mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Images"),
        titleTextStyle: TextStyle(fontSize: 16, color: Colors.green),
        iconTheme: IconThemeData(size: 20, color: Colors.black87),
        titleSpacing: -5,
        elevation: 1,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _fetchImages();
            },
            icon: Icon(Icons.image_rounded),
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
              foregroundColor: Colors.green.shade800,
            ),
          ),
        ],

        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        height: double.infinity,
        width: double.infinity,
        child: _isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text("Loading Images"),
                  ],
                ),
              )
            : _error != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 24),
                    SizedBox(height: 10),
                    Text(
                      "Error: $_error",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : _images.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.insert_page_break_rounded, color: Colors.red),
                    SizedBox(height: 10),
                    Text(
                      "No images yet, please click the image icon to load images",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                itemCount: _images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  // childAspectRatio: 16 / 9,
                ),
                itemBuilder: (BuildContext context, index) =>
                    _buildImageItem(_images[index]),
              ),
      ),
    );
  }
}
