import '../models/speaking_rule_model.dart';

class SpeakingRulesRepository {
  SpeakingRulesRepository._();

  static final List<SpeakingRule> rules = [
    _rule01,
  ];

  static SpeakingRule findById(int ruleId) {
    return rules.firstWhere(
          (rule) => rule.id == ruleId,
      orElse: () => throw StateError(
        'Speaking rule $ruleId was not found.',
      ),
    );
  }

  static List<String> validate() {
    final errors = <String>[];
    final usedIds = <int>{};

    for (final rule in rules) {
      if (!usedIds.add(rule.id)) {
        errors.add('Duplicate rule ID: ${rule.id}');
      }

      if (rule.practices.length != 20) {
        errors.add(
          'Rule ${rule.id} must contain exactly 20 practices.',
        );
      }

      final practiceIds = <int>{};

      for (final practice in rule.practices) {
        if (!practiceIds.add(practice.id)) {
          errors.add(
            'Duplicate practice ${practice.id} in Rule ${rule.id}.',
          );
        }

        if (practice.targetSentence.trim().isEmpty) {
          errors.add(
            'Rule ${rule.id}, Practice ${practice.id} has no answer.',
          );
        }
      }
    }

    return errors;
  }

  static const SpeakingRule _rule01 = SpeakingRule(
    id: 1,
    title: 'Introduce Yourself',
    explanation:
    'নিজের পরিচয় দিতে I am, My name is এবং I live in ব্যবহার করা হয়।',
    formula: 'I am + name/identity/place',
    example: 'I am Raj. I am a developer.',
    level: 'Beginner',
    practices: [
      SpeakingPracticeItem(
        id: 1,
        type: SpeakingPracticeType.structureChoice,
        instruction: 'Choose the correct sentence.',
        targetSentence: 'I am Raj.',
        nativeTexts: {'bn': 'আমি রাজ।'},
        hint: 'নিজের নামের আগে I am ব্যবহার করো।',
        explanation: 'নিজের পরিচয় দিতে I am ব্যবহার করা হয়।',
        options: ['I is Raj.', 'I am Raj.', 'I are Raj.'],
      ),
      SpeakingPracticeItem(
        id: 2,
        type: SpeakingPracticeType.structureChoice,
        instruction: 'Choose the correct introduction.',
        targetSentence: 'My name is Raj.',
        nativeTexts: {'bn': 'আমার নাম রাজ।'},
        hint: 'My name-এর পরে is বসে।',
        explanation: 'সঠিক structure: My name is + name.',
        options: [
          'My name am Raj.',
          'My name is Raj.',
          'My name are Raj.',
        ],
      ),
      SpeakingPracticeItem(
        id: 3,
        type: SpeakingPracticeType.fillBlank,
        instruction: 'Complete and speak the sentence.',
        targetSentence: 'I am a student.',
        nativeTexts: {'bn': 'আমি একজন শিক্ষার্থী।'},
        hint: 'I-এর পরে am বসে।',
        explanation: 'I-এর সঙ্গে সবসময় am ব্যবহার হয়।',
        options: ['is', 'am', 'are'],
      ),
      SpeakingPracticeItem(
        id: 4,
        type: SpeakingPracticeType.fillBlank,
        instruction: 'Complete and speak the sentence.',
        targetSentence: 'I live in Bangladesh.',
        nativeTexts: {'bn': 'আমি বাংলাদেশে থাকি।'},
        hint: 'কোথায় থাকো বলতে live in ব্যবহার করো।',
        explanation: 'Structure: I live in + place.',
        options: ['live in', 'am live', 'living'],
      ),
      SpeakingPracticeItem(
        id: 5,
        type: SpeakingPracticeType.wordOrder,
        instruction: 'Arrange the words and speak.',
        targetSentence: 'I am a developer.',
        nativeTexts: {'bn': 'আমি একজন ডেভেলপার।'},
        hint: 'Sentence শুরু হবে I দিয়ে।',
        explanation: 'Structure: I + am + identity.',
        words: ['developer', 'I', 'a', 'am'],
      ),
      SpeakingPracticeItem(
        id: 6,
        type: SpeakingPracticeType.wordOrder,
        instruction: 'Arrange the words and speak.',
        targetSentence: 'My name is Raj.',
        nativeTexts: {'bn': 'আমার নাম রাজ।'},
        hint: 'My name দিয়ে শুরু করো।',
        explanation: 'Structure: My name + is + name.',
        words: ['Raj', 'is', 'My', 'name'],
      ),
      SpeakingPracticeItem(
        id: 7,
        type: SpeakingPracticeType.translateAndSpeak,
        instruction: 'Say this sentence in English.',
        targetSentence: 'I am twenty years old.',
        nativeTexts: {'bn': 'আমার বয়স বিশ বছর।'},
        hint: 'I am + age + years old.',
        explanation: 'বয়স বলার সময় I am ... years old বলা হয়।',
      ),
      SpeakingPracticeItem(
        id: 8,
        type: SpeakingPracticeType.translateAndSpeak,
        instruction: 'Say this sentence in English.',
        targetSentence: 'I am from Bangladesh.',
        nativeTexts: {'bn': 'আমি বাংলাদেশ থেকে এসেছি।'},
        hint: 'I am from + country.',
        explanation: 'নিজের দেশ বলতে I am from ব্যবহার করো।',
      ),
      SpeakingPracticeItem(
        id: 9,
        type: SpeakingPracticeType.translateAndSpeak,
        instruction: 'Say this sentence in English.',
        targetSentence: 'I live in Dhaka.',
        nativeTexts: {'bn': 'আমি ঢাকায় থাকি।'},
        hint: 'I live in + place.',
        explanation: 'থাকার জায়গা বলতে live in ব্যবহার হয়।',
      ),
      SpeakingPracticeItem(
        id: 10,
        type: SpeakingPracticeType.translateAndSpeak,
        instruction: 'Say this sentence in English.',
        targetSentence: 'I am learning English.',
        nativeTexts: {'bn': 'আমি ইংরেজি শিখছি।'},
        hint: 'I am learning + subject.',
        explanation: 'চলমান কাজ বোঝাতে am learning ব্যবহার হয়।',
      ),
      SpeakingPracticeItem(
        id: 11,
        type: SpeakingPracticeType.listenAndRepeat,
        instruction: 'Listen carefully and repeat.',
        targetSentence: 'Hello, my name is Raj.',
        nativeTexts: {'bn': 'হ্যালো, আমার নাম রাজ।'},
        hint: 'ধীরে ধীরে প্রতিটি শব্দ বলো।',
        explanation: 'Greeting-এর পরে নিজের নাম বলা হয়েছে।',
      ),
      SpeakingPracticeItem(
        id: 12,
        type: SpeakingPracticeType.listenAndRepeat,
        instruction: 'Listen carefully and repeat.',
        targetSentence: 'I am happy to meet you.',
        nativeTexts: {'bn': 'আপনার সঙ্গে দেখা করে আমি আনন্দিত।'},
        hint: 'Happy to meet you.',
        explanation: 'নতুন কারও সঙ্গে পরিচয়ের সময় এটি বলা যায়।',
      ),
      SpeakingPracticeItem(
        id: 13,
        type: SpeakingPracticeType.listenAndRepeat,
        instruction: 'Listen carefully and repeat.',
        targetSentence: 'I want to improve my English.',
        nativeTexts: {'bn': 'আমি আমার ইংরেজি উন্নত করতে চাই।'},
        hint: 'I want to + action.',
        explanation: 'নিজের ইচ্ছা বলতে I want to ব্যবহার হয়।',
      ),
      SpeakingPracticeItem(
        id: 14,
        type: SpeakingPracticeType.pictureSpeaking,
        instruction: 'Look at the profile and speak.',
        targetSentence: 'I am a student.',
        nativeTexts: {'bn': 'ছবির ব্যক্তিটি একজন শিক্ষার্থী।'},
        hint: 'নিজেকে ব্যক্তিটি ধরে I am বলো।',
        explanation: 'Profession বা identity-এর আগে a/an বসে।',
      ),
      SpeakingPracticeItem(
        id: 15,
        type: SpeakingPracticeType.pictureSpeaking,
        instruction: 'Look at the country and speak.',
        targetSentence: 'I am from Bangladesh.',
        nativeTexts: {'bn': 'ছবিতে বাংলাদেশ দেখানো হয়েছে।'},
        hint: 'I am from + country.',
        explanation: 'নিজের দেশ পরিচয় করাতে এই structure ব্যবহার হয়।',
      ),
      SpeakingPracticeItem(
        id: 16,
        type: SpeakingPracticeType.questionAnswer,
        instruction: 'Listen to the question and answer.',
        question: 'What is your name?',
        targetSentence: 'My name is Raj.',
        nativeTexts: {'bn': 'তোমার নাম কী? উত্তর ইংরেজিতে বলো।'},
        hint: 'My name is...',
        explanation: 'নাম জানতে What is your name? বলা হয়।',
      ),
      SpeakingPracticeItem(
        id: 17,
        type: SpeakingPracticeType.questionAnswer,
        instruction: 'Listen to the question and answer.',
        question: 'Where are you from?',
        targetSentence: 'I am from Bangladesh.',
        nativeTexts: {'bn': 'তুমি কোথা থেকে এসেছ? উত্তর ইংরেজিতে বলো।'},
        hint: 'I am from...',
        explanation: 'দেশ বা hometown জানতে এই প্রশ্ন করা হয়।',
      ),
      SpeakingPracticeItem(
        id: 18,
        type: SpeakingPracticeType.errorCorrection,
        instruction: 'Correct the sentence and speak.',
        targetSentence: 'I am a developer.',
        nativeTexts: {'bn': 'ভুল বাক্য: I is a developer.'},
        hint: 'I-এর সঙ্গে is নয়।',
        explanation: 'I-এর সঙ্গে am ব্যবহার করতে হবে।',
      ),
      SpeakingPracticeItem(
        id: 19,
        type: SpeakingPracticeType.situationSpeaking,
        instruction: 'Introduce yourself to a new friend.',
        targetSentence: 'Hello, I am Raj. I am from Bangladesh.',
        nativeTexts: {
          'bn': 'নতুন বন্ধুর কাছে নিজের নাম ও দেশের পরিচয় দাও।',
        },
        hint: 'Hello + name + country.',
        explanation: 'ছোট পরিচয়ে greeting, name ও country বলো।',
      ),
      SpeakingPracticeItem(
        id: 20,
        type: SpeakingPracticeType.conversation,
        instruction: 'Reply to the speaker.',
        question: 'Hello! Nice to meet you. What is your name?',
        targetSentence: 'Hello! My name is Raj. Nice to meet you too.',
        nativeTexts: {
          'bn': 'অপর ব্যক্তি তোমার নাম জানতে চেয়েছে। উত্তর দাও।',
        },
        hint: 'Greeting + name + polite reply.',
        explanation: 'Conversation-এ greeting-এর উত্তর দিয়ে নাম বলো।',
      ),
    ],
  );
}