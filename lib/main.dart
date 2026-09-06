import 'package:flutter/material.dart';

void main() => runApp(const IshaqzadaApp());

class Product {
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final IconData icon;
  const Product(this.name, this.category, this.price, this.oldPrice, this.icon);
}

class IshaqzadaApp extends StatelessWidget {
  const IshaqzadaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'اسحاقزاده آنلاین خدمات',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080808),
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFC107),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const ShopHome(),
    );
  }
}

class ShopHome extends StatefulWidget {
  const ShopHome({super.key});

  @override
  State<ShopHome> createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  int tab = 0;
  final List<Product> products = const [
    Product('اصلي عطر', 'فیشن سامان', 60, 80, Icons.local_florist),
    Product('د مخ پوستکي کریم', 'کریمونه', 17.5, 25, Icons.spa),
    Product('لوکس جاکټ', 'فیشن سامان', 36, 45, Icons.checkroom),
    Product('لوکس ښځینه بکس', 'اکسسوري', 34, 40, Icons.shopping_bag),
  ];
  final List<Product> cart = [];

  void add(Product p) {
    setState(() => cart.add(p));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${p.name} سبد ته اضافه شو')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _home(),
      _categories(),
      _cart(),
      _profile(),
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: pages[tab]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (i) => setState(() => tab = i),
          backgroundColor: const Color(0xFF0D0D0D),
          indicatorColor: const Color(0x33FFC107),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'کور'),
            NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'کټګورۍ'),
            NavigationDestination(icon: Badge(child: Icon(Icons.shopping_cart_outlined)), selectedIcon: Icon(Icons.shopping_cart), label: 'سبد'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'پروفایل'),
          ],
        ),
      ),
    );
  }

  Widget _header() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
    child: Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFFFC107),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Image.asset('assets/logo.png', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('اسحاقزاده آنلاین خدمات',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
              Text('فیشن • کریمونه • شخصي استعمال سامان',
                style: TextStyle(fontSize: 11, color: Colors.white70)),
            ],
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Color(0xFFFFC107))),
        Badge(
          label: Text('${cart.length}'),
          isLabelVisible: cart.isNotEmpty,
          child: IconButton(onPressed: () => setState(() => tab = 2), icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFFFC107))),
        ),
      ],
    ),
  );

  Widget _search() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white24),
      borderRadius: BorderRadius.circular(18),
    ),
    child: const TextField(
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        border: InputBorder.none,
        icon: Icon(Icons.search, color: Color(0xFFFFC107)),
        hintText: 'د محصول نوم ولټوئ...',
      ),
    ),
  );

  Widget _home() => ListView(
    children: [
      _header(),
      _search(),
      const SizedBox(height: 14),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF332000), Color(0xFF0D0D0D)],
          ),
          border: Border.all(color: const Color(0x66FFC107)),
        ),
        child: Stack(
          children: [
            const Positioned(
              right: 20, top: 22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('اسحاقزاده', style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
                  Text('آنلاین خدمات', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                  SizedBox(height: 7),
                  Text('کیفیت • اعتماد • رضایت مشتری', style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 15),
                  DecoratedBox(
                    decoration: BoxDecoration(color: Color(0xFFFFC107), borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                      child: Text('اوس یې واخلئ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
            ),
            const Positioned(left: 12, bottom: 10, child: Icon(Icons.shopping_bag, size: 105, color: Color(0x55FFC107))),
          ],
        ),
      ),
      const SizedBox(height: 18),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text('کټګورۍ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      const SizedBox(height: 10),
      SizedBox(
        height: 105,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            _cat('فیشن سامان', Icons.checkroom),
            _cat('کریمونه', Icons.spa),
            _cat('اکسسوري', Icons.watch),
            _cat('نور سامان', Icons.category),
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
        child: Text('ځانګړي وړاندیزونه', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
      ),
      SizedBox(
        height: 275,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: products.length,
          itemBuilder: (_, i) => _productCard(products[i]),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );

  Widget _cat(String title, IconData icon) => Container(
    width: 92,
    margin: const EdgeInsets.only(left: 10),
    child: Column(
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor: const Color(0x2210FFC107),
          child: Icon(icon, color: const Color(0xFFFFC107), size: 30),
        ),
        const SizedBox(height: 6),
        Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
      ],
    ),
  );

  Widget _productCard(Product p) => Container(
    width: 175,
    margin: const EdgeInsets.only(left: 12),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF111111),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0x555A4300)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(p.icon, size: 72, color: const Color(0xFFFFC107)),
          ),
        ),
        const SizedBox(height: 8),
        Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(p.category, style: const TextStyle(color: Colors.white54, fontSize: 11)),
        const SizedBox(height: 5),
        Row(
          children: [
            Text('\$${p.price}', style: const TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold, fontSize: 17)),
            const Spacer(),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () => add(p),
              icon: const Icon(Icons.add_shopping_cart, color: Color(0xFFFFC107)),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _categories() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      const Text('ټولې کټګورۍ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
      const SizedBox(height: 18),
      _categoryTile('فیشن سامان', Icons.checkroom, 'کالي، جاکټونه او نور'),
      _categoryTile('کریمونه او ښکلا', Icons.spa, 'د پوستکي او ښکلا محصولات'),
      _categoryTile('اکسسوري', Icons.watch, 'بکس، ساعت، عینکې او نور'),
      _categoryTile('نور سامان', Icons.category, 'نور آنلاین محصولات'),
    ],
  );

  Widget _categoryTile(String title, IconData icon, String sub) => Card(
    color: const Color(0xFF111111),
    child: ListTile(
      leading: CircleAvatar(backgroundColor: const Color(0x22FFC107), child: Icon(icon, color: const Color(0xFFFFC107))),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(sub, style: const TextStyle(color: Colors.white60)),
      trailing: const Icon(Icons.chevron_left, color: Color(0xFFFFC107)),
    ),
  );

  Widget _cart() {
    final total = cart.fold<double>(0, (s, p) => s + p.price);
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('ستاسې سبد', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
        const SizedBox(height: 15),
        if (cart.isEmpty) const Padding(
          padding: EdgeInsets.only(top: 80),
          child: Column(children: [Icon(Icons.shopping_cart_outlined, size: 70, color: Colors.white38), SizedBox(height: 12), Text('سبد تش دی')]),
        ),
        ...cart.map((p) => Card(
          color: const Color(0xFF111111),
          child: ListTile(
            leading: Icon(p.icon, color: const Color(0xFFFFC107)),
            title: Text(p.name),
            subtitle: Text('\$${p.price}'),
          ),
        )),
        if (cart.isNotEmpty) ...[
          const Divider(),
          Text('ټول: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => _showOrderDialog(),
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFFFC107), foregroundColor: Colors.black),
            child: const Text('فرمایش ثبت کړئ'),
          ),
        ],
      ],
    );
  }

  void _showOrderDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('فرمایش'),
        content: const Text('په راتلونکې نسخه کې به د نوم، موبایل، پته او تادیې معلومات دلته ثبتېږي.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('سمه ده'))],
      ),
    );
  }

  Widget _profile() => const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(radius: 40, child: Icon(Icons.person, size: 42)),
        SizedBox(height: 12),
        Text('زما پروفایل', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFFC107))),
        SizedBox(height: 8),
        Text('د مشتری معلومات او فرمایشونه'),
      ],
    ),
  );
}
