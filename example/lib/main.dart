import 'package:flutter/material.dart';
import 'package:advanced_count_control/advanced_count_control.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  // متغیرهای وضعیت برای هر مثال
  int qtyStandard = 10;
  int qtyCustomStyle = 2;
  int qtyNoAddBtn = 1;
  int qtyLoading = 0;
  int qtyIcons = 0;
  int qtyMaxLimit = 8;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Advanced Count Control'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          // ─── 1. حالت استاندارد ───
          _buildSectionTitle('۱. حالت پیش‌فرض (ساده)'),
          AdvancedCountControl(
            currentQuantity: qtyStandard,
            width: 250,
            height: 80,
            maxQuantity: 20,
            onIncrease: () => setState(() => qtyStandard++),
            onDecrease: () => setState(() => qtyStandard--),
          ),

          const SizedBox(height: 30),

          // ─── 2. استایل سفارشی (مثل دیجی‌کالا) ───
          _buildSectionTitle('۲. استایل قرمز (مشابه دیجی‌کالا)'),
          AdvancedCountControl(
            currentQuantity: qtyCustomStyle,
            onIncrease: () => setState(() => qtyCustomStyle++),
            onDecrease: () => setState(() => qtyCustomStyle--),
            style: const CountControlStyle(
              primaryColor: Color(0xFFEF394E), // قرمز
              contentColor: Color(0xFFEF394E),
              borderRadius: 8,
            ),
          ),

          const SizedBox(height: 30),

          // ─── 3. بدون دکمه "افزودن" ───
          _buildSectionTitle('۳. بدون دکمه "افزودن" (همیشه کانتر)'),
          AdvancedCountControl(
            currentQuantity: qtyNoAddBtn,
            showAddButton: false, // 👈 این خط دکمه بزرگ را حذف می‌کند
            onIncrease: () => setState(() => qtyNoAddBtn++),
            onDecrease: () {
              // اجازه نمی‌دهیم کمتر از 0 شود
              if(qtyNoAddBtn > 0) setState(() => qtyNoAddBtn--);
            },
            style: const CountControlStyle(
              primaryColor: Colors.teal,
              contentColor: Colors.teal,
            ),
          ),

          const SizedBox(height: 30),

          // ─── 4. شبیه‌سازی لودینگ ───
          _buildSectionTitle('۴. مدیریت لودینگ (Async)'),
          AdvancedCountControl(
            currentQuantity: qtyLoading,
            isLoading: _isLoading, // 👈 اتصال به متغیر لودینگ
            addButtonLabel: "افزودن (با تاخیر)",
            onIncrease: () => _simulateApiCall(true),
            onDecrease: () => _simulateApiCall(false),
            onAddTap: () => _simulateApiCall(true),
          ),

          const SizedBox(height: 30),

          // ─── 5. حالت غیرفعال (Disabled) ───
          _buildSectionTitle('۵. حالت غیرفعال (Disabled)'),
          AdvancedCountControl(
            currentQuantity: 5,
            isDisabled: true, // 👈 کل ویجت قفل می‌شود
            onIncrease: () {},
            onDecrease: () {},
            style: const CountControlStyle(
              disabledColor: Colors.grey,
            ),
          ),

          const SizedBox(height: 30),

          // ─── 6. آیکون‌های شخصی‌سازی شده ───
          _buildSectionTitle('۶. آیکون‌های دلخواه'),
          AdvancedCountControl(
            currentQuantity: qtyIcons,
            onIncrease: () => setState(() => qtyIcons++),
            onDecrease: () => setState(() => qtyIcons--),
            // 👇 تغییر آیکون‌ها
            iconAdd: Icons.add_circle_outline,
            iconRemove: Icons.remove_circle_outline,
            iconTrash: Icons.cancel_outlined,
            style: const CountControlStyle(
              primaryColor: Colors.purple,
              contentColor: Colors.purple,
              borderRadius: 50, // کاملا گرد
            ),
          ),

          const SizedBox(height: 30),

          // ─── 7. محدودیت تعداد (Max Stock) ───
          _buildSectionTitle('۷. محدودیت موجودی (حداکثر ۱۰)'),
          AdvancedCountControl(
            currentQuantity: qtyMaxLimit,
            maxQuantity: 10, // 👈 سقف تعداد
            maxReachedLabel: "اتمام موجودی",
            onIncrease: () => setState(() => qtyMaxLimit++),
            onDecrease: () => setState(() => qtyMaxLimit--),
            style: const CountControlStyle(
              primaryColor: Colors.orange,
              contentColor: Colors.orange,
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  /// متد کمکی برای شبیه‌سازی درخواست به سرور
  Future<void> _simulateApiCall(bool increase) async {
    setState(() => _isLoading = true);

    // ۲ ثانیه صبر کن
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        if (increase) {
          qtyLoading++;
        } else {
          if (qtyLoading > 0) qtyLoading--;
        }
        _isLoading = false;
      });
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}