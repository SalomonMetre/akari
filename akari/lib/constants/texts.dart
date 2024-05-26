class TextConstants {
  static const String akariDescription = """
  Light Up (Japanese: 美術館 bijutsukan, art gallery), also called Akari (明かり, light) is a binary-determination logic puzzle published by Nikoli. As of 2011, three books consisting entirely of Light Up puzzles have been published by Nikoli.
  """;
  static const String akariRules1 = """
  Light Up is played on a rectangular grid of white and black cells. 
  """;
  static const String akariRules2 =
      """The player places light bulbs in white cells such that no two bulbs shine on each other, until the entire grid is lit up. """;
  static const String akariRules3 =
      """A bulb sends rays of light horizontally and vertically, illuminating its entire row and column unless its light is blocked by a black cell. A black cell may have a number on it from 0 to 4, indicating how many bulbs must be placed adjacent to its four sides; for example, a cell with a 4 must have four bulbs around it, one on each side, and a cell with a 0 cannot have a bulb next to any of its sides. """;
  static const String akariRules4 =
      """An unnumbered black cell may have any number of light bulbs adjacent to it, or none. Bulbs placed diagonally adjacent to a numbered cell do not contribute to the bulb count.""";
  static const String funFactComplexity =
      """Determining whether a given Light Up puzzle is solvable is NP-complete. This is proved by a polynomial-time reduction from Circuit-SAT, which is known to be NP-complete, to Light Up puzzles.""";
}

class HomePageTxtConstants {
  static const String homeTabLabel = "Home";
  static const String settingsTabLabel = "Settings";
  static const String quitTabLabel = "Back";
}
