# Figma App - Flutter Project

## 📁 Cấu trúc Project

```
lib/
├── main.dart                    # Entry point
├── theme/                       # 🎨 Design System từ Figma
│   ├── theme.dart               # Barrel export
│   ├── app_colors.dart          # Màu sắc
│   ├── app_text_styles.dart     # Typography
│   ├── app_dimens.dart          # Spacing, radius, sizes
│   ├── app_shadows.dart         # Box shadows
│   └── app_theme.dart           # ThemeData tổng hợp
├── screens/                     # 📱 Các màn hình
│   ├── _screen_template.dart    # Template để tạo screen mới
│   ├── home_screen.dart         # Trang chủ
│   ├── login_screen.dart        # Đăng nhập
│   └── profile_screen.dart      # Hồ sơ cá nhân
├── widgets/                     # 🧩 Reusable Widgets
│   └── common/
│       ├── common_widgets.dart  # Barrel export
│       ├── app_button.dart      # Button component
│       ├── app_text_field.dart  # Input component
│       ├── app_card.dart        # Card component
│       ├── app_avatar.dart      # Avatar component
│       ├── app_badge.dart       # Badge/Tag component
│       └── app_list_item.dart   # List item component
├── routes/                      # 🗺️ Navigation
│   └── app_routes.dart
├── models/                      # 📦 Data models
├── services/                    # ⚙️ API & Business logic
└── utils/                       # 🛠️ Utilities
    ├── screen_utils.dart        # Responsive helpers
    └── figma_utils.dart         # Figma → Flutter converters
assets/
├── images/                      # Ảnh export từ Figma
├── icons/                       # SVG icons từ Figma
└── fonts/                       # Custom fonts từ Figma
```

## 🚀 Bắt đầu

```bash
# Cài đặt dependencies
flutter pub get

# Chạy ứng dụng
flutter run

# Chạy trên Chrome
flutter run -d chrome

# Build APK
flutter build apk
```

## 📋 Cách paste code Widget từ Figma Dev Mode

### Bước 1: Copy Design Tokens
Mở Figma Dev Mode → chọn element → copy properties:
- **Colors** → paste vào `lib/theme/app_colors.dart`
- **Typography** → paste vào `lib/theme/app_text_styles.dart`
- **Spacing/Radius** → paste vào `lib/theme/app_dimens.dart`

### Bước 2: Tạo Screen mới
1. Copy file `lib/screens/_screen_template.dart`
2. Đổi tên file và class
3. Thêm route vào `lib/routes/app_routes.dart`

### Bước 3: Paste Widget Code
1. Mở Figma Dev Mode → chọn frame/component
2. Copy Flutter code
3. Paste vào screen file
4. Thay thế hardcode values bằng Design System:
   - `Color(0xFF...)` → `AppColors.xxx`
   - `TextStyle(...)` → `AppTextStyles.xxx`
   - `EdgeInsets.all(16)` → `AppDimens.paddingAll16`
   - `BorderRadius.circular(12)` → `AppDimens.borderRadiusLarge`

### Bước 4: Export Assets
1. Chọn icon/ảnh trong Figma → Export
2. SVG → đặt vào `assets/icons/`
3. PNG/JPG → đặt vào `assets/images/`
4. Fonts → đặt vào `assets/fonts/`

## 🎨 Sử dụng Design System

```dart
// Colors
Container(color: AppColors.primary)

// Typography
Text('Hello', style: AppTextStyles.h1)

// Spacing
Padding(padding: AppDimens.paddingAll16)

// Shadows
Container(decoration: BoxDecoration(boxShadow: AppShadows.medium))

// Figma hex color convert
Color myColor = FigmaUtils.hexToColor('#6366F1');

// Responsive
double scale = ScreenUtils.scaleFactor(context);
bool isMobile = ScreenUtils.isMobile(context);
```

## 📦 Packages đã cài

| Package | Mô tả |
|---------|--------|
| `flutter_svg` | Hỗ trợ SVG icons export từ Figma |
| `cached_network_image` | Cache ảnh từ network |
| `google_fonts` | Google Fonts (không cần download font files) |
