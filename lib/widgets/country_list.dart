import 'package:flutter/material.dart';
import 'package:news_app/models/country_model.dart';
import 'package:news_app/screens/news/news.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/sharedprefs.dart';

class CountryList extends StatelessWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async => await showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const Text(
                'Choose your location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: Country.countries.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () async {
                    await Storage.setCountry(Country.countries[index].name);
                    await Storage.setCountryCode(Country.countries[index].code);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewsPage(),
                      ),
                      (route) => false,
                    );
                  },
                  title: Text(
                    Country.countries[index].name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_right,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 20,
            color: kSecondaryColor,
          ),
          Text(
            Storage.getCountry(),
            style: const TextStyle(
              fontSize: 16,
              color: kSecondaryColor,
            ),
          )
        ],
      ),
    );
  }
}