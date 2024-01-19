import 'package:get/get.dart';

class MyTransilation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": {
          // Login Screen
          "login": 'Login',
          "enterEmail": "Enter Email",
          "enterPass": "Enter Password",

          // main Appbar
          "welcome": "Welcome Back ",
          "AppbarDesc": "Here is the information about all your orders",
          "search": "Search",

          // Sidebar
          "dashboard": "Dashboard",
          "categories": "Categories",
          "Orders": "Orders",
          "dileveryZones": "Dilevery Zones",

          // Settings
          "lang": "Language",
          "darkmode": "Dark Mode",
          "logout": "Logout",

          "add": "Add",

          // Home
          "findProduct": "Find Product",
          "offerTitle": "Summer Suprise",
          "offerDesc": "Cashback 20%",
          "productForYou": "Products For You",
          "offerThisMonth": "Offer This Month",
          "compeletedOrders": "Compeleted Orders",
          "pendingOrders": "Pending Orders",
          "totalOrders": "Total Orders",
          "Daily": "Daily",
          "Monthly": "Monthly",
          "OrdersAnalytics": "Orders Analytics",
          'NumberofOrders': "Number of Orders",
          "CategoriesSales": "Categories Sales",

          // Categories
          "CreateNewCategory": "Create New Category",
          "CategoryName": "Category Name",
          "CategoryNameAr": "Category Name Ar",
          "PickImage": "Pick Image",
          "Create": "Create",

          "Edit": "Edit ",
          "category": "Category ",

          "Warrning": "Warrning",
          "DeleteCategory": "Are You Sure For Delete This Category ?",
          "Confirm": "Confirm",
          "Cancel": "Cancel",
          "canceled": "Canceled",

          // CategoryProducts
          'AddProduct': 'Add Product',
          "NoMoreProducts": "No More Products",

          // Product Details
          "ColorsandSizes": "Colors and Sizes",
          "Delete": "Delete",
          "Size": "Size",
          "Quantity/Color": "Quantity / Colors",
          "DeleteProduct": "Are You Sure You Want To Delete This Product ?",

          // Edit Product
          "ProductName": "Product Name",
          "ProductNameAr": "Product Name Ar",
          "ProductDesc": "Product Desc",
          "ProductDescAr": "Product Desc Ar",
          "Price": "Price",
          "Discount%": "Discount %",
          "MainImage": "Main Image",
          "OtherImages": "Other Images",
          "ImagePreview": "Image Preview",
          "Sizes:": "Sizes : ",
          "Colors:": "Colors : ",
          "Quantity": "Quantity",

          // Orders
          "orders": "Orders",
          'index': 'index',
          'User': 'User',
          'Zone': 'Zone',
          'ShippingFee': 'Shipping Fee',
          'Status': 'Status',
          'TotalPrice': 'Total Price',
          'PaymentMethod': 'Payment Method',
          'numofItems': 'num of Items',
          'Date': 'Date',
          "Refresh": "Refresh",

          // Order Details
          "OrdersDetails#": "OrdersDetails",
          "DeliveryDetails": "DeliveryDetails",
          'Street:': 'Street : ',
          'Building:': 'Building : ',
          'Floor:': 'Floor : ',
          'Apartment :': 'Apartment :',
          'Zone:': 'Zone : ',
          'DeliveyTime:': 'DeliveyTime : ',
          "within": "with in ",
          "days": " days",
          "OrderStatus:": "Order Status : ",
          "completed": "completed",
          "pending": "pending",
          "outForDeleviery": "Out For Deleviery",
          'Prepared': 'Prepared',

          // Delivery Zones
          "DeliveryZones": "Delivery Zones",
          'AddZone': 'Add Zone',
          'Fee': 'Fee',
          'TimeinDays': 'Time in Days',
          'CreatedAt': 'Created At',
          'UpdatedAt': 'Updated At',
          'Actions': 'Edit / Delete',
          'AddNewZone': 'Add New Zone',
          "ZoneName": "Zone Name",
          "ZoneNameAr": "Zone Name Ar",
          "ZoneFee": "Zone Fee",
          "ZoneDeliveryDays": "Zone Delivery Days",
          "DeleteZone": "Are You Sure Wanna Delete This Zone ?",

          // Search
          "ResultsFor:": "Results For :",
          "NoResultsWereFound": "No Results Were Found",

          // Add Product
          "AddNewProductTo": "Add New Product To ",
          "CreateProduct": "Create Product"
        },
        "ar": {
          "login": 'تسجيل الدخول',
          // main Appbar
          'welcome': "مرحبا بك يا ",
          "AppbarDesc": "ستجد هنا كل المعلومات الخاصة بطلبياتك",
          "search": "بحث",
          'email': "البريد الالكتروني",
          'password': "كلمة السر",
          "enterEmail": "ادخل الايميل",
          "enterPass": "ادخل كلمة السر",

          // Validate Fields
          "notEmpty": "الحقل لا يجب ان يكون فارغا",
          "passless8": "كلمة السر لا تجب ان تكون اقل من 8 احرف",

          // Sidebar
          "dashboard": "الأحصائيات",
          "categories": "الأقسام",
          "Orders": "الطلبيات",
          "dileveryZones": "مناطق التوصيل",

          // Settings
          "lang": "اللغة",
          "darkmode": "الوضع المظلم",
          "logout": "تسجيل خروج",

          "add": "أضافة",
          // Home
          "findProduct": "البحث عن منتج",
          "offerTitle": "عروض الصيف",
          "offerDesc": "كاش باك 20%",
          "productForYou": "منتجات لك",
          "offerThisMonth": "عروض هذا الشهر",
          "compeletedOrders": "طلبات مكتملة",
          "pendingOrders": "طلبات معلقة",
          "totalOrders": "مجموع الطلبات",
          "Daily": "يومي",
          "Monthly": "شهري",
          "OrdersAnalytics": "تحليل الطلبات",
          'NumberofOrders': "عدد الطلبات",
          "CategoriesSales": "مبيعات الاقسام",

          // Categories
          "CreateNewCategory": "انشاء قسم جديد",
          "CategoryName": "اسم القسم بالانجليزية",
          "CategoryNameAr": "اسم القسم بالعربية",
          "PickImage": "اختر صورة",
          "Create": "انشاء",

          "Edit": " تعديل",
          "category": " القسم ",

          "Warrning": "تحذير",
          "DeleteCategory": "هل انت متأكد من حذف هذا القسم ؟",
          "Confirm": "تأكيد",
          "Cancel": "الغاء",
          "canceled": "ملغي ",
          // CategoryProducts
          'AddProduct': "أضافة منتج",
          "NoMoreProducts": "لا يوجد منتجات اخري",

          // Product Details
          "ColorsandSizes": "الالوان و المقاسات",
          "Delete": "حذف",
          "Size": "المقاس",
          "Quantity/Color": "اللون / الكمية",
          "DeleteProduct": "هل انت متأكد من حذف هذا المنتج ؟",

          // Edit Product
          "ProductName": "اسم المنتج",
          "ProductNameAr": "اسم المنتج بالعربية",
          "ProductDesc": "وصف المنتج",
          "ProductDescAr": "وصف المنتج بالعربية",
          "Price": "السعر",
          "Discount%": "% الخصم",
          "MainImage": "الصورة الرئيسية",
          "OtherImages": "صور اخري",
          "ImagePreview": "صورة توضيحية",
          "Sizes:": "المقاس : ",
          "Colors:": "اللون :",
          "Quantity": "الكمية",

          // Orders
          "orders": "الطلبات",
          'index': 'التسلسل',
          'User': 'المستخدم',
          'Zone': ' المنطقة ',
          'ShippingFee': 'رسوم التوصيل',
          'Status': 'حالة الطلب',
          'TotalPrice': 'السعر النهائي',
          'PaymentMethod': 'طريقة الدفع',
          'numofItems': 'عدد العناصر',
          'Date': 'التاريخ',
          "Refresh": "تحديث",

          // Order Details
          "OrdersDetails#": " تفاصيل الطلب ",
          "DeliveryDetails": "معلومات التوصيل",
          'Street:': 'الشارع : ',
          'Building:': "المبني : ",
          'Floor:': 'الدور : ',
          'Apartment:': 'الشقة : ',
          'Zone:': 'المنطقة : ',
          'DeliveyTime:': 'وقت التوصيل : ',
          "within": "في خلال ",
          "days": " ايام ",
          "OrderStatus:": "حالة الطلب : ",
          "completed": "مكتملة",
          "pending": "معلفة",
          "outForDeleviery": "خرج للتوصيل",
          'Prepared': 'تم التحضير ',

          // Delivery Zones
          "DeliveryZones": "مناطق التوصيل",
          'AddZone': 'اضافة منطقة',
          'Fee': 'رسوم التوصيل',
          'TimeinDays': 'الوقت بالأيام',
          'CreatedAt': 'أنشئت في ',
          'UpdatedAt': 'اخر تحديث',
          'Actions': "تعديل / حذف",
          'AddNewZone': 'اضافة منطقة جديدة',
          "ZoneName": "اسم المنطقة",
          "ZoneNameAr": "اسم المنطقة بالعربية",
          "ZoneFee": "سعر المنطقة",
          "ZoneDeliveryDays": "وقت التوصيل للمنطقة بالأيام",
          "DeleteZone": "هل انت متأكد من حذف هذه المنطقة ؟",

          // Search
          "ResultsFor:": "نتائج البحث عن : ",
          "NoResultsWereFound": "لا يوجد اي نتائج",

          // Add Product
          "AddNewProductTo": "اضافة منتج جديد الي :",
          "CreateProduct": "انشاء المنتج"
        }
      };
}
