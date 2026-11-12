 
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Rateservice {
 
  int goldRate = 0;
  int goldchg = 0;

  bool isGoldUp = true;

  String goldHigh = '0';
  String goldLow = '0';

 
  int silverRate = 0;
  int silverchg = 0;

  bool isSilverUp = true;

  String silverHigh = '0';
  String silverLow = '0';

  // -----------------------------
  // FIX RATES
  // -----------------------------

  int msilver = 0;
  String msilveru = '';

  int mgold = 0;
  String mgoldu = '';

  int msilverrtgs = 0;

  int mgoldn = 0;
  String mgoldnu = '';

  int mgoldrtgs = 0;

  // -----------------------------
  // UPDATED TIME
  // -----------------------------

  String updatedTime = '';

  // -----------------------------
  // TIMER
  // -----------------------------

  Timer? _timer;

  // -----------------------------
  // FETCH ALL RATES
  // -----------------------------

  Future<void> fetchRates() async {
    try {
      final uniqueId =
          DateTime.now().millisecondsSinceEpoch.toString();
final apkey=222;

      // Fetch both APIs simultaneously
      final responses = await Future.wait([
        http.get(
          Uri.parse(
            'https://www.esysoft.info/android/showmcxrate.php'
            '?api_key=ratekey&_=$uniqueId',
          ),
        ),
        http.get(
          Uri.parse(
            'https://rpsilverhouse.in/api/rpsilverrate?password=$apkey'
          ),
        ),
      ]);

      final rateRes = responses[0];
      final fixRes = responses[1];

      // Keep current values for RTGS calculation
      int newSilverPrice = silverRate;
      int newGoldPrice = goldRate;

      // =========================================================
      // LIVE RATES
      // =========================================================

      if (rateRes.statusCode == 200) {
        String rawText = rateRes.body
            .replaceFirst('\uFEFF', '')
            .trim();

        final data = jsonDecode(rawText);

        if (data is List && data.isNotEmpty) {
          final rate = data[0];

          // -----------------------------
          // GOLD
          // -----------------------------

          final gold = double.tryParse(
            rate['gold']?.toString() ?? '',
          );

          if (gold != null) {
            newGoldPrice = gold.round();

            if (goldRate != 0 &&
                newGoldPrice != goldRate) {
              isGoldUp = newGoldPrice > goldRate;
            }

            goldRate = newGoldPrice;
          }

          final gchg = double.tryParse(
            rate['gchg']?.toString() ?? '',
          );

          if (gchg != null) {
            goldchg = gchg.round();
          }

          final ghigh = double.tryParse(
            rate['ghigh']?.toString() ?? '',
          );

          if (ghigh != null) {
            goldHigh = _formatIndian(ghigh.round());
          }

          final glow = double.tryParse(
            rate['glow']?.toString() ?? '',
          );

          if (glow != null) {
            goldLow = _formatIndian(glow.round());
          }

          // -----------------------------
          // SILVER
          // -----------------------------

          final silver = double.tryParse(
            rate['silver']?.toString() ?? '',
          );

          if (silver != null) {
            newSilverPrice = silver.round();

            if (silverRate != 0 &&
                newSilverPrice != silverRate) {
              isSilverUp =
                  newSilverPrice > silverRate;
            }

            silverRate = newSilverPrice;
          }

          final schg = double.tryParse(
            rate['schg']?.toString() ?? '',
          );

          if (schg != null) {
            silverchg = schg.round();
          }

          final shigh = double.tryParse(
            rate['shigh']?.toString() ?? '',
          );

          if (shigh != null) {
            silverHigh = _formatIndian(shigh.round());
          }

          final slow = double.tryParse(
            rate['slow']?.toString() ?? '',
          );

          if (slow != null) {
            silverLow = _formatIndian(slow.round());
          }
        }
      }

      // =========================================================
      // FIX RATES
      // =========================================================

      if (fixRes.statusCode == 200) {
        String fixRawText = fixRes.body
            .replaceFirst('\uFEFF', '')
            .trim();

        final fixData = jsonDecode(fixRawText);

        if (fixData is List && fixData.isNotEmpty) {
          final fixRate = fixData[0];

          // v1 = Silver
          final v1 = double.tryParse(
            fixRate['v1']?.toString() ?? '',
          );

          if (v1 != null) {
            msilver = v1.round();
          }

          // v2 = Silver updated
          if (fixRate['v2'] != null) {
            msilveru =
                fixRate['v2'].toString().trim();
          }

          // v3 = Gold
          final v3 = double.tryParse(
            fixRate['v3']?.toString() ?? '',
          );

          if (v3 != null) {
            mgold = v3.round();
          }

          // v4 = Gold updated
          if (fixRate['v4'] != null) {
            mgoldu =
                fixRate['v4'].toString().trim();
          }

          // v5 = Silver RTGS difference
          final v5 = double.tryParse(
            fixRate['v5']?.toString() ?? '',
          );

          if (v5 != null) {
            msilverrtgs =
                newSilverPrice + v5.round();
          }

          // v7 = Gold RTGS difference
          final v7 = double.tryParse(
            fixRate['v7']?.toString() ?? '',
          );

          if (v7 != null) {
            mgoldrtgs =
                newGoldPrice + v7.round();
          }

          // v13 = Gold Number
          final v13 = double.tryParse(
            fixRate['v13']?.toString() ?? '',
          );

          if (v13 != null) {
            mgoldn = v13.round();
          }

          // v14 = Gold Number updated
          if (fixRate['v14'] != null) {
            mgoldnu =
                fixRate['v14'].toString().trim();
          }
        }
      }

      // =========================================================
      // UPDATED TIME
      // =========================================================

      updatedTime = _getTime();

    } catch (e) {
      debugPrint(
        'API error, retrying next tick: $e',
      );
    }
  }

  // -----------------------------
  // START AUTO REFRESH
  // -----------------------------

  void startAutoRefresh({
    Duration interval = const Duration(seconds: 3),
    VoidCallback? onUpdate,
  }) {
    // Fetch immediately
    fetchRates().then((_) {
      onUpdate?.call();
    });

    // Then every 3 seconds
    _timer = Timer.periodic(interval, (_) async {
      await fetchRates();
      onUpdate?.call();
    });
  }

  // -----------------------------
  // STOP AUTO REFRESH
  // -----------------------------

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  // -----------------------------
  // INDIAN NUMBER FORMAT
  // -----------------------------

  String _formatIndian(int number) {
    final isNegative = number < 0;
    final value = number.abs().toString();

    if (value.length <= 3) {
      return '${isNegative ? '-' : ''}$value';
    }

    final lastThree = value.substring(value.length - 3);
    var remaining =
        value.substring(0, value.length - 3);

    final parts = <String>[];

    while (remaining.length > 2) {
      parts.insert(
        0,
        remaining.substring(remaining.length - 2),
      );

      remaining =
          remaining.substring(0, remaining.length - 2);
    }

    if (remaining.isNotEmpty) {
      parts.insert(0, remaining);
    }

    return '${isNegative ? '-' : ''}'
        '${parts.join(',')},$lastThree';
  }

  // -----------------------------
  // TIME FORMAT
  // -----------------------------

  String _getTime() {
    final now = DateTime.now();

    int hour = now.hour;
    final minute = now.minute;

    final period = hour >= 12 ? 'PM' : 'AM';

    hour = hour % 12;

    if (hour == 0) {
      hour = 12;
    }

    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }
}
 