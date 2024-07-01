import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:race_in/components/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../components/custom_app_bar.dart';
import '../constants/custom_colors.dart';
import '../data/data_notifier.dart';

class Latest extends StatelessWidget {
  const Latest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Latest'),
      body: Consumer<DataNotifier>(
        builder: (context, dataNotifier, child) {
          if (dataNotifier.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;
            final newsData = dataNotifier.getData('news');
            return ListView.builder(
              itemCount: newsData.length,
              itemBuilder: (context, index) {
                final news = newsData[index];
                final imageUrl = news['images'][0]['url'];
                final imgCaption = news['images'][0]['caption'];
                final newsLink = news['link'];

                return Card(
                  margin: const EdgeInsets.only(
                    top: 2,
                    bottom: 5,
                    right: 5,
                  ),
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: CustomColors.f1red.withOpacity(0.5),
                          width: 3,
                        ),
                        bottom: BorderSide(
                          color: CustomColors.f1red.withOpacity(0.5),
                          width: 3,
                        ),
                        right: BorderSide(
                          color: CustomColors.f1red.withOpacity(0.5),
                          width: 3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: imageUrl,
                          height: screenHeight * 0.24,
                          width: screenWidth,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        if (imgCaption != null)
                          Container(
                            width: double.infinity,
                            color: Colors.grey.withOpacity(0.1),
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: Text(
                              imgCaption,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                news['headline'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.f1red,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                news['description'],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  final Uri uri = Uri.parse(newsLink);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri,
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    showToast(message: 'Failed to open');
                                  }
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      'Read More',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.f1red,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 13,
                                      color: CustomColors.f1red,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
