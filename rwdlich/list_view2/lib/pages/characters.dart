import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/rick_morty.dart';
import '../repos/rick_morty_repo.dart';
import '../widgets/character_card.dart';
import 'suggestions.dart';

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage>
    with SingleTickerProviderStateMixin {
  ScrollController controller;
  AnimationController _hide;

  List<Character> characters = [];
  final int initialPage = 0;
  int page = 0;
  bool hasMorePages = true;
  bool isLoading = false;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    controller = ScrollController()..addListener(_scrollListener);
    _hide = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _hide.dispose();
    super.dispose();
  }

  void fetchData() {
    if (page == initialPage) {
      setState(() {
        isLoading = true;
      });
    }
    RickAndMortyRepo().getCharacters(page: page + 1).then((res) {
      page++;
      setState(() {
        isLoading = false;
        isLoadingMore = false;
        characters.addAll(res.results);
        hasMorePages = page < res.info.pages;
        // hasMorePages = res.info.next != "";
      });
    });
  }

  bool _onNotificationHandler(ScrollNotification notification) {
    if (notification.depth == 0 && notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.forward) {
        _hide.forward();
      } else if (notification.direction == ScrollDirection.reverse) {
        _hide.reverse();
      }
    }
    return false;
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent) {
      print("Reached End");
      if (!isLoadingMore && hasMorePages) {
        print("Fetching");
        setState(() {
          isLoadingMore = true;
        });
        fetchData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rick and Morty"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuggestionsPage()),
              );
            },
          )
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _hide,
        child: FloatingActionButton(
          child: Icon(Icons.keyboard_arrow_up),
          onPressed: () {
            controller.animateTo(
              controller.initialScrollOffset,
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 500),
            );
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: _onNotificationHandler,
              child: ListView.builder(
                controller: controller,
                itemCount: characters.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == characters.length) {
                    if (hasMorePages) {
                      return CharacterCard(loading: true);
                    }
                    return Container();
                  }
                  return CharacterCard(character: characters[index]);
                },
              ),
            ),
    );
  }
}
