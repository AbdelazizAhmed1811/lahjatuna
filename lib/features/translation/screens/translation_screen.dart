import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahjatuna/features/history/screens/camera_page.dart';
import 'package:lahjatuna/features/history/screens/chat_page.dart';
import 'package:lahjatuna/features/history/screens/favorites_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../themes/colors.dart';
import '../../history/screens/history_page.dart';
import '../widgets/input_widget.dart';
import '../widgets/output_widget.dart';
import '../widgets/side_bar.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final _pageController =
      PageController(initialPage: 2); // Set initial page to 2
  final NotchBottomBarController _notchController =
      NotchBottomBarController(index: 2); // Focus on the Translate icon

  final List<Widget> _pages = [
    const ChatPage(),
    const CameraPage(),
    const TranslationPage(),
    const HistoryPage(),
    const FavoritesPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _notchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var animatedNotchBottomBar = AnimatedNotchBottomBar(
      notchBottomBarController: _notchController,
      notchColor: ColorsManager.dartBlue,
      bottomBarItems: const [
        BottomBarItem(
          inActiveItem: Icon(Icons.mic, color: Colors.grey),
          activeItem: Icon(Icons.mic, color: Colors.white),
          itemLabel: 'Chat',
        ),
        BottomBarItem(
          inActiveItem: Icon(Icons.camera, color: Colors.grey),
          activeItem: Icon(Icons.camera, color: Colors.white),
          itemLabel: 'Camera',
        ),
        BottomBarItem(
          inActiveItem: Icon(Icons.translate, color: Colors.grey),
          activeItem: Icon(Icons.translate, color: Colors.white),
          itemLabel: 'Translate',
        ),
        BottomBarItem(
          inActiveItem: Icon(Icons.history, color: Colors.grey),
          activeItem: Icon(Icons.history, color: Colors.white),
          itemLabel: 'History',
        ),
        BottomBarItem(
          inActiveItem: Icon(Icons.favorite, color: Colors.grey),
          activeItem: Icon(Icons.favorite, color: Colors.white),
          itemLabel: 'Favorites',
        ),
      ],
      color: Colors.white,
      onTap: (index) {
        setState(() {
          _pageController.jumpToPage(index);
        });
      },
      kIconSize: 25,
      kBottomRadius: 30,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.dartBlue,
        title: Text(
          "Lahjatuna",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.sp,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      drawer: const SideBar(),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (value) {
          setState(() {
            _notchController.index = value;
          });
        },
      ),
      bottomNavigationBar: animatedNotchBottomBar,
    );
  }
}

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  String? selectedSourceLanguage;
  String? selectedTargetLanguage;

  final List<Map<String, String>> languageOptions = [
    {'code': 'en', 'label': 'English', 'flag': '🇬🇧'},
    {'code': 'es', 'label': 'Spanish', 'flag': '🇪🇸'},
    {'code': 'fr', 'label': 'French', 'flag': '🇫🇷'},
    {'code': 'ar', 'label': 'Arabic', 'flag': '🇪🇬'},
    {'code': 'de', 'label': 'German', 'flag': '🇩🇪'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguages();
  }

  Future<void> _loadSelectedLanguages() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedSourceLanguage = prefs.getString('selectedSourceLanguage');
      selectedTargetLanguage = prefs.getString('selectedTargetLanguage');
    });
  }

  Future<void> _saveSelectedLanguages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'selectedSourceLanguage', selectedSourceLanguage ?? '');
    await prefs.setString(
        'selectedTargetLanguage', selectedTargetLanguage ?? '');
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(String? excludeCode) {
    return languageOptions
        .where((lang) => lang['code'] != excludeCode)
        .map((lang) => DropdownMenuItem(
              value: lang['code'],
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.transparent,
                    child: Text(lang['flag']!,
                        style: const TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(width: 8),
                  Text(lang['label']!),
                ],
              ),
            ))
        .toList();
  }

  void _swapLanguages() {
    setState(() {
      final temp = selectedSourceLanguage;
      selectedSourceLanguage = selectedTargetLanguage;
      selectedTargetLanguage = temp;
    });
    _saveSelectedLanguages();
  }

  String _getLanguageLabel(String? code) {
    final language = languageOptions.firstWhere((lang) => lang['code'] == code,
        orElse: () => {'label': 'Translation'});
    return language['label']!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2.w,
                  blurRadius: 5.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedSourceLanguage,
                  hint: const Text("Select"),
                  items: _buildDropdownItems(selectedTargetLanguage),
                  onChanged: (value) {
                    setState(() {
                      selectedSourceLanguage = value;
                    });
                    _saveSelectedLanguages();
                  },
                  underline: const SizedBox(),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.swap_horiz, color: ColorsManager.black),
                  onPressed: _swapLanguages,
                ),
                DropdownButton<String>(
                  value: selectedTargetLanguage,
                  hint: const Text("Select"),
                  items: _buildDropdownItems(selectedSourceLanguage),
                  onChanged: (value) {
                    setState(() {
                      selectedTargetLanguage = value;
                    });
                    _saveSelectedLanguages();
                  },
                  underline: const SizedBox(),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),
          InputWidget(
              sourceLanguage: _getLanguageLabel(selectedSourceLanguage)),
          SizedBox(height: 25.h),
          OutputWidget(
              targetLanguage: _getLanguageLabel(selectedTargetLanguage)),
        ],
      ),
    );
  }
}
