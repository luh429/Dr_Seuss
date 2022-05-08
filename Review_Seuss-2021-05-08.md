## *Dr. Seuss Text Analysis*: Review

* Site publication: <https://luh429.github.io/Dr_Seuss/projects.html>
* GitHub repos: 
   * Public: <https://github.com/luh429/Dr_Seuss>
   * Private: <https://github.com/luh429/Dr_Seuss_Private>
* Developers: Logan Hering, Geng Chen, Sam Deeter, Zak Murphy, Janet Pituch, Emily Wargo 
* Date of Evaluation: 2021-05-08
* Evaluated by: @ebeshero

### Research questions and project design

#### Relax NG Schema: the "bones" of the project
In XML-based text analysis, a project's schema organizes its research questions, making it possible to locate data that you want to find consistently. In your project, the schema took a while to "settle," and it seems still possibly unsettled because, as I look at your XML files, two of them are outright breaking the schema's rules (carrying code for `<object>` elements in _The 500 Hats of Bartholomew Cubbins_, and apparently misplacing the `<char>`element in titles in a few other books). It may have been difficult to tell whether an individual XML file passed schema validation because there were multiple schemas of different names saved in different places in both project repos. This was confusing to me, but I tested your files following the most recent schema I could find in the Dr_Seuss_Private repo, and that yielded the fewest errors. Optimally, there shouldn't be any schema validation errors so that you can be sure you can find all the data you are looking for when you query your documents. 

#### Documentation of your methods
The more.html page seems to be the place where the team is documenting its methods. This is an area that needs some work on your site. You provide a screen capture of an XQuery file that is out of date, posted to the GitHub repo back on March 28. Having helped out with this project, I'm aware of quite a lot more XQuery that you wrote in the eXist-dB to generate your visualizations, charts, and pulls of made-up words and character names, and you aren't sharing that work, or the schema. 

The schema you provide is *also* apparently not the current one in use in the project (see next section). There isn't any discussion of the schema, but there really needs to be--this is the beating heart of the project's design, isn't it? You should be commenting on particular rules that matter: how you marked made-up words and characters for example! 

The TSV section contains...a repeat of the outdated schema? That seems an unfortunate oversight! Anyway, you should be explaining what the TSV is, what it contains, and how you used it. 

Why does the network graph appear alone at the bottom of this without any discussion? Maybe it deserves a more prominent place, perhaps on the main index.html page since it provides an overview of the collection's use of made-up words. And surely it is not complete? It only seems to feature four books, and yet you've marked 20 or 21 files, haven't you? 

Not only should you be sharing these files, you should be providing comments to discuss your team's decisions, as well as things you're not going to share publicly (like a view of the XML files, since that's a copyright issue). 


### Analysis

The latest XQuery files do not appear to be posted in the project Github repo(s), so I looked for them in the newtfire eXist-dB. It would have been helpful to share a view of your XQuery code and your schema on the project since this is the basis of your data curation and analysis. Openly sharing *how* you collected and retrieved your data is important, even if you can't share the XML files due to copyright reasons. You can still be sharing a glimpse of how you did your markup, how you handled characters, made-up words, lines, and sentences in your analysis. Your schema and your query code are the best resources for this. 

#### Problem with Character Count Data
There is a serious problem with the character count: You encoded `<char>` elements in 
*Too Many Daves*, but the book comes out with zero on the graph. Why? The project XML files were last updated on April 25, 2022 in eXist-dB and they seem to match what's in the private GitHub repo. *Too Many Daves* has `<char>` elements marked up, so they should have been queried and visualized anywhere there's a character count on your website. 

In eXist-dB I believe I find the XQuery script, drSeussXQuery, in seuss-queries, last updated April 22. It seems possible the script was not re-run after the last update to the XML files, but even if it had been, it could not have collected character data from *Too Many Daves* (and likely several other books) when it was coded like this:

```xml
char type="son" n="2">Daves</char>
```

That is because the XQuery that reaches for distinct-values of the characters was formulated to reach only the char elements with `@name` attributes, and it reached only into the `@name` before taking distinct values. 

```
let $char := $b//char/@name =>distinct-values()
```

With this line, you are missing quite a lot of data you encoded. To conform with your project schema, what you should have is a way to handle the `<char>` elements with `@n` attributes, or that lack `@name`. That's complicated, but I think you would probably need something like this. Always use `normalize-space()` to make sure you eliminate extra spaces before you take distinct values()! 

```
let $charNames := $b//char/@name ! normalize-space() => distinct-values()
let $otherChars := $b//char[not(@name)] ! normalize-space() => distinct-values()
let $chars := ($charNames, $otherChars)
```

I believe that would combine all the different ways you encoded `<char>` elements. Ideally you would not have this problem because you would have *strictly controlled it* with your project schema. But when the schema is too permissive, you have to code the XQuery to accommodate the variety of ways your team encoded if you are visualize your project data accurately.

I wanted to see how many distinct characters you were missing, so I ran this simple XQuery to check:

```
xquery version "3.1";
let $seussColl := collection('/db/seuss/tsg-xml/')
let $charNames := $seussColl//char/@name ! normalize-space() => distinct-values()
let $otherChars := $seussColl//char[not(@name)] ! normalize-space() => distinct-values()
let $chars := ($charNames, $otherChars) => distinct-values()
return $chars
```

The `$chars` variable basically combines the two different ways of grabbing characters into a single sequence. I then sent it through `distinct-values()` just in case there were any duplicates in the `@name` vs. non-named approaches to the code and removed one value that way. Doing this, I returned 86 distinct characters in the whole collection. When I returned the simple `$charNames` variable that only looks in `@name`, I only retrieved 59 distinct values. That's a problem. 

 I am sorry to find that the data collection and visualization in this project to have missed a serious portion of the team's markup. I am also concerned that the only XQuery file saved in the eXist-dB that seems generate the character count data appears to be pointed at Logan's personal directory, which does not at this time contain any Seuss XML project files. The XQuery *should* be reaching into `collection('/db/seuss/tsg-xml/')`, not `collection('/db/luh429/') at the very least to share this data with the project team, which should have been reviewing it for accuracy. 
 
 It's hard to do "sanity checking" of your data when you're the one writing the XQuery, and it really takes cooordinated teamwork to do this well. Next time, we hope you'll improve at this, simply knowing what kinds of things can go wrong. 

#### Made-up Words and Line-counts
This part of your project appears to be more reliable than the character data, since the schema rules are less complicated. It might have helped to inform the readers that 20 out of 21 of your books are written as poems with lines, while just one book seems to have prose paragraphs(?) 


### Website design and user experience
The team devoted much care to the crafting of an elegant website, featuring your Seuss-inspired artwork for the background and a set of cleverly designed Suessian id-cards to represent the team members. You designed some wonderful cursors and hover-effects with CSS, and the site is lots of fun to navigate. 

I'm impressed with the design of the site to display your findings on the project.html page, so that we can click on each book to explore its data about made-up words, character names, sounds, and more. This is very well designed. You worked to make sure the SVG graphs would fit in the space provided. You could make them behave a little more responsively in mobile-friendly ways by adding the `@viewBox` and `preserveAspectRatio` attributes like we discussed in class (see example on the textAnalysis-Hub). 

The visual design of the site is very appealing and fits the topic well! You balanced Seuss-ian bright colors with a shield of opacity to feature your findings, and you made good use of space on your site. You chose easily legible high-contrast fonts and did a nice job with labeling your SVG plots clearly. 

One interesting finding comes up when I run your pages through [the w3c Validator](https://validator.w3.org/): You want to add a `@lang="en"` to your pages simply to declare to the world that they are written in English. For a Dr. Seuss project, it's fascinating that the [projects.html page](https://luh429.github.io/Dr_Seuss/projects.html) featuring the made-up words from the books is interpreted by the w3c as most likely in Afrikaans (a form of Dutch spoken by Dutch colonists in South Africa). I wonder if Seuss's made-up words have some relation to Dutch? Maybe that's a follow-up question for linguistic text analysis! 

### Concluding comments
What's genuinely well-made and admirable here is the visual design of your project website. What needs work is the analysis, the coordination of the project schema, the write-up of your research and documentation of your methods. The project has "strong bones" in its Relax NG schema,  but very serious weaknesses in its implementation, and that affects the quality of the results we see on the otherwise attractive website. 

I encourage the team members to think about how you could have coordinated *review* of your own work together more effectively. You had a large group, so that should have meant more quality control, more pairs of eyes to catch problems. I hope you'll learn from your experiences this semester to be stronger developers, aware of things that worked well and not so well, so you can always be improving. 