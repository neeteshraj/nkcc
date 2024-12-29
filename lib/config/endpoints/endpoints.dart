class Endpoints {
  static const String _basePath = "/nkcc/sca/api/v1";

  static const String login = "$_basePath/users/login";
  static const String register = "$_basePath/users/register";
  static const String userDetail = "$_basePath/users/details";
  static const String productsList = "$_basePath/products/list";
  static const String myProducts = "$_basePath/bills/find";
  static const String listProductsByBillId = "$_basePath/bills/findById";
}
