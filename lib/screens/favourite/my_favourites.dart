import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_state_management/favourite_provider.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favourites'),
        centerTitle: true,
        elevation: 1,
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: favouriteProvider.favouriteItems.length,
                itemBuilder: (context, index) {
                  return Consumer<FavouriteProvider>(
                    builder: (context, value, child) {
                      return ListTile(
                        title: Text('Item ${value.favouriteItems[index]}'),
                        trailing: Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: 32,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        onTap: () {
                          value.removeFromFavourite(
                            value.favouriteItems[index],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
