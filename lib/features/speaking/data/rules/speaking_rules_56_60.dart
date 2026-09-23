import '../../models/speaking_rule_model.dart';
import 'speaking_rule_factory.dart';

class SpeakingRules56To60 {
  SpeakingRules56To60._();

  static final List<SpeakingRule> rules = <SpeakingRule>[
    _rule56, _rule57, _rule58, _rule59, _rule60,
  ];

  static final SpeakingRule _rule56 = SpeakingRuleFactory.create(
    id: 56,
    title: 'Giving Opinions',
    explanation:
    'নিজের মতামত স্পষ্টভাবে বলতে I think, I believe, In my opinion এবং From my point of view ব্যবহার করা যায়।',
    formula: 'Opinion phrase + complete sentence',
    example: 'In my opinion, practice is essential.',
    optionBuilder: _opinionOptions,
    hintBuilder: (_) => 'একটি opinion phrase দিয়ে শুরু করে নিজের কারণসহ সম্পূর্ণ বাক্য বলো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I think English is important.', 'আমি মনে করি English গুরুত্বপূর্ণ।'),
      SpeakingSeed('In my opinion, practice is essential.', 'আমার মতে practice অত্যন্ত প্রয়োজনীয়।'),
      SpeakingSeed('I believe this plan will work.', 'আমি বিশ্বাস করি এই plan কাজ করবে।'),
      SpeakingSeed('From my point of view, the app is helpful.', 'আমার দৃষ্টিতে app-টি helpful।'),
      SpeakingSeed('I think we should start now.', 'আমি মনে করি আমাদের এখন শুরু করা উচিত।'),
      SpeakingSeed('In my opinion, online learning saves time.', 'আমার মতে online learning সময় বাঁচায়।'),
      SpeakingSeed('I believe everyone can learn English.', 'আমি বিশ্বাস করি সবাই English শিখতে পারে।'),
      SpeakingSeed('I think this phone is too expensive.', 'আমি মনে করি phone-টি অতিরিক্ত দামি।'),
      SpeakingSeed('From my point of view, health comes first.', 'আমার দৃষ্টিতে health সবার আগে।'),
      SpeakingSeed('In my opinion, the second option is better.', 'আমার মতে দ্বিতীয় option ভালো।'),
      SpeakingSeed('I think she speaks very clearly.', 'আমি মনে করি সে খুব স্পষ্টভাবে বলে।'),
      SpeakingSeed('I believe hard work brings success.', 'আমি বিশ্বাস করি কঠোর পরিশ্রম success আনে।'),
      SpeakingSeed('In my opinion, we need more time.', 'আমার মতে আমাদের আরও সময় প্রয়োজন।'),
      SpeakingSeed('I think traveling teaches us many things.', 'আমি মনে করি travel আমাদের অনেক কিছু শেখায়।'),
      SpeakingSeed('From my point of view, mistakes help us learn.', 'আমার দৃষ্টিতে ভুল আমাদের শিখতে সাহায্য করে।'),
      SpeakingSeed('I think daily practice is the best method.', 'English শেখার সেরা method কী?', question: 'What is the best way to learn English?'),
      SpeakingSeed('In my opinion, this app is easy to use.', 'App-টি সম্পর্কে তোমার মতামত কী?', question: 'What is your opinion about this app?'),
      SpeakingSeed('I think this idea is good.', 'ভুল বাক্যটি ঠিক করো: I am think this idea is good.'),
      SpeakingSeed('In my opinion, this room is not quiet enough.', 'Hotel room সম্পর্কে মতামত দাও।'),
      SpeakingSeed('I believe consistent practice is more important than speaking perfectly.', 'English শেখার বিষয়ে নিজের মতামত ও কারণ বলো।', question: 'What do you believe about learning English?'),
    ],
  );

  static final SpeakingRule _rule57 = SpeakingRuleFactory.create(
    id: 57,
    title: 'Agreeing & Disagreeing',
    explanation:
    'সম্মতি জানাতে I agree, You are right এবং অসম্মতি ভদ্রভাবে জানাতে I’m not sure I agree বা I see it differently বলা যায়।',
    formula: 'Agreement/disagreement phrase + reason',
    example: 'I agree with you. I’m not sure I agree because...',
    optionBuilder: _agreementOptions,
    hintBuilder: (_) => 'প্রথমে সম্মতি বা অসম্মতি জানাও, তারপর ছোট একটি কারণ বলো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('I agree with you.', 'আমি তোমার সঙ্গে একমত।'),
      SpeakingSeed('You are absolutely right.', 'তুমি সম্পূর্ণ সঠিক।'),
      SpeakingSeed('I think so too.', 'আমিও তাই মনে করি।'),
      SpeakingSeed('That is a good point.', 'এটি ভালো একটি point।'),
      SpeakingSeed('I could not agree more.', 'আমি সম্পূর্ণ একমত।'),
      SpeakingSeed('I am not sure I agree.', 'আমি নিশ্চিত নই যে আমি একমত।'),
      SpeakingSeed('I see it differently.', 'আমি বিষয়টি ভিন্নভাবে দেখি।'),
      SpeakingSeed('I understand your point, but I disagree.', 'আমি তোমার point বুঝি, কিন্তু একমত নই।'),
      SpeakingSeed('That may be true, but we need more information.', 'সেটি সত্য হতে পারে, কিন্তু আরও information প্রয়োজন।'),
      SpeakingSeed('I agree because practice builds confidence.', 'আমি একমত, কারণ practice confidence তৈরি করে।'),
      SpeakingSeed('You are right about the price.', 'দামের বিষয়ে তুমি ঠিক।'),
      SpeakingSeed('I disagree because the plan is too risky.', 'আমি একমত নই, কারণ plan-টি ঝুঁকিপূর্ণ।'),
      SpeakingSeed('I partly agree with you.', 'আমি আংশিকভাবে তোমার সঙ্গে একমত।'),
      SpeakingSeed('That makes sense to me.', 'এটি আমার কাছে যুক্তিযুক্ত মনে হয়।'),
      SpeakingSeed('I respect your opinion, but mine is different.', 'আমি তোমার মতামত সম্মান করি, কিন্তু আমারটি ভিন্ন।'),
      SpeakingSeed('I agree that English needs daily practice.', 'Daily practice সম্পর্কে একমত কি?', question: 'Do you agree that English needs daily practice?'),
      SpeakingSeed('I disagree because learning can happen at any age.', 'শুধু শিশুরাই দ্রুত শিখতে পারে—তুমি কি একমত?', question: 'Do you agree that only children can learn quickly?'),
      SpeakingSeed('I agree with you.', 'ভুল বাক্যটি ঠিক করো: I am agree with you.'),
      SpeakingSeed('I understand your point, but I think another room is better.', 'Hotel room নিয়ে ভদ্রভাবে অসম্মতি জানাও।'),
      SpeakingSeed('I partly agree, but regular practice matters more than natural talent.', 'Talent বনাম practice নিয়ে response দাও।', question: 'Is talent more important than practice?'),
    ],
  );

  static final SpeakingRule _rule58 = SpeakingRuleFactory.create(
    id: 58,
    title: 'Making Suggestions',
    explanation:
    'পরামর্শ দিতে Let’s, Why don’t we, How about এবং We could ব্যবহার করা যায়। How about-এর পরে verb+ing বসে।',
    formula: 'Let’s + verb • Why don’t we + verb • How about + verb-ing?',
    example: 'Let’s practice. How about practicing together?',
    optionBuilder: _suggestionOptions,
    hintBuilder: (_) => 'Let’s-এর পরে base verb এবং How about-এর পরে verb+ing ব্যবহার করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('Let’s practice English.', 'চলো English practice করি।'),
      SpeakingSeed('Why don’t we start now?', 'আমরা এখন শুরু করি না কেন?'),
      SpeakingSeed('How about watching an English movie?', 'একটি English movie দেখলে কেমন হয়?'),
      SpeakingSeed('We could meet tomorrow.', 'আমরা আগামীকাল দেখা করতে পারি।'),
      SpeakingSeed('Let’s take a short break.', 'চলো ছোট একটি break নিই।'),
      SpeakingSeed('Why don’t you speak more slowly?', 'তুমি আরও ধীরে বলো না কেন?'),
      SpeakingSeed('How about going by bus?', 'Bus-এ গেলে কেমন হয়?'),
      SpeakingSeed('We could try another option.', 'আমরা অন্য option চেষ্টা করতে পারি।'),
      SpeakingSeed('Let’s review the lesson again.', 'চলো lesson-টি আবার দেখি।'),
      SpeakingSeed('Why don’t we ask for help?', 'আমরা সাহায্য চাই না কেন?'),
      SpeakingSeed('How about having some tea?', 'কিছু tea খেলে কেমন হয়?'),
      SpeakingSeed('We could book the room online.', 'আমরা room-টি online book করতে পারি।'),
      SpeakingSeed('Let’s make a daily plan.', 'চলো দৈনিক plan তৈরি করি।'),
      SpeakingSeed('Why don’t you use a dictionary?', 'তুমি dictionary ব্যবহার করো না কেন?'),
      SpeakingSeed('How about practicing for twenty minutes?', 'বিশ মিনিট practice করলে কেমন হয়?'),
      SpeakingSeed('Let’s practice speaking together.', 'English practice-এর suggestion দাও।', question: 'What do you suggest for improving speaking?'),
      SpeakingSeed('We could take a taxi.', 'Bus না এলে কী করা যায়?', question: 'What could we do if the bus does not arrive?'),
      SpeakingSeed('How about going to the park?', 'ভুল বাক্যটি ঠিক করো: How about go to the park?'),
      SpeakingSeed('Why don’t we ask for a quieter room?', 'Hotel room-এর সমস্যা সমাধানের suggestion দাও।'),
      SpeakingSeed('Let’s practice daily, watch English videos, and speak without fearing mistakes.', 'Beginner learner-এর জন্য complete suggestion দাও।', question: 'How can a beginner improve quickly?'),
    ],
  );

  static final SpeakingRule _rule59 = SpeakingRuleFactory.create(
    id: 59,
    title: 'Asking for Clarification',
    explanation:
    'কথা বুঝতে না পারলে ভদ্রভাবে repeat, explain, spell বা speak slowly বলতে clarification চাওয়া যায়।',
    formula: 'Could you + repeat/explain/speak slowly + please?',
    example: 'Could you repeat that, please?',
    optionBuilder: _clarificationOptions,
    hintBuilder: (_) => 'Could you বা Would you দিয়ে ভদ্র request তৈরি করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('Could you repeat that, please?', 'দয়া করে কথাটি আবার বলবেন?'),
      SpeakingSeed('Could you speak more slowly?', 'আপনি কি আরও ধীরে বলতে পারেন?'),
      SpeakingSeed('What do you mean by that?', 'আপনি এটি দিয়ে কী বোঝাতে চেয়েছেন?'),
      SpeakingSeed('Could you explain it again?', 'আপনি কি এটি আবার explain করবেন?'),
      SpeakingSeed('How do you spell that word?', 'শব্দটির spelling কীভাবে করবেন?'),
      SpeakingSeed('I am sorry, I did not understand.', 'দুঃখিত, আমি বুঝতে পারিনি।'),
      SpeakingSeed('Did you say fifteen or fifty?', 'আপনি fifteen নাকি fifty বলেছেন?'),
      SpeakingSeed('Could you give me an example?', 'আপনি কি আমাকে একটি example দেবেন?'),
      SpeakingSeed('Could you say the last part again?', 'আপনি কি শেষ অংশটি আবার বলবেন?'),
      SpeakingSeed('What does this word mean?', 'এই word-এর অর্থ কী?'),
      SpeakingSeed('Could you write it down, please?', 'দয়া করে এটি লিখে দেবেন?'),
      SpeakingSeed('Let me check if I understood correctly.', 'আমি সঠিকভাবে বুঝেছি কি না check করি।'),
      SpeakingSeed('Do you mean we should start now?', 'আপনি কি বোঝাতে চেয়েছেন আমাদের এখন শুরু করা উচিত?'),
      SpeakingSeed('Could you be more specific?', 'আপনি কি আরও specific বলতে পারেন?'),
      SpeakingSeed('I understand the first part, but not the second.', 'প্রথম অংশ বুঝেছি, কিন্তু দ্বিতীয়টি নয়।'),
      SpeakingSeed('Could you repeat the question, please?', 'প্রশ্ন না বুঝলে কী বলবে?', question: 'What will you say if you do not understand a question?'),
      SpeakingSeed('Do you mean the meeting is tomorrow?', 'Meeting-এর date নিশ্চিত করো।', question: 'How would you confirm the meeting date?'),
      SpeakingSeed('Could you explain it again?', 'ভুল বাক্যটি ঠিক করো: Could you explain me it again?'),
      SpeakingSeed('Did you say the room is on the third floor?', 'Hotel staff-এর কথা নিশ্চিত করো।'),
      SpeakingSeed('I am sorry, I missed the last part. Could you repeat it more slowly, please?', 'দীর্ঘ clarification request বলো।', question: 'How would you politely ask for repetition?'),
    ],
  );

  static final SpeakingRule _rule60 = SpeakingRuleFactory.create(
    id: 60,
    title: 'Confident Storytelling',
    explanation:
    'একটি ঘটনা সুন্দরভাবে বলতে beginning, sequence, detail এবং ending ব্যবহার করো। First, then, after that, because, finally দিয়ে বাক্য যুক্ত করো।',
    formula: 'Beginning + sequence + details/reason + ending',
    example: 'Yesterday, I went out. Then it rained, so I returned home.',
    optionBuilder: _storyOptions,
    hintBuilder: (_) => 'সময় দিয়ে শুরু করো, ঘটনাগুলো ক্রমে বলো এবং শেষে result বা feeling যোগ করো।',
    seeds: const <SpeakingSeed>[
      SpeakingSeed('Yesterday, I went to the market.', 'গতকাল আমি বাজারে গিয়েছিলাম।'),
      SpeakingSeed('First, I made a shopping list.', 'প্রথমে আমি shopping list তৈরি করেছিলাম।'),
      SpeakingSeed('Then, I took a bus to the market.', 'তারপর আমি bus-এ বাজারে গিয়েছিলাম।'),
      SpeakingSeed('After that, I bought some vegetables.', 'এরপর আমি কিছু সবজি কিনেছিলাম।'),
      SpeakingSeed('It started raining, so I waited in a shop.', 'বৃষ্টি শুরু হয়েছিল, তাই একটি দোকানে অপেক্ষা করেছিলাম।'),
      SpeakingSeed('Finally, I returned home safely.', 'সবশেষে আমি নিরাপদে বাসায় ফিরেছিলাম।'),
      SpeakingSeed('Last week, I met an old friend.', 'গত সপ্তাহে আমি পুরোনো বন্ধুর সঙ্গে দেখা করেছিলাম।'),
      SpeakingSeed('We talked about our school days.', 'আমরা school-এর দিনগুলো নিয়ে কথা বলেছিলাম।'),
      SpeakingSeed('I was nervous because I had to speak English.', 'English বলতে হয়েছিল বলে আমি nervous ছিলাম।'),
      SpeakingSeed('I spoke slowly, but the client understood me.', 'আমি ধীরে বলেছিলাম, কিন্তু client আমাকে বুঝেছিল।'),
      SpeakingSeed('The conversation went better than I expected.', 'Conversation আমার ধারণার চেয়ে ভালো হয়েছিল।'),
      SpeakingSeed('That experience made me more confident.', 'সেই experience আমাকে আরও confident করেছিল।'),
      SpeakingSeed('One day, my bus broke down on the road.', 'একদিন আমার bus রাস্তায় নষ্ট হয়েছিল।'),
      SpeakingSeed('While we were waiting, I spoke to another passenger.', 'অপেক্ষার সময় আমি আরেক passenger-এর সঙ্গে কথা বলেছিলাম।'),
      SpeakingSeed('In the end, another bus took us home.', 'শেষ পর্যন্ত অন্য একটি bus আমাদের বাসায় নিয়ে গিয়েছিল।'),
      SpeakingSeed('Yesterday, I worked and practiced English.', 'গতকাল কী করেছিলে?', question: 'What did you do yesterday?'),
      SpeakingSeed('I felt proud because I spoke without fear.', 'ঘটনার শেষে কেমন অনুভব করেছিলে?', question: 'How did you feel at the end?'),
      SpeakingSeed('Then, I called my friend.', 'ভুল বাক্যটি ঠিক করো: Then, I did called my friend.'),
      SpeakingSeed('First, I checked in. Then, I went to my room and finally rested.', 'Hotel check-in-এর ছোট story বলো।'),
      SpeakingSeed('At first, I could not speak English. Then I practiced every day, learned from mistakes, and finally became confident.', 'নিজের English learning journey বলো।', question: 'Can you tell your English-learning story?'),
    ],
  );

  static List<String> _opinionOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst('I think ', 'I am think ');
    final wrongTwo = correct
        .replaceFirst('In my opinion, ', 'In my think, ')
        .replaceFirst('I believe ', 'I am believe ')
        .replaceFirst('From my point of view, ', 'From me view, ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _agreementOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst('I agree ', 'I am agree ');
    final wrongTwo = correct.replaceFirst('I disagree ', 'I am disagree ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _suggestionOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst('Let’s ', 'Let’s to ');
    final wrongTwo = correct.replaceFirst('How about ', 'How about to ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _clarificationOptions(int id, String correct) {
    final wrongOne = correct.replaceFirst('Could you ', 'Could you to ');
    final wrongTwo = correct.replaceFirst('What do you ', 'What you do ');
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _storyOptions(int id, String correct) {
    final wrongOne = correct
        .replaceFirst('First, ', 'Finally, ')
        .replaceFirst('Then, ', 'Before first, ');
    final wrongTwo = 'Does $correct';
    return _options(id, correct, wrongOne, wrongTwo);
  }

  static List<String> _options(int id, String correct, String wrongOne, String wrongTwo) {
    return SpeakingRuleFactory.arrangeOptions(
      practiceId: id,
      correct: correct,
      wrongOne: wrongOne,
      wrongTwo: wrongTwo,
    );
  }
}
