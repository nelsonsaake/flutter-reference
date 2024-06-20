List<String> splitPascalCase(String input) {
  List<String> words = [];
  StringBuffer currentWord = StringBuffer();

  for (int i = 0; i < input.length; i++) {
    if (i > 0 && i < input.length - 1 && input[i].toUpperCase() == input[i]) {
      words.add(currentWord.toString());
      currentWord.clear();
    }
    currentWord.write(input[i]);
  }

  words.add(currentWord.toString());
  return words;
}