import 'package:food4u/model/foodtype_model.dart';

abstract class FoodView{
  Future<List<FoodTypeModel>> displayFoodList();
}