import 'package:flutter/cupertino.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterRow/CharacterRowView.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterRow/CharacterRowViewModel.dart';
import '../Header/HeaderView.dart';
import 'RMCharactersViewModel.dart';

class RMCharactersView extends StatefulWidget {
  const RMCharactersView({super.key});


  @override
  State<RMCharactersView> createState() => _RMCharactersViewState();
}

class _RMCharactersViewState extends State<RMCharactersView> {
  var viewModel = RMCharactersViewModel();

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchCharactersAndUpdateUI();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
      } else {
        _fetchCharactersAndUpdateUI();
      }
    }
  }

  Future<void> _fetchCharactersAndUpdateUI() async {
    await viewModel.fetchCharacters();
    setState(() {
      print("setstate calisti");
    });
  }


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
              child: CupertinoScrollbar(
                controller: _scrollController, // ListView ile aynı ScrollController'ı kullan
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: viewModel.adaptedCharacters.length + 1,
                  itemBuilder: (context, index) {
                    if (index < viewModel.adaptedCharacters.length) {
                      final character = viewModel.adaptedCharacters[index];
                      return CharacterRowView(viewModel: CharacterRowViewModel(character: character));
                    } else {
                      return CupertinoActivityIndicator(); // Yeni karakterler yüklenene kadar gösterilecek loading indicator
                    }
                  },
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
