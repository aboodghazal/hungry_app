const String baseUrl = 'https://sonic-zdi0.onrender.com/api';

const String logins = '/login';
const String signup = '/register';
const String getProfile = '/profile';
 const String logouts = '/logout';
const String updateProfiles = '/update-profile';
const String getCategorys = '/categories';
const String getProducts = '/products';
const String getToppings = '/toppings';
const String getSideOptions = '/side-options';
const String toggleFav = '/toggle-favorite';
const String getCarts = '/cart';
const String addToCarts = '/cart/add';

String deleteItemCarts(int idItem)=>'/cart/remove/$idItem';

 String getProductDetails(int idProduct)=>'/products/$idProduct';