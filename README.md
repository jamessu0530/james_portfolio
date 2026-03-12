## James Portfolio（Flutter iOS）

一個為 **蘇奕勳（James Su）** 製作的個人履歷 / Portfolio App，風格偏 Apple，內建可拖曳的人生時間軸。

### 功能重點

- **個人簡介**：中英雙語（繁體中文 / English），包含自我介紹、學歷、技能、專案與經歷。
- **人生時間軸 Timeline**：
  - 依照「年份」分段顯示（例如 2023 / 2024 / 2025）。
  - 支援拖曳排序（ReorderableListView），跨年份拖曳會自動更新該事件的年份。
  - 往最上方拖曳可自動建立更早的年份區塊。
- **圖片顯示**：
  - Timeline 事件圖片支援 `Image.asset` 與從相簿選擇（`image_picker`）。
  - 個人頭像可點擊更換，相簿選取後即時更新畫面。
- **主題**：內建淺色 / 深色模式切換，色彩與卡片樣式參考 iOS 風格。

### 檔案結構（重點）

- `lib/main.dart`：App 進入點，管理語言（中 / 英）、主題模式與頭像路徑狀態。
- `lib/data/profile_data.dart`：所有履歷內容集中管理（文字、自傳、技能、專案、活動）。
- `lib/screens/home_screen.dart`：主畫面，使用 `SingleChildScrollView` 串接 Profile 與各區塊。
- `lib/widgets/`：
  - `profile_header.dart`：頭像、姓名、標語與 GitHub / LinkedIn / Medium 連結。
  - `glass_card.dart`、`section_title.dart`、`skill_section.dart`、`project_card.dart`、`info_sections.dart`：一般履歷區塊的共用元件。
  - `timeline_card.dart`、`timeline_image.dart`、`timeline_year_header.dart`、`timeline_editor_dialog.dart`：時間軸畫面用的卡片、圖片與編輯表單元件。
- `lib/pages/timeline_page.dart`：時間軸頁面，負責年份分組、拖曳排序與事件 CRUD。
- `lib/models/`：`AppLanguage`、`L10n`、`TimelineEvent` 等資料模型。
- `lib/services/timeline_storage.dart`：時間軸事件的記憶體儲存層，未來可很容易改成 Hive 或 SharedPreferences。

### 執行方式

```bash
flutter pub get
flutter run
```

