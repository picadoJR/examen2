import 'package:flutter/material.dart';

void main() {
  runApp(const ProductDetailsApp());
}

class ProductDetailsApp extends StatelessWidget {
  const ProductDetailsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Details',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFFAF8FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E78),
        ),
      ),
      home: const ProductDetailsPage(),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String selectedSize = 'M';
  int bottomIndex = 0;

  static const pink = Color(0xFFE91E78);
  static const dark = Color(0xFF25242A);
  static const grey = Color(0xFF777780);
  static const border = Color(0xFFE4E1E5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(43),
        child: AppBar(
          backgroundColor: const Color(0xFFFAF8FA),
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const Text(
            'Product Details',
            style: TextStyle(
              color: dark,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 15),
            color: dark,
            onPressed: () {},
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.only(right: 14),
              icon: const Icon(Icons.share_outlined, size: 17),
              color: dark,
              onPressed: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigation(),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(11, 0, 11, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _heroImage(),
              const SizedBox(height: 17),
              _productTitle(),
              const SizedBox(height: 18),
              _sizeSection(),
              const SizedBox(height: 23),
              _description(),
              const SizedBox(height: 20),
              _actionRow(),
              const SizedBox(height: 27),
              _recommendations(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroImage() {
    return Container(
      height: 263,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.10),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/hero_dress.jpg',
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _productTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Text(
                'Vestido Floral Primavera',
                style: TextStyle(
                  color: Color(0xFF69717F),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Row(
              children: const [
                Icon(Icons.star_rounded, color: pink, size: 10),
                SizedBox(width: 2),
                Text(
                  '4.8',
                  style: TextStyle(
                    color: pink,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Text(
          '\$89.00',
          style: TextStyle(
            color: pink,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _sizeSection() {
    const sizes = ['S', 'M', 'L', 'XL'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Select Size',
              style: TextStyle(
                color: dark,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Size Guide',
              style: TextStyle(
                color: pink,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Row(
          children: sizes.map((size) {
            final selected = selectedSize == size;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: size == sizes.last ? 0 : 8,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => selectedSize = size),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 29,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFFFE4F0)
                          : const Color(0xFFFAF8FA),
                      border: Border.all(
                        color: selected ? pink : border,
                        width: selected ? 1.2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      size,
                      style: TextStyle(
                        color: selected ? pink : dark,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            color: dark,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Experience the beauty of spring with our signature Vestido Floral. This lightweight, breathable dress features a vibrant pink blossom pattern on high-quality silk-blend fabric. Perfect for garden parties, weddings, or a sunny afternoon out.',
          style: TextStyle(
            color: grey,
            fontSize: 8.5,
            height: 1.42,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 9),
        _bullet('100% Sustainable Cotton Blend'),
        const SizedBox(height: 7),
        _bullet('Adjustable waist tie for perfect fit'),
      ],
    );
  }

  Widget _bullet(String text) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle_outline_rounded,
          color: pink,
          size: 10,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: grey,
            fontSize: 8,
          ),
        ),
      ],
    );
  }

  Widget _actionRow() {
    return Row(
      children: [
        Container(
          width: 31,
          height: 31,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: pink, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.favorite_border_rounded,
            color: pink,
            size: 17,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: SizedBox(
            height: 31,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: pink,
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: pink.withOpacity(.25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.zero,
              ),
              icon: const Icon(Icons.shopping_bag_outlined, size: 13),
              label: const Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _recommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You might also like',
          style: TextStyle(
            color: dark,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _productCard(
                image: 'assets/summer_breeze.jpg',
                name: 'Summer Breeze',
                price: '\$75.00',
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: _productCard(
                image: 'assets/boho_chic.jpg',
                name: 'Boho Chic Maxi',
                price: '\$92.00',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productCard({
    required String image,
    required String name,
    required String price,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 116,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 6,
                right: 6,
                child: Icon(
                  Icons.favorite_border_rounded,
                  color: Color(0xFFB7B7BE),
                  size: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(
            color: dark,
            fontSize: 8,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          price,
          style: const TextStyle(
            color: pink,
            fontSize: 8,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _bottomNavigation() {
    final labels = ['Shop', 'Search', 'Bag', 'Profile'];
    final icons = [
      Icons.storefront_rounded,
      Icons.search_rounded,
      Icons.shopping_bag_outlined,
      Icons.person_outline_rounded,
    ];

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFFCFAFC),
        border: const Border(
          top: BorderSide(color: Color(0xFFEDE9ED), width: .7),
        ),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final active = index == bottomIndex;
          return Expanded(
            child: InkWell(
              onTap: () => setState(() => bottomIndex = index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icons[index],
                    size: 14,
                    color: active ? pink : const Color(0xFF89909C),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[index],
                    style: TextStyle(
                      color: active ? pink : const Color(0xFF89909C),
                      fontSize: 7,
                      fontWeight:
                          active ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}