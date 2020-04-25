class User {
  static const _ID = 'id';
  static const _LOGIN = 'login';
  static const _NAME = 'name';
  static const _PUBLIC_REPOS = 'public_repos';
  static const _AVATAR_URL = 'avatar_url';
  static const _LOCATION = 'location';
  static const _BIO = 'bio';

  final int id;
  final String login;
  final String name;
  final int publicRepos;
  final String avatarUrl;
  final String location;
  final String bio;

  User.fromMap(Map<String, dynamic> map)
      : id = map[_ID],
        login = map[_LOGIN],
        name = map[_NAME] ?? '',
        publicRepos = map[_PUBLIC_REPOS],
        avatarUrl = map[_AVATAR_URL] ?? '',
        location = map[_LOCATION] ?? '',
        bio = map[_BIO] ?? '';
}
