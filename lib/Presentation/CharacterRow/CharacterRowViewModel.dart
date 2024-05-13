import 'package:flutter/cupertino.dart';
import 'package:rmcharactersappfluttercupertino/Model/AdaptedCharacter.dart';

class CharacterRowViewModel {
  AdaptedCharacter character;
  late String statusInfo;
  late Color statusColor;
  late Color genderColor;


  CharacterRowViewModel({required this.character}) {
    statusInfo = determineStatusInfo(character.status) + " " +  character.name;
    statusColor = characterStatusColor(character.status);
    genderColor = characterGenderColor(character.gender);

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
