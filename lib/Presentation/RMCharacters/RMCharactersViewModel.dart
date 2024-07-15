import 'package:rmcharactersappfluttercupertino/Model/AdaptedCharacter.dart';
import 'package:rmcharactersappfluttercupertino/Model/ApiCharacter.dart';
import 'package:rmcharactersappfluttercupertino/Network/Service/CharacterService.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterRow/CharacterRowViewModel.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/Header/HeaderViewModel.dart';
import '../../Model/Filter.dart';

class RMCharactersViewModel {
  var characterService = CharacterService();
  int apiPageNumber = 0;
  List<ApiCharacter> characters = [];
  List<AdaptedCharacter> adaptedCharacters = [];
  Filter filter = Filter(name: "", status: "", species: "", gender: "");

  var headerViewModel = HeaderViewModel(
    isFilterMenuOpen: () {
      print("testt");
    },
    headerTitle: "Rick&Morty\nCharacters",
  );

  RMCharactersViewModel();

  fetchCharacters() async {
    apiPageNumber++;
    final fetchedCharacters = await characterService.fetchCharacters(() {}, filter, apiPageNumber);
    fetchedCharacters.forEach((character) {
      adaptedCharacters.add(character.AdaptCharacter());
      print(adaptedCharacters.length);
    });
  }

  CharacterRowViewModel createCharacterRowViewModel(AdaptedCharacter character, Function(AdaptedCharacter) onDetailsTapped) {
    return CharacterRowViewModel(
      character: character,
      onFavoriteChanged: (AdaptedCharacter character) {

      }, onDetailsTapped: onDetailsTapped,
    );
  }
}
