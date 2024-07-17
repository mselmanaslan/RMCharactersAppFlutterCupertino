import 'package:flutter/cupertino.dart';
import 'package:rmcharactersappfluttercupertino/Model/AdaptedCharacter.dart';
import '../../Network/Service/DatabaseService.dart';
import '../Components/FavoriteIcon/FavoriteIconViewModel.dart';

class CharacterDetailsViewModel with ChangeNotifier {
  AdaptedCharacter character;
  late FavoriteIconViewModel favoriteIconViewModel;
  bool isFavorited = false;
  late String statusInfo;
  late Color statusColor;
  late String characterInEpisodes;

  CharacterDetailsViewModel({required this.character}) {
    statusInfo = characterStatusEmote(character.status) + " " + character.status;
    statusColor = characterStatusColor(character.status);
    characterInEpisodes = character.episode.toString();


    favoriteIconViewModel = FavoriteIconViewModel(isFavorited: isFavorited, favoriteIconAction: () {
      toggleFavorite();
    });

    initFavoriteStatus();
  }

  Future<void> initFavoriteStatus() async {
    isFavorited = await isCharacterInFavorite(character.id);
    favoriteIconViewModel.isFavorited = isFavorited;
    notifyListeners();  // Değişiklikleri dinleyicilere bildirir
  }

  Future<void> toggleFavorite() async {
    isFavorited = !isFavorited;
    await DatabaseService().toggleFavorite(character);
    favoriteIconViewModel.isFavorited = isFavorited;
    notifyListeners();  // Değişiklikleri dinleyicilere bildirir
  }

  Future<bool> isCharacterInFavorite(String characterId) async {
    return await DatabaseService().isCharacterInFavorites(characterId);
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

  String characterStatusEmote(String? status) {
    switch (status) {
      case "Alive":
        return "🕊️";
      case "Dead":
        return "☠️";
      default:
        return "❔";
    }
  }
}
