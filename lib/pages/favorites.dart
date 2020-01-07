import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/routes.dart';

class FavoritesPage extends StatefulWidget {
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<int> favorites;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      List<String> favoritesStr = prefs.getStringList('favorites');
      favorites = [];
      // needed because team names stored in int instead of str
      for (String team in favoritesStr) {
        favorites.add(int.parse(team));
      }
      debugPrint('FAVORITES: ' + favorites.toString());
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('teams')
              .where('teamNumber', whereIn: favorites)
              .orderBy('teamNumber')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Center(child: CircularProgressIndicator());
              default:
                return new ListView.separated(
                  itemCount: snapshot.data.documents.length,
                  separatorBuilder: (context, index) {
                    return new Divider(
                      height: 1.0,
                    );
                  },
                  itemBuilder: (context, index) {
                    return new ListTile(
                        title: Text(snapshot
                            .data.documents[index].data['teamNumber']
                            .toString()),
                        subtitle: Text(
                            snapshot.data.documents[index].data['nickname']),
                        onTap: () {
                          int teamNumber =
                              snapshot.data.documents[index].data['teamNumber'];
                          router.navigateTo(
                              context, '/team_summary/$teamNumber',
                              transition: TransitionType.nativeModal);
                        });
                  },
                );
            }
          },
        ));
  }
}
