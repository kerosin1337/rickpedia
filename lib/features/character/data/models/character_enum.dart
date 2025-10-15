enum CharacterStatus {
  alive('Alive'),
  dead('Dead'),
  unknown('unknown');

  final String status;

  const CharacterStatus(this.status);

  static CharacterStatus fromString(String value) {
    return CharacterStatus.values.firstWhere((type) => type.status == value);
  }
}

enum CharacterGender {
  female('Female'),
  male('Male'),
  genderless('Genderless'),
  unknown('unknown');

  final String gender;

  const CharacterGender(this.gender);

  static CharacterGender fromString(String value) {
    return CharacterGender.values.firstWhere((type) => type.gender == value);
  }
}
