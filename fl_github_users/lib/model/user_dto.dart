
class UserDTO {
  final String login;
  final String githubProfile;
  final String avatar;
  // final String? location;
  // final String bio;
  // final int publicRepos;
  // final int followers;
  // final int following;
  // final String name;

  const UserDTO({
    required this.login,
    required this.githubProfile,
    required this.avatar
    // required this.location,
    // required this.bio,
    // required this.publicRepos,
    // required this.followers,
    // required this.following,
    // required this.name,
  });

  factory UserDTO.fromJSON(Map<String, dynamic> json) {
    return UserDTO(
        login: json["login"],
        githubProfile: json["url"],
        avatar: json["avatar_url"]);
        // location: json["location"],
        // bio: json["bio"],
        // publicRepos: json["public_repos"],
        // followers: json["followers"],
        // following: json["following"],
        // name: json["name"]);
  }
}