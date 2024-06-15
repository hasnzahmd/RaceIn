String cleanTeamName(String name) {
  final wordsToRemove = {
    'Team',
    'F1',
    'Formula',
    'One',
    'Visa',
    'Cash',
    'App',
    'Stake',
    'Petronas',
    'Scuderia',
    ' '
  };
  final nameWords = name.split(' ');

  final filteredWords =
      nameWords.where((word) => !wordsToRemove.contains(word)).toList();

  var finalName = filteredWords.join(' ');
  if (finalName == 'Mercedes-AMG') {
    finalName = 'Mercedes';
  } else if (finalName == 'Ferrari\n') {
    finalName = 'Ferrari';
  }
  return finalName;
}
