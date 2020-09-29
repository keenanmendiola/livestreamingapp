String getInitials(String name) {
  List<String> split = name.split(" ");
  String initialFirstName = split[0][0];
  String initialLastName = split[1][0];
  return "$initialFirstName$initialLastName";
}
