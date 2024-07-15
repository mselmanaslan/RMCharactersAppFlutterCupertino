import 'package:flutter/cupertino.dart';
import 'package:rmcharactersappfluttercupertino/Model/AdaptedCharacter.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/FavoriteIcon/FavoriteIconViewModel.dart';
import '../../Network/Service/DatabaseService.dart';

class CharacterRowViewModel with ChangeNotifier {
  AdaptedCharacter character;
  late String statusInfo;
  late Color statusColor;
  late Color genderColor;
  late FavoriteIconViewModel favoriteIconViewModel;
  late bool isFavorited = false;
  final Function(AdaptedCharacter character) onFavoriteChanged;
  final Function(AdaptedCharacter character) onDetailsTapped;

  CharacterRowViewModel({required this.character, required this.onFavoriteChanged, required this.onDetailsTapped}) {
    statusInfo = determineStatusInfo(character.status) + " " + character.name;
    statusColor = characterStatusColor(character.status);
    genderColor = characterGenderColor(character.gender);

    favoriteIconViewModel = FavoriteIconViewModel(isFavorited: isFavorited, favoriteIconAction: () {
      toggleFavorite();
    });

    initFavoriteStatus();
  }

  Future<void> initFavoriteStatus() async {
    isFavorited = await isCharacterInFavorite(character.id);
    favoriteIconViewModel.isFavorited = isFavorited;
    notifyListeners();
  }

  Future<void> refreshFavoriteStatus() async {
    isFavorited = await isCharacterInFavorite(character.id);
    favoriteIconViewModel.isFavorited = isFavorited;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    isFavorited = !isFavorited;
    await DatabaseService().toggleFavorite(character);
    favoriteIconViewModel.isFavorited = isFavorited;
    notifyListeners();
    onFavoriteChanged(character); // Callback çağrısı
  }

  Future<bool> isCharacterInFavorite(String characterId) async {
    return await DatabaseService().isCharacterInFavorites(characterId);
  }

  String determineStatusInfo(String status) {
    switch (status) {
      case "Alive":
        return "🍀";
      case "Dead":
        return "☠️";
      default:
        return "?";
    }
  }

  Color characterStatusColor(String? status) {
    switch (status) {
      case "Alive":
        return CupertinoColors.systemGreen;
      case "Dead":
        return CupertinoColors.systemRed;
      default:
        return CupertinoColors.black;
    }
  }

  Color characterGenderColor(String? gender) {
    switch (gender) {
      case "Male":
        return CupertinoColors.systemBlue;
      case "Female":
        return CupertinoColors.systemRed;
      case "Genderless":
        return CupertinoColors.systemPurple;
      default:
        return CupertinoColors.black;
    }
  }
}
