class Utilisateur {
  final String uid;
  final String name;
  final String email;
  final String password;
  final Map objectifs;
  final Map statistiques;
  final bool usesDarkTheme;
  final String profilePicURL;

  Utilisateur({
    this.usesDarkTheme,
    this.email,
    this.password,
    this.uid,
    this.name,
    this.objectifs,
    this.statistiques,
    this.profilePicURL,
  });
}
