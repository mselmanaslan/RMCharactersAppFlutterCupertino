import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterRow/CharacterRowViewModel.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/FavoriteIcon/FavoriteIconView.dart';

class CharacterRowView extends StatefulWidget {
  final CharacterRowViewModel viewModel;

  const CharacterRowView({required this.viewModel});

  @override
  _CharacterRowViewState createState() => _CharacterRowViewState();
}

class _CharacterRowViewState extends State<CharacterRowView> {
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
    return ChangeNotifierProvider<CharacterRowViewModel>.value(
      value: widget.viewModel,
      child: Consumer<CharacterRowViewModel>(
        builder: (context, viewModel, child) {
          return GestureDetector(
            onTap: () => viewModel.onDetailsTapped(viewModel.character),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
              child: Container(
                height: 190,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: viewModel.statusColor,
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              viewModel.statusInfo,
                              style: TextStyle(
                                color: viewModel.statusColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: isFavoriteInitialized
                                    ? FavoriteIconView(viewModel: viewModel.favoriteIconViewModel)
                                    : CupertinoActivityIndicator(),
                              ),
                              SizedBox(height: 14),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 1),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: viewModel.statusColor,
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                viewModel.character.image,
                                width: 115,
                                height: 115,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Species: ",
                                    style: TextStyle(
                                      color: CupertinoColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.28,
                                    ),
                                    child: Text(
                                      viewModel.character.species,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Text(
                                    "Gender:  ",
                                    style: TextStyle(
                                      color: CupertinoColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.28,
                                    ),
                                    child: Text(
                                      viewModel.character.gender,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: viewModel.genderColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
