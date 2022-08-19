# Contributing to QBCore

First of all, thank you for taking the time to contribute!

These guidelines will help you help us in the best way possible regardless of your skill level. We ask that you try to read everything related to the way you'd like to contribute and try and use your best judgement for anything not covered.

### Table of Contents

[Code of Conduct](#code-of-conduct)

[I don't want to read this whole thing, I just have a question!!!](#i-dont-want-to-read-this-whole-thing-i-just-have-a-question)

[How Can I Contribute?](#how-can-i-contribute)
  * [Reporting Bugs](#reporting-bugs)
  * [Suggesting Features / Enhancements](#suggesting-features--enhancements)
  * [Your First Code Contribution](#your-first-code-contribution)
  * [Pull Requests](#pull-requests)

[Styleguides](#styleguides)
  * [Git Commit Messages](#git-commit-messages)
  * [Lua Styleguide](#lua-styleguide)
  * [JavaScript Styleguide](#javascript-styleguide)



## Code of Conduct

- Refrain from using languages other than English.
- Refrain from discussing any politically charged or inflammatory topics.
- Uphold mature conversations and respect each other; excessive profanity, hate speech or any kind of harassment will not be tolerated.
- No advertising of any kind.
- Follow these guidelines.
- Do not mention members of github unless a question is directed at them and can't be answered by anyone else.
- Do not mention any of the development team for any reason. We will read things as we get to them.

## I don't want to read this whole thing I just have a question!!!

> **Note:** Please don't file an issue to ask a question. You'll get faster results by using the resources below.

* [QBCore Website](https://qbcore.org)
* [QBCore Discord](https://discord.gg/qbcore)
* [FiveM Discord - #qbcore channel](https://discord.gg/fivem)










## How Can I Contribute?

### Reporting Bugs

The easiest way to contribute for most people is just to report bugs you find cause if nobody reports it there's a chance we'll never know it exists and then we'll never fix it.

Before creating bug reports, please check [this list](#before-submitting-a-bug-report) as you might find out that you don't need to create one. When you are creating a bug report, please [include as many details as possible](#how-do-i-submit-a-good-bug-report). Fill out the bug-report template with the information it asks for helps us resolve issues faster.

> **Note:** If you find a **Closed** issue that seems like it is the same thing that you're experiencing, open a new issue and include a link to the original issue in the body of your new one.

#### Before Submitting A Bug Report

* **Check the docs** There's a chance what you see as a bug might just work differently than you expect and if you think it could work better consider a feature enhancement report instead.
* **Search the [discord](https://discord.gg/qbcore)** to see if anyone else has run into the issue and see if it was solved through user error or code changes. (if the code change isn't pending a PR and you know what you're doing consider submitting one following [Pull Requests](#pull-requests) )
* **Determine which resource the problem should be reported in**. If the bug is related to the inventory for example report this bug under qb-inventory rather than under qb-core or some other resource.
* **Perform a [cursory search](https://github.com/search?q=+is%3Aissue+user%3Aqbcore-framework)** to see if the problem has already been reported. If it has **and the issue is still open**, add a comment to the existing issue instead of opening a new one.

#### How Do I Submit A (Good) Bug Report?

Bugs are tracked as [GitHub issues](https://guides.github.com/features/issues/). After you've determined which resource your bug is related to, create an issue on that repository and provide the following information by filling in bug-report template.

Explain the problem and include additional details to help maintainers reproduce the problem:

* **Use a clear and descriptive title** for the issue to identify the problem.
* **Describe the exact steps which reproduce the problem** in as many details as possible.
* **Provide specific examples to demonstrate the steps**. If something happened with only a specific group or single item but not others, specify that.
* **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
* **Explain which behavior you expected to see instead and why.**
* **Include screenshots** which show the specific bug in action or before and after.
* **If the problem wasn't triggered by a specific action**, describe what you were doing before the problem happened and share more information using the guidelines below.

Provide more context by answering these questions if possible:

* **Did the problem start happening recently** (e.g. after updating to a new version of QBCore?) or was this always a problem?
* If the problem started happening recently, **can you reproduce the problem in an older version of QBCore?** What's the most recent commit in which the problem doesn't happen?
* **Can you reliably reproduce the issue?** If not, provide details about how often the problem happens and under which conditions it normally happens.

Include details about your setup:

* **When was your QBCore last updated?** 
* **What OS is the server running on**?
* **Which *extra* resources do you have installed?**


---


### Suggesting Features / Enhancements

This section guides you through submitting an enhancement suggestion for QBCore, including completely new features and minor improvements to existing functionality. Following these guidelines helps maintainers and the community understand your suggestion.

Before creating enhancement suggestions, please check [this list](#before-submitting-an-enhancement-suggestion) as you might find out that you don't need to create one. When you are creating an enhancement suggestion, please [include as many details as possible](#how-do-i-submit-a-good-enhancement-suggestion). Fill in feature request template, including the steps that you imagine you would take if the feature you're requesting existed.

#### Before Submitting An Enhancement Suggestion

* **Make sure it doesn't already exist.** Sounds silly, but there's a lot of features built in to qbcore that people don't realize so take a look through the docs and stuff to make sure it's not already there.
* **Check if there's already PR which provides that enhancement.**
* **Determine which resource the enhancement should be suggested in.** if it fits with another resource suggest it in that resource. if it would be it's own resource suggest it in the main qb-core repository.
* **Perform a [cursory search](https://github.com/search?q=+is%3Aissue+user%3Aqbcore-framework)** to see if the enhancement has already been suggested. If it has, add a comment to the existing issue instead of opening a new one.

#### How Do I Submit A (Good) Enhancement Suggestion?

Enhancement suggestions are tracked as [GitHub issues](https://guides.github.com/features/issues/). After you've determined which resource your enhancement suggestion is related to, create an issue on that repository and provide the following information:

* **Use a clear and descriptive title** for the issue to identify the suggestion.
* **Provide a step-by-step description of the suggested enhancement** in as many details as possible.
* **Provide specific examples to demonstrate the steps**. Include copy/pasteable snippets which you use in those examples, as [Markdown code blocks](https://help.github.com/articles/markdown-basics/#multiple-lines).
* **Describe the current behavior** and **explain which behavior you expected to see instead** and why.
* **Include screenshots and animated GIFs** which help you demonstrate the steps or point out the part of QBCore which the suggestion is related to.
* **Explain why this enhancement would be useful.**
* **Be creative and unique.** Stealing ideas from popular servers 1:1 detail isn't going to get accepted.


---



### Your First Code Contribution

Unsure where to begin contributing to QBCore? You can start by looking through these `beginner` and `help-wanted` issues.



---


### Pull Requests

The process described here has several goals:

- Maintain QBCore's quality.
- Fix problems that are important to users.
- Engage the community in working toward the best possible QBCore.
- Enable a sustainable system for QBCore's maintainers to review contributions.

Please follow these steps to have your contribution considered by the maintainers:

1. Follow all instructions in The Pull Request template.
2. Follow the [styleguides](#styleguides).
3. Await review by the reviewer(s).

While the prerequisites above must be satisfied prior to having your pull request reviewed, the reviewer(s) may ask you to complete additional design work, tests, or other changes before your pull request can be ultimately accepted.


---

## Styleguides

### Git Commit Messages

* Limit the first line to 72 characters or less.
* Reference issues and pull requests liberally after the first line.
* Consider starting the commit message with an applicable emoji:
    * :art: `:art:` when improving the format/structure of the code
    * :racehorse: `:racehorse:` when improving performance
    * :memo: `:memo:` when writing docs
    * :bug: `:bug:` when fixing a bug
    * :fire: `:fire:` when removing code or files
    * :white_check_mark: `:white_check_mark:` when adding tests
    * :lock: `:lock:` when dealing with security
    * :arrow_up: `:arrow_up:` when upgrading dependencies
    * :arrow_down: `:arrow_down:` when downgrading dependencies
    * :shirt: `:shirt:` when removing linter warnings

### Lua Styleguide

All lua code should be done using all the best practices of proper lua using the easiest to read yet fastest/most optimized methods of execution.

- Use 4 Space indentation
- Aim for lua 5.4 (include `lua54 'yes'` in the fxmanifest.lua)
- Use `PlayerPedId()` instead of `GetPlayerPed(-1)`
- Use `#(vector3 - vector3)` instead of `GetDistanceBetweenCoords()`
- Don't create unnecessary threads. always try to find a better method of triggering events
- Don't repeat yourself.. if you're using the same operations in many different places convert them into a function with flexible variables
- For distance checking loops set longer waits if you're outside of a range
- Job specific loops should only run for players with that job, don't waste cycles
- When possible don't trust the client, esspecially with transactions
- Balance security and optimizations
- [Consider this Lua Performance guide](https://springrts.com/wiki/Lua_Performance)
- Use local varriables everywhere possible
- Make use of config options where it makes sense making features optional or customizable
- Instead of `table.insert(myTable, "Value")` use `myTable[#myTable + 1] = "Value"`
- Instead of `table.insert(ages, "bob", 30)` use `ages["bob"] = 30`


### JavaScript Styleguide

- Use 2 Space indentation
- Don't repeat yourself.. if you're using the same operations in many different places convert them into a function with flexible variables.
