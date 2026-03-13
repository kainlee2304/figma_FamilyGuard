import 'package:flutter/material.dart';
import '../models/safe_zone.dart';

/// Service quản lý dữ liệu vùng an toàn
class SafeZoneService extends ChangeNotifier {
  final List<SafeZone> _zones = [];
  final List<SafeZoneMember> _members = [];

  List<SafeZone> get zones => List.unmodifiable(_zones);
  List<SafeZoneMember> get members => List.unmodifiable(_members);

  SafeZoneService() {
    _seedData();
  }

  // ─── CRUD Zones ────────────────────────────────────────────

  SafeZone? getZone(String id) {
    final idx = _zones.indexWhere((z) => z.id == id);
    return idx >= 0 ? _zones[idx] : null;
  }

  List<SafeZone> getZonesForMember(String memberId) {
    return _zones.where((z) => z.recipientIds.contains(memberId)).toList();
  }

  void addZone(SafeZone zone) {
    _zones.add(zone);
    notifyListeners();
  }

  void updateZone(SafeZone zone) {
    final idx = _zones.indexWhere((z) => z.id == zone.id);
    if (idx >= 0) {
      _zones[idx] = zone;
      notifyListeners();
    }
  }

  void removeZone(String id) {
    _zones.removeWhere((z) => z.id == id);
    notifyListeners();
  }

  void toggleZone(String id) {
    final idx = _zones.indexWhere((z) => z.id == id);
    if (idx >= 0) {
      _zones[idx].isActive = !_zones[idx].isActive;
      notifyListeners();
    }
  }

  // ─── Members ───────────────────────────────────────────────

  SafeZoneMember? getMember(String id) {
    final idx = _members.indexWhere((m) => m.id == id);
    return idx >= 0 ? _members[idx] : null;
  }

  // ─── ID generation ─────────────────────────────────────────

  String nextZoneId() => 'zone_${DateTime.now().millisecondsSinceEpoch}';

  // ─── Seed data ─────────────────────────────────────────────

  void _seedData() {
    _members.addAll([
      const SafeZoneMember(
        id: 'm1',
        name: 'Bà Nguyễn Thị Lan',
        ageGroup: '60+ TUỔI',
        badgeColor: Color(0x14FF6B00),
        badgeBorderColor: Color(0x33FF6B00),
        badgeTextColor: Color(0xFFFF6B00),
        isOnline: true,
        zoneIds: ['z1', 'z2'],
      ),
      const SafeZoneMember(
        id: 'm2',
        name: 'Ông Trần Văn Minh',
        ageGroup: '60+ TUỔI',
        badgeColor: Color(0x14FF6B00),
        badgeBorderColor: Color(0x33FF6B00),
        badgeTextColor: Color(0xFFFF6B00),
        isOnline: false,
        zoneIds: ['z1'],
      ),
      const SafeZoneMember(
        id: 'm3',
        name: 'Nguyễn Hoàng Anh',
        ageGroup: 'NGƯỜI CHĂM SÓC',
        badgeColor: Color(0x141EA5FC),
        badgeBorderColor: Color(0x331EA5FC),
        badgeTextColor: Color(0xFF1EA5FC),
        isOnline: true,
        zoneIds: ['z1', 'z2', 'z3'],
      ),
    ]);

    _zones.addAll([
      SafeZone(
        id: 'z1',
        name: 'Nhà riêng',
        address: '122 Nguyễn Huệ, Q.1, TP.HCM',
        latitude: 10.7769,
        longitude: 106.7009,
        radius: 500,
        zoneType: SafeZoneType.home,
        isActive: true,
        recipientIds: ['m1', 'm2', 'm3'],
      ),
      SafeZone(
        id: 'z2',
        name: 'Bệnh viện Chợ Rẫy',
        address: '201B Nguyễn Chí Thanh, Q.5, TP.HCM',
        latitude: 10.7556,
        longitude: 106.6595,
        radius: 300,
        zoneType: SafeZoneType.hospital,
        isActive: true,
        recipientIds: ['m1', 'm3'],
      ),
      SafeZone(
        id: 'z3',
        name: 'Công viên Tao Đàn',
        address: 'Công viên Tao Đàn, Q.1, TP.HCM',
        latitude: 10.7743,
        longitude: 106.6922,
        radius: 200,
        zoneType: SafeZoneType.custom,
        isActive: false,
        recipientIds: ['m3'],
      ),
    ]);
  }
}

/// InheritedWidget để truyền service xuống widget tree
class SafeZoneProvider extends InheritedNotifier<SafeZoneService> {
  const SafeZoneProvider({
    super.key,
    required SafeZoneService service,
    required super.child,
  }) : super(notifier: service);

  static SafeZoneService of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<SafeZoneProvider>();
    return provider!.notifier!;
  }

  /// Read-only access – không subscribe rebuild
  static SafeZoneService read(BuildContext context) {
    final provider = context
        .getInheritedWidgetOfExactType<SafeZoneProvider>();
    return provider!.notifier!;
  }
}
