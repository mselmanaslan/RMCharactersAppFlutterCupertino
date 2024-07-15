import 'package:rmcharactersappfluttercupertino/Model/AdaptedCharacter.dart';
import 'package:rmcharactersappfluttercupertino/Model/ApiCharacter.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterDetails/CharacterDetailsViewModel.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterRow/CharacterRowViewModel.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/Header/HeaderViewModel.dart';
import '../../Model/Filter.dart';
import '../../Network/Service/DatabaseService.dart';

class FavoritedCharactersViewModel {
  var databaseService = DatabaseService();
  List<ApiCharacter> characters = [];
  List<AdaptedCharacter> adaptedCharacters = [];
  Filter filter = Filter(name: "", status: "", species: "", gender: "");

  var headerViewModel = HeaderViewModel(
    isFilterMenuOpen: () {
      print("testt");
    },
    headerTitle: "Favorited\nCharacters",
  );

  FavoritedCharactersViewModel();

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

  CharacterRowViewModel createCharacterRowViewModel(AdaptedCharacter character, Function(AdaptedCharacter) onFavoriteChanged, Function(AdaptedCharacter) onDetailsTapped) {
    return CharacterRowViewModel(
      character: character,
      onFavoriteChanged: onFavoriteChanged,
      onDetailsTapped: onDetailsTapped,
    );
  }

}
