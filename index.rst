.. include:: <s5defs.txt>

============================================
Rapid Web Prototyping with Lightweight Tools
============================================

:Author:  Andrew Montalenti
:Date:    $Date: 2013-01-27 09:00:00 -0500 (Sun, 27 Jan) $

.. This document is copyright Andrew Montalenti and Parsely, Inc.

.. container:: handout

    **How this was made**

    This document was created using Docutils_/reStructuredText_ and S5_.

    Rapid Web Prototyping with lightweight tools: a tour through "inside
    out" web development with Bootstrap, jQuery, Jinja2, Flask, and
    MongoDB.

.. _Docutils: http://docutils.sourceforge.net/
.. _reStructuredText: http://docutils.sourceforge.net/rst.html
.. _S5: http://meyerweb.com/eric/tools/s5/

Meta Information
----------------

**Me**: I've been using Python for >10 years. I use Python full-time, and have for the last 4 years.

**Startup**: I'm co-founder/CTO of Parse.ly_, a tech startup in the digital media space.

**E-mail me**: andrew@parsely.com

**Follow me on Twitter**: amontalenti_

**Connect on LinkedIn**: http://linkedin.com/in/andrewmontalenti

.. _Parse.ly: http://parsely.com
.. _amontalenti: http://twitter.com/amontalenti

Parse.ly
--------

What do we do?

System Preliminaries
--------------------

Run `python -V` and make sure you're on Python 2.7.x.

Run `git --version` to make sure you have git installed.

Repo setup
----------

Clone the code respository::

    git clone git@github.com:amontalenti/rapid-web.git

Inspect the tags::

    git tag -l

Look at `Github web interface`_.

.. _Github web interface: https://github.com/amontalenti/rapid-web/

Feel free to fork!

Set up virtualenv
-----------------

Run the virtualenv setup script::

    cd rapid-web
    sh steps/01_init.sh

You should then have a virtualenv folder called `rapid-env`.
Activate it and install IPython::

    $ source rapid-env/bin/activate
    (rapid-env)$ pip install ipython
    ...
    (rapid-env)$ ipython -V
    0.13.1

Rapid Web Prototyping
---------------------

Thesis: the most important skill that a modern web developer can have today is
*prototyping*.

Most web developers lack this skill due to a number of biases:

* Computer Science Backend Bias
* Fear of Unskilled Design Bias
* Web Framework SQL Bias
* Polyglot Complexity Bias

Let's take each of these in turn.


Computer Science Backend Bias
-----------------------------

.. class:: incremental

    Myth: The most interesting problems in computing are algorithmic and backend systems
    oriented: e.g. data structures, natural language processing, operating systems,
    distributed systems, cryptography.

    Reality: These are simply the most interesting problems to introverted CS
    PhDs. The most widely used software is not solving fundamental computing
    problems (think Twitter, Facebook, GMail, Reddit) but is instead solving
    user experience problems.

Fear of Unskilled Design Bias
-----------------------------

.. class:: incremental

    Myth: Only a trained graphic designer can create usable and functional user interfaces.

    Reality: Anyone can create these interfaces; a skilled designer will
    promote these interfaces from the kind you merely use daily to the kind you
    share excitedly to friends.

Web Framework SQL Bias
----------------------

.. class:: incremental

    Myth: The purpose of a web framework is to unify web technologies with
    backend (database) technologies, specifically a SQL database. Building a
    web app consists of building a SQL model, then building the interfaces on
    that model.

    Reality: SQL isn't necessary in the early stages of a project; it may not
    be necessary at all during the entire lifetime of the project. Traditional
    web frameworks focus on the wrong thing.

Polyglot Complexity Bias
------------------------

.. class:: incremental

    Myth: The web requires knowledge of a slew of complex technologies: a
    backend programming language, a database query language, a templating
    language, JavaScript, HTML, and CSS. That's messy; I prefer to simply code
    in Java, Ruby, Python, etc.

    Reality: The web is messy, but all that's necessary to build a web app 
    is some basic knowledge of JavaScript and HTML. Much of the rest can 
    be abstracted via modern toolkits like jQuery and Bootstrap. You also
    need a way to render that JavaScript/HTML code, but this isn't as tough 
    as it seems.

Beat the Backend Bias Back!
---------------------------

Together, all of these biases form a general software engineering "backend
bias" that I observe in the real world.

The typical Python software engineer has no problem with:

* writing a testing a database schema
* implementing pure Python classes / functions
* thinking about scale and performance
* writing a program with a command-line interface

This is a kind of "comfort zone" for typical programmers.

Free From Frontend Fear?
------------------------

Same engineers exhibit a real fear when confronted with:

* creating hand-drawn or digital wireframes
* prototyping entire UIs that are backend-free but clickable
* testing out a user interface concept in isolation
* testing variations of a user interface on a live population

I'm not really concerned with why this split exists, but I definitely observe
it.

Premature Optimization
----------------------

.. class:: incremental

    "Premature optimization is the root of all evil."

    Don't overcomplicate your code with optimizations before you've measured
    whether those optimizations are actually necessary for acceptable runtime
    performance.

    "Premature backend is the root of all evil."

    Don't start to build the backend of your web app until you've determined
    what user experience your application will enable.

Fake It Till We Make It
-----------------------

Now that you have a sense of the theory behind this course, I'll take you
through three phases of rapid web prototyping:

.. class:: incremental

    * "First Fake": a JavaScript & HTML web clickable with jQuery and Bootstrap

    * "Get Real": introduce Flask & Jinja2, the front-end / back-end split

    * "Ship It!": add a database and deployment, store your first data

Why Fake?
---------

Traditional software process:

1. Someone has an idea
2. Idea elaborated into "Requirements Document"
3. Requirements enriched with Wireframes (optional, "product lead")
4. Wireframes enriched into Mockup (optional, "design lead")
5. Backend engineer builds Requirements into API, database schema, or somesuch
6. Frontend engineer builds Mockup into user interface
7. Some engineer "wires frontend to backend"
8. Feature is tested on users
9. Feedback from users leads to bug reports / revisions / rewrites

Problem: between steps 1 and 9, MONTHS can pass.

Related problem: when building fundamentally new & innovative products, step 9
is the most important since you're mainly looking for feedback & idea
validation.

First Fake
----------

.. class:: incremental

    Can we skip from step 1 to step 9?

    Yes: this is the essence of "rapid web prototyping".

    We need to fake a test user into thinking a working system exists.

Light Bulb
----------

.. class:: incremental

    I have an idea: "Reddit for clickstreams!"

    Reddit is cool, but the explicit "voting" process is annoying.

    People don't mind submitting links, but who wants to take time to upvote/downvote them?

    How about implicit voting based on users clicking on or re-submitting the same article?

    Insight: click is "implicit upvote"; re-submit is "explicit upvote". No
    vote buttons necessary!

Now What?
---------

Do you start building a database? ``Frontpage``, ``Article``, and ``Link``
classes w/ ORM bindings? Hell, no!

Do you start researching high-concurrency web frameworks for your millions of
potential users? Screw that!

Do you write a really detailed requirements document and complicated technical
architecture? What good will that do!?

Let's **prototype** this idea.

Pen and Paper
-------------

Even before diving into code, let's think about how to sketch out this idea
using the old pen and paper.

Quick discussion about wireframes:

* hand-drawn vs digital
* low-fidelity vs high-fidelity
* information, heirarchy, flow

Answer key questions:

* what does she see?
* what can she do?
* why does she care?

Wireframe share session
-----------------------

You have 5 minutes. Then we'll share!

Wireframe to Static
--------------------

In my version of this wireframe, I have three main screens:

.. class:: incremental

    * Links: shows recently posted articles that are most popular
    
    * Submit: form for submitting a new article to the site
    
    * Search: variation of links screen that lets you find links by keyword

Static HTML
-----------

.. sourcecode:: html

    <!DOCTYPE html>
    <html>
        <head>
            <meta charset="utf-8">
            <title>Rapid News Static</title>

            <link rel="stylesheet" href="css/main.css">
        </head>
        <body>

            <div class="container">
                <!-- fun stuff -->
            </div>

            <script src="js/main.js"></script>
        </body>
    </html>

jQuery / Bootstrap Intro
------------------------

.. sourcecode:: html

    <html>
        <head>
            <link rel="stylesheet" href="css/lib/bootstrap.css">
            <link rel="stylesheet" href="css/lib/bootstrap-responsive.css">
            <link rel="stylesheet" href="css/main.css">
        </head>
        <body>

            <div class="container">
                <!-- <bootstrap> -->

                <!-- </bootstrap> -->
            </div>

            <script src="js/lib/jquery.js"></script>
            <script src="js/lib/bootstrap.js"></script>
            <script src="js/main.js"></script>
        </body>
    </html>

Why Bootstrap?
--------------

.. class:: incremental

    * We are not designers.

    * HTML's default styling is ugly!

    * Modern HTML & CSS involves a lot of "boilerplate"

    * CSS is especially tricky for novices to get right

    * Component toolkit built mostly with pre-canned CSS classes

Bootstrap Components
--------------------

* Scaffolding
* Base CSS
* Components
* JavaScript plugins

Scaffolding
-----------

Smooths out the differences between different browser default HTML / CSS styling.

Provides a "grid" and "layout" system.

Supports responsive design approaches (auto scale down for mobile/tablet).

Base CSS
--------

Improves typically-used HTML elements with some reasoanble default stylings.

* ``h1`` through ``h6``
* ``body`` and ``p``
* ``table``
* ``form`` and ``input``
* ``button`` (with links)
* ``img``
* glyphicons

Components
----------

Adds other commonly-used UI components that are "missing" from HTML.

* dropdowns
* navigation bars
* pagination bars
* labels
* alerts
* "media objects"

JavaScript plugins
------------------

Richer interactive components that require JavaScript.

* modal windows
* typeahead search
* image carousels
* tab panels
* tooltips & popovers

Let's build the fake!
---------------------

We'll start with the navigation area and header.

We'll then add a simple listing of fake links in a table.

What have we learned?
---------------------

HTML isn't that hard.

With Bootstrap, you don't need to be a designer to get from wireframe to
clickable.

Problems:

* app is not very interactive
* list of links hard-coded

Adding Interactivity
--------------------

Enter jQuery.

Let's play in the Chrome Inspector console with the jQuery API.

Chrome Inspector
----------------

* Console
* Elements
* Network

Baby Turtles
------------

Use your powers wisely, and always remember...

.. image:: img/babyturtles.png
    :align: center

Magic Turtles!
--------------

It's turtles all the way down!

.. image:: img/magicturtle.jpg
    :align: center
