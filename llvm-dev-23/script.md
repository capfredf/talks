# Talk Script

Today, I'll be talking about Code Completion in ClangRepl. This is a project for
Google Summer of Code 2023.

[missing a slide]

For starters, let's chat a little more about ClangRepl, since not everyone here knows what it is.

ClangRepl is a project inspired by Cling from the Root Project. It features a
REPL environment which enables C++ programmers to develop programs in an
exploratory manner.

<Examples ...> you can do this and that after a repl prompt

[Slide Motivations]

Now let's move on to our project: Code Completion in ClangRepl. Why do we need this feature in ClangRepl?

[Slide Motivations Cont'd]

First of all, we really want to type as less as we can. Like here, we have a
struct with a very long name, I know I exagerated a little bit. It is really
annoying that we that we need to type all the symbols without code completion or
use copy and paste. But with code completion, users can hit tab and the result
gets completed

In addition, code completion should be able to offer more relevant context-aware
information. As in this case, we have defined two structs, Apple and Banana, the
function getApple that takes a reference to an apple. We also have one apple
instance and banana instance. When we hit tab after the letter "f" at the call
site of getApple, showing both identifiers `fruitIsBanana` and `fruitIsApple`
seems to leave something to be desired because `fruitIsBanana` is not an apple
whatsoever. Ideally our system should complete f with fruitIsApple.


[Slide Implementation]

Let's see how we can make this happen. 

[Slide Handling Tab]

The interactive parts of a REPL are handled by the LineEditor. It supports
completion. We implemented a completer called ReplListCompleter. When tab is
pressed in a REPL session, the function call-operator of the completer is
triggered. Using the example here, Buffer is "Wh", Pos = 1.  The method should
return completion results. Now since we are able to take over the tab event,
let's see how we do real code completion.

[Slide How Code Completion Works]

First, suppose we have a source file like. We want to do code completion at the point where the cursor is. 
Clang has built-in code completion, which can be used like this. 

Here is a diagram that roughly shows the whole process

First, we have a fresh new compiler instance.  Then we do a lot of configs,
among which we set the code completion point.  Then we create a syntax only
action for parsing. During parsing, we first create a default Consumer and
enable code completion since we have set a completion point.  when the parser
reaches the completion point, it trigger code completion. in this case, the
Default consumer's ProcessCompletionResults is invoked.

[Slide first attempt]

Now, we are in a repl. We can follow what the regular code completion does.  We
need our incremental compiler instance and syntax only action, since we are in
repl now.  we also need to supply our customized completion consumer. But we
still need to write a lot of boilerplate code.

Is there a better way to do this?

[Slide ASTUnit] 

Yes, there is. We ended up piggybacking on the APIs XCode uses. we create a
ASTUnit using an incremental compiler instance, parameterize its codeComplete
method invocation with the relevant data. Then bingo bango, our process
completion results method gets triggered.

[Slide Problems]

However, there are two problems. 

Though we can invoke the method, we can't actually do code completion. For a
regular file, Clang can complete here using foo.  Whereas in repl, it
can't. Why? those prompts make a difference. Clang treats a regular file as a
single ASTContext. Whereas in repl, we have two ASTContexts. When we are at the
current line, `foo` is not visible!

How can we solve the visibility issue?

[Slide Problems Contd]

Let's zoom into our repl. Here we have a chain of declarations in the main context. 

First, we make the main ast context the external source of the current ast context. 

Next, we go through the chain and import every declaration defined from the main
context into current context, from `foo` to `flight`.

[missing showing completion result after foo]

[Slide New Context]

The other problem is by default, Clang is unable to do code completion in a top level
expression, since in a regular c++ file, expression statements are not allowed
to appear at a top level. But top level expressions are bread and butter in repl. 

So we added a new kind of CompletionContext. 

[Slide Semantic Code Completion]

Now let's talk about how we implemented semantic Code Completion

[Slide Original Plan]

In the very beginning, we thought we needed to do all the parsing on our end to figure what context code completion happens in.

In the first example, we would want to know the cursor is after an ordinary symbol. 

In the second example, we would want to know we are completing symbols at a call site. 

In the last example, we would want to know we are accessing members of a
variable through a dot, we would also know to the variable's class and the class
methods.

It turns out nothing needs to be done because Sematic Analysis and Parser do the
heavy-lifting job for us.

[Slide Original Plan Contd]

Next, we thought we needed to extract type information regarding the cursor position. 

For example, Suppose, the constructor of Foo takes an interger and a string and
we are doing code completion for the second argument to a call of this
constructor.

we would need to get the type of the constructor in order to get the second
parameter's type.

Well, it turns out Sematic Analysis already provides us this kind of type
information.

[Slide How to use Sema]

Recall that one key method in code completion is ProcessCodeCompleteResults. 

The key to solve the issues we mentioned the previous two slides is the `Context` here

If the completion context kind is TopLevelOrExpression and the PreferredType is not set,

There are no type constraints on completion results.

If we are still in TopLevelOrExpression and PreferredType is set,

we can use it to filter candidates. 

If the context we are in is DotMemberAccess, we can use the baseType to get the
class of the instance we are accessing via dot.  As shown the example, we can
list of public members of apple.

[Slide Filter Candidates]

under the hood, the filter proccess is defined with a for loop

if a candidate's type is compatible with the preferred type, the candidate is valid and gets converted into a completion string.

The binary predicate isComppatible checks if the first clang type is compatible
with the second. Like whether it is the same of the , it is a reference of the
latter, it is a subclass reference of the latter, and etc.

[Slide sum up]

To achieve code completion in repl, we first solved the vibility issue of
declarations defined in the main context with ASTImporter and External Source.

we enabled code completion in top level expressions by adding a new
CompletionContextKind. Lastly, we showed how we leveraged Sematic Analysis
modules to achieve semantic code completion.
