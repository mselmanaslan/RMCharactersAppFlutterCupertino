import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/FavoriteIcon/FavoriteIconView.dart';
import 'CharacterDetailsViewModel.dart';

class CharacterDetailsView extends StatefulWidget {
  final CharacterDetailsViewModel viewModel;

  CharacterDetailsView({required this.viewModel});

  @override
  _CharacterDetailsViewState createState() => _CharacterDetailsViewState();
}

class _CharacterDetailsViewState extends State<CharacterDetailsView> {
  bool isFavoriteInitialized = false;

  @override
  void initState() {
    super.initState();
    widget.viewModel.initFavoriteStatus().then((_) {
      setState(() {
        isFavoriteInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<CharacterDetailsViewModel>.value(
      value: widget.viewModel,
      child: Consumer<CharacterDetailsViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: [
                    Image.network(
                      viewModel.character.image,
                      fit: BoxFit.cover,
                      width: screenWidth,
                      height: screenWidth,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: viewModel.statusColor,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              viewModel.statusInfo,
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: screenWidth - 60),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.viewModel.character.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    // Type and Fav
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
                          child: Text(
                            "Type:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(" " + viewModel.character.species),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: isFavoriteInitialized
                              ? FavoriteIconView(viewModel: viewModel.favoriteIconViewModel)
                              : CupertinoActivityIndicator(),
                        ),
                      ],
                    ),
                    // Gender
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
                          child: Text(
                            "Gender:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(" " + viewModel.character.gender),
                      ],
                    ),
                    // Origin
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
                          child: Text(
                            "Origin:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(" " + viewModel.character.origin),
                      ],
                    ),
                    // Last Seen
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
                          child: Text(
                            "Last Seen:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(" " + viewModel.character.location),
                      ],
                    ),
                    // Episodes the Character Was Seen In
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
                          child: Text(
                            "Episodes the Character Was Seen In:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(" " + viewModel.characterInEpisodes),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
