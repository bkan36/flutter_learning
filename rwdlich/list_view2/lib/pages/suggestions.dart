import 'package:flutter/material.dart';

class SuggestionsPage extends StatefulWidget {
  @override
  _SuggestionsPageState createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  final _textController = TextEditingController();
  List<String> names = ['James Haywire', 'Fela Kuti'];

  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void insertName(String value) {
    names.insert(0, value);
    setState(() {});
    _animatedListKey.currentState.insertItem(
      0,
      duration: Duration(milliseconds: 1000),
    );
  }

  void removeName(int index) {
    String name = names.removeAt(index);

    _animatedListKey.currentState.removeItem(
      index,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: _buildItem(name),
        );
      },
      duration: Duration(milliseconds: 700),
    );
    if (names.isEmpty) {
      Future.delayed(Duration(milliseconds: 800), () {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Character Suggestion"),
      ),
      body: Column(
        children: <Widget>[
          names.length == 0
              ? Expanded(
                  child: Center(
                    child: Text("No Characters Yet"),
                  ),
                )
              : Container(),
          Expanded(
            child: AnimatedList(
              key: _animatedListKey,
              initialItemCount: names.length,
              itemBuilder:
                  (BuildContext context, int index, Animation animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: _buildItem(names[index], index),
                );
              },
            ),
          ),
          _buildTextBox(),
        ],
      ),
    );
  }

  Widget _buildItem(String name, [int index]) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(name),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => removeName(index),
        ),
      ),
    );
  }

  Widget _buildTextBox() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter New Character Name',
        ),
        onSubmitted: (value) {
          _textController.clear();
          insertName(value);
        },
      ),
    );
  }
}
