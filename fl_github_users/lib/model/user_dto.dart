
class UserDTO {
  final int id;
  final String login;
  final String githubProfile;
  final String avatar;

  const UserDTO({
    required this.id,
    required this.login,
    required this.githubProfile,
    required this.avatar
  });

  factory UserDTO.fromJSON(Map<String, dynamic> json) {
    return UserDTO(
        id: json["id"],
        login: json["login"],
        githubProfile: json["url"],
        avatar: json["avatar_url"]);
  }
}
