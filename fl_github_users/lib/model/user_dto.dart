
class UserDTO {
  final String login;
  final String githubProfile;
  final String avatar;

  const UserDTO({
    required this.login,
    required this.githubProfile,
    required this.avatar
  });

  factory UserDTO.fromJSON(Map<String, dynamic> json) {
    return UserDTO(
        login: json["login"],
        githubProfile: json["url"],
        avatar: json["avatar_url"]);
  }
}