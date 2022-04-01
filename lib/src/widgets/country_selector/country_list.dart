import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';

import '../../models/country.dart';

class CountryList extends StatelessWidget {
  /// Callback function triggered when user select a country
  final Function(Country) onTap;

  /// List of countries to display
  final List<Country> countries;

  /// list of favorite countries to display at the top
  final List<Country> favorites;

  /// proxy to the ListView.builder controller (ie: [ScrollView.controller])
  final ScrollController? scrollController;

  /// whether the country dialcode should be displayed as the [ListTile.subtitle]
  final bool showDialCode;

  const CountryList({
    Key? key,
    required this.countries,
    required this.favorites,
    required this.onTap,
    this.scrollController,
    this.showDialCode = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      // +1 for separator
      itemCount: favorites.length + 1 + countries.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < favorites.length)
          return Divider(key: ValueKey('countryListSeparator-$index'));

        return ListTile(
          key: ValueKey(country.isoCode.name),
          leading: CircleFlag(
            country.isoCode.name,
            size: showDialCode ? null : 40,
          ),
          title: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              country.name,
              textAlign: TextAlign.start,
            ),
          ),
          subtitle: showDialCode
              ? Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    country.displayCountryCode,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                  ),
                )
              : null,
          onTap: () => onTap(country),
        );
      },
    );
  }
}
