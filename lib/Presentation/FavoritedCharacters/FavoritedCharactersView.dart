import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterDetails/CharacterDetailsView.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterDetails/CharacterDetailsViewModel.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterRow/CharacterRowView.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/FavoritedCharacters/FavoritedCharactersViewModel.dart';
import '../../Model/AdaptedCharacter.dart';
import '../Header/HeaderView.dart';

class FavoritedCharactersView extends StatefulWidget {
  const FavoritedCharactersView({super.key});

  @override
  State<FavoritedCharactersView> createState() => _FavoritedCharactersViewState();
}

class _FavoritedCharactersViewState extends State<FavoritedCharactersView> {
  var viewModel = FavoritedCharactersViewModel();
  final ScrollController _scrollController = ScrollController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _fetchCharactersAndUpdateUI();
    print("a");
  }

  @override
  void didUpdateWidget(covariant FavoritedCharactersView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isInitialized) {
      _fetchCharactersAndUpdateUI();
      print("b");
    }
  }

  Future<void> _fetchCharactersAndUpdateUI() async {
    await viewModel.fetchCharacters();
    setState(() {
      _isInitialized = true;
      print("setstate calisti");
    });
  }

  void _showCharacterDetailsSheet(BuildContext context, AdaptedCharacter character) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      backgroundColor: CupertinoColors.black,
      builder: (context) =>  CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: character),)
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: CupertinoPageScaffold(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: HeaderView(viewModel: viewModel.headerViewModel,),
            ),
            Expanded(
              child: Center(
                child: CupertinoScrollbar(
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.only(top: 20, bottom: 90),
                    itemCount: viewModel.adaptedCharacters.length,
                    itemBuilder: (context, index) {
                      final character = viewModel.adaptedCharacters[index];
                      return CharacterRowView(
                        viewModel: viewModel.createCharacterRowViewModel(
                          character,
                              (AdaptedCharacter character) {
                            setState(() {
                              viewModel.adaptedCharacters.remove(character);
                            });
                          },
                              (AdaptedCharacter character) {
                            _showCharacterDetailsSheet(context, character);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
