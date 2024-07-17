import 'package:flutter/cupertino.dart';
import 'package:rmcharactersappfluttercupertino/Model/AdaptedCharacter.dart';
import 'package:rmcharactersappfluttercupertino/Model/ApiCharacter.dart';
import '../../Model/Filter.dart';
import '../../Network/Service/DatabaseService.dart';
import '../Components/CharacterRow/CharacterRowViewModel.dart';
import '../Components/FilterMenu/FilterMenuViewModel.dart';
import '../Components/Header/HeaderViewModel.dart';

class FavoritedCharactersViewModel extends ChangeNotifier {
  var databaseService = DatabaseService();
  List<ApiCharacter> characters = [];
  List<AdaptedCharacter> adaptedCharacters = [];
  Filter filter = Filter(name: "", status: "", species: "", gender: "");
  var headerViewModel;
  late FilterMenuViewModel filterMenuViewModel;
  bool isFilterMenuOpen = false;

  FavoritedCharactersViewModel() {
    filterMenuViewModel = FilterMenuViewModel(
      isFilterMenuOpen: isFilterMenuOpen,
      filter: filter,
      onFilterChanged: (Filter ) {

      },
    );
    headerViewModel = HeaderViewModel(
      isFilterMenuOpen: toggleFilterMenu,
      headerTitle: "Favorited\nCharacters",
    );
  }

  Future<void> fetchCharacters() async {
    final fetchedCharacters = await databaseService.fetchAllFavorites();

    List<AdaptedCharacter> updatedCharacters = [];

    for (var character in adaptedCharacters) {
      if (fetchedCharacters.contains(character)) {
        updatedCharacters.add(character);
      }
    }
    for (var character in fetchedCharacters) {
      if (!adaptedCharacters.contains(character)) {
        updatedCharacters.add(character);
      }
    }
    updatedCharacters = updatedCharacters.reversed.toList();
    adaptedCharacters = updatedCharacters;
  }

  CharacterRowViewModel createCharacterRowViewModel(AdaptedCharacter character,
      Function(AdaptedCharacter) onFavoriteChanged,
      Function(AdaptedCharacter) onDetailsTapped) {
    return CharacterRowViewModel(
      character: character,
      onFavoriteChanged: onFavoriteChanged,
      onDetailsTapped: onDetailsTapped,
    );
  }

  void toggleFilterMenu() {
    isFilterMenuOpen = !isFilterMenuOpen;
    filterMenuViewModel.isFilterMenuOpen = isFilterMenuOpen;
    print(filterMenuViewModel.isFilterMenuOpen);
    notifyListeners();
  }
}
