/// Düello oyun türleri
enum DuelGameType { test, fillBlanks, guess, findCards }

/// Düello durumları
enum DuelStatus { idle, searching, found, playing, finished }

/// Düello soru entity'si
class DuelQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String? imageUrl;

  const DuelQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    this.imageUrl,
  });

  factory DuelQuestion.fromJson(Map<String, dynamic> json) {
    return DuelQuestion(
      id: json['id'] ?? '',
      question: json['question'] ?? json['soru'] ?? '',
      options: List<String>.from(json['options'] ?? json['secenekler'] ?? []),
      correctIndex: json['correctIndex'] ?? json['dogruCevap'] ?? 0,
      imageUrl: json['imageUrl'] ?? json['resim'],
    );
  }
}

/// Cümle tamamlama sorusu entity'si
class DuelFillBlankQuestion {
  final String id;
  final String sentence;
  final String answer;
  final List<String> options;

  const DuelFillBlankQuestion({
    required this.id,
    required this.sentence,
    required this.answer,
    required this.options,
  });

  factory DuelFillBlankQuestion.fromJson(Map<String, dynamic> json) {
    return DuelFillBlankQuestion(
      id: json['id'] ?? '',
      sentence: json['sentence'] ?? json['cumle'] ?? '',
      answer: json['answer'] ?? json['cevap'] ?? '',
      options: List<String>.from(json['options'] ?? json['secenekler'] ?? []),
    );
  }
}

/// Salla Bakalım (Guess) düello sorusu entity'si
class DuelGuessQuestion {
  final String id;
  final String question;
  final int answer;
  final int tolerance;
  final String? hint;
  final String? info;

  const DuelGuessQuestion({
    required this.id,
    required this.question,
    required this.answer,
    this.tolerance = 100,
    this.hint,
    this.info,
  });

  factory DuelGuessQuestion.fromJson(Map<String, dynamic> json) {
    return DuelGuessQuestion(
      id: json['id']?.toString() ?? '',
      question: json['question'] as String? ?? '',
      answer: json['answer'] as int? ?? 0,
      tolerance: json['tolerance'] as int? ?? 100,
      hint: json['hint'] as String?,
      info: json['info'] as String?,
    );
  }
}

/// Bul Bakalım (FindCards) düello kart entity'si
class DuelMemoryCard {
  final int id; // Kartın pozisyon ID'si (0-9)
  final int number; // Kartın üzerindeki sayı (1-10)
  final bool isFlipped;
  final bool isMatched;

  const DuelMemoryCard({
    required this.id,
    required this.number,
    this.isFlipped = false,
    this.isMatched = false,
  });

  DuelMemoryCard copyWith({
    int? id,
    int? number,
    bool? isFlipped,
    bool? isMatched,
  }) {
    return DuelMemoryCard(
      id: id ?? this.id,
      number: number ?? this.number,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }

  @override
  String toString() =>
      'DuelMemoryCard(id: $id, number: $number, flipped: $isFlipped, matched: $isMatched)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DuelMemoryCard && other.id == id && other.number == number;
  }

  @override
  int get hashCode => id.hashCode ^ number.hashCode;
}
