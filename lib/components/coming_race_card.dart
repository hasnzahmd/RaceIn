import 'dart:async';
import 'package:flutter/material.dart';
import '../../constants/custom_colors.dart';
import '../../constants/f1_countries.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ComingRaceCard extends StatefulWidget {
  final Map race;
  final int round;

  const ComingRaceCard({super.key, required this.race, required this.round});

  @override
  _ComingRaceCardState createState() => _ComingRaceCardState();
}

class _ComingRaceCardState extends State<ComingRaceCard> {
  late DateTime raceDateTime;
  late Timer _timer;
  Duration _remainingTime = const Duration();

  @override
  void initState() {
    super.initState();
    raceDateTime = DateTime.parse(widget.race['date']).toLocal();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = raceDateTime.difference(DateTime.now());
        if (_remainingTime.isNegative) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  List<String> _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = duration.inDays;
    final hours = twoDigits(duration.inHours.remainder(24));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [days.toString(), hours, minutes, seconds];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final raceCountry = widget.race['competition']['location']['country'];
    final competition = widget.race['competition']['name'];
    final countryCode = _getCountryCode(raceCountry);
    final formattedDate = DateFormat('EEE, MMM d, h:mm a').format(raceDateTime);
    final countdown = _formatDuration(_remainingTime);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      elevation: 5,
      child: Stack(
        children: [
          Container(
            height: screenHeight * 0.22,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/race.webp'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          Container(
            height: screenHeight * 0.22,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(
                color: CustomColors.f1red.withOpacity(0.2),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Round ${widget.round}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.f1red,
                            ),
                          ),
                          Text(
                            raceCountry == 'United Arab Emirates'
                                ? 'UAE'
                                : raceCountry,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          competition,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CachedNetworkImage(
                        imageUrl:
                            'https://flagsapi.com/$countryCode/shiny/64.png',
                        height: 40,
                        width: 40,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 100, 66, 0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _CountdownColumn(label: 'DAYS', value: countdown[0]),
                          _CountdownColumn(label: 'HRS', value: countdown[1]),
                          _CountdownColumn(label: 'MINS', value: countdown[2]),
                          _CountdownColumn(label: 'SECS', value: countdown[3]),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCountryCode(String country) {
    for (var item in f1Countries) {
      if (item['name'] == country) {
        return item['code'];
      }
    }
    return '';
  }
}

class _CountdownColumn extends StatelessWidget {
  final String label;
  final String value;

  const _CountdownColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
