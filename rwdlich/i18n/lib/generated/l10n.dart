// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Death by Caffeine Calculator`
  String get formPageAppBarTitle {
    return Intl.message(
      'Death by Caffeine Calculator',
      name: 'formPageAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Drip Coffee (Cup)`
  String get firstSuggestedDrinkName {
    return Intl.message(
      'Drip Coffee (Cup)',
      name: 'firstSuggestedDrinkName',
      desc: '',
      args: [],
    );
  }

  /// `Espresso (Shot)`
  String get secondSuggestedDrinkName {
    return Intl.message(
      'Espresso (Shot)',
      name: 'secondSuggestedDrinkName',
      desc: '',
      args: [],
    );
  }

  /// `Latte (Mug)`
  String get thirdSuggestedDrinkName {
    return Intl.message(
      'Latte (Mug)',
      name: 'thirdSuggestedDrinkName',
      desc: '',
      args: [],
    );
  }

  /// `Body Weight`
  String get formPageWeightInputLabel {
    return Intl.message(
      'Body Weight',
      name: 'formPageWeightInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `pounds`
  String get formPageWeightInputSuffix {
    return Intl.message(
      'pounds',
      name: 'formPageWeightInputSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Choose a drink`
  String get formPageRadioListLabel {
    return Intl.message(
      'Choose a drink',
      name: 'formPageRadioListLabel',
      desc: '',
      args: [],
    );
  }

  /// `CALCULATE`
  String get formPageActionButtonTitle {
    return Intl.message(
      'CALCULATE',
      name: 'formPageActionButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get formPageCustomDrinkRadioTitle {
    return Intl.message(
      'Other',
      name: 'formPageCustomDrinkRadioTitle',
      desc: '',
      args: [],
    );
  }

  /// `Serving Size`
  String get formPageCustomDrinkServingSizeInputLabel {
    return Intl.message(
      'Serving Size',
      name: 'formPageCustomDrinkServingSizeInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `fl. oz`
  String get formPageCustomDrinkServingSizeInputSuffix {
    return Intl.message(
      'fl. oz',
      name: 'formPageCustomDrinkServingSizeInputSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Caffeine`
  String get formPageCustomDrinkCaffeineAmountInputLabel {
    return Intl.message(
      'Caffeine',
      name: 'formPageCustomDrinkCaffeineAmountInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `mg`
  String get formPageCustomDrinkCaffeineAmountInputSuffix {
    return Intl.message(
      'mg',
      name: 'formPageCustomDrinkCaffeineAmountInputSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Dosages`
  String get resultsPageAppBarTitle {
    return Intl.message(
      'Dosages',
      name: 'resultsPageAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Lethal Dosage`
  String get resultsPageLethalDosageTitle {
    return Intl.message(
      'Lethal Dosage',
      name: 'resultsPageLethalDosageTitle',
      desc: '',
      args: [],
    );
  }

  /// `*Based on {servingSize} fl. oz serving.`
  String resultsPageFirstDisclaimer(Object servingSize) {
    return Intl.message(
      '*Based on $servingSize fl. oz serving.',
      name: 'resultsPageFirstDisclaimer',
      desc: '',
      args: [servingSize],
    );
  }

  /// `{quantity, plural, one{One serving.} other{{formattedNumber} servings in your system at one time.}}`
  String resultsPageLethalDosageMessage(num quantity, Object formattedNumber) {
    return Intl.plural(
      quantity,
      one: 'One serving.',
      other: '$formattedNumber servings in your system at one time.',
      name: 'resultsPageLethalDosageMessage',
      desc: '',
      args: [quantity, formattedNumber],
    );
  }

  /// `Daily Safe Maximum`
  String get resultsPageSafeDosageTitle {
    return Intl.message(
      'Daily Safe Maximum',
      name: 'resultsPageSafeDosageTitle',
      desc: '',
      args: [],
    );
  }

  /// `{quantity, plural, one{One serving per day.} other{{formattedNumber} servings per day.}}`
  String resultsPageSafeDosageMessage(num quantity, Object formattedNumber) {
    return Intl.plural(
      quantity,
      one: 'One serving per day.',
      other: '$formattedNumber servings per day.',
      name: 'resultsPageSafeDosageMessage',
      desc: '',
      args: [quantity, formattedNumber],
    );
  }

  /// `*Applies to age 18 and over. This calculator does not replace professional medical advice.`
  String get resultsPageSecondDisclaimer {
    return Intl.message(
      '*Applies to age 18 and over. This calculator does not replace professional medical advice.',
      name: 'resultsPageSecondDisclaimer',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}