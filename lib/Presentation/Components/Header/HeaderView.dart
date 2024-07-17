import 'package:flutter/cupertino.dart';

import 'HeaderViewModel.dart';


class HeaderView extends StatefulWidget {
  final HeaderViewModel viewModel;
  HeaderView({required this.viewModel});

  @override
  _HeaderViewState createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // İstediğiniz yüksekliği burada ayarlayabilirsiniz
      child: CupertinoNavigationBar(
        border: null,
        middle: Row(
          children: [
            Text(
              widget.viewModel.headerTitle,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            CupertinoButton(
              onPressed: () {
                widget.viewModel.isFilterMenuOpen();
              },
              child: Text(
                "Filter",
                style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 26, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        backgroundColor: CupertinoColors.white,
      ),
    );
  }
}
