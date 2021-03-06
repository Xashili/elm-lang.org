import Website.Skeleton (skeleton)
import open Website.ColorScheme
import Window
import JavaScript as JS

port title : String
port title = "Elm REPL"

main = lift (skeleton everything) Window.dimensions

everything wid =
    let w = min 600 wid
    in  width w intro

intro = [markdown|

<style type="text/css">
p { text-align: justify }
pre { background-color: white;
      padding: 10px;
      border: 1px solid rgb(216, 221, 225);
      border-radius: 4px;
}
code > span.kw { color: #204a87; font-weight: bold; }
code > span.dt { color: #204a87; }
code > span.dv { color: #0000cf; }
code > span.bn { color: #0000cf; }
code > span.fl { color: #0000cf; }
code > span.ch { color: #4e9a06; }
code > span.st { color: #4e9a06; }
code > span.co { color: #8f5902; font-style: italic; }
code > span.ot { color: #8f5902; }
code > span.al { color: #ef2929; }
code > span.fu { color: #000000; }
code > span.er { font-weight: bold; }
</style>

<h1><div style="text-align:center">Announcing Elm REPL
<div style="margin-top:4px;font-size:0.5em;font-weight:normal">*An Old Kind of REPL*</div></div>
</h1>

The first release of [`elm-repl`](https://github.com/evancz/elm-repl#elm-repl)
is now available. Like any traditional
[REPL](http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop),
it lets you interact with functions and expressions buried deep inside a
large project with many modules.

After you install [node.js](http://nodejs.org/download/),
you can install the REPL with:

```bash
cabal update ; cabal install elm-repl
```

From there, just run `elm-repl` and start writing Elm expressions, definitions,
ADTs, and module imports.

It is just for the command line now, but I&rsquo;d *love* to see `elm-repl`
integrated into editors. Modes for [emacs](https://github.com/jcollard/elm-mode),
[vim](https://github.com/lambdatoast/elm.vim), and
[Sublime Text](https://github.com/deadfoxygrandpa/Elm.tmLanguage) are still
maturing and improving, so if you are interested in working on any of these,
please get in contact with the authors. This is a great way to contribute to Elm!

## Usage

The first thing to know about a REPL is how to exit:
press `Ctrl-c` twice.

When you enter an expression, you get the result and its type:

```
> 1 + 1
2 : number

> "hello" ++ "world"
"helloworld" : String
```

The same can be done with definitions of values and functions:

```
> fortyOne = 41
41 : number

> increment n = n + 1
<function> : number -> number

> increment fortyOne
42 : number

> factorial n = \
|   if n < 1 then 1 \
|            else n * factorial (n-1)
<function> : number -> number

> factorial 5   
120 : number
```

You can also define ADTs:

```
> data List a = Nil | Cons a (List a)

> isNil xs = case xs of \
|              Nil -> True \
|              Cons _ _ -> False
<function> : List a -> Bool

> isNil Nil
True : Bool
```

You can also import standard libraries and any library reachable
from the directory in which `elm-repl` is running. Let's say you
are working on a module called `Graph`:

```
> import String

> String.length "hello"
5 : Int

> String.reverse "flow"
"wolf" : String

> import Graph

> Graph.edges
<function> : Graph -> [Edge]
```

This means you can dig into large projects you are working on
and see how a specific function behaves.

## What happened to &ldquo;A New Kind of REPL&rdquo;?

When I announced [hot-swapping in Elm](/blog/Interactive-Programming.elm), I
called it a new kind of REPL. Riffing on Stephen Wolfram's
[New Kind of Science](http://en.wikipedia.org/wiki/A_New_Kind_of_Science) definitely
makes for a provocative title, but perhaps unsurprisingly, the old kind
of REPL is still very important.

It is clear that [hot-swapping](/blog/Interactive-Programming.elm)
changes how we tweak and perfect our programs. It changes how we debug.
It changes how beginners learn to program. It changes how developers dig
into existing codebases. That is all great, but for some reason we still had
folks on [the list][repl-request] asking for a good old fashioned
[Read-eval-print-loop](http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop).
My initial feeling was &ldquo;Don't you see!
[REPLs are so 2000 and late](http://vimeo.com/46555107#t=0m47s)&rdquo;
but I was missing the bigger picture.

When it comes to exploring functions deep inside a large codebase, a REPL is
a great tool. Looking at the results of an entire program makes it hard to
pin down specific functions, especially when they are more abstract or do not
have direct impact on the things displayed by the program. In other words,
a REPL is the unit test of interactive programming. 

<p style="text-align:center;">
[REPL](http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) : [unit testing](http://en.wikipedia.org/wiki/Unit_testing) :: [hot-swapping](http://en.wikipedia.org/wiki/Hot_swapping) : [system testing](http://en.wikipedia.org/wiki/System_testing)
</p>

Once I put together the basics of `elm-repl` it was obvious that REPLs and
hot-swapping are great complements, both helping make developing and debugging
easier in their own way.

## Thank you

Thank you to Joe Collard for [explaining to me why he needed a
REPL][repl-request].
Once I fully understood the problem, I had to do it. It was like a happier version
of [The Tell-Tale Heart](http://en.wikipedia.org/wiki/The_Tell-Tale_Heart).
Thank you to [Thomas Bereknyei](https://github.com/tomberek) for figuring out
how to catch `Ctrl-c` presses in a platform independent way. Thanks to
the [haskeline](http://hackage.haskell.org/package/haskeline) project
which provided lots of great infrastructure for this project.

 [repl-request]: https://groups.google.com/forum/#!searchin/elm-discuss/repl/elm-discuss/OqT-HjGCkyY/sGvDAcb8Y84J

|]
