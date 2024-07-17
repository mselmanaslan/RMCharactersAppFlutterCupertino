
class FavoriteIconViewModel {
  bool isFavorited;
  Function() favoriteIconAction;

  FavoriteIconViewModel({required this.isFavorited, required this.favoriteIconAction });


  void changeFavoriteState() {
    isFavorited = !isFavorited;
    print(isFavorited);
  }

}
