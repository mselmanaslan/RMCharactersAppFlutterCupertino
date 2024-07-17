import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../Model/AdaptedCharacter.dart';
import '../CharacterDetails/CharacterDetailsView.dart';
import '../CharacterDetails/CharacterDetailsViewModel.dart';
import '../Components/CharacterRow/CharacterRowView.dart';
import '../Components/FilterMenu/FilterMenuView.dart';
import '../Components/Header/HeaderView.dart';
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
    _refreshFavoriteStatus(); // Favori durumlarını kontrol et ve güncelle
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
    await viewModel.fetchCharacters(viewModel.reqFilter);
    setState(() {
      print("setState çalıştı");
    });
  }

  Future<void> _refreshFavoriteStatus() async {
    for (var characterViewModel in viewModel.adaptedCharacters.map((character) => viewModel.createCharacterRowViewModel(character, (AdaptedCharacter character) {}))) {
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
      builder: (context) => CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: character)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<RMCharactersViewModel>(
        builder: (context, viewModel, child) {
          return CupertinoPageScaffold(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: HeaderView(viewModel: viewModel.headerViewModel),
                ),
                FilterMenuView(viewModel: viewModel.filterMenuViewModel),
                Expanded(child: viewModel.adaptedCharacters.isEmpty
                ? Center(
                  child: FutureBuilder(
                    future: Future.delayed(Duration(seconds: 2)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CupertinoActivityIndicator();
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sorry...",
                                style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 32, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "No characters found matching\nyour search criteria.\nPlease try adjusting your filters.",
                                style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 22, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ): CupertinoScrollbar(
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
                            },
                          ),
                        );
                      } else {
                        return CupertinoActivityIndicator();
                      }
                    },
                  ),
                ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
