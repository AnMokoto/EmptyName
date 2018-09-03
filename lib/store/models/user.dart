class UserModel extends Object {
  String token = "";
  UserInfo mUserInfo;
  UserBalance mUserBalance;

  UserModel() {
    mUserBalance = new UserBalance(0, 0);
    mUserInfo = new UserInfo();
  }
}

class UserBalance extends Object {
  dynamic totalBalance;
  dynamic withdrawable;
  UserBalance(this.totalBalance, this.withdrawable);
}

class UserInfo extends Object {
  dynamic avatar;
  dynamic nickName;
  dynamic username;
  dynamic phone;
  dynamic type;
}
