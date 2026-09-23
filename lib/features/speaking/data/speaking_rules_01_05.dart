
import '../models/speaking_rule_model.dart';

class SpeakingRules01To05 {
  SpeakingRules01To05._();

  static final List<SpeakingRule> rules = [
    _createRule(
      id: 1,
      title: 'Introduce Yourself',
      explanation:
      'নিজের নাম, দেশ, বয়স, পেশা এবং আগ্রহ সম্পর্কে সহজ ইংরেজিতে পরিচয় দিতে শিখুন।',
      formula: 'I am + identity / My name is + name',
      example: 'Hello, my name is Raj. I am from Bangladesh.',
      seeds: const [
        _Seed('I am Raj.', 'আমি রাজ।'),
        _Seed('My name is Raj.', 'আমার নাম রাজ।'),
        _Seed('I am a student.', 'আমি একজন শিক্ষার্থী।'),
        _Seed('I am from Bangladesh.', 'আমি বাংলাদেশ থেকে এসেছি।'),
        _Seed('I live in Dhaka.', 'আমি ঢাকায় থাকি।'),
        _Seed('I am twenty years old.', 'আমার বয়স বিশ বছর।'),
        _Seed('I am a developer.', 'আমি একজন ডেভেলপার।'),
        _Seed('I am learning English.', 'আমি ইংরেজি শিখছি।'),
        _Seed('I like reading books.', 'আমি বই পড়তে পছন্দ করি।'),
        _Seed('I like playing football.', 'আমি ফুটবল খেলতে পছন্দ করি।'),
        _Seed('Hello, my name is Raj.', 'হ্যালো, আমার নাম রাজ।'),
        _Seed('I am happy to meet you.',
            'আপনার সঙ্গে দেখা করে আমি আনন্দিত।'),
        _Seed('I want to improve my English.',
            'আমি আমার ইংরেজি উন্নত করতে চাই।'),
        _Seed('I am a friendly person.', 'আমি একজন বন্ধুসুলভ মানুষ।'),
        _Seed('I work as a developer.',
            'আমি একজন ডেভেলপার হিসেবে কাজ করি।'),
        _Seed(
          'My name is Raj.',
          'তোমার নাম কী? ইংরেজিতে উত্তর দাও।',
          question: 'What is your name?',
        ),
        _Seed(
          'I am from Bangladesh.',
          'তুমি কোথা থেকে এসেছ? ইংরেজিতে উত্তর দাও।',
          question: 'Where are you from?',
        ),
        _Seed(
          'I am a student.',
          'ভুল বাক্যটি ঠিক করে বলো: I is a student.',
        ),
        _Seed(
          'Hello, I am Raj. I am from Bangladesh.',
          'নতুন বন্ধুর কাছে নিজের নাম এবং দেশের পরিচয় দাও।',
        ),
        _Seed(
          'Hello, my name is Raj. Nice to meet you too.',
          'অপর ব্যক্তির সঙ্গে পরিচিত হও এবং নিজের নাম বলো।',
          question: 'Hello! Nice to meet you. What is your name?',
        ),
      ],
    ),

    _createRule(
      id: 2,
      title: 'I am & You are',
      explanation:
      'নিজের জন্য I am এবং সামনে থাকা ব্যক্তির জন্য You are ব্যবহার করা হয়।',
      formula: 'I + am / You + are',
      example: 'I am happy. You are kind.',
      seeds: const [
        _Seed('I am happy.', 'আমি খুশি।'),
        _Seed('You are happy.', 'তুমি খুশি।'),
        _Seed('I am ready.', 'আমি প্রস্তুত।'),
        _Seed('You are ready.', 'তুমি প্রস্তুত।'),
        _Seed('I am tired.', 'আমি ক্লান্ত।'),
        _Seed('You are busy.', 'তুমি ব্যস্ত।'),
        _Seed('I am hungry.', 'আমি ক্ষুধার্ত।'),
        _Seed('You are helpful.', 'তুমি সাহায্যকারী।'),
        _Seed('I am at home.', 'আমি বাড়িতে আছি।'),
        _Seed('You are my friend.', 'তুমি আমার বন্ধু।'),
        _Seed('I am very happy today.', 'আমি আজ খুব খুশি।'),
        _Seed('You are a good person.', 'তুমি একজন ভালো মানুষ।'),
        _Seed('I am ready to learn.', 'আমি শেখার জন্য প্রস্তুত।'),
        _Seed('I am in my room.', 'আমি আমার ঘরে আছি।'),
        _Seed('You are near the door.', 'তুমি দরজার কাছে আছ।'),
        _Seed(
          'I am fine.',
          'তুমি কেমন আছ? ইংরেজিতে উত্তর দাও।',
          question: 'How are you?',
        ),
        _Seed(
          'Yes, I am ready.',
          'তুমি কি প্রস্তুত? ইংরেজিতে উত্তর দাও।',
          question: 'Are you ready?',
        ),
        _Seed(
          'I am happy.',
          'ভুল বাক্যটি ঠিক করে বলো: I are happy.',
        ),
        _Seed(
          'You are welcome.',
          'কেউ তোমাকে ধন্যবাদ দিয়েছে। ভদ্রভাবে উত্তর দাও।',
        ),
        _Seed(
          'I am fine, thank you. You are very kind.',
          'কথোপকথনের উত্তর দাও।',
          question: 'Hello! How are you today?',
        ),
      ],
    ),

    _createRule(
      id: 3,
      title: 'He is & She is',
      explanation:
      'একজন পুরুষ সম্পর্কে He is এবং একজন নারী সম্পর্কে She is ব্যবহার করা হয়।',
      formula: 'He + is / She + is',
      example: 'He is a teacher. She is a doctor.',
      seeds: const [
        _Seed('He is a student.', 'সে একজন ছাত্র।'),
        _Seed('She is a student.', 'সে একজন ছাত্রী।'),
        _Seed('He is my brother.', 'সে আমার ভাই।'),
        _Seed('She is my sister.', 'সে আমার বোন।'),
        _Seed('He is happy.', 'সে খুশি।'),
        _Seed('She is busy.', 'সে ব্যস্ত।'),
        _Seed('He is a teacher.', 'সে একজন শিক্ষক।'),
        _Seed('She is a doctor.', 'সে একজন ডাক্তার।'),
        _Seed('He is at home.', 'সে বাড়িতে আছে।'),
        _Seed('She is in the kitchen.', 'সে রান্নাঘরে আছে।'),
        _Seed('He is very friendly.', 'সে খুব বন্ধুসুলভ।'),
        _Seed('She is learning English.', 'সে ইংরেজি শিখছে।'),
        _Seed('He is playing football.', 'সে ফুটবল খেলছে।'),
        _Seed('She is reading a book.', 'সে একটি বই পড়ছে।'),
        _Seed('He is standing near the car.',
            'সে গাড়ির পাশে দাঁড়িয়ে আছে।'),
        _Seed(
          'He is my brother.',
          'লোকটি তোমার কে? ইংরেজিতে উত্তর দাও।',
          question: 'Who is he?',
        ),
        _Seed(
          'She is a doctor.',
          'মহিলাটি কী করেন? ইংরেজিতে উত্তর দাও।',
          question: 'What does she do?',
        ),
        _Seed(
          'She is happy.',
          'ভুল বাক্যটি ঠিক করে বলো: She are happy.',
        ),
        _Seed(
          'He is my friend. He is very helpful.',
          'তোমার একজন ছেলে বন্ধুর পরিচয় দাও।',
        ),
        _Seed(
          'She is my sister. She is learning English.',
          'কথোপকথনে মেয়েটির পরিচয় দাও।',
          question: 'Who is she and what is she doing?',
        ),
      ],
    ),

    _createRule(
      id: 4,
      title: 'This is & That is',
      explanation:
      'কাছের একটি জিনিসের জন্য This is এবং দূরের একটি জিনিসের জন্য That is ব্যবহার করা হয়।',
      formula: 'This is + nearby thing / That is + distant thing',
      example: 'This is my phone. That is your bag.',
      seeds: const [
        _Seed('This is a book.', 'এটি একটি বই।'),
        _Seed('That is a chair.', 'ওটি একটি চেয়ার।'),
        _Seed('This is my phone.', 'এটি আমার ফোন।'),
        _Seed('That is your bag.', 'ওটি তোমার ব্যাগ।'),
        _Seed('This is a pen.', 'এটি একটি কলম।'),
        _Seed('That is a tree.', 'ওটি একটি গাছ।'),
        _Seed('This is my room.', 'এটি আমার ঘর।'),
        _Seed('That is our school.', 'ওটি আমাদের স্কুল।'),
        _Seed('This is very useful.', 'এটি খুব উপকারী।'),
        _Seed('That is very beautiful.', 'ওটি খুব সুন্দর।'),
        _Seed('This is a glass of water.',
            'এটি এক গ্লাস পানি।'),
        _Seed('That is a tall building.',
            'ওটি একটি উঁচু ভবন।'),
        _Seed('This is my favourite book.',
            'এটি আমার পছন্দের বই।'),
        _Seed('This is a new computer.',
            'এটি একটি নতুন কম্পিউটার।'),
        _Seed('That is an old house.',
            'ওটি একটি পুরোনো বাড়ি।'),
        _Seed(
          'This is my phone.',
          'তোমার হাতের জিনিসটি কী? ইংরেজিতে উত্তর দাও।',
          question: 'What is this?',
        ),
        _Seed(
          'That is our school.',
          'দূরের ভবনটি কী? ইংরেজিতে উত্তর দাও।',
          question: 'What is that?',
        ),
        _Seed(
          'This is a book.',
          'ভুল বাক্যটি ঠিক করে বলো: This are a book.',
        ),
        _Seed(
          'This is my ticket.',
          'কাউন্টারে নিজের টিকিট দেখিয়ে বাক্যটি বলো।',
        ),
        _Seed(
          'This is my bag, and that is your bag.',
          'দুটি ব্যাগ কার তা কথোপকথনে বোঝাও।',
          question: 'Which bag is yours and which bag is mine?',
        ),
      ],
    ),

    _createRule(
      id: 5,
      title: 'These are & Those are',
      explanation:
      'কাছের একাধিক জিনিসের জন্য These are এবং দূরের একাধিক জিনিসের জন্য Those are ব্যবহার হয়।',
      formula:
      'These are + nearby plural / Those are + distant plural',
      example: 'These are my books. Those are your shoes.',
      seeds: const [
        _Seed('These are books.', 'এগুলো বই।'),
        _Seed('Those are chairs.', 'ওগুলো চেয়ার।'),
        _Seed('These are my pens.', 'এগুলো আমার কলম।'),
        _Seed('Those are your bags.', 'ওগুলো তোমার ব্যাগ।'),
        _Seed('These are fresh flowers.', 'এগুলো তাজা ফুল।'),
        _Seed('Those are tall trees.', 'ওগুলো লম্বা গাছ।'),
        _Seed('These are my friends.', 'এরা আমার বন্ধু।'),
        _Seed('Those are our teachers.', 'ওনারা আমাদের শিক্ষক।'),
        _Seed('These are new shoes.', 'এগুলো নতুন জুতা।'),
        _Seed('Those are old houses.', 'ওগুলো পুরোনো বাড়ি।'),
        _Seed('These are useful books.', 'এগুলো উপকারী বই।'),
        _Seed('Those are beautiful pictures.',
            'ওগুলো সুন্দর ছবি।'),
        _Seed('These are red apples.', 'এগুলো লাল আপেল।'),
        _Seed('These are my English notes.',
            'এগুলো আমার ইংরেজির নোট।'),
        _Seed('Those are expensive cars.',
            'ওগুলো দামি গাড়ি।'),
        _Seed(
          'These are my books.',
          'তোমার হাতের বইগুলো কার? ইংরেজিতে উত্তর দাও।',
          question: 'Whose books are these?',
        ),
        _Seed(
          'Those are mango trees.',
          'দূরের গাছগুলো কী? ইংরেজিতে উত্তর দাও।',
          question: 'What are those?',
        ),
        _Seed(
          'These are my shoes.',
          'ভুল বাক্যটি ঠিক করে বলো: These is my shoes.',
        ),
        _Seed(
          'These are my documents.',
          'অফিসে নিজের কাগজপত্র দেখিয়ে বাক্যটি বলো।',
        ),
        _Seed(
          'These are my keys, and those are your keys.',
          'চাবিগুলো কার তা কথোপকথনে বোঝাও।',
          question: 'Which keys are mine and which keys are yours?',
        ),
      ],
    ),
  ];

  static SpeakingRule _createRule({
    required int id,
    required String title,
    required String explanation,
    required String formula,
    required String example,
    required List<_Seed> seeds,
  }) {
    if (seeds.length != 20) {
      throw StateError(
        'Rule $id must contain exactly 20 practice seeds.',
      );
    }

    return SpeakingRule(
      id: id,
      title: title,
      explanation: explanation,
      formula: formula,
      example: example,
      level: 'Beginner',
      practices: List.generate(
        seeds.length,
            (index) => _createPractice(
          ruleId: id,
          index: index,
          seed: seeds[index],
        ),
        growable: false,
      ),
    );
  }

  static SpeakingPracticeItem _createPractice({
    required int ruleId,
    required int index,
    required _Seed seed,
  }) {
    final type = _practiceType(index);
    final practiceId = index + 1;

    return SpeakingPracticeItem(
      id: practiceId,
      type: type,
      instruction: _instruction(type),
      targetSentence: seed.english,
      nativeTexts: {
        'bn': seed.bangla,
        'en': seed.english,
      },
      hint: _hint(
        ruleId: ruleId,
        sentence: seed.english,
      ),
      explanation: _explanation(ruleId),
      options: _needsOptions(type)
          ? _createOptions(
        ruleId: ruleId,
        practiceId: practiceId,
        correctAnswer: seed.english,
      )
          : const [],
      words: type == SpeakingPracticeType.wordOrder
          ? _createWords(seed.english)
          : const [],
      question: seed.question,
    );
  }

  static SpeakingPracticeType _practiceType(int index) {
    if (index <= 1) {
      return SpeakingPracticeType.structureChoice;
    }

    if (index <= 3) {
      return SpeakingPracticeType.fillBlank;
    }

    if (index <= 5) {
      return SpeakingPracticeType.wordOrder;
    }

    if (index <= 9) {
      return SpeakingPracticeType.translateAndSpeak;
    }

    if (index <= 12) {
      return SpeakingPracticeType.listenAndRepeat;
    }

    if (index <= 14) {
      return SpeakingPracticeType.pictureSpeaking;
    }

    if (index <= 16) {
      return SpeakingPracticeType.questionAnswer;
    }

    if (index == 17) {
      return SpeakingPracticeType.errorCorrection;
    }

    if (index == 18) {
      return SpeakingPracticeType.situationSpeaking;
    }

    return SpeakingPracticeType.conversation;
  }

  static String _instruction(
      SpeakingPracticeType type,
      ) {
    return switch (type) {
      SpeakingPracticeType.structureChoice =>
      'Choose the correct sentence.',
      SpeakingPracticeType.fillBlank =>
      'Choose the correct answer and complete the sentence.',
      SpeakingPracticeType.wordOrder =>
      'Arrange the words in the correct order.',
      SpeakingPracticeType.translateAndSpeak =>
      'Read the Bangla meaning and speak in English.',
      SpeakingPracticeType.listenAndRepeat =>
      'Listen carefully and repeat the sentence.',
      SpeakingPracticeType.pictureSpeaking =>
      'Understand the situation and speak the sentence.',
      SpeakingPracticeType.questionAnswer =>
      'Listen to the question and answer in English.',
      SpeakingPracticeType.errorCorrection =>
      'Correct the wrong sentence and speak.',
      SpeakingPracticeType.situationSpeaking =>
      'Speak according to the real-life situation.',
      SpeakingPracticeType.conversation =>
      'Listen and reply to complete the conversation.',
    };
  }

  static bool _needsOptions(
      SpeakingPracticeType type,
      ) {
    return type == SpeakingPracticeType.structureChoice ||
        type == SpeakingPracticeType.fillBlank;
  }

  static List<String> _createOptions({
    required int ruleId,
    required int practiceId,
    required String correctAnswer,
  }) {
    final wrongAnswers = _wrongAnswers(
      ruleId,
      correctAnswer,
    );

    final options = <String>[
      correctAnswer,
      ...wrongAnswers,
    ];

    // Correct option সবসময় একই position-এ থাকবে না।
    if (practiceId % 3 == 0) {
      return [
        options[1],
        options[2],
        options[0],
      ];
    }

    if (practiceId % 2 == 0) {
      return [
        options[1],
        options[0],
        options[2],
      ];
    }

    return options;
  }

  static List<String> _wrongAnswers(
      int ruleId,
      String correct,
      ) {
    switch (ruleId) {
      case 1:
        if (correct.startsWith('My name is')) {
          return [
            correct.replaceFirst('My name is', 'My name am'),
            correct.replaceFirst('My name is', 'My name are'),
          ];
        }

        return [
          correct.replaceFirst('I am', 'I is'),
          correct.replaceFirst('I am', 'I are'),
        ];

      case 2:
        if (correct.startsWith('You are')) {
          return [
            correct.replaceFirst('You are', 'You is'),
            correct.replaceFirst('You are', 'You am'),
          ];
        }

        return [
          correct.replaceFirst('I am', 'I is'),
          correct.replaceFirst('I am', 'I are'),
        ];

      case 3:
        return [
          correct.replaceFirst(' is ', ' are '),
          correct.replaceFirst(' is ', ' am '),
        ];

      case 4:
        return [
          correct.replaceFirst(' is ', ' are '),
          correct.replaceFirst('This', 'These'),
        ];

      case 5:
        return [
          correct.replaceFirst(' are ', ' is '),
          correct.startsWith('These')
              ? correct.replaceFirst('These', 'This')
              : correct.replaceFirst('Those', 'That'),
        ];

      default:
        return [
          'Not $correct',
          '$correct not',
        ];
    }
  }

  static List<String> _createWords(String sentence) {
    final cleanSentence = sentence.replaceAll(
      RegExp(r'[.!?,]'),
      '',
    );

    final words = cleanSentence.split(RegExp(r'\s+'));

    // একই sentence-এর words predictable না রেখে reverse করা।
    return words.reversed.toList(growable: false);
  }

  static String _hint({
    required int ruleId,
    required String sentence,
  }) {
    return switch (ruleId) {
      1 => sentence.startsWith('My name')
          ? 'My name is + your name'
          : 'নিজের সম্পর্কে বললে I ব্যবহার করো।',
      2 => sentence.startsWith('You')
          ? 'You-এর সঙ্গে are ব্যবহার করো।'
          : 'I-এর সঙ্গে am ব্যবহার করো।',
      3 => 'He অথবা She-এর সঙ্গে is ব্যবহার করো।',
      4 => sentence.startsWith('This')
          ? 'কাছের একটি জিনিসের জন্য This is বলো।'
          : 'দূরের একটি জিনিসের জন্য That is বলো।',
      5 => sentence.startsWith('These')
          ? 'কাছের একাধিক জিনিসের জন্য These are বলো।'
          : 'দূরের একাধিক জিনিসের জন্য Those are বলো।',
      _ => 'Sentence structure মনে করে ধীরে বলো।',
    };
  }

  static String _explanation(int ruleId) {
    return switch (ruleId) {
      1 =>
      'নিজের পরিচয় দিতে I am অথবা My name is ব্যবহার করা হয়।',
      2 =>
      'I-এর সঙ্গে am এবং You-এর সঙ্গে are ব্যবহার করতে হয়।',
      3 =>
      'একজন পুরুষের জন্য He is এবং একজন নারীর জন্য She is ব্যবহার হয়।',
      4 =>
      'কাছের একটি জিনিসে This is এবং দূরের একটি জিনিসে That is ব্যবহার হয়।',
      5 =>
      'কাছের একাধিক জিনিসে These are এবং দূরের একাধিক জিনিসে Those are ব্যবহার হয়।',
      _ => 'সঠিক structure অনুসরণ করে sentence তৈরি করো।',
    };
  }
}

class _Seed {
  final String english;
  final String bangla;
  final String? question;

  const _Seed(
      this.english,
      this.bangla, {
        this.question,
      });
}