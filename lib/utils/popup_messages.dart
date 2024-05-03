import 'dart:math';

class PopupMessages {
  static final List<String> messages = [
    "there is no rain that does not stop",
    "when are you going to do it? Now!!",
    "the only impossible journey is the one you never begin",
    "Life is really simple, but we insist on making it complicated",
    "All you need in this life is ignorance and confidence, and then success is sure",
    "Being honest may not get you many friends but it’ll always get you the right ones",
    "Do what you feel in your heart to be right – for you’ll be criticized anyway",
    "The best and most beautiful things in the world cannot be seen or even touched — they must be felt with the heart",
    "If you don’t like where you are, change it. You’re not a tree",
    "If you’re not doing some things that are crazy, then you’re doing the wrong things",
    "Things may come to those who wait, but only the things left by those who hustle",
    "Action is the foundational key to all success",
    "All your dreams can come true if you have the courage to pursue them",
    "Sometimes things fall apart so that better things can fall together",
    "Sometimes the questions are complicated and the answers are simple",
    "Be healthy and take care of yourself, but be happy with the beautiful things that makes you, you",
    "Although the world is full of suffering, it is also full of the overcoming of it.",
    "If you can't fly then run, if you can't run then walk, if you can't walk then crawl, but whatever you do, you have to keep moving forward.",
    "If you were born without wings, do nothing to prevent them from growing.",
    "We're here for a reason. I believe a bit of the reason is to throw little torches out to lead people through the dark",
    "The great gift of human beings is that we have the power of empathy",
    "It always seems impossible until it’s done.",
    "Twenty years from now, you will be more disappointed by the things that you didn't do than by the ones you did do, so throw off the bowlines, sail away from safe harbor, catch the trade winds in your sails. Explore, Dream, Discover.",
    "If somebody hurts you, it’s okay to cry a river: Just remember to build a bridge and get over it.",
    "Unable are the loved to die, for love is immortality.",
    "Above all, be the heroine of your life, not the victim",
    "The past is gone, the future is not here, now I am free of both. Right now, I choose joy",
    "Where there is no struggle, there is no strength",
    "I don't like to lose — at anything — yet I've grown most not from victories, but setbacks.",
    "The thought that you could die tomorrow frees you to appreciate your life now.",
    "Promise me you'll always remember: You're braver than you believe, stronger than you seem, and smarter than you think",
    "Remember, no one can make you feel inferior without your consent",
    "Pain is temporary. It may last a minute, or an hour, or a day, or a year, but eventually it will subside and something else will take its place",
    "We must accept finite disappointment, but never lose finite hope",
    "To be good, and to do good, is all we have to do",
    "Heroes may not be braver than anyone else. They’re just braver five minutes longer",
    "Yesterday is not ours to recover, but tomorrow is ours to win or lose",
    "Your time is limited, so don't waste it living someone else's life",
    "A hero is an ordinary individual who finds the strength to persevere and endure in spite of overwhelming obstacles.",
    "Anyone who claims to be a leader must speak like a leader. That means speaking with integrity and truth",
    "I’d rather regret the things I’ve done than regret the things I haven’t done",
    "You are the one that possesses the keys to your being. You carry the passport to your own happiness",
    "I was brought up to understand that we are all on this planet Earth together.",
    "If you remain calm in the midst of great chaos, it is the surest guarantee that it will eventually subside",
    "One part of wisdom is knowing what you don't need anymore and letting it go.",
    "The way I see it, if you want the rainbow, you gotta put up with the rain!",
    "I've learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel",
    "Be faithful in small things because it is in them that your strength lies",
    "It is through art that we will prevail and we will endure. It lives on after us and defines us as people",
    "Just because you fail once doesn't mean you're gonna fail at everything",
    "There is no normal life that is free of pain. It’s the very wrestling with our problems that can be the impetus for our growth",
    "You are enough just as you are",
    "Life is like a bicycle. To keep your balance, you must keep moving",
    "Only in the darkness can you see the stars",
    "Setting goals is the first step in turning the invisible into the visible",
    "Keep your face to the sunshine and you cannot see a shadow",
    "You do not find the happy life. You make it",
    "I think that if you live long enough, you realize that so much of what happens in life is out of your control — but how you respond to it is in your control.",
    "It's not whether you get knocked down; it's whether you get up",
    "Try to be a rainbow in someone’s cloud.",
    "No act of kindness, no matter how small, is ever wasted.",
    "A winner is a dreamer who never gave up",
    "Lead from the heart, not the head.",
    "Know what sparks the light in you. Then use that light to illuminate the world",
    "Choose to be optimistic, it feels better",
    "You only live once, but if you do it right, once is enough",
    "The key to life when things get tough is to just keep moving. Just keep moving",
    "Don't try to lessen yourself for the world; let the world catch up to you",
    "To succeed in life, you need two things; ignorance and confidence",
    "Nothing in life is to be feared. It is only to be understood",
    "You will live a dull and boring life if you do not take risks",
    "Once you stop learning, you start dying",
    "If your dreams do not scare you, they are not big enough",
    "In order to realize our true self we must be willing to live without being dependant upon the opinion of others",
    "If today were the last day of your life, would you want to do what you are about to do today",
    "It is not the strongest of the species that survives, nor the most intelligent that survives. It is the one that is most adaptable to change",
    "I’m a success today because I had a friend who believed in me and I didn’t have the heart to let him down",
    "I never lose. I either win or learn",
    "A pessimist sees the difficulty in every opportunity; an optimist sees the opportunity in every difficulty",
    "No man will make a great leader who wants to do it all himself or get all the credit for doing it",
    "Being honest may not get you many friends but it’ll always get you the right ones",
    "Honesty is a very expensive gift. Don’t expect it from cheap people",
    "We cannot learn without pain",
    "No man can become rich without himself enriching others",
    "It takes a lifetime to build reputation, and it can be ruined in five minutes. If you really think about that, you might behave differently",
    "Don’t let the noise of others’ opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition. They somehow already know what you truly want to become. Everything else is secondary",
    "Success isn’t about how much money you make, it’s about the difference you make in people’s lives",
    "Faith is taking the first step even when you don’t see the whole staircase",
    "An investment in knowledge pays the best interest",
    "Believe nothing, no matter where you read it or who has said it, not even if I have said it, unless it agrees with your own reason and your own common sense",
    "Stay hungry, stay foolish",
    "Failure is an option here. If things are not failing, you are not innovating enough",
    "Risk comes from not knowing what you’re doing",
    "You should learn from your competitor, but never copy. Copy and you die",
    "Control your own destiny or someone else will",
    "You don’t need to have a 100-person company to develop that idea",
    // 他にもメッセージを追加
  ];

  static String getRandomMessage() {
    final random = Random();
    return messages[random.nextInt(messages.length)];
  }
}
