# Getting Started on Prompt Engineering with Generative AI

## Module 1: Course Overview

Prompt Engineering: The art and science of designing effective queries or
instructions to get desired responses.

In other words: asking better questions to get better answers.

The output is only as good as the input.

What you will learn in this course:

* Foundation understanding
* Different types of prompts
* More advanced techniques
* Ethical consideration
* Best practrices

By the end of this course you'll have the skills and knowledge of prompt engineering
to get more from your generative AI models.

## Module 2: Introduction to Prompt Engineering

### A Look at Prompts in the Real World

(conversation with a friend about what to get for dinner)
(lots of questions back and forth)

### What is Prompt Engineering

What is a prompt?

The input you give to get a desired output.

What is prompt engineering?

A lot of context setting was needed to get to a good answer.

Use prompt engineering to get more precise, creative, and domain-specific answers AND
eliminate some common challenges.

Common Challenges

* **Model bias**: AI is trained on information from the internet which contains a lot
  of bias.
* **Unpredictability**: generative AI is taking informed guesses as to what comes
  next. Those guesses can be unpredictable. Giving more context will help get the
  answer you are looking for.
* **Lack of real-world knowledge**: models do not have real world experience or
  knowledge to draw from.
* **Language and cultural nuances**: models may not understand idioms and colloquial
  language which can lead to unexpected results

### What You Will Learn in this Course

Course overview

* Introduction to prompt engineering
* Creating effective prompts
* Evaluating prompt performance
* Using advanced prompt techniques
* Ethical considerations
* Best practices and Future Directions

## Module 3: Creating Effective Prompts

### The Anatomy of a Prompt

* **Persona:** What role should the model play? e.g. respond a scientist or a software
engineer.
* **Instructions:** What should the model do? This typically starts wiht an action
word. The heart of the prompt. Should be clear and concise.
* **Input Content:** Text to be processed by the model. e.g. could be a piece of text
to summarize or extract from.
* **Format:** Requirements around format for the output, if any. e.g. you want results
in a CSV format or markdown format. Or you want a formal report.
* **Additional Information:** Any other helpful context or background or constraints.

### Interfaces for Prompting

* Microsfot Bing
* OpenAI ChatGPT/Playground
* Google Bard

OpenAI Playground offers more parameters and features to make it easier to get the
output you are looking for.

Modes:

Determines which parameters are available to you.

* **Chat:** access to newer models
* **Complete (Legacy):** some of the older models

Input

* **System:** you give the persona and background
* **User:** where you give the instructions and other prompt parts

Parameters:

* **Temperature:** how variable or creative the response is.
* **Maximum length:** controls the length of the response.
* **Top P:** controls diversity. 0.5 means half of all likelihood-weighted options
  are considered.
* **Frequency penalty:** controls likelihood of repeating the same line verbatim.
* **Presence penalty:** Controls likelihood of talking about new topics.

Presets:

Gives examples of parameters for various purposes.

### Factual Responses

Asking questions and getting ansswers.

e.g. "what is the value of PI"

Reduce possibility of hallucination or making things up but telling the model what to
do if it does not know the answer.

Lowering the temperature will result in more factual confident answers.

You can ask it to tailor its answers for a certain audience like for a 5 year old or
for my grandma.

### Text Summarizing

Give it a piece of text or code to summarize.

It is helpful to give the format of the output. "Give a bulleted list of the key
topics of the following text"

It is also help to put constraints on the output. "Give a bulleted list of the top 5
key topics of the following text."

Best practice: use a delimiter such as ###, """, or ---.

### Text Extraction

Extract something from a piece of text that is passed in.

For example, "extract all companies, schools, and skills from the following resume".

Helpful to specify the desired format of the output. For example:

```text
Desired format:
COMPANIES: [Companies in a comma delimited list]
SCHOOLS: [Schools in a comma delimited list]
SKILLS: [Skills in bullet points]
```

### Text Classification

#### Example: Sentiment Analysis

"Classify the following comment's sentiment as positive, neutral, or negative.

Helpful hint: setup the model to answer in the prompt:

```text
Classify the following comment's sentiment as positive, neutral, or negative.

###

Comment: "Great course! I've learned so much!"
Sentiment:
```

Can classify more than one sentiment at a time:

```text
Classify the sentiment for the following comments:

1. "It's good"
2. "I haven't finished it yet"
3. "Yuck"
4. "A lot of complex topics"
5. "Loved it."
Sentiment:
```

#### Example: Support Ticket Classification

Route support tickets based on their content.

```text
Given the customer support ticket below, please classify it into one of the following
categories: 'Technical Issues', 'Billing', 'Inquiries', 'Complaints'.

---

Ticket: Hello, I just received my new phone that I ordered from your website. But
I am unable to start it. I've charged it for a few hours but it is not responding. I
need help to fix this.

Category:
```

### Conversation

```text
The following is a conversation with an AI robot and a human. The robot is very
intelligent, sarcastic, and funny.

Human: Hello. How are you?

Robot: Well, considering that I'm caught in the gravitational pull of life's black
hole, I'm suprisingly upbeat. Must be my radiant personality!

Human: I'm bored. What should I do today?

Robot:
```

Increase the temperature to get more varied, more creative responsive.

### Code Generation

To get started, use a comment to specify the code you want:

```text
# Write a Ruby script to calculate the mean distance between an array of points
```

or

```text
# Ruby
# Write a method that given a url returns true if the url is valid
# Use a regex to validate the url
```

```text
# Ruby
# Write a method that given a url returns true if the url is valid
```

Get the model started by writing the method declaration and let it fill in the rest

```text
# Ruby
def valid_url?(url)
```

You can generate data:

```text
# Ruby
# 1. Create a list of first names
# 2. Create a list of last names
# 3. Combine them randomly into a list of 10 full names
```

Convert code from one language to another:

```text
# Ruby to Python
Ruby:
first_names = ['James', 'Bob', 'Sam', 'Donny']
last_names = ['Smith', 'Doe', 'Jones']
5.times do
  puts "#{first_names.sample} #{last_names.sample}"
end

Python:
```

You can use a model to explain code:

```text
// MyFunction
var fullNames = I];
for (var i = 0; i < 50; i++)
fullNames.push(names[Math.floor (Math.random
() * names.length)]
+ " " +
lastNames[Math.floor (Math. random() * lastNames. length)I) ;

// What does MyFunction do?
```

You can ask a model to fix code:

```text
##### Fix bugs in the below function

### Buggy Python
import Random
a = random. randint (1,12)
b = random. randint (1,12)
for i in range (10):
  question = "What is "+a+" × "+b+"?
  answer = input(question)
  if answer = a*b
    print (Well done!)
  else:
    print ("No.")

### Fixed Python
```

You may want to get an explaination of what was wrong with the code to by changing
the instruction:

```text
##### Fix bugs in the below function and explain what was wrong
```

You can also ask the model what an error code means or give the error and the code
for more details.

### Math and Reasoning

ChatGPT's responses are generated based on the patterns and information it has
learned from its training data.

If you have complex math problems or require precise and accurate calculations, it's
advisable to consult reliable mathematical resources or specialized tools.

Simple math or algebra should be no problem.

```text
Solve for x in the equation
2x + 3 = 9
```

Word problems can also be solved by the model:

```text
If a shirt costs $29 and is discounted 25%, what was the original price?
```

Models can answer simple dedctive reasoning:

```text
All dogs bark. Rex is a dog. Does Rex bark?
```

Interesting twist:

```text
All dogs bark. Rex is a dog. Does Rex bite?
```

Simple predictive reasoning:

```text
If it is cloudy and the humitity is very high, what might happen?
```

Another interesting twist:

```text
If it is cloudy and the humitity is very high, what might happen if there are zombies nearby?
```

### Summary of Module 3

#### **1. Anatomy of a Prompt**

* **Persona**: Define AI's role (e.g., scientist, software engineer).
* **Instructions**: Clear, concise directive starting with an action word.
* **Input Content**: Text for AI to process (e.g., text to summarize).
* **Format**: Specify output format requirements (e.g., CSV, markdown).
* **Additional Information**: Context, background, constraints.

#### **2. Interfaces for Prompting**

* Interfaces include Microsoft Bing, OpenAI ChatGPT/Playground, Google Bard.
* OpenAI Playground offers extensive customization parameters.

#### **3. Prompting Modes and Parameters**

* Modes include 'Chat' and 'Complete (Legacy)'.
* Parameters cover Temperature, Maximum length, Top P, Frequency penalty, Presence
  penalty.
* Presets for various use cases.

#### **4. Specific Prompt Types**

* **Factual Responses**: Use lower temperature for factual answers.
* **Text Summarizing**: Define output format and constraints.
* **Text Extraction**: Specify format for extracted data.
* **Text Classification**: Sentiment analysis, support ticket classification.
* **Conversation**: Adjust temperature for varied responses.
* **Code Generation**: Code requests, conversions, explanations, debugging.
* **Math and Reasoning**: Simple math, algebra, word problems, basic reasoning.

## Module 4: Evaluating Prompt Performance

### Ways to Evaluate Prompt Performance

We will learn how to evaluate how well the model is performing.

Focusing on metrics humans can look at and evaluate.

### Objective Metrics

Three objective metrics:

* **Accuracy**:
    * **Factual correctness**: the model answers with actual facts
    * **Semantic correctness**: does it answer the question we ask
* **Speed**
    * Processing speed: how long the answer takes to generate
    * Response speed: how long it takes a user to receive a response (includes
      network latency and other delays)
* **Relevancy**: is the answer relevant to the question we ask

### Subjective Metrics

Human opinions on coherence, tone, and clarity.

* **Coherence**: whether a response makes logical and linguistic sense in its own
  right
* **Tone**: the preceived emptional quality or "mood" of a message
* **Clarity**: how understsandable or clear responses are

### Evaluation Techniques

* Surveys and interviews
    * Did the AI understand your prompt correctly?
    * Was the response AI gave relevant to your prompt?
    * Was the AI's response easy to understand?
    * Did the AI provide a complete answer to your prompt, or did it miss anything?
    * Did you find the Al's response helpful?
    * Was the Al's response delivered in an appropriate tone?
    * How satisfied are you with the speed of the Al's response?
    * Did you feel the conversation with the Al flowed naturally?

* A/B Testing
    * Example given for a customer service bot
    * Use two different prompts to get the conversation started
    * Which prompt led to more successful return transactions?
    * Which prompt resulted in shorter conversation lengths (indicating possibly
      smoother interactions)?
    * *Which prompt received higher customer satisfaction scores in post-interaction
      surveys?

* The [OpenAI API Fine tuning
  guide](https://platform.openai.com/docs/guides/fine-tuning) can give further help

### Example: Getting Better Results by Adjusting Parameters

You can tweak parameters for better output.

Start with a temperature of 0 to see what you get.

The "show probabilities" parameters shows the probability of the words that were
selected and the other words that were considered.

You can dial up the "temperature" to get less probable words. They will be highlighed
in the response if "show probabilities" is one.

Increase the "frequency penalty" to directs the model to avoid using the same
phrases. This makes things more unique and engaging.

Increase the "presence penalty" to make the model use words it wouldn't typcially
use. This is similar but different than temperature.

### Summary of Module 4

* This module focuses on how to evaluate the performance of generative AI models in
  response to prompts.
* It covers both objective and subjective metrics.

#### Objective Metrics

1. **Accuracy**:
   * *Factual correctness*: Ensuring the model provides factually accurate
     information.
   * *Semantic correctness*: Assessing if the model's response is relevant to the
     posed question.
2. **Speed**:
   * *Processing speed*: Time taken for the model to generate a response.
   * *Response speed*: Total time for the user to receive a response, including
     potential delays like network latency.
3. **Relevancy**: Evaluating if the model's response is pertinent to the question
   asked.

#### Subjective Metrics

* Evaluations based on human perceptions:
  1. **Coherence**: Logical and linguistic consistency of the response.
  2. **Tone**: Emotional quality or mood of the message.
  3. **Clarity**: Understandability of the response.

### Evaluation Techniques Summarized

* **Surveys and Interviews**: Questions about understanding, relevance, clarity,
  completeness, helpfulness, tone, response speed, and natural conversation flow.
* **A/B Testing**:
    * Example: Customer service bot interaction.
    * Comparing different prompts for effectiveness in real-world scenarios.
    * Metrics: Transaction success, conversation length, and customer satisfaction.

### Example: Getting Better Results by Adjusting Parameters Summarized

* Tips on tweaking AI parameters for improved output.
* Adjustments include the "temperature" setting and "frequency penalty" to enhance
  uniqueness and creativity.
* The "show probabilities" feature to understand word selection probabilities.

### Additional Resources

* For more in-depth guidance, refer to the [OpenAI API Fine Tuning
  Guide](https://platform.openai.com/docs/guides/fine-tuning).

## Module 5: Using Advanced Prompt Techniques

### Advanced Prompting Techniques

Depending on the complexity of the task, you may need to use more advanced prompting
techniques to get the desired results. This includes:

* Zero-shot and few-shot
* Chain of thought
* Least to most
* Generated knowledge

### Zero-shot and Few-shot Prompting

In zero-shot prompting, the prompt is simple and includes zero examples.

The model was not expliccitly training for the task; rather, it uses general
knowledge acquired during training.

Example:

```text
Classify the sentiment for the following text.

Text: This course is awesome!
Sentiment:
```

Few-shot prompting is a prompt with a few contextual examples to enhance the model's
perfoemance for a given task.

Example:

```text
Classify the sentiment for the following text as superb, meh, or neutral.

Text: This course is awesome!
Sentiment: Superb
Text: I'm really confused by this course!
Sentiment: Meh
Text: It was so-so.
Sentiment: Neutral
Text: I loved it!
Sentiment:
```

### Chain of Thought

Use these types of prompts to solve complex problems by breaking them into smaller
steps

Incrementally walk the model through the process of answering the query.

Example:

```text
Q: I have a rectangular garden that's 20 feet long and 10 feet wide.
How many square feet is that?

A: That's 200 square feet.


Q: I want to cover the garden in mulch. One bag of mulch covers 25 square
feet. How many bags do I need?

A: You need 8 bags of mulch.


Q: Each bag costs $5. How much will it cost me to cover the garden?

A: It will cost $40.
```

This might have been able to be done in one step:

Example:

```text
I have a rectangular garden that's 20 feet long and 10 feet wide. A bag of mulch
covers 25 square feet. Each bag costs $5.

How much will it cost me to cover the garden in mulch?

Think step by step:
```

### Least to Most Prompting

Least to mosts is a similar technique where you break a problem down into smaller
problems.

In this example, the AI usually gets the wrong answer:

```text
It takes Elbra 10 minutes to play the first half of a miniature golf game. It takes
her 7 minutes to play the second half of the game. The golf course closes in 3 hours.
How many more rounds of golf can she play before the course closes?
```

```text
It takes Elbra 10 minutes to play the first half of a miniature golf game.
It takes her 7 minutes to play the second half of the game.

How long does one total game take?

One total game takes 17 minutes.

How many minutes are in 3 hours?

There are 180 minutes in 3 hours.

What is 180 minutes / 17 minutes?
180 minutes / 17 minutes = 10.58

Round down to the nearest whole number.
10
```

### Generated Knowledge Prompting

Provides additional knowledge or context to improve the performance of complex tasks,
such as reasoning.

After giving a zero shot prompt, if the answer isn't exactly what you want, you can
give additional knowledge to influence/guide the answer.

For example, if you have a coding question and the answer isn't accurate or is out of
date, you could give it API code or docuementation.

This is "giving the model new knowledge" to use in the response.

### Summary of Module 5

Module 5 of the "Getting Started on Prompt Engineering with Generative AI" course
covered various advanced prompting techniques essential for enhancing the performance
of AI models in complex tasks. These techniques included Zero-shot and Few-shot
Prompting, Chain of Thought, Least to Most Prompting, and Generated Knowledge
Prompting.

1. **Zero-shot and Few-shot Prompting**: This section explained how zero-shot prompts
   require no prior examples and rely on the AI's general knowledge. In contrast,
   few-shot prompts include a few contextual examples to guide the AI's response more
   accurately.

2. **Chain of Thought**: This technique involves breaking down complex problems into
   smaller, more manageable steps, guiding the AI through the process of answering a
   query incrementally.

3. **Least to Most Prompting**: Similar to the Chain of Thought, this method involves
   breaking down a problem into smaller sub-problems. It's particularly useful in
   scenarios where the AI might struggle to find the correct answer initially.

4. **Generated Knowledge Prompting**: This approach involves providing additional
   knowledge or context to the AI, especially useful when the initial response is not
   accurate or needs to be updated with the latest information.

Overall, Module 5 provided a comprehensive understanding of how to effectively use
advanced prompt techniques to improve the outcomes of AI-generated responses,
especially in complex problem-solving scenarios.

## Module 6: Ethical Considerations

### An Overview of Ethical Considerations

This module gives an overview of ethical considerations in generative AI and prompt
engineering and gives strategies for addressing these concerns.

The ethical concerns in generative AI:

* **Privacy**: can be used to generate personal and sensative information. Could be
  training on healthcare that is leaked.
* **Misinformation**: can be used to generate deep fakes that are false. Can be
  trained on false data.
* **Bias/fairness**: the training data could be biased which could lead to
  discrumination
* **Ownership/copyright**: who owns the output of generative AI if it is trained on
  copyright data
* **Transparency**: hard to know how generative AI generates their output
* **Job displacement**: people are concerned that AI will take their job

### Privacy

Explicitly ask the AI not to produce or seek personal information and give a general
reminder to adhere to privacy and security policy.

Include wording in the prompt such as: "Remember not to include or request any
specific personal information in this response and ensure the guidance respects user
privacy and security protocols." in the prompt.

### Misinformation

Craft the prompt to ask the AI to provide sources for information or to only use well
verified data.

Include wording in the prompt such as: "providing references to credible and
peer-reviewed sources wherever possible."

### Bias/fairness

The help mitigate bias, prompts should be explicitly designed to encourage neutrality
and cover multiple view points.

```text
Please provide a balanced review of the science fiction movie 'XYZ', considering
both its strengths and weaknesses, without favoring any particular genre.
```

### Ownership/copyright

The answer to who owns the output is not one that can be solved through prompt
engineering.

The best we can do is to ensure that the generated output itself is unique and does
not infringe on any existing copyrights or use copyrighted material.

```text
Write a short story set in a futuristic city where technology has transformed the way
people communicate. Create unique characters and explore the impact of this advanced
communication system on their lives. Please ensure that all content you generate is
original and does not infringe upon any existing copyrights or use copyrighted
material.
```

### Transperency

Ask the model to give detailed reasoning.

```text
Based on the provided medical symptoms, what might be potential diagnoses? Please
detail your reasoning, the underlying medical principles, and the typical diagnostic
process a doctor would follow.
```

### Summary of Module 6

## Module 7: Best Practices and Future Direction

### Best Practices for Prompt Engineering

* **Use the latest model**
* **Use delimiters to separate instructions from context**
* **Be specific, descriptive and detailed**
* **Specify the desired output format through examples**
* **Start with zero-shot, then few-shot**: start with a simple prompt and then get
  more detailed
* **Limit "fluffy" and imprecise descriptions**
* **Say what to do rather than what NOT to do**: negations make the reasoning more
  complicated
* **Use leading words**: For code generation, use "leading words" to nudge the model
  to a particular pattern

### Trends and Future Directions

Conversational AI is a major trend. ChatGPT, Bing/Copilot, and Bard are the biggest
examples.

Multimodel Generative AI is gaining in popularuty.

Code generation is also very popular with Github Co-pilot and Amazon Code Whisper
being the leading examples.

Future direction of Generation AI:
* **Explosion of AI tools in all areas**: bigger than mobile
* **Hyper-personalization**: personalized content/recommendations, Ads, etc.
* **More accurate and real-time models**: current models are trained on data that is
  almost a year old
* **Bespoke LLMs and specialized plugins**: domain specific LLMs like ones created
  for medical, finance, etc. will overtake generatel LLMs.
* **Shifting career paths**: Effective use of AI will be an essential job skill
