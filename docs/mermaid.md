# Mermaid

Mermaid is a JavaScript based diagramming and charting tool that renders
Markdown-inspired text definitions to create and modify diagrams dynamically.

[Using Mermaid for each GitHub diagrams in Markdown-ish code](https://blog.jakelee.co.uk/using-mermaid-for-diagrams-on-github/)
gives comprehensive Mermaid cheatsheets for each Mermaid graph type.

This page includes Mermaid example diagrams.

## Class Diagram

```mermaid
---
title: A Model of Online School
---
classDiagram
  title This is the Title
  Person <|-- Student
  Person <|-- Professor
  Person : +String name
  Person : +String phoneNumber
  Person : +String emailAddress
  Person: +purchaseParkingPass()
  Address "1" <-- "0..1" Person:lives at
  class Student{
    +int studentNumber
    +int averageMark
    +isEligibleToEnrol()
    +getSeminarsTaken()
  }
  class Professor{
    +int salary
  }
  class Address{
    +String street
    +String city
    +String state
    +int postalCode
    +String country
    -validate()
    +outputAsLabel()
  }
```

## Entity Relationship Diagram

``` mermaid
---
title: Invoicing Entity Relationship Diagram
---
erDiagram
  CUSTOMER }|..|{ DELIVERY-ADDRESS : has
  CUSTOMER ||--o{ ORDER : places
  CUSTOMER ||--o{ INVOICE : "liable for"
  DELIVERY-ADDRESS ||--o{ ORDER : receives
  INVOICE ||--|{ ORDER : covers
  ORDER ||--|{ ORDER-ITEM : includes
  PRODUCT-CATEGORY ||--|{ PRODUCT : contains
  PRODUCT ||--o{ ORDER-ITEM : "ordered in"
```

## Flow Chart

A flowchart is a type of diagram that represents an algorithm, workflow or
process. The flowchart shows the steps as boxes of various kinds, and their
order by connecting the boxes with arrows. This diagrammatic representation
illustrates a solution model to a given problem.

``` mermaid
---
title: Fix Error Flow Chart
---
graph LR
  A[Start] --> B{Error?};
  B -->|Yes| C[Hmm...];
  C --> D[Debug];
  D --> B;
  B ---->|No| E[Yay!];
```

## Gaant Diagram

``` mermaid
---
title: Transformation Gantt Chart
---
gantt
  dateFormat  YYYY-MM-DD

  section Transformation Work
    Project Start:     milestone, m0, 2022-01-05, 0d
    Feasibility Study: done,      task1, after m0, 2022-01-08
    Real Work Begins:  milestone, m1, after task1, 0d
    Design:            active,    tast2, 2022-01-09, 4d
    Coding:                       task3, after tast2, 10d
    Acceptance:        crit,      task4, after task3, 5d
    Project End:       milestone, m2, after task4, 0d
```

## GitGraph Diagram

``` mermaid
---
title: GitGraph Diagram
---
%%{init: { 'gitGraph': { 'mainBranchName': 'master'}} }%%
gitGraph
  commit
  commit
  branch develop
  checkout develop
  commit
  commit
  checkout master
  merge develop
  commit
  commit
```

## Pie Chart

``` mermaid
---
title: Pets Adopted by Volunteers
---
pie
  "Dogs" : 386
  "Cats" : 85
  "Rats" : 15
```

## Sequence Diagram

``` mermaid
---
title: Sequence Diagram
---
sequenceDiagram
  Alice->>John: Hello John, how are you?
  loop Healthcheck
      John->>John: Fight against hypochondria
  end
  Note right of John: Rational thoughts!
  John-->>Alice: Great!
  John->>Bob: How about you?
  Bob-->>John: Jolly good!
```

## State Diagram

``` mermaid
---
title: State Diagram
---
stateDiagram-v2
  state fork_state <<fork>>
    [*] --> fork_state
    fork_state --> State2
    fork_state --> State3

    state join_state <<join>>
    State2 --> join_state
    State3 --> join_state
    join_state --> State4
    State4 --> [*]
```
