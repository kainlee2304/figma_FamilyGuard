/// Model cho thành viên gia đình
class FamilyMember {
  final String name;
  final String role;
  final String imageUrl;
  final bool isOnline;

  const FamilyMember({
    required this.name,
    required this.role,
    required this.imageUrl,
    this.isOnline = true,
  });
}
