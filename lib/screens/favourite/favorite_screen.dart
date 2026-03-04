import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_state_management/favourite_provider.dart';
import 'package:test_app/screens/favourite/my_favourites.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavoriteScreen> {
  // List<int> selectedItem = [];
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite App'),
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_rounded, color: Colors.red, size: 32),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyFavourites()),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Consumer<FavouriteProvider>(
                    builder: (context, value, child) => ListTile(
                      onTap: () {
                        // bool isFavourite = value.favouriteItems.contains(index);
                        bool isFavourite = value.checkIsFavourite(index);

                        if (isFavourite) {
                          value.removeFromFavourite(index);
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Item $index added to favourite',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                              ),
                            );
                        } else {
                          value.addToFavourite(index);
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Item $index added to favourite',
                                  style: TextStyle(
                                    // fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                              ),
                            );
                        }
                      },
                      title: Text('Item $index'),
                      tileColor: Colors.green.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      trailing: value.favouriteItems.contains(index)
                          ? Icon(
                              Icons.favorite_rounded,
                              color: Colors.red,
                              size: 32,
                            )
                          : Icon(Icons.favorite_outline, size: 32),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
