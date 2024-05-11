import 'package:flutter/cupertino.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/FavoritedCharacters/FavoritedCharactersViewModel.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/Header/HeaderView.dart';

class FavoritedCharactersView extends StatefulWidget {
  const FavoritedCharactersView({super.key});


  @override
  State<FavoritedCharactersView> createState() => _FavoritedCharactersViewState();
}

class _FavoritedCharactersViewState extends State<FavoritedCharactersView> {
  var viewModel = FavoritedCharactersViewModel();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: HeaderView(viewModel: viewModel.headerViewModel,),
          ),
          Expanded(
            child: Center(
              child: Text('FavCharacters Content'),
            ),
          ),
        ],
      ),
    );

  }
}