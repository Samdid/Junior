// modified https://gist.github.com/sma/1f22ef926ef878f10915aa9e00bc9eaa
import 'package:flutter/material.dart';

import '../../theme.dart';
import 'novel_data.dart';

class StarRating extends StatefulWidget {
  final int value = NovelData.novel.novelRating;
  final IconData filledStar;
  final IconData unfilledStar;

  StarRating({
    Key key,
    this.filledStar,
    this.unfilledStar,
  }) : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState(value);
}

class _StarRatingState extends State<StarRating> {
  int _value = 0;

  void onChanged(int index) {
    NovelData.isChanged = true;
    NovelData.novel.novelRating = index;

    setState(() {
      _value = index;
    });
  }

  _StarRatingState(this._value);

  @override
  Widget build(BuildContext context) {
    final color = Colors.amber;
    const blank = Color.fromRGBO(0, 0, 0, 0.5);
    const size = 36.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Novel Rating',
          style: TextStyle(color: textColor, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Container(
          transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              5,
              (index) {
                return IconButton(
                  onPressed: () {
                    onChanged(_value == index + 1 ? index : index + 1);
                  },
                  color: index < _value ? color : blank,
                  iconSize: size,
                  icon: Icon(
                    index < _value
                        ? widget.filledStar ?? Icons.star
                        : widget.unfilledStar ?? Icons.star_outlined,
                  ),
                  padding: EdgeInsets.zero,
                  tooltip: "${index + 1} of 5",
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
