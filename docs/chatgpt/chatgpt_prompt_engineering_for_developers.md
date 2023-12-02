# Guidelines for Prompting

## Principle 1: Write clear and specific instructions**

### Tactic 1: Use delimiters to clearly indicate distinct parts of the input

Delimiters can be anything like: ```, """, < >, `<tag> </tag>`, `:`

### Tactic 2: Ask for a structured output

For instance, ask for JSON, HTML, Markdown, etc.

### Tactic 3: Ask the model to check whether conditions are satisfied

For example: "If the text does not contain a sequence of instructions, then simply
write 'No steps provided.'"

### Tactic 4: "Few-shot" prompting

Example:

```text
Your task is to answer in a consistent style.

<child>: Teach me about patience.

<grandparent>: The river that carves the deepest \
valley flows from a modest spring; the \
grandest symphony originates from a single note; \
the most intricate tapestry begins with a solitary thread.

<child>: Teach me about resilience.
```

## Principle 2: Give the model time to “think”

### Tactic 1: Specify the steps required to complete a task

### Tactic 2: Instruct the model to work out its own solution before rushing to a conclusion

## Model Limitations: Hallucinations

ChatGPT might try to answer questions about obscure topics and can
make things up that sound plausible but are not actually true. This
kinds of fabricated ideas are called hallucinations.

In this example, Boie is a real company, the product name is not real:

```text
Tell me about AeroGlide UltraSlim Smart Toothbrush by Boie
```

## Iterative Prompt Develelopment

In this lesson, you'll iteratively analyze and refine your prompts to generate
marketing copy from a product fact sheet.

``` mermaid
---
title: Iterative Prompt Development
---
graph LR
  A[Idea] --> B[Implementation];
  B --> C[Experimental Result];
  C --> D[Error Analysis];
  D --> A;
```

Prompt development is an interative process where you
1. try something
2. analyze where the result did not give you what you want
3. clarify the instructions and/or give the model more time to think
4. Refine prompts with a batch of examples

The key to being an effective prompt engineer isn't about knowing the perfect
prompt. It is about having a good process to develop prompts that are effective
for your application.

## Summarizing

You can summarize articles so you have time to read many more articles.

### Summarize with a word/sentence/character count

Example using the browser plugin using ChatGPT 4:

```text
Summarize the review at the URL that follows in at most 200 words:
https://www.cnn.com/2023/06/10/politics/takeaways-trump-nauta-indictment/index.html
```

### Summarize with a particular focus

Focus the summary on what is more relevant to you.

```text
Summarize the review at the URL that follows in at most 200 words focusing on the details of the charges against Trump:
https://www.cnn.com/2023/06/10/politics/takeaways-trump-nauta-indictment/index.html
```

### Try "extract" instead of "summarize"

Extract exact information rather than producing a summary.

```text
Extract the number of charges against Trump in the following article:
https://www.cnn.com/2023/06/10/politics/takeaways-trump-nauta-indictment/index.html
```

## Inferring

Infer sentiment and topics from product reviews and news articles.

### Sentiment (positive/negative)

```text
What is the sentiment of the following article:
https://www.cnn.com/2023/06/10/politics/takeaways-trump-nauta-indictment/index.html
```

### Identify types of emotions

```text
Identify a list of emotions that the writer of the following review is expressing. Include no more than five items in the list. Format the result as a markdown list.

https://www.cnn.com/2023/06/10/politics/takeaways-trump-nauta-indictment/index.html
```

### Identify bias

```text
Read the following article and identify the bias shown by the author:
https://www.cnn.com/2023/06/10/politics/takeaways-trump-nauta-indictment/index.html
```

### Identify anger

```text
Read the following article and tell me if the writer is expressing anger:
https://www.cnn.com/2023/06/10/politics/takeaways-trump-nauta-indictment/index.html
```

### Extract specific information

```text
Identify the name of Trump's lawyer given in the following article:
https://www.cnn.com/2023/06/10/politics/takeaways-trump-nauta-indictment/index.html
```

### Infer topics

```text
Determine five topics that are being discussed in the following article.

Make each item one or two words long.

Format your response as a list of items separated by commas.

https://www.cnn.com/2023/06/10/politics/takeaways-trump-nauta-indictment/index.html
```

### Make a new alert for certain topics

```text
List the top news stories about former president Donald Trump that appear on the CNN home page at https://cnn.com. Format the results as a markdown list where each list item is a link to the article.
```

```text
List the top articles about the Apple Vision Pro that appear on the Ars Technica home page at https://arstechnica.com. Format the result as a markdown list of articles where each list item is a link to the article.
```

## Transforming

Large language models are very good at transforming its input to a
different format, such as inputting a
piece of text in one language and transforming
it or translating it to a different language,
or helping with spelling and grammar corrections.

This makes it great for use as a proof-reader.

### Translation

Translate text:

```text
Translate the following English text to Spanish:
"Hi, I would like to order a hamberger and french fries"
```

Determine the language of given text:

```text
Tell me which language this is:
"Combien coûte le lampadaire?"

Multiple translations at once:

```text
Translate the following  text to French and Spanish
and English pirate:
"Hi, I would like to order a hamberger and french fries"
```

```text
Translate the following text to Spanish in both the formal
and informal forms:
"Would you like to order a hamberger and french fries?"
```

```text
How would Yoda say "Hi, I would like to order a hamburger and french fries"
```

### Universal translator

Imagine you are in charge of IT at a large multinational e-commerce company. Users
are messaging you with IT issues in all their native languages. Your staff is from
all over the world and speaks only their native languages. You need a universal
translator!

```text
user_messages = [
  "La performance du système est plus lente que d'habitude.",  # System performance is slower than normal
  "Mi monitor tiene píxeles que no se iluminan.",              # My monitor has pixels that are not lighting
  "Il mio mouse non funziona",                                 # My mouse is not working
  "Mój klawisz Ctrl jest zepsuty",                             # My keyboard has a broken control key
  "我的屏幕在闪烁"                                               # My screen is flashing
]
```

```text
for issue in user_messages:
    prompt = f"Tell me what language this is: ```{issue}```"
    lang = get_completion(prompt)
    print(f"Original message ({lang}): {issue}")

    prompt = f"""
    Translate the following  text to English \
    and Korean: ```{issue}```
    """
    response = get_completion(prompt)
    print(response, "\n")
```

### Tone translation

What is tone in writing? Tone in writing is the attitude your words employ. Just
like tone of voice, tone in writing gives much more context beyond the words used.
It can reveal intention or conceal it.

Writing can vary based on the intended audience. ChatGPT can produce different tones.

```text
Translate the following from slang to a business letter:

Hey man, what the heck is going on with the Browser project. It looks like it is
hella late so I wanted to get the 411 from you before I blast that status to the
company.
```

**15 Types of Tone You Can Use in Your Writing**

Honing your prose style depends on what effect you wish to achieve. What tone do
you want to set? What feelings or mood do you want to evoke? What kind of language
will best deliver the story you want to tell? Many words can be used to describe
an author’s tone. If you’re writing a novel, short story, or poem, you might consider
your tone to be one or more of the following:

1. Cheerful
2. Dry
3. Assertive
4. Puckish
5. Lighthearted
6. Facetious
7. Regretful
8. Humorous
9. Pessimistic
10. Nostalgic
11. Joyful
12. Sarcastic
13. Persuasive
14. Uneasy
15. Inspirational

### Format conversion

ChatGPT can translate between formats. The prompt should describe the input and
output formats.

```text
Output the following JSON into an HTML table with column headerss and title:

[
  {
    "firstName": "John",
    "lastName": "Doe",
    "joinDate": "2023-01-02"
  },
  {
    "firstName": "Jane",
    "lastName": "Smith",
    "joinDate": "2022-06-15"
  },
  {
    "firstName": "Mike",
    "lastName": "Johnson",
    "joinDate": "2021-12-25"
  }
]
```

### Spell check / grammer check

To signal to the LLM that you want it to proofread your text, you instruct the
model to 'proofread' or 'proofread and correct'.

```text
Proofread and correct the each of the following quoted lines of text and rewrite
the corrected version. If you don't find and errors, just say "No errors found".
Don't use any punctuation around the text:

"The girl with the black and white puppies have a ball.",  # The girl has a ball.
"Yolanda has her notebook.", # ok
"Its going to be a long day. Does the car need it’s oil changed?",  # Homonyms
"Their goes my freedom. There going to bring they’re suitcases.",  # Homonyms
"Your going to need you’re notebook.",  # Homonyms
"That medicine effects my ability to sleep. Have you heard of the butterfly affect?", # Homonyms
"This phrase is to cherck chatGPT for speling abilitty"  # spelling

```

## Expanding

Expanding is the task of taking a shorter piece of text, such as a set of
instructions or a list of topics, and having the large language model generate a
longer piece of text, such as an email or an essay about some topic.

### Automated reply to a customer email

```text
You are a customer service AI assistant. Your task is to send an email reply to a
valued customer. Given the customer email delimited by ---, Generate a reply to thank
the customer for their review. If the sentiment is positive or neutral, thank them
for their review. If the sentiment is negative, apologize and suggest that they can
reach out to customer service. Make sure to use specific details from the review.
Write in a concise and professional tone. Sign the email as `AI customer agent`.

---
So, they still had the 17 piece system on seasonal sale for around $49 in the month
of November, about half off, but for some reason (call it price gouging) around the
second week of December the prices all went up to about anywhere from between $70-$89
for the same system. And the 11 piece system went up around $10 or so in price also
from the earlier sale price of $29. So it looks okay, but if you look at the base,
the part where the blade locks into place doesn’t look as good as in previous
editions from a few years ago, but I plan to be very gentle with it (example, I crush
very hard items like beans, ice, rice, etc. in the blender first then pulverize them
in the serving size I want in the blender then switch to the whipping blade for a
finer flour, and use the cross cutting blade first when making smoothies, then use
the flat blade if I need them finer/less pulpy). Special tip when making smoothies,
finely cut and freeze the fruits and vegetables (if using spinach-lightly stew soften
the spinach then freeze until ready for use-and if making sorbet, use a small to
medium sized food processor) that you plan to use that way you can avoid adding so
much ice if at all-when making your smoothie. After about a year, the motor was
making a funny noise. I called customer service but the warranty expired already, so
I had to buy another one. FYI: The overall quality has gone done in these types of
products, so they are kind of counting on brand recognition and consumer loyalty to
maintain sales. Got it in about two days.
---
```

Another possibility:

```text
You are a customer service AI assistant. Your task is to send an email reply to a
valued customer. Given the customer email delimited by ---, generate 3 possible
emails responses each with a different tone to thank the customer for their review.
If the sentiment is positive or neutral, thank them for their review. If the
sentiment is negative, apologize and suggest that they can reach out to customer
service. Make sure to use specific details from the review. Sign the email as `AI
customer agent`.
```

### Remind the model to use details from the customer's email
