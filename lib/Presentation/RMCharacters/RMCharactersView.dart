import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterRow/CharacterRowView.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterRow/CharacterRowViewModel.dart';
import '../../Model/AdaptedCharacter.dart';
import '../CharacterDetails/CharacterDetailsView.dart';
import '../CharacterDetails/CharacterDetailsViewModel.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("sayfa tekrar geldi");
  }

  @override
  void didUpdateWidget(covariant RMCharactersView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshFavoriteStatuses(); // Favori durumlarını kontrol et ve güncelle
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        // Alt kenara ulaşıldığında
        _fetchCharactersAndUpdateUI();
      }
    }
  }

  Future<void> _fetchCharactersAndUpdateUI() async {
    await viewModel.fetchCharacters();
    setState(() {
      print("setState çalıştı");
    });
  }


  Future<void> _refreshFavoriteStatuses() async {
    for (var characterViewModel in viewModel.adaptedCharacters.map((character) => viewModel.createCharacterRowViewModel(character,(AdaptedCharacter character){}))) {
      await characterViewModel.refreshFavoriteStatus();
    }
    setState(() {
      print("Favori durumlar güncellendi");
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
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: HeaderView(viewModel: viewModel.headerViewModel),
          ),
          Expanded(
            child: Center(
              child: CupertinoScrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: 20, bottom: 90),
                  itemCount: viewModel.adaptedCharacters.length + 1,
                  itemBuilder: (context, index) {
                    if (index < viewModel.adaptedCharacters.length) {
                      final character = viewModel.adaptedCharacters[index];
                      return CharacterRowView(
                        viewModel: viewModel.createCharacterRowViewModel(
                          character,
                                (AdaptedCharacter character) {
                              _showCharacterDetailsSheet(context, character);
                            }),
                      );
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
