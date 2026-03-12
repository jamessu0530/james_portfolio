## James Portfolio（Flutter iOS）

一個用 Flutter 做的 iOS 風格履歷 App，重點放在「作品展示」和「人生時間軸」。

### 功能一覽

- 個人履歷：中英雙語介紹、學歷、技能、專案、活動。
- 人生時間軸：依年份分段，拖曳改順序與年份，可往上拖出更早的年份。
- 地點連結：Timeline 事件可加入 Google Maps 網址，點擊即可開啟地圖。
- 照片：Timeline 事件可放 asset 或從相簿選圖；大頭貼可從相簿更換。
- 主題：支援淺色 / 深色模式，Apple 風格。

### 檔案結構

```text
lib/
  main.dart
  constants/
    app_constants.dart
  styles/
    app_colors.dart / app_theme.dart
  models/
    app_language.dart
    timeline_event.dart
  data/
    profile_data.dart
  screens/
    home_screen.dart
  pages/
    timeline_page.dart
  services/
    timeline_storage.dart
  widgets/
    common/
      glass_card.dart          # 共用卡片
      section_title.dart       # 區塊標題
    profile/
      profile_header.dart      # 頭像、姓名、社群連結
      info_sections.dart       # 關於我 / 學歷 / 活動 / 自傳
      project_card.dart        # 專案卡片
      skill_section.dart       # 技能區塊
    timeline/
      timeline_card.dart       # 事件卡片（含地點連結）
      timeline_editor_dialog.dart
      timeline_image.dart
      timeline_year_header.dart
```

### 執行

```bash
flutter pub get
flutter run
```
