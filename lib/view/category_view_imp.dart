import 'package:food4u/model/category_model.dart';
import 'package:food4u/referance/category_refer.dart';
import 'package:food4u/view/category_view.dart';

class CategoryViewImp implements CategoryViewModel {
  @override
  Future<List<CategoryModel>> displayCategoryByRestaurantById(String ccode){
    return getCategoryByRestaurantId(ccode);
  }
}
