import 'package:flutter/cupertino.dart';

import '../Header/HeaderView.dart';
import 'RMCharactersViewModel.dart';

class RMCharactersView extends StatefulWidget {
  const RMCharactersView({super.key});


  @override
  State<RMCharactersView> createState() => _RMCharactersViewState();
}

class _RMCharactersViewState extends State<RMCharactersView> {
  var viewModel = RMCharactersViewModel();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: HeaderView(viewModel: viewModel.headerViewModel,),
          ),
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: viewModel.adaptedCharacters.length,
                itemBuilder: (context, index) {
                  final character = viewModel.adaptedCharacters[index];
                  return Container(
                    child: Text(character.name)
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
