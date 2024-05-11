import 'package:rmcharactersappfluttercupertino/Model/AdaptedCharacter.dart';
import 'package:rmcharactersappfluttercupertino/Model/ApiCharacter.dart';
import 'package:rmcharactersappfluttercupertino/Network/Service/CharacterService.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/Header/HeaderViewModel.dart';
import '../../Model/Filter.dart';

class RMCharactersViewModel {
  var characterService = CharacterService();
  int apiPageNumber = 0;
  List<ApiCharacter> characters = [];
  List<AdaptedCharacter> adaptedCharacters = [];
  Filter filter = Filter(name: "", status: "", species: "", gender: "");


  var headerViewModel = HeaderViewModel(isFilterMenuOpen: () {
    print("testt");
  }, headerTitle: "Rick&Morty\nCharacters");

  RMCharactersViewModel() {
    init();
  }

  void init() {
    fetchCharacters();
  }

  void fetchCharacters() async {
    apiPageNumber++;
    final fetchedCharacters = await characterService.fetchCharacters(() {
    }, filter, apiPageNumber);
    fetchedCharacters.forEach((character) {
      adaptedCharacters.add(character.AdaptCharacter());
    });
    adaptedCharacters.forEach((character) {
      print('Karakter Adı: ${character.id}');
    });
  }

}