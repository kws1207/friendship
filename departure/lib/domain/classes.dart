class Menu {
  String name, hashTags, imageLink;

  Menu(this.name, this.hashTags, this.imageLink);
}

class MenuList {
  num menuNum;
  List<Menu> menuList = [];

  MenuList(this.menuNum) {
    menuList.add(Menu('치킨', '#뿌링클 #고추바사삭 #허니콤보', 'assets/images/치킨.jpg'));
    menuList.add(Menu('마라요리', '#마라탕 #마라샹궈', 'assets/images/마라요리.jpg'));
    menuList.add(Menu('떡볶이', '#밀떡 #쌀떡 #오뎅볶이', 'assets/images/떡볶이.jpg'));
    menuList.add(Menu('파스타', '#토마토 #까르보나라 #로제 #투움바', 'assets/images/파스타.jpg'));
    /*
    menuList.add(Menu('리조또', '#베이컨크림 #로제 #버섯크림', 'assets/images/리조또.jpg'));
    menuList.add(Menu('피자', '#불고기 #포테이토 #콤비네이션 #고구마', 'assets/images/피자.jpg'));
    menuList.add(Menu('라멘', '#차슈 #돈코츠', 'assets/images/라멘.jpg'));
    menuList.add(Menu('족발', '#냉채족발 #막국수 #불족발', 'assets/images/족발.jpg'));
    menuList.add(Menu(
        '고기덮밥', '#스테이크덮밥 #목살덮밥 #대창덮밥 #항정살덮맙 #차슈덮밥', 'assets/images/고기덮밥.jpg'));
    menuList.add(Menu('감자탕', '#뼈해장국', 'assets/images/감자탕.jpg'));
    menuList.add(Menu('김밥', '#참치 #치즈 #야채 #돈까스', 'assets/images/김밥.jpg'));
    menuList.add(Menu('찜닭', '#안동 #로제 #고추장', 'assets/images/찜닭.jpg'));
    menuList.add(Menu('닭갈비', '#춘천 #우동사리추가 #볶음밥', 'assets/images/닭갈비.jpg'));
    menuList.add(Menu('곱창전골', '#수제비사리 #볶음밥', 'assets/images/곱창전골.jpg'));
    menuList.add(Menu('야채곱창', '#알곱창 #볶음밥 #치즈곱창', 'assets/images/야채곱창.jpg'));
    menuList.add(Menu('곱창구이', '#데리야끼 #양념 #소금구이', 'assets/images/곱창구이.jpg'));
    menuList.add(Menu('막창', '#불막창', 'assets/images/막창.jpg'));
    menuList.add(
        Menu('돼지고기구이', '#우삼겹 #삼겹살 #오겹살 #목살 #뒷고기', 'assets/images/돼지고기구이.jpg'));
    menuList.add(Menu('초밥', '#연어 #활어 #참치', 'assets/images/초밥.jpg'));
    menuList.add(Menu('돈까스', '#등심 #히레 #경양식', 'assets/images/돈까스.jpg'));
    menuList.add(Menu('메밀소바', '#밀가루 #판모밀 #냉모밀', 'assets/images/메밀소바.jpg'));
    menuList.add(Menu('카레', '#일본식 #인도식', 'assets/images/카레.jpg'));
    menuList.add(Menu('함박스테이크', '#로제 #치즈 #반숙후라이', 'assets/images/함박스테이크.jpg'));
    menuList.add(Menu('중화면요리', '#밀가루', 'assets/images/중화면요리.jpg'));
    menuList.add(Menu('중화고기요리', '#탕수육 #깐풍기 #동파육', 'assets/images/중화고기요리.jpg'));
    menuList.add(Menu('중화해산물요리', '#유산슬 #잡탕밥', 'assets/images/중화해산물요리.jpg'));
    menuList.add(Menu('회', '#광어회 #도미 #우럭', 'assets/images/회.jpg'));
    menuList.add(Menu('닭발', '#무뼈닭발 #오돌뼈', 'assets/images/닭발.jpg'));
    menuList.add(Menu('아구찜', '#알 #콩나물 #창원', 'assets/images/아구찜.jpg'));
    menuList.add(Menu('비빔밥', '#전주비빔밥 #육회비빔밥 #우삼겹', 'assets/images/비빔밥.jpg'));
    menuList.add(Menu('후토마키', '#장어 #멸치 #계란', 'assets/images/후토마키.jpg'));
    menuList.add(Menu('텐동', '#새우튀김 #계란 #단호박 #오징어', 'assets/images/텐동.jpg'));
    */
  }
}
