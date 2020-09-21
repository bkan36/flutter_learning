import 'package:flutter/material.dart';

import '../models/rick_morty.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final bool loading;

  const CharacterCard({Key key, this.character, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: loading
            ? _buildLoadingCard()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(character.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            character.name,
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(height: 8),
                          DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.black54),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Episodes: ${character.episode.length}"),
                                Text("Planet: ${character.location.name}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        EmptyBlock(
          width: 100,
          height: 100,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                EmptyBlock(
                  width: 150,
                  height: 20,
                ),
                SizedBox(height: 8),
                EmptyBlock(
                  width: 200,
                  height: 14,
                ),
                SizedBox(height: 2),
                EmptyBlock(
                  width: 200,
                  height: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EmptyBlock extends StatelessWidget {
  final double width;
  final double height;

  const EmptyBlock({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
    );
  }
}
