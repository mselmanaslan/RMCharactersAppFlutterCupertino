import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rmcharactersappfluttercupertino/Model/AdaptedCharacter.dart';
import 'package:rmcharactersappfluttercupertino/Model/ApiCharacter.dart';
import 'package:rmcharactersappfluttercupertino/Network/Service/CharacterService.dart';
import '../../Model/Filter.dart';
import '../Components/CharacterRow/CharacterRowViewModel.dart';
import '../Components/FilterMenu/FilterMenuViewModel.dart';
import '../Components/Header/HeaderViewModel.dart';


class RMCharactersViewModel extends ChangeNotifier {
  var characterService = CharacterService();
  int apiPageNumber = 0;
  List<ApiCharacter> characters = [];
  List<AdaptedCharacter> adaptedCharacters = [];
  Filter reqFilter = Filter(name: "", status: "", species: "", gender: "");
  late FilterMenuViewModel filterMenuViewModel;
  var headerViewModel;
  bool isFilterMenuOpen = false;
  bool isLoading = false;
  Timer? _debounce;

  RMCharactersViewModel() {
    filterMenuViewModel = FilterMenuViewModel(
      isFilterMenuOpen: isFilterMenuOpen,
      filter: reqFilter,
      onFilterChanged: (Filter newfilter) {
        adaptedCharacters.clear();
        reqFilter = newfilter;
        notifyListeners();
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {

          fetchFilteredCharacters(reqFilter);
          notifyListeners();
        });
      },
    );
    headerViewModel = HeaderViewModel(
      isFilterMenuOpen: toggleFilterMenu,
      headerTitle: "Rick&Morty\nCharacters",
    );
  }

  fetchCharacters(Filter filter) async {
    print('Fetching characters with filter: ${filter.gender}');
    apiPageNumber++;
    isLoading = true;
    notifyListeners();
    try {
      final fetchedCharacters = await characterService.fetchCharacters(() {}, filter, apiPageNumber);
      fetchedCharacters.forEach((character) {
        adaptedCharacters.add(character.AdaptCharacter());
      });
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print('Error fetching characters: $e');
      notifyListeners();
    }
  }

  CharacterRowViewModel createCharacterRowViewModel(AdaptedCharacter character, Function(AdaptedCharacter) onDetailsTapped) {
    return CharacterRowViewModel(
      character: character,
      onFavoriteChanged: (AdaptedCharacter character) {

      }, onDetailsTapped: onDetailsTapped,
    );
  }

  void toggleFilterMenu() {
    isFilterMenuOpen = !isFilterMenuOpen;
    filterMenuViewModel.isFilterMenuOpen = isFilterMenuOpen;
    print(filterMenuViewModel.isFilterMenuOpen);
    notifyListeners();
  }

  fetchFilteredCharacters(Filter filter) {

    apiPageNumber = 0;
    fetchCharacters(reqFilter);
  }
}
