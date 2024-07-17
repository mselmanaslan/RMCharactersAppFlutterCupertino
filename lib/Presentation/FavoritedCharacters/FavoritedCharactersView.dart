import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterDetails/CharacterDetailsView.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterDetails/CharacterDetailsViewModel.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/FavoritedCharacters/FavoritedCharactersViewModel.dart';
import '../../Model/AdaptedCharacter.dart';
import '../Components/CharacterRow/CharacterRowView.dart';
import '../Components/FilterMenu/FilterMenuView.dart';
import '../Components/FilterMenu/FilterMenuViewModel.dart';
import '../Components/Header/HeaderView.dart';



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
  }

  @override
  void didUpdateWidget(covariant FavoritedCharactersView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isInitialized) {
      _fetchCharactersAndUpdateUI();
    }
  }

  Future<void> _fetchCharactersAndUpdateUI() async {
    await viewModel.fetchCharacters();
    setState(() {
      _isInitialized = true;
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
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Consumer<FavoritedCharactersViewModel>(
        builder: (context, viewModel, child) {
          return CupertinoScaffold(
            body: CupertinoPageScaffold(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: HeaderView(viewModel: viewModel.headerViewModel),
                  ),
                  FilterMenuView(
                    viewModel: FilterMenuViewModel(
                      isFilterMenuOpen: viewModel.isFilterMenuOpen,
                      filter: viewModel.filter,
                      onFilterChanged: (filter) {
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: CupertinoScrollbar(
                        controller: _scrollController,
                        child: viewModel.adaptedCharacters.isEmpty
                            ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Oops...",
                                style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 32, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "It looks like you haven't added\nany favorite characters yet.",
                                style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 22, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                            : _filteredCharacters(viewModel).isEmpty
                            ? Center(
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
                            )
                        )
                            : ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(top: 20, bottom: 90),
                          itemCount: _filteredCharacters(viewModel).length,
                          itemBuilder: (context, index) {
                            final character = _filteredCharacters(viewModel)[index];
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
        },
      ),
    );
  }

  List<AdaptedCharacter> _filteredCharacters(FavoritedCharactersViewModel viewModel) {
    return viewModel.adaptedCharacters.where((character) {
      return (viewModel.filter.name.isEmpty || character.name.toLowerCase().contains(viewModel.filter.name.toLowerCase())) &&
          (viewModel.filter.status.isEmpty || character.status.toLowerCase() == viewModel.filter.status.toLowerCase()) &&
          (viewModel.filter.species.isEmpty || character.species.toLowerCase() == viewModel.filter.species.toLowerCase()) &&
          (viewModel.filter.gender.isEmpty || character.gender.toLowerCase() == viewModel.filter.gender.toLowerCase());
    }).toList();
  }
}
