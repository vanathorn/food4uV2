import 'package:food4u/model/shopmenu_model.dart';
import 'package:food4u/referance/shopmenu_refer.dart';
import 'package:food4u/view/shopmenu_view.dart';

class ShopMenuViewImp implements ShopMenuView{
  @override
  Future<List<ShopMenuModel>> displayShopMenuList(){
    return getShopMenuList();
  }
}