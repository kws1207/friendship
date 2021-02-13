class Menu {
  String name, hashTags, imageLink;

  Menu(this.name, this.hashTags, this.imageLink);
}

class MenuList {
  num menuNum;
  List<Menu> menuList = [];

  MenuList(this.menuNum) {
    menuList.add(Menu('치킨', '#뿌링클 #고추바사삭 #허니콤보', 'assets/images/chicken.jpg'));
    menuList.add(Menu('떡볶이', '#밀떡 #쌀떡 #오뎅볶이', 'assets/images/tteokbokki.jpg'));
    menuList.add(Menu('파스타', '#토마토 #까르보나라 #로제', 'assets/images/pasta.jpg'));
    menuList.add(Menu('마라요리', '#마라탕 #마라샹궈', 'assets/images/mara.jpg'));
  }
}
