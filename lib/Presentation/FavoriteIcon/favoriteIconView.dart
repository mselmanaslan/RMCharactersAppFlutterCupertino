import 'package:flutter/cupertino.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/FavoriteIcon/FavoriteIconViewModel.dart';

class FavoriteIconView extends StatefulWidget {

  final FavoriteIconViewModel viewModel;

  FavoriteIconView({required this.viewModel});


  @override
  _FavoriteIconViewState createState() => _FavoriteIconViewState();
}

class _FavoriteIconViewState extends State<FavoriteIconView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: CupertinoButton(
        child: Icon(
          widget.viewModel.isFavorited ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
          color: widget.viewModel.isFavorited ? CupertinoColors.systemRed : CupertinoColors.black,
          size: 32,
        ),
        onPressed: () {
          setState(() {
            widget.viewModel.favoriteIconAction();
            widget.viewModel.changeFavoriteState();
          });
        },
      ),
    );
  }

}

