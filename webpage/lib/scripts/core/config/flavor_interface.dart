part of 'flavor.dart';

sealed class const FlavorInterface() { // i always ignore const as sealed and abstracts are const
  String get name; // Declare name getter for generic constraint
  String get baseUrl;
}

