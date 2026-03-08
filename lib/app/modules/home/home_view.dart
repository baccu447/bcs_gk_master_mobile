import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../subscription/subscription_view.dart';
import '../quiz/quiz_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;
  int _coinBalance = 150; // Mock real-time balance

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2C),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Color(0xFFF0C14B), size: 18),
                const SizedBox(width: 4),
                Text('$_coinBalance', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.workspace_premium, color: Color(0xFFF0C14B)), onPressed: () {
            Get.to(() => const SubscriptionView());
          }),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Summary
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Welcome back, Halim!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text('Pro Member | $_coinBalance Coins', style: const TextStyle(color: Color(0xFFF0C14B))),
            ),
            const SizedBox(height: 10),

            // AdMob Banner Placeholder
            if (_isBannerAdLoaded)
              Container(
                alignment: Alignment.center,
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
              
            const SizedBox(height: 20),
            
            // Daily Challenge Placeholder
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Daily Challenge', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text('Complete today\\'s quiz to maintain your streak and earn double coins!'),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Get.to(() => const QuizView());
                      },
                      child: const Text('Start Daily Quiz'),
                    )
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            // Categories Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildCategoryCard('BCS Prep', Icons.book),
                _buildCategoryCard('Bank Jobs', Icons.account_balance),
                _buildCategoryCard('Admission', Icons.school),
                _buildCategoryCard('Mock Tests', Icons.timer),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).cardColor,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Leaderboard'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Card(
      child: InkWell(
        onTap: () {
          Get.to(() => const QuizView());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
