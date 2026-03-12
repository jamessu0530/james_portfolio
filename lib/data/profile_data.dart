import 'package:flutter/material.dart';

import '../models/app_language.dart';

// ---------------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------------

class SkillCategory {
  const SkillCategory({required this.title, required this.skills});
  final L10n title;
  final List<String> skills;
}

class ProjectItem {
  const ProjectItem({
    required this.title,
    required this.subtitle,
    required this.highlights,
    required this.techTags,
  });

  final String title;
  final L10n subtitle;
  final List<L10n> highlights;
  final List<String> techTags;
}

class ExperienceItem {
  const ExperienceItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final L10n title;
  final L10n subtitle;
  final IconData icon;
}

class EducationItem {
  const EducationItem({
    required this.school,
    required this.degree,
    this.detail = '',
  });

  final L10n school;
  final L10n degree;
  final String detail;
}

// ---------------------------------------------------------------------------
// All profile data (Chinese + English)
// ---------------------------------------------------------------------------

class ProfileData {
  ProfileData._();

  // -- Basic info --
  static const String name = '蘇奕勳';
  static const String englishName = 'James Su';
  static const String email = 'jamessu2016@gmail.com';
  static const String githubURL = 'https://github.com/jamessu0530';
  static const String linkedInURL =
      'https://www.linkedin.com/in/james-su-832bb2324';
  static const String mediumURL = 'https://medium.com/@jamessu2016';

  static const L10n tagline = L10n(
    zh: '資工 × 建築 ｜ AI 系統 · 軟體工程',
    en: 'CS × Architecture | AI Systems · Software Engineering',
  );

  // -- About --
  static const L10n bio = L10n(
    zh: '我目前就讀於國立臺灣海洋大學資訊工程學系三年級，'
        '並輔修台北科技大學建築設計，具備程式設計、數據分析及空間設計的跨域背景。'
        '熟悉軟體工程、人工智慧與使用者體驗，能獨立完成從需求分析到實作測試。'
        '希望能將 AI 技術與空間設計思維結合，打造具韌性與快速反應的企業系統架構。',
    en: 'I am a third-year Computer Science student at National Taiwan Ocean '
        'University, with a minor in Architecture at NTUT. '
        'I have interdisciplinary experience in software engineering, AI, '
        'data analysis, and spatial design. '
        'I aim to combine AI technology with spatial design thinking '
        'to build resilient enterprise system architectures.',
  );

  // -- Education --
  static const List<EducationItem> education = [
    EducationItem(
      school: L10n(zh: '國立臺灣海洋大學', en: 'National Taiwan Ocean University'),
      degree: L10n(zh: '資訊工程學系 三年級', en: 'B.S. Computer Science (Junior)'),
    ),
    EducationItem(
      school: L10n(
        zh: '國立臺北科技大學',
        en: 'National Taipei University of Technology',
      ),
      degree: L10n(zh: '建築系輔系', en: 'Minor in Architecture'),
    ),
    EducationItem(
      school: L10n(zh: '語言能力', en: 'Language Proficiency'),
      degree: L10n(zh: 'TOEIC 810', en: 'TOEIC 810'),
    ),
  ];

  // -- Skills --
  static const List<SkillCategory> skills = [
    SkillCategory(
      title: L10n(zh: '程式語言', en: 'Languages'),
      skills: ['Python', 'JavaScript', 'Dart', 'C / C++', 'SQL'],
    ),
    SkillCategory(
      title: L10n(zh: '框架與技術', en: 'Frameworks & Tools'),
      skills: ['React', 'Flutter', 'OpenCV', 'Git / GitHub', 'REST API'],
    ),
    SkillCategory(
      title: L10n(zh: 'AI / ML', en: 'AI / ML'),
      skills: ['RAG', 'Computer Vision', 'Machine Learning'],
    ),
    SkillCategory(
      title: L10n(zh: '資料庫', en: 'Databases'),
      skills: ['MariaDB', 'MongoDB'],
    ),
  ];

  // -- Projects --
  static const List<ProjectItem> projects = [
    ProjectItem(
      title: 'CARE AI System',
      subtitle: L10n(
        zh: 'RAG-based 智慧照護助理（開發中）',
        en: 'RAG-based Healthcare Assistant (In Progress)',
      ),
      highlights: [
        L10n(
          zh: '整合 LINE Bot 介面並支援語音互動',
          en: 'LINE Bot integration with voice interaction',
        ),
        L10n(
          zh: '長照資訊查詢與醫療謠言辨識',
          en: 'Long-term care info & medical misinformation detection',
        ),
        L10n(
          zh: '完成 Iteration 1 prototype，提出國科會計畫',
          en: 'Iteration 1 prototype completed; proposed to NSTC',
        ),
      ],
      techTags: ['RAG', 'LLM', 'LINE Bot', 'Python'],
    ),
    ProjectItem(
      title: 'NTOU Auction System',
      subtitle: L10n(
        zh: 'React 前端拍賣系統',
        en: 'React Frontend Auction System',
      ),
      highlights: [
        L10n(
          zh: '使用 React 開發拍賣系統前端介面',
          en: 'Built frontend interface with React',
        ),
      ],
      techTags: ['React', 'JavaScript', 'REST API'],
    ),
    ProjectItem(
      title: 'Rock Paper Scissors AI',
      subtitle: L10n(
        zh: 'Flutter 強化式學習猜拳遊戲',
        en: 'Flutter Reinforcement Learning Game',
      ),
      highlights: [
        L10n(
          zh: '使用 Flutter 開發互動式猜拳遊戲',
          en: 'Built interactive mobile game with AI opponent',
        ),
      ],
      techTags: ['Flutter', 'Dart', 'ML'],
    ),
    ProjectItem(
      title: 'Image Processing',
      subtitle: L10n(
        zh: 'Python + OpenCV 影像處理',
        en: 'Python + OpenCV Image Processing',
      ),
      highlights: [
        L10n(
          zh: 'Histogram Equalization、Convolution Filtering',
          en: 'Histogram Equalization, Convolution Filtering',
        ),
        L10n(
          zh: 'High-pass / Low-pass filters',
          en: 'High-pass / Low-pass filters',
        ),
      ],
      techTags: ['Python', 'OpenCV', 'Computer Vision'],
    ),
  ];

  // -- Experience & Activities --
  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      title: L10n(zh: '馬尚彬教授實驗室', en: "Prof. Ma's Lab — NTOU CS"),
      subtitle: L10n(zh: 'AI / RAG 系統研究', en: 'AI / RAG Research'),
      icon: Icons.science_outlined,
    ),
    ExperienceItem(
      title: L10n(zh: 'SITCON 2024 計算機年會', en: 'SITCON 2024'),
      subtitle: L10n(zh: '技術社群活動', en: 'Tech Community Event'),
      icon: Icons.groups_outlined,
    ),
    ExperienceItem(
      title: L10n(zh: 'Google DevFest 2025', en: 'Google DevFest 2025'),
      subtitle: L10n(zh: 'Google 開發者活動', en: 'Google Developer Event'),
      icon: Icons.auto_awesome_outlined,
    ),
    ExperienceItem(
      title: L10n(
        zh: 'LINE Taiwan Tech Sharing',
        en: 'LINE Taiwan Tech Sharing',
      ),
      subtitle: L10n(
        zh: 'Agile 開發 · Daily Scrum',
        en: 'Agile Development · Daily Scrum',
      ),
      icon: Icons.chat_outlined,
    ),
    ExperienceItem(
      title: L10n(zh: '北海道大學短期交流', en: 'Hokkaido University Exchange'),
      subtitle: L10n(zh: 'STEM 教學學程', en: 'STEM Education Program'),
      icon: Icons.flight_outlined,
    ),
    ExperienceItem(
      title: L10n(zh: '澳洲遊學', en: 'Study Abroad — Australia'),
      subtitle: L10n(zh: '英語溝通與跨文化交流', en: 'English & Cross-cultural'),
      icon: Icons.public_outlined,
    ),
    ExperienceItem(
      title: L10n(
        zh: 'Camino 義大利朝聖之路',
        en: 'Camino Pilgrimage Walk',
      ),
      subtitle: L10n(
        zh: '獨自完成長距離徒步旅行',
        en: 'Solo long-distance pilgrimage',
      ),
      icon: Icons.hiking_outlined,
    ),
  ];

  // -- Biography --
  static const L10n biography = L10n(
    zh: '我目前就讀於國立海洋大學資訊工程學系，輔修台北科技大學建築系，'
        '具備軟體工程、資料分析、機器學習、空間與使用者設計經驗等跨域能力。'
        '我是一個對新事物都充滿好奇心、樂於挑戰未知，同時注重細節與問題分析的人。\n\n'
        '在求學過程中，我參與 SITCON 2024 計算機年會、2025 Google DevFest 與 '
        'LINE Taiwan Tech Sharing 等活動；國際交流方面，我到北海道大學進行短期交流，'
        '也到澳洲遊學提升英語溝通能力。2025 年 1 月我獨自完成 Camino 義大利朝聖之路徒步旅行。\n\n'
        '此外，我參與馬尚彬教授實驗室 CARE RAG AI 專案，並提出國科會計畫，'
        '透過 LLM / RAG 協助長照資訊查詢與醫療謠言辨識。'
        '這段經驗讓我學會如何拆解問題、團隊合作與有效溝通。\n\n'
        '雖然目前尚未具備產業經驗，但我相信自己自主學習與解決問題的能力，'
        '能夠在短時間融入公司工作環境。',
    en: 'I am studying Computer Science at NTOU with a minor in Architecture '
        'at NTUT. My interdisciplinary background spans software engineering, '
        'data analysis, machine learning, and spatial / UX design. '
        'I am curious, detail-oriented, and always eager to take on challenges.\n\n'
        'During my studies I attended SITCON 2024, Google DevFest 2025, and '
        'LINE Taiwan Tech Sharing. For international exposure I joined a STEM '
        'program at Hokkaido University and studied in Australia. '
        'In January 2025, I completed the Camino pilgrimage walk in Italy solo.\n\n'
        'I joined Prof. Ma\'s lab working on the CARE RAG AI project and '
        'proposed a research plan to NSTC — using LLM / RAG for healthcare '
        'information retrieval and medical misinformation detection.\n\n'
        'I believe my self-learning ability and problem-solving skills will '
        'allow me to quickly adapt to a professional environment.',
  );
}
