import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emoji Battle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const EmojiBattleScreen(),
    );
  }
}

class EmojiBattleScreen extends StatefulWidget {
  const EmojiBattleScreen({super.key});

  @override
  State<EmojiBattleScreen> createState() => _EmojiBattleScreenState();
}

class _EmojiBattleScreenState extends State<EmojiBattleScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final List<String> _fighters = [];
  String _winner = '';
  bool _isBattleMode = false;

  late AnimationController _battleController;
  late AnimationController _backgroundController;

  final Random _random = Random();
  final List<_FallingEmoji> _fallingEmojis = [];

  final Map<String, String> _emojiMap = {
    'pryvit': '👋',
    'hello': '👋',
    'hi': '👋',
    'lubov': '❤️',
    'love': '❤️',
    'sertse': '❤️',
    'sontse': '☀️',
    'sun': '☀️',
    'shchastia': '😊',
    'smikh': '😂',
    'laugh': '😂',
    'vohon': '🔥',
    'fire': '🔥',
    'zirka': '⭐',
    'star': '⭐',
    'raketa': '🚀',
    'rocket': '🚀',
    'kompiuter': '💻',
    'computer': '💻',
    'kava': '☕',
    'coffee': '☕',
    'knyha': '📖',
    'book': '📖',
    'muzyka': '🎵',
    'music': '🎵',
    'planeta': '🪐',
    'planet': '🪐',
    'kit': '🐱',
    'cat': '🐱',
    'sobaka': '🐶',
    'dog': '🐶',
    'ukraina': '🇺🇦',
    'peremoha': '🏆🎉',
    'victory': '🏆🎉',
    'zrada': '😡🔪',
    'betrayal': '😡🔪',
    'palianytsia': '🍞',
    'bread': '🍞',
    'microsoft': '🪟',
    'fortnite': '🎮',
    'money': '💵',
    'diamond': '💎',
    'thinking': '🤔',
    'angry': '😡',
    'cry': '😭',
    'smile': '😄',
    'cool': '😎',
    'ghost': '👻',
    'clown': '🤡',
    'robot': '🤖',
    'devil': '😈',
  };

  @override
  void initState() {
    super.initState();

    _battleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _generateFallingEmojis();
      }
    });

    _textController.addListener(() {
      final converted = _textToEmoji(_textController.text);
      if (_textController.text != converted) {
        _textController.value = _textController.value.copyWith(
          text: converted,
          selection: TextSelection.collapsed(offset: converted.length),
        );
      }
    });
  }

  void _generateFallingEmojis() {
    final size = MediaQuery.of(context).size;
    final emojisList = _emojiMap.values.toList();
    for (int i = 0; i < 50; i++) {
      _fallingEmojis.add(_FallingEmoji(
        emoji: emojisList[_random.nextInt(emojisList.length)],
        x: _random.nextDouble() * size.width,
        y: _random.nextDouble() * size.height,
        speed: 1 + _random.nextDouble(),
        size: 20 + _random.nextInt(20),
        opacity: 0.2 + _random.nextDouble() * 0.3,
      ));
    }
    setState(() {});
  }

  String _textToEmoji(String input) {
    final words = input.toLowerCase().split(' ');
    return words.map((w) => _emojiMap[w] ?? w).join(' ');
  }

  void _addFighter() {
    if (_textController.text.trim().isEmpty) return;

    if (_winner.isNotEmpty) {
      _fighters.clear();
      _winner = '';
    }

    setState(() {
      _fighters.add(_textController.text.trim());
      _textController.clear();
    });
  }

  void _startBattle() {
    if (_fighters.length < 2) return;

    setState(() {
      _isBattleMode = true;
      _winner = '';
      _battleController.forward(from: 0);
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      final winner = _fighters[_random.nextInt(_fighters.length)];
      setState(() {
        _winner = winner;
        _isBattleMode = false;
      });
    });
  }

  @override
  void dispose() {
    _battleController.dispose();
    _backgroundController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Stack(
        children: [
          // Фонові напівпрозорі смайлики
          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              for (var e in _fallingEmojis) {
                e.y += e.speed;
                if (e.y > size.height) e.y = -e.size.toDouble();
              }
              return CustomPaint(
                painter: _FallingEmojiPainter(_fallingEmojis),
                size: size,
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_fighters.isNotEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_fighters.isNotEmpty)
                          ScaleTransition(
                            scale: Tween<double>(begin: 1, end: 1.2)
                                .animate(_battleController),
                            child: Text(
                              _fighters[0],
                              style: const TextStyle(fontSize: 80),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        const SizedBox(height: 20),
                        if (_fighters.length >= 2)
                          AnimatedBuilder(
                            animation: _battleController,
                            builder: (context, child) {
                              final scale =
                                  1.0 + (_battleController.value * 0.5);
                              return Transform.scale(
                                scale: scale,
                                child: const Text(
                                  'VS',
                                  style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 4,
                                        color: Colors.yellow,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        const SizedBox(height: 20),
                        if (_fighters.length >= 2)
                          ScaleTransition(
                            scale: Tween<double>(begin: 1, end: 1.2)
                                .animate(_battleController),
                            child: Text(
                              _fighters[1],
                              style: const TextStyle(fontSize: 80),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        const SizedBox(height: 20),
                        if (_fighters.length > 2)
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16,
                            runSpacing: 16,
                            children: _fighters.sublist(2).map((fighter) {
                              return ScaleTransition(
                                scale: Tween<double>(begin: 1, end: 1.2)
                                    .animate(_battleController),
                                child: Text(
                                  fighter,
                                  style: const TextStyle(fontSize: 60),
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  if (_winner.isNotEmpty)
                    Card(
                      color: Colors.yellow.shade700,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          child: Text(
                            '🏆 $_winner 🏆',
                            key: ValueKey(_winner),
                            style: const TextStyle(
                              fontSize: 60,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 40),
                  Card(
                    color: Colors.grey.shade800.withAlpha(200),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _textController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Введи слово або смайлик...',
                          // FIX: (avoid_redundant_argument_values)
                          // Removed the 'border: InputBorder.none' line
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _addFighter,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Додати',
                            style: TextStyle(fontSize: 20)),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _startBattle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Бій!',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (_isBattleMode)
                    const Text(
                      '💥 БІЙ ВІДБУЄТЬСЯ 💥',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FallingEmoji {
  String emoji;
  double x, y, speed;
  int size;
  double opacity;
  _FallingEmoji({
    required this.emoji,
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    this.opacity = 0.3,
  });
}

class _FallingEmojiPainter extends CustomPainter {
  final List<_FallingEmoji> emojis;
  _FallingEmojiPainter(this.emojis);

  @override
  void paint(Canvas canvas, Size size) {
    for (var e in emojis) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: e.emoji,
          style: TextStyle(
            fontSize: e.size.toDouble(),
            color: Colors.white.withAlpha(
              (e.opacity * 255).toInt(),
            ),
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(e.x, e.y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
// FIX: (eol_at_end_of_file) Added final newline