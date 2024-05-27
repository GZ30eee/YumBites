import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: _themeData,
      home: const MyHomePage(),
    );
  }
}

ThemeData _themeData = ThemeData(
  primaryColor: const Color(0xFFFF4B3A), // Use your color here
  // Other theme properties...
);
bool _isOrange = true;

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);

    // Draw top line
    canvas.drawLine(Offset(0, center.dy - 10),
        Offset(size.width * 2, center.dy - 10), paint);

    // Draw middle line (shorter)
    canvas.drawLine(
        Offset(10, center.dy), Offset(size.width - 10, center.dy), paint);

    // Draw bottom line
    canvas.drawLine(
        Offset(0, center.dy + 10), Offset(size.width, center.dy + 10), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Review {
  final String profileImage;
  final String name;
  final String description;
  final double rating;

  Review({required this.profileImage, required this.name, required this.description, required this.rating});
}


class FoodItem {
  final String image;
  final String name;
  final String rating;
  final String rate;
  final String description;
  final List<Review> reviews;// Add this line

  FoodItem({
    required this.image,
    required this.name,
    required this.rating,
    required this.rate,
    required this.description,
    required this.reviews,// And this line
  });
}

class Category {
  final String name;
  final List<FoodItem> items;

  Category({required this.name, required this.items});
}

List<Review> reviews = [
  Review(
    profileImage: 'assets/images/profile1.png',
    name: 'John Doe',
    description: 'The food was delicious!',
    rating: 4.5,
  ),
  Review(
    profileImage: 'assets/images/profile2.png',
    name: 'Jane Smith',
    description: 'Great service and tasty food.',
    rating: 5.0,
  ),
  // Add more reviews...
];


List<FoodItem> favoriteItems = [];

List<FoodItem> cartItems = [];

List<FoodItem> foodItems = [
  FoodItem(
    image: 'assets/images/food1.png',
    name: 'Spicy Pasta',
    rating: '4.4',
    rate: '199',
    description:
        'A sizzling taste of the Salmon with crunchiness of freshly baked veggies and garnished with cherry tomatoes and basil oil',
    reviews: reviews,

  ),
  FoodItem(
    image: 'assets/images/food2.png',
    name: 'Fried Rice',
    rating: '4.6',
    rate: '180',
    description: 'Enjoy the delicious meal with the pinch of veggies',
    reviews: reviews,

  ),
  FoodItem(
    image: 'assets/images/item2.jpg',
    name: 'Item 3',
    rating: 'Rating 3',
    rate: 'Rate 2',
    description: 'Description 1',
    reviews: reviews,

  ),

  // Add the rest of your food items here...
];

List<FoodItem> drinkItems = [
  FoodItem(
    image: 'assets/images/drink1.jpg',
    name: 'Latte',
    rating: 'Rating 1',
    rate: 'Rate 1',
    description: 'Description 1',
    reviews: reviews,
  ),
  FoodItem(
    image: 'assets/images/drink2.png',
    name: 'Caramel',
    rating: 'Rating 2',
    rate: 'Rate 2',
    description: 'Description 1',
    reviews: reviews,

  ),
  // Add the rest of your food items here...
];

List<FoodItem> sauceItems = [
  FoodItem(
    image: 'assets/images/sauce1.png',
    name: 'Mustard',
    rating: 'Rating 1',
    rate: 'Rate 1',
    description: 'Description 1',
    reviews: reviews,

  ),
  FoodItem(
    image: 'assets/images/sauce2.png',
    name: 'Chilli',
    rating: 'Rating 2',
    rate: 'Rate 2',
    description: 'Description 1',
    reviews: reviews,

  ),
  // Add the rest of your food items here...
];

List<FoodItem> snackItems = [
  FoodItem(
    image: 'assets/images/snack1.jpg',
    name: 'Donut',
    rating: 'Rating 1',
    rate: 'Rate 1',
    description: 'Description 1',
    reviews: reviews,

  ),
  FoodItem(
    image: 'assets/images/snack2.png',
    name: 'Noodles',
    rating: 'Rating 2',
    rate: 'Rate 2',
    description: 'Description 1',
    reviews: reviews,

  ),
  // Add the rest of your food items here...
];

List<Category> categories = [
  Category(name: 'Foods', items: foodItems),
  Category(name: 'Drinks', items: drinkItems),
  Category(name: 'Snacks', items: snackItems),
  Category(name: 'Sauce', items: sauceItems),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedCategory = 0;
  int _selectedIndex = 0;
  List<FoodItem> cartItems = []; // Initialize your cartItems here

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartPage()));
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritesPage()),
        );
        break;
      case 3:
        Navigator.pushNamed(context, '/history');
        break;
    }
  }

  ValueNotifier<List<FoodItem>> searchResults =
      ValueNotifier<List<FoodItem>>([]);
  ValueNotifier<bool> isSearchBarEmpty = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: SizedBox(
          width: 257,
          height: 36,
          child: TextField(
            onChanged: (value) {
              isSearchBarEmpty.value = value.isEmpty;
              if (value.isEmpty) {
                searchResults.value = [];
              } else {
                searchResults.value = foodItems
                    .where((item) => item.name.contains(value))
                    .toList();
              }
            },
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
              fontSize: 17,
              color: Colors.black.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              fillColor: const Color(0xFFEFEEEE),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0), // adjust as needed
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Hero(
              tag: 'profilePic',
              child: CircleAvatar(
                radius: 25.5,
                backgroundImage: AssetImage('assets/images/profile1.png'),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Container(
                      width: 300.0, // Set your desired width
                      height: 500.0, // Set your desired height
                      child: AlertDialog(
                        content: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                const Positioned(
                                  // Adjust as needed
                                  child: Hero(
                                    tag: 'profilePic',
                                    child: CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage: AssetImage('assets/images/profile1.png'),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // Add your edit functionality here
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20), // This adds some space
                            Row(
                              children: <Widget>[
                                const Text(
                                  'Name: ',
                                  style: TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const Text(
                                  'xyz', // Replace with the actual name
                                  style: TextStyle(
                                    color: Color(0xFFFF4B3A),
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Divider(color: Colors.grey), // This adds a thin line
                            Row(
                              children: <Widget>[
                                const Text(
                                  'Address: ',
                                  style: TextStyle(
                                    color: Color(0xFFC4C4C4),
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const Text(
                                  'xyz', // Replace with the actual address
                                  style: TextStyle(
                                    color: Color(0xFFFF4B3A),
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Divider(color: Colors.grey), // This adds a thin line
                            // Repeat for email and address
                          ],
                        ),
                      ),

                    ),
                  );
                },
              );
            },


          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFFF4B3A),
          // Change the drawer background color to #FF4B3A
          child: ListView(
            padding: const EdgeInsets.only(top: 40.0),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Settings'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Change theme, change font style'),
                            const SizedBox(height: 20), // Add some spacing
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (_isOrange) {
                                    _themeData = ThemeData(
                                      primaryColor:
                                          Colors.black, // Change to black
                                      // Other theme properties...
                                    );
                                  } else {
                                    _themeData = ThemeData(
                                      primaryColor: Colors
                                          .orange, // Change back to orange
                                      // Other theme properties...
                                    );
                                  }
                                  _isOrange = !_isOrange; // Toggle the color
                                });
                              },
                              child: const Text('Change Theme'),
                            ),

                            const SizedBox(height: 10), // Add some spacing
                            ElevatedButton(
                              onPressed: () {
                                // Handle text change
                              },
                              child: const Text('Change Text'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.qr_code, color: Colors.white),
                title: const Text(
                  'Scan Code',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('assets/images/qr_code.png'),
                            // Replace with your QR code image
                            const SizedBox(height: 20),
                            // Add some spacing
                            const Text('Scan the code!'),
                            const SizedBox(height: 10),
                            // Add some spacing
                            InkWell(
                              child: const Text(
                                'Click here',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onTap: () async {
                                const url =
                                    'https://gz30eee.github.io/QR-Code-Generator/';
                                if (await canLaunchUrl(Uri.parse(url))) {
                                  await launchUrl(Uri.parse(url));
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet,
                    color: Colors.white),
                title: const Text(
                  'Wallet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () {
                  // Handle navigation
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_offer, color: Colors.white),
                title: const Text(
                  'Offers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () {
                  // Handle navigation
                },
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.white),
                title: const Text(
                  'Help',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () {
                  // Handle navigation
                },
              ),
              ListTile(
                leading: const Icon(Icons.star_rate, color: Colors.white),
                title: const Text(
                  'Rate the App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Rate the App'),
                        content: RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String dialogText = '25OFFSUS';
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  content: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(dialogText),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.content_copy),
                                        onPressed: () {
                                          Clipboard.setData(const ClipboardData(
                                              text: '25OFFSUS'));
                                          setState(() {
                                            dialogText = 'Copied to clipboard';
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Hero(
                        tag: 'hero1',
                        child: Card(
                          color: const Color(0xFFFF4B3A),
                          child: Container(
                            width: 169,
                            height: 138,
                            padding: const EdgeInsets.all(10.0),
                            // Add some padding
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align text to the left
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '25%',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 48,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' off',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        text: 'on all ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'sushi',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' orders',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Text(
                                      'across app*',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Text(
                                      'Valid till 25th Dec, 2023',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Text(
                                    '*Terms and conditions applied',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 5,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: const Color(0xFFFF4B3A),
                      child: Container(
                        width: 169,
                        height: 138,
                        padding: const EdgeInsets.all(10.0),
                        // Add some padding
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align text to the left
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '50%',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 48,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' off',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: const TextSpan(
                                    text: 'on all ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Mac n Cheese',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' orders across app*',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Text(
                                  'Valid till 25th Dec, 2023',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const Positioned(
                              bottom: 0,
                              right: 0,
                              child: Text(
                                '*Terms and conditions applied',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 5,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
              const SizedBox(height: 8.0), // Add some space between the rows

              Card(
                color: const Color(0xFF333333),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'Use code\n',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'iLovemyfood\n',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            TextSpan(
                              text: 'to get 10% off on your orders\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),





              const SizedBox(height: 8.0),
              Container(
                height: 400,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                // Wrap your Text with a Center widget
                                child: Text(
                                  categories[index].name,
                                  textAlign: TextAlign.center, // Align text to the center
                                  style: const TextStyle(
                                    fontSize: 20.0, // Reduced font size
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                    const SizedBox(height: 1),
                    // Add some space between the categories and items
                    Flexible(
                      flex: 5, // Adjust the flex factor as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories[selectedCategory].items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DescriptionPage(
                                        item: categories[selectedCategory]
                                            .items[index])),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      // Adjust the padding as needed
                                      child: Container(
                                        width: 200,
                                        height: 180,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              categories[selectedCategory]
                                                  .items[index]
                                                  .name,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins-Medium',
                                              ),
                                            ),
                                            Text(
                                              categories[selectedCategory]
                                                  .items[index]
                                                  .rate,
                                              style: const TextStyle(
                                                color: Colors.deepOrange,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            Text(
                                              categories[selectedCategory]
                                                  .items[index]
                                                  .rating,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                fontFamily: 'Poppins-Light',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 63.5,
                                  backgroundImage: AssetImage(
                                      categories[selectedCategory]
                                          .items[index]
                                          .image),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),),
          ValueListenableBuilder<List<FoodItem>>(
            valueListenable: searchResults,
            builder: (context, items, child) {
              if (items.isEmpty) {
                return Container(); // Return an empty Container when there are no search results
              } else {
                return Container(
                  color: Colors.white, // Set the background color to white
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.asset(items[index].image),
                          title: Text(items[index].name),
                          subtitle: Text(items[index].description),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                  onPressed: () => setState(() => _selectedIndex = 0),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                  onPressed: () {
                    setState(() => _selectedIndex = 1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),

                IconButton(
                  icon: Icon(Icons.favorite),
                  color: _selectedIndex == 2 ? Colors.black : Colors.grey,
                  onPressed: () => setState(() => _selectedIndex = 2),
                ),
                IconButton(
                  icon: Icon(Icons.history),
                  color: _selectedIndex == 3 ? Colors.black : Colors.grey,
                  onPressed: () => setState(() => _selectedIndex = 3),
                ),
              ],
            ),
          ),
        ),
      ),


    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int itemCount = 1;
  int _selectedIndex = 0;

  void incrementCount() {
    if (itemCount < 5) {
      setState(() {
        itemCount++;
      });
    }
  }

  void decrementCount() {
    if (itemCount > 1) {
      setState(() {
        itemCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${cartItems[index].name} removed")),
                      );
                      setState(() {
                        cartItems.removeAt(index);
                      });
                    } else if (direction == DismissDirection.startToEnd) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                            Text("${cartItems[index].name} added to favorites")),
                      );
                      // Add code to add item to favorites
                    }
                  },
                  background: Container(
                    color: Colors.green,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(Icons.favorite,
                            color: Colors.white), // Heart icon for favorites
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.delete,
                            color: Colors.white), // Delete icon for removal
                      ),
                    ),
                  ),
                  child: Card(
                    child: Container(
                      width: 336,
                      height: 104,
                      child: Padding( // Add padding here
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40.21,
                              backgroundImage: AssetImage(cartItems[index].image),
                            ),
                            SizedBox(width: 8), // Add space between the image and the text
                            Expanded( // Use Expanded to prevent overflow
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(cartItems[index].name),
                                  Text(
                                    'Price: \$${(double.parse(cartItems[index].rate) * itemCount).toStringAsFixed(2)}',
                                    style: const TextStyle(color: Colors.deepOrange),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Details'),
                                            content: Text(
                                              'Rating: ${cartItems[index].rating}\nDescription: ${cartItems[index].description}',
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Close'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('View Details', style: TextStyle(fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: decrementCount,
                                    ),
                                    Text('$itemCount'),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: incrementCount,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                );
              },
            ),
          ),
          if (cartItems.length > 0)
            ElevatedButton(
              onPressed: () {
                // Navigate to checkout class or perform related actions
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutClass()),
                );
              },
              child: Text('Complete Order'),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                  onPressed: () => setState(() => _selectedIndex = 0),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                  onPressed: () {
                    setState(() => _selectedIndex = 1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),

                IconButton(
                  icon: Icon(Icons.favorite),
                  color: _selectedIndex == 2 ? Colors.black : Colors.grey,
                  onPressed: () => setState(() => _selectedIndex = 2),
                ),
                IconButton(
                  icon: Icon(Icons.history),
                  color: _selectedIndex == 3 ? Colors.black : Colors.grey,
                  onPressed: () => setState(() => _selectedIndex = 3),
                ),
              ],
            ),
          ),
        ),
      ),
      // Rest of your code...
    );
  }
}

class DescriptionPage extends StatefulWidget {
  final FoodItem item;

  DescriptionPage({required this.item});

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  bool addedToCart = false;
  bool isFavorite = false;
  int _selectedIndex = 0;
  List<FoodItem> favoriteItems = []; // Declare favoriteItems here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 25),
        // Increase AppBar height
        child: Padding(
          padding: const EdgeInsets.all(25.0), // Add padding to the top
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              // Back button
              onPressed: () => Navigator.pop(context), // Navigate back
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.black : null,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  if (isFavorite) {
                    // Add the item to the list of favoriteItems
                    FavoritesPage.favoriteItems.add(widget.item);
                  } else {
                    // Remove the item from the list of favoriteItems
                    FavoritesPage.favoriteItems.remove(widget.item);
                  }
                },
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            CircleAvatar(
              radius: 100.0,
              backgroundImage: AssetImage(widget.item.image), // Item image
            ),

            const SizedBox(height: 12.0),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    widget.item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black, // Set color to black
                      fontSize: 24.0, // Set font size to 24px
                      fontFamily: 'Poppins', // Set font family to Poppins
                      fontWeight: FontWeight.w600, // Set font weight to 600
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    widget.item.rate,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFA4A0C), // Set color to black
                      fontSize: 24.0, // Set font size to 24px
                      fontFamily: 'Poppins', // Set font family to Poppins
                      fontWeight: FontWeight.w500, // Set font weight to 600
                    ), // Item rate
                  ),
                ],
              ),
            ),

            const SizedBox(height: 38.0),
            const Text(
              'Description',
              style: TextStyle(
                color: Colors.black, // Set color to black
                fontSize: 16.0, // Set font size to 24px
                fontFamily: 'Poppins', // Set font family to Poppins
                fontWeight: FontWeight.w500, // Set font weight to 600
              ), // Description heading
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.item.description,
              style: const TextStyle(
                color: Colors.black, // Set color to black
                fontSize: 10.0, // Set font size to 24px
                fontFamily: 'Poppins', // Set font family to Poppins
                fontWeight: FontWeight.w400, // Set font weight to 600
              ), // Item rate
            ),
            // Item description
            const SizedBox(height: 10.0),
            const Text(
              'Delivery',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Poppins',
                // Set font family to Poppins
                fontWeight: FontWeight.w500,
              ), // Delivery heading
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Divered within 30mins from your location* if placed now. '
              'Cupon Available.',
              style: TextStyle(
                color: Colors.black, // Set color to black
                fontSize: 10.0, // Set font size to 24px
                fontFamily: 'Poppins', // Set font family to Poppins
                fontWeight: FontWeight.w400, // Set font weight to 600
              ),
            ), // Delivery text
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                const Text(
                  'Review ',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '(${widget.item.rating})/5',
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.orange,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            width: 350.0, // Set the width of the dialog box
                            height: 600.0, // Set the height of the dialog box
                            child: AlertDialog(
                              title: const Text('All Reviews'),
                              content: ListView.builder(
                                itemCount: widget.item.reviews.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 30.0, // Adjust as needed
                                        backgroundImage: AssetImage(widget.item.reviews[index].profileImage),
                                      ),
                                      const SizedBox(width: 10.0), // Add some space between the image and text
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(widget.item.reviews[index].name),
                                                ),
                                                Text('${widget.item.reviews[index].rating}/5'),
                                              ],
                                            ),
                                            Text(widget.item.reviews[index].description),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text(
                    'See all reviews',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Color(0xFF9A9A9D),
                    ),
                  ),
                ),



              ],
            ),
            const SizedBox(height: 10.0),

            const SizedBox(height: 10.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFA4A0C),
                // Button color
                padding: const EdgeInsets.fromLTRB(108.0, 22.0, 108.0, 22.0),
                // Padding inside the box
                minimumSize: const Size(314.0, 70.0), // Button width and height
              ),
              onPressed: () {
                setState(() {
                  addedToCart = !addedToCart; // Toggle the addedToCart state
                  if (addedToCart) {
                    cartItems.add(widget.item); // Add the item to the cart
                  } else {
                    cartItems.remove(widget.item); // Remove the item from the cart
                  }
                });
              },
              child: Text(
                addedToCart ? 'Added' : 'Add to Cart',
                style: const TextStyle(
                  color: Color(0xFFF6F6F9), // Text color
                  fontSize: 17.0, // Font size
                  fontFamily: 'Poppins', // Font family
                  fontWeight: FontWeight.w900, // Font weight
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                  onPressed: () {
                    setState(() => _selectedIndex = 1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                  onPressed: () {
                    setState(() => _selectedIndex = 1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),

                IconButton(
                  icon: Icon(Icons.favorite),
                  color: _selectedIndex == 2 ? Colors.black : Colors.grey,
                  onPressed: () => setState(() => _selectedIndex = 2),
                ),
                IconButton(
                  icon: Icon(Icons.history),
                  color: _selectedIndex == 3 ? Colors.black : Colors.grey,
                  onPressed: () => setState(() => _selectedIndex = 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class FavoritesPage extends StatelessWidget {
  static List<FoodItem> favoriteItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            child: ListTile(
              leading: Image.asset(favoriteItems[index].image),
              title: Text(favoriteItems[index].name),
              subtitle: Text(favoriteItems[index].description),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          ),
        ],
        currentIndex: 2,
        // Set the current index to represent the 'Cart' page
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle navigation based on the tapped index
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          } else if (index == 2) {
            // Navigate to favorites page or perform related actions
          } else if (index == 3) {
            // Navigate to history page or perform related actions
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}


class CheckoutClass extends StatefulWidget {
  @override
  _CheckoutClassState createState() => _CheckoutClassState();
}

class _CheckoutClassState extends State<CheckoutClass> {
  // Default delivery method is Door Delivery
  String deliveryMethod = 'Door Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Add your address details form or widget here

            SizedBox(height: 20),

            Text(
              'Delivery Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio(
                  value: 'Door Delivery',
                  groupValue: deliveryMethod,
                  onChanged: (value) {
                    setState(() {
                      deliveryMethod = value.toString();
                    });
                  },
                ),
                Text('Door Delivery'),
                Radio(
                  value: 'Pick Up',
                  groupValue: deliveryMethod,
                  onChanged: (value) {
                    setState(() {
                      deliveryMethod = value.toString();
                    });
                  },
                ),
                Text('Pick Up'),
              ],
            ),

            Spacer(),

            ElevatedButton(
              onPressed: () {
                // Navigate to PaymentClass or perform related actions
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentClass()),
                );
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          ),
        ],
        currentIndex: 1, // Set the current index to represent the 'Cart' page
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle navigation based on the tapped index
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          } else if (index == 1) {
            // Already on the cart page
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FavoritesPage()), // Pass your favorite items list
            );
          } else if (index == 3) {
            // Navigate to history page or perform related actions
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

class PaymentClass extends StatefulWidget {
  @override
  _PaymentClassState createState() => _PaymentClassState();
}

class _PaymentClassState extends State<PaymentClass> {
  int _paymentMethod = 0; // 0 for card, 1 for bank, 2 for COD

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Payment',
              style: TextStyle(
                fontSize: 34.0,
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20.0), // Leave some space below the heading
            const Text(
              'Payment method',
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20.0), // Leave some space below the subheading
            Container(
              padding: const EdgeInsets.all(23.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), spreadRadius: 10, blurRadius: 40)],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Radio(
                      value: 0,
                      groupValue: _paymentMethod,
                      onChanged: (value) => setState(() => _paymentMethod = value as int),
                    ),
                    title: const Text('Card'),
                    trailing: Icon(Icons.credit_card), // Card icon
                  ),
                  Divider(color: Colors.black.withOpacity(0.3), thickness: 0.5),
                  ListTile(
                    leading: Radio(
                      value: 1,
                      groupValue: _paymentMethod,
                      onChanged: (value) => setState(() => _paymentMethod = value as int),
                    ),
                    title: const Text('Bank'),
                    trailing: Icon(Icons.account_balance), // Bank icon
                  ),
                  Divider(color: Colors.black.withOpacity(0.3), thickness: 0.5),
                  ListTile(
                    leading: Radio(
                      value: 2,
                      groupValue: _paymentMethod,
                      onChanged: (value) => setState(() => _paymentMethod = value as int),
                    ),
                    title: const Text('COD'),
                    trailing: Icon(Icons.money), // COD icon
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0), // Leave some space below the box
            ElevatedButton(
              onPressed: () {
                // Navigate to home page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()), // Replace with your home page
                );
              },
              child: const Text(
                'Start Ordering',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Color(0xFFF6F6F9),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(314.0, 70.0), // Button width and height
              ),
            ),
          ],
        ),
      ),
    );
  }
}


