import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:rmcharactersappfluttercupertino/Presentation/CharacterRow/CharacterRowViewModel.dart';


class CharacterRowView extends StatefulWidget {
  final CharacterRowViewModel viewModel;

  const CharacterRowView({required this.viewModel});

  @override
  _CharacterRowViewState createState() => _CharacterRowViewState();
}

class _CharacterRowViewState extends State<CharacterRowView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      child: Container( height: 200,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: widget.viewModel.statusColor,
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0,0),
            ),
          ]
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                children: [
                  Expanded(child: Text("${widget.viewModel.statusInfo}", style: TextStyle(color: widget.viewModel.statusColor, fontWeight: FontWeight.w600, fontSize: 18),overflow: TextOverflow.ellipsis,)),
                  Column(
                    children: [
                      SizedBox(height: 5,),
                      Icon(CupertinoIcons.heart,color: CupertinoColors.black, size: 32,),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.viewModel.statusColor,
                        width: 3, // Border kalınlığı
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        widget.viewModel.character.image,
                        width: 115, // İstenilen genişlik
                        height: 115, // İstenilen yükseklik
                        fit: BoxFit.cover, // Resmi nasıl boyutlandırılacağı
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Species: ", style: TextStyle(color: CupertinoColors.black, fontWeight: FontWeight.w500, fontSize: 17),),
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.28), // Burada metnin maksimum genişliğini ayarlayabilirsiniz
                            child: Text(
                              "${widget.viewModel.character.species}",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Text("Gender:  ", style: TextStyle(color: CupertinoColors.black, fontWeight: FontWeight.w500, fontSize: 17),),
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.28), // Burada metnin maksimum genişliğini ayarlayabilirsiniz
                            child: Text(
                              "${widget.viewModel.character.gender}",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: widget.viewModel.genderColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40,)
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
