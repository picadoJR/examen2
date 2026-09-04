import 'package:flutter/material.dart';

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

      // BARRA SUPERIOR
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
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 15,
            ),
            color: dark,
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          actions: [
            IconButton(
              padding: const EdgeInsets.only(right: 14),
              icon: const Icon(
                Icons.share_outlined,
                size: 17,
              ),
              color: dark,
              onPressed: () {},
            ),
          ],
        ),
      ),

      // BARRA INFERIOR
      bottomNavigationBar: _bottomNavigation(),

      // CONTENIDO
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(
            11,
            0,
            11,
            14,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // IMAGEN PRINCIPAL
              _heroImage(),

              const SizedBox(height: 17),

              // NOMBRE Y PRECIO
              _productTitle(),

              const SizedBox(height: 18),

              // TALLAS
              _sizeSection(),

              const SizedBox(height: 23),

              // DESCRIPCIÓN
              _description(),

              const SizedBox(height: 20),

              // BOTONES
              _actionRow(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // IMAGEN PRINCIPAL
  // ============================================================

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

        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey,
              size: 40,
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // NOMBRE DEL PRODUCTO Y PRECIO
  // ============================================================

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

                Icon(
                  Icons.star_rounded,
                  color: pink,
                  size: 10,
                ),

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

  // ============================================================
  // SELECCIÓN DE TALLA
  // ============================================================

  Widget _sizeSection() {
    const sizes = [
      'S',
      'M',
      'L',
      'XL',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

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

            final selected =
                selectedSize == size;

            return Expanded(

              child: Padding(

                padding: EdgeInsets.only(
                  right:
                      size == sizes.last
                          ? 0
                          : 8,
                ),

                child: GestureDetector(

                  onTap: () {

                    setState(() {
                      selectedSize = size;
                    });
                  },

                  child: AnimatedContainer(

                    duration:
                        const Duration(
                      milliseconds: 150,
                    ),

                    height: 29,

                    decoration:
                        BoxDecoration(

                      color: selected
                          ? const Color(
                              0xFFFFE4F0,
                            )
                          : const Color(
                              0xFFFAF8FA,
                            ),

                      border: Border.all(

                        color: selected
                            ? pink
                            : border,

                        width:
                            selected
                                ? 1.2
                                : 1,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        5,
                      ),
                    ),

                    alignment:
                        Alignment.center,

                    child: Text(

                      size,

                      style: TextStyle(

                        color: selected
                            ? pink
                            : dark,

                        fontSize: 9,

                        fontWeight:
                            FontWeight.w600,
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

  // ============================================================
  // DESCRIPCIÓN
  // ============================================================

  Widget _description() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

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

        _bullet(
          '100% Sustainable Cotton Blend',
        ),

        const SizedBox(height: 7),

        _bullet(
          'Adjustable waist tie for perfect fit',
        ),
      ],
    );
  }

  // ============================================================
  // CARACTERÍSTICAS
  // ============================================================

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

  // ============================================================
  // BOTÓN FAVORITOS + ADD TO CART
  // ============================================================

  Widget _actionRow() {

    return Row(
      children: [

        // FAVORITOS
        Container(

          width: 31,
          height: 31,

          decoration:
              BoxDecoration(

            color: Colors.transparent,

            border: Border.all(
              color: pink,
              width: 1,
            ),

            borderRadius:
                BorderRadius.circular(6),
          ),

          child: const Icon(
            Icons.favorite_border_rounded,
            color: pink,
            size: 17,
          ),
        ),

        const SizedBox(width: 9),

        // ADD TO CART
        Expanded(

          child: SizedBox(

            height: 31,

            child: ElevatedButton.icon(

              onPressed: () {},

              style:
                  ElevatedButton.styleFrom(

                backgroundColor: pink,

                foregroundColor:
                    Colors.white,

                elevation: 2,

                shadowColor:
                    pink.withOpacity(.25),

                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(
                    6,
                  ),
                ),

                padding:
                    EdgeInsets.zero,
              ),

              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 13,
              ),

              label: const Text(

                'Add to Cart',

                style: TextStyle(
                  fontSize: 9,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BARRA DE NAVEGACIÓN INFERIOR
  // ============================================================

  Widget _bottomNavigation() {

    final labels = [
      'Shop',
      'Search',
      'Bag',
      'Profile',
    ];

    final icons = [

      Icons.storefront_rounded,

      Icons.search_rounded,

      Icons.shopping_bag_outlined,

      Icons.person_outline_rounded,
    ];

    return Container(

      height: 56,

      decoration:
          const BoxDecoration(

        color: Color(0xFFFCFAFC),

        border: Border(
          top: BorderSide(
            color: Color(0xFFEDE9ED),
            width: .7,
          ),
        ),
      ),

      child: Row(

        children:
            List.generate(
          labels.length,
          (index) {

            final active =
                index == bottomIndex;

            return Expanded(

              child: InkWell(

                onTap: () {

                  setState(() {
                    bottomIndex = index;
                  });
                },

                child: Column(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Icon(

                      icons[index],

                      size: 14,

                      color: active
                          ? pink
                          : const Color(
                              0xFF89909C,
                            ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Text(

                      labels[index],

                      style: TextStyle(

                        color: active
                            ? pink
                            : const Color(
                                0xFF89909C,
                              ),

                        fontSize: 7,

                        fontWeight: active
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}