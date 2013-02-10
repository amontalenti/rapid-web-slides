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

    Myth: The most interesting problems in computing are algorithmic and
    backend systems oriented: e.g. data structures, natural language
    processing, operating systems, distributed systems, cryptography.

    Reality: These are simply the most interesting problems to introverted CS
    PhDs. The most widely used software is not solving fundamental computing
    problems (think Twitter, Facebook, GMail, Reddit) but is instead solving
    user experience problems.

Fear of Unskilled Design Bias
-----------------------------

.. class:: incremental

    Myth: Only a trained graphic designer can create usable and functional user
    interfaces.

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

    Reality: This is partially true. The web is messy, but all that's necessary
    to build a web app is some basic knowledge of JavaScript and HTML. Much of
    the rest can be abstracted via modern toolkits like jQuery and Bootstrap.
    You also need a way to render that JavaScript/HTML code, but this isn't as
    tough as it seems.

Beat the Backend Bias Back!
---------------------------

Together, all of these biases form a general software engineering "backend
bias" that I observe in the real world.

The typical Python software engineer has no problem with:

* writing a testing a database schema
* implementing pure Python classes / functions
* thinking about scale and performance
* building a command-line interface

This is a kind of "comfort zone" for typical programmers.

Free From Frontend Fear?
------------------------

Same engineers exhibit a real fear when confronted with:

* creating hand-drawn or digital wireframes
* prototyping entire clickable user interfaces
* experimenting with a user interface concept in isolation
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

Why Fake? (1)
-------------

Traditional software process:

.. class:: incremental

    1. Someone has an idea

    2. Idea elaborated into "Requirements Document"

    3. Requirements enriched with Wireframes (optional, "product lead")

    4. Wireframes enriched into Mockup (optional, "design lead")

    5. Backend engineer builds Requirements into API, database schema, or somesuch

Why Fake? (2)
-------------

.. class:: incremental


    6. Frontend engineer builds Mockup into user interface

    7. Some engineer "wires frontend to backend"

    8. Feature is tested on users

    9. Feedback from users leads to bug reports / revisions / rewrites


Why Fake? (3)
-------------

.. class:: incremental

    Problem: between steps 1 and 9, MONTHS can pass.

    Related problem: when building fundamentally new & innovative products,
    step 9 (feedback from real users) is the most important.

First Fake
----------

.. class:: incremental

    Can we skip from step 1 to step 9?

    Yes: this is the essence of "rapid web prototyping".

    We need to fake a test user into thinking a working system exists.

Light Bulb
----------

.. class:: incremental

    Idea: "Reddit for clickstreams!"

    Reddit is cool, but the explicit "voting" process is annoying.

    People don't mind submitting links, but who wants to take time to upvote/downvote them?

    How about implicit voting based on users clicking on or re-submitting the same article?

    Insight: click is "implicit upvote"; re-submit is "explicit upvote". No
    vote buttons necessary!

Now What?
---------

.. class:: incremental

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

.. class:: incremental

    * hand-drawn vs digital

    * low-fidelity vs high-fidelity

    * information, heirarchy, flow

Goal of Sketch
--------------

Answer key questions:

.. class:: incremental

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
* Sources
* Elements
* Network

First Visit Experience
----------------------

Use browser cookie to detect whether user has visited before.

Show a modal dialog on first visit to explain concept, and then hide it on
future visits.

Static file limitations
-----------------------

When first prototyping, the easiest approach is "pure static" -- just open your
HTML file in your browser.

This has some limitations though:

* cookies don't work
* localStorage doesn't work
* referencing static JSON/CSV files doesn't work
* relative links won't work

Python SimpleHTTPServer
-----------------------

Here is our first "Python backend".

A simple HTTP web server built into Python itself.

Just run:

.. sourcecode:: sh

    cd static
    python -m SimpleHTTPServer

Now open http://localhost:8000 in your browser.

Bootstrap Modal HTML
--------------------

.. sourcecode:: html

    <div id="first-visit-dialog" class="modal hide fade in">
        <div class="modal-header">
            <a class="close" data-dismiss="modal">×</a>
            <h3>Welcome to Rapid News!</h3>
        </div>
        <div class="modal-body">
            <h4>Rapid News connects you with the latest links</h4>
            <p>Links are prioritized on this page based on clicks and
            submits. Simply click a link or submit a story and you're 
            instantly a part of the community.</p>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn" data-dismiss="modal">Close</a>
        </div>
    </div> 

Scripting the Modal
-------------------

.. sourcecode:: javascript

    function showFirstVisitDialog() {
        var cookie = RAPID.readCookie("visited");
        if (cookie === "true") {
            // do nothing, user has visited before
            return;
        }
        var modal = $("#first-visit-dialog");
        modal.on("hide", function() {
            RAPID.createCookie("visited", "true", 30);
        });
        modal.modal();
    };

Building a small API
--------------------

Console and state.

.. image:: img/js_object.png
    :align: center

Use a JSON-P API with jQuery
----------------------------

.. sourcecode:: html

    http://hndroidapi.appspot.com
        /best/format/json/page/
            ?appid=RAPID&
            callback=

.. sourcecode:: javascript

    var apiroot = "http://hndroidapi.appspot.com";
    var path = "/best/format/json/page/";
    var params = "?appid=RAPID&callback=?";
    var url = [apiroot, path, params].join("");

    $.getJSON(url, function(data) {
        $.each(data.items, function(i, item) {
            console.log(item.title);
        });
        console.dir(data);
    });

Dynamic Element Modification
----------------------------

.. sourcecode:: javascript

    $.getJSON(url, function(data) {
        var rows = $("table tr");
        $.each(data.items, function(i, item) {
            var row = rows.get(i+1);
            if (typeof row !== "undefined") {
                row = $(row);
                var score = row.find("span.label:first");
                var pubdate = row.find("span.label:last");
                var link = row.find("a");
                link.attr("href", item.url);
                link.html(item.title);
                score.html(item.score.replace(" points", ""));
                pubdate.html(item.time);
            }
        });
    });

Implementing the Submit Page
----------------------------

* what she sees: a form for submitting content
* why she cares: share a story with the community

Copypasta time!

Review Template
---------------

.. sourcecode:: html

    <html>
        <head>
            <meta charset="utf-8">
            <title>RN: Submit News</title>
            <!-- ... -->
        </head>
        <body>
            <div class="container">
                <!-- <bootstrap> -->

                <!-- </bootstrap> -->
            </div>

            <script src="js/lib/jquery.js"></script>
            <script src="js/lib/bootstrap.js"></script>
            <script>window.RAPID = {};</script>
            <script src="js/submit.js"></script>
        </body>
    </html>

Link Wiring
-----------

On main page:

.. sourcecode:: html

    <ul class="nav">
        <li><a href="#">Links</a></li>
        <li class="active"><a href="/submit.html">Submit</a></li>
    </ul>

On submit page:

.. sourcecode:: html

    <ul class="nav">
        <li><a href="/">Links</a></li>
        <li class="active"><a href="#">Submit</a></li>
    </ul>

Create a Form
-------------

.. sourcecode:: html

    <div id="submit-form">
        <form action="/new">
            <fieldset>
                <legend>Submit some news!</legend>
                <label>Link</label>
                <input type="text" placeholder="http://...">
                <label>Title</label>
                <input type="text" placeholder="news headline or description">
                <div class="control-group">
                    <button type="submit" class="btn">Submit!</button>
                </div>
            </fieldset>
        </form>
    </div>

Reviewing the Carnage
---------------------

.. class:: incremental

    Two pages: ``index.html`` and ``submit.html``.

    Using several Bootstrap components: navigation, table, form, modal.

    JSON-P API calls to some fake data and jQuery for element manipulation.

    Still no backend built.

    Can be used to gather useful user feedback.

What's Missing from our Prototype?
----------------------------------

.. class:: incremental

    No server means no way to handle the submit form.

    No way to track clicks (no link redirector).

    No real scoring algorithm yet (data faked from HN).

What's Wrong with Our Prototype?
--------------------------------

.. class:: incremental

    Nothing! With very little code, we're providing a clickable UI.

    De-risking some of our core assumptions about the product.

    However, we can already see some code duplications (header/footer, nav).

    Starting to hit the limits of no backend.

    Time for Python to save the day!

Onward to "Getting Real!"
-------------------------

Let's take a 5m break to answer questions / reflect a bit.

IPython and Flask installation
------------------------------

.. sourcecode:: sh

    $ cat requirements.txt
    ipython
    Flask
    $ pip install -r requirements.txt
    ...

Then...

.. sourcecode:: sh

    $ ipython
    >>> import flask
    >>> flask.<TAB>
    >>> import jinja2
    >>> jinja2.<TAB>
    >>> import werkzeug
    >>> werkzeug.<TAB>

Advanced Prototyping
--------------------

If you install some optional requirements, you can get:

* IPython Notebook: browser-based Python editor and prototyping environmnet
* LiveReload: browser plugin and server for auto reloading on page changes

.. sourcecode:: sh

    $ cat dev-requirements
    # for live code updates
    livereload
    # for ipython notebook
    tornado
    pyzmq
    $ pip install -r dev-requirements.txt
    ...
    $ ipython notebook
    $ livereload -p 8000

Build a Web Server
------------------

.. sourcecode:: python

    from werkzeug.wrappers import Request, Response

    @Request.application
    def app(request):
        print request.path
        print request.headers
        return Response("hello, world!")

    from werkzeug.serving import run_simple
    run_simple("localhost", 4000, app)

Debug a Web Server
------------------

.. sourcecode:: python

    from werkzeug.wrappers import Request, Response
    from werkzeug.debug import DebuggedApplication

    @Request.application
    def app(request):
        raise ValueError("testing debugger")
        return Response("hello, world!")

    app = DebuggedApplication(app, evalex=True)

    from werkzeug.serving import run_simple
    run_simple("localhost", 4000, app)

Inspecting the Request
----------------------

.. sourcecode:: python

    >>> request.headers
    EnvironHeaders([('Cookie', 'csrftoken=ETXzOTz6zqbQYt0o...
    >>> request.headers.keys()
    ['Cookie', 'Content-Length', 'Accept-Charset', 'User-Agent', 
    'Connection', 'Host', 'Cache-Control', 'Accept', 'Accept-Language', 
    'Content-Type', 'Accept-Encoding']
    >>> request.headers["User-Agent"]
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.17 (KHTML, like Gecko)'
    'Chrome/24.0.1312.68 Safari/537.17'  
 
Inspecting the Request from Chrome
----------------------------------

We can look at both sides of this request to really understand it.

Flask "microframework" overview
-------------------------------

* Werkzeug provides the web server and HTTP utility libraries
* Jinja2 provides the templating language
* Flask wires these two together conveniently

Why do we need a programmable web server?
-----------------------------------------

To do anything "dynamic" in response to user requests.

For our Rapid News app, we need the server to:

* validate the news submission form
* store recently submitted stories
* calculate the scoring algorithm
* implement a link redirector (for tracking clicks)
* implement keyword search

Why do we need a templating language?
-------------------------------------

Remember copypasta?

.. class:: incremental

    We want to avoid duplicating code between ``index.html`` and
    ``submit.html``.  As this app grows, we may add new pages, and 
    we'd like to maintain a common look-and-feel (template heirarchy).

    We want to render pages "dynamically" using data we've stored on the
    server (control flow and interpolation).

    We want to enable HTML code re-use within pages (macros).

Template Example
----------------

.. sourcecode:: python

    from jinja2 import Template

    tmpl = Template(u'''<table>
    <tr>
        <td><strong>Number</strong></td> <td><strong>Square</strong></td>
    </tr>
    {%- for item in rows %}
    <tr>
        <td>{{ item.number }}</td> <td>{{ item.square }}</td>
    </tr>
    {%- endfor %}
    <table>
    ''')

    data = [{"number": number, "square": number*number} 
                for number in range(10)]
    print tmpl.render(rows=data)

Template Output
---------------

.. sourcecode:: html

    <table>
    <tr>
        <td><strong>Number</strong></td>
        <td><strong>Square</strong></td>
    </tr>
        ...
    <tr>
        <td>3</td>
        <td>9</td>
    </tr>
    <tr>
        <td>4</td>
        <td>16</td>
    </tr>
        ...
    <tr>
        <td>9</td>
        <td>81</td>
    </tr>
    <table>

Template Loaders
----------------

.. sourcecode:: python

    import os
    import sys
    import json
    from jinja2 import Environment, FileSystemLoader

    args = sys.argv
    env = Environment(loader=FileSystemLoader(os.getcwd()))
    data = json.load(open(args[2]))
    print env.get_template(args[1]).render(data)

Template as File
----------------

.. sourcecode:: jinja

    <table>
        <tr>
            <td><strong>Number</strong></td>
            <td><strong>Square</strong></td>
        </tr>
        {%- for item in rows %}
            <tr>
                <td>{{ item.number }}</td>
                <td>{{ item.square }}</td>
            </tr>
        {%- endfor %}
    <table>

Saved in ``squares.jinja2.html``.

Template Tester
---------------

.. sourcecode:: sh

    $ python render.py squares.jinja2.html
    {"rows": [{"number": 3, "square": 9}]}
    <table>
    <tr>
        <td><strong>Number</strong></td>
        <td><strong>Square</strong></td>
    </tr>
    <tr>
        <td>3</td>
        <td>9</td>
    </tr>
    </table>

Data Access Stub
----------------

.. sourcecode:: python

    def top_articles():
        return []

    def search_articles(query):
        return []

    def insert_article(article):
        return False

Flask App Structure
-------------------

.. sourcecode:: python

    from flask import Flask, render_template
    from rapid import top_articles 

    app = Flask(__name__)

    @app.route('/')
    def index():
        articles = top_articles()
        return render_template('index.jinja2.html',
                               articles=articles)

    if __name__ == "__main__":
        app.run(debug=True)

Flask Goodies
-------------

* request "context"
* URL routing
* template "context"
* sessions
* redirects
* app configuration
* filesystem handling

Request Context (1)
-------------------

.. class:: incremental

    In plain Python code, you tend to avoid global state like the plague.

    In web applications, there is some implicit global state: the currently
    running "application", and the currently-being-handled "request".

    Flask makes dealing with these easier than it would otherwise be.

Request Context (2)
-------------------

.. sourcecode:: python

    app = Flask(__name__)
    # the "application context"


... and...

.. sourcecode:: python

    from flask import request

    @app.route('/')
    def index():
        # the "request context"
        print request.headers

Handling Shared State
---------------------

.. class:: incremental

    Core Idea: your Python functions / classes get "bound to a context".

    Flask calls your code and sets appropriate shared state (e.g. current
    request via ``flask.request`` and the current session via ``flask.session``).

    You can also share arbitrary data in-process via ``flask.g`` (global).

Code Coupling
-------------

In this way, Flask makes coupling between your code and the web server very explicit.

(Insight: Flask can create a "thin web layer" for plain Python code.)

URL Routing
-----------

.. class:: incremental

    URL Routing lets you bind HTTP paths and arguments to Python functions easily.

    This is the "design of your URLs".

    Let's look at an example of Flickr's URL design.

URL Routing at Flickr
---------------------

.. sourcecode:: python

    @app.route("/explore")
    def explore_photos():
        pass

    @app.route("/photos")
    def most_recent_photos():
        pass

    @app.route("/photos/<username>")
    def user_photos(username):
        pass

    @app.route("/photos/<username>/<int:photo_id>")
    def photo_detail(username, photo_id):
        pass

URL Routing with Rapid News
---------------------------

.. sourcecode:: python

    @app.route('/')
    def index():
        pass

    @app.route('/search/<query>')
    def search(query):
        pass

    @app.route('/submit', methods=["GET", "POST"])
    def submit():
        pass

Porting Static Design to Templates
----------------------------------

.. sourcecode:: jinja

    {# example layout.html #}    
    {# header #}
    <html>
        <head>
            <title>{% block title %}{% endblock %}</title>
        </head>
        <body>
    {# /header #}
            {% block body %}
            {% endblock %}
    {# footer #}
        </body>
    </html>
    {# /footer #}

Simplified Index Template
-------------------------

.. sourcecode:: jinja

    {# example index.html #}
    {% extends 'layout.html' %}
    {% block title %}Latest News{% endblock %}
    {% block body %}
        <table>
            <thead>
                ...
            </thead>
            <tbody>
                ....
            </tbody>
        </table>
    {% endblock %}

Simplified Submit Template
--------------------------

.. sourcecode:: jinja

    {# example submit.html #}
    {% extends 'layout.html' %}
    {% block title %}Submit News{% endblock %}
    {% block body %}
        <form>
            <fieldset>
                ...
            </fieldset>
        </form>
    {% endblock %}

Static Code Generation
----------------------

.. sourcecode:: sh

    $ cd templates
    $ python render.py index.jinja2.html data.json
    <html>
    ...
        <table>
    ...
    </html>
    $ python render.py submit.jinja2.html data.json
    <html>
    ...
        <form>
    ...
    </html>

Template Context (1)
--------------------

.. class:: incremental

    In the ``render.py`` calls from before, data.json was a file with an empty JSON object.

    {}

    We can populate variables in here to create a "template context".

Template Context (2)
--------------------

.. sourcecode:: javascript

    {"rows": 
        [
            {"title": "Google", 
             "score": 150, 
             "link": "http://google.com"},
            {"title": "Yahoo", 
             "score": 75, 
             "link": "http://yahoo.com"},
            {"title": "Bing", 
             "score": 50, 
             "link": "http://bing.com"}
        ]
    }


Template Context (3)
--------------------

.. sourcecode:: jinja

    {% for row in rows %}
    <tr>
        <td>{{ row.score }}</td>
        <td><a href="{{ row.link }}">{{ row.title }}</a></td>
        <td>just now</td>
    </tr>
    {% endfor %}

Template Context (4)
--------------------

.. sourcecode:: sh

    $ python render.py index.jinja2.html articles.json

.. sourcecode:: html

    <html>
        ...
    <body>
        ...
            <tr>
                <td>150</td>
                <td><a href="http://google.com">Google</a></td>
                <td>just now</td>
            </tr>
        ...
        </body>
    </html>

Wire Templates to Flask
-----------------------

.. sourcecode:: python

    from flask import render_template, Flask
    app = Flask(__name__)

    def top_articles():
        articles = [
            {"title": "Google", "score": 150, "link": "http://google.com"},
            {"title": "Yahoo", "score": 75, "link": "http://yahoo.com"},
            {"title": "Bing", "score": 50, "link": "http://bing.com"}
        ]
        return articles

    @app.route('/')
    def index():
        articles = top_articles()
        return render_template("index.jinja2.html", rows=articles)

    if __name__ == "__main__":
        app.run(debug=True)

Frontend / Backend Recap
------------------------

Backend:

* browser makes request to specific URL
* Flask server routes URL to appropriate view function
* "does something useful" during request context
* stashes results into template context

Frontend:

* server renders HTML / JavaScript in response to request
* rendering happens within a "template context", via Jinja2
* template context provides "dynamic" data from server
* JavaScript executed within client browser, after page rendering

Simplified Backend thru Frontend
--------------------------------

.. sourcecode:: text

    Browser Request 
        --> WSGI Server 
            --> Flask App Context
                --> View Function 
                    --> Request Context
                        --> Python Code / Data Access
                    --> Template Context
                        --> Render Template
            --> Response to Browser
    Browser Response Parsing 
        --> Download & Parse CSS / JavaScript
        --> Render DOM
        --> Execute JavaScript
            --> Register Event Handlers
            --> Remote Requests (AJAX)
            --> Dynamic Element Modification
        --> Full Page Loaded

What Goes Where?
----------------

.. class:: incremental

    This request/response lifecycle is what makes web programming a little complex.

    Paradox of choice re: where to put your logic.

    Should core logic be in the browser (JavaScript), templates (Jinja2), in
    the request context (Flask) or just on the server (plain Python)?

    The answer is, "it depends".

Single Page Apps
----------------

.. class:: incremental

    There has been a bit of a craze recently about "single-page web apps".

    The idea is that for many web apps, almost all of the application logic can
    live in the browser.

    The server only speaks an API (HTTP/JSON) and does not do things like
    template rendering.

    Proponents of this approach say that it makes the applications more
    performant and unifies the codebase (mostly JavaScript).

    JavaScript interpreters in modern browsers are fast enough for this now,
    whereas in e.g. 2004-2008, this would have been infeasible.

Multi-Page Apps
---------------

.. class:: incremental

    Multi-page apps tend to be more "web-friendly".

    They also tend to be simpler to implement and debug.

    Easy to selectively use single-page app techniques in a multi-page app.

    Original "AJAX" craze was about this.


Rapid News As Single-Page
-------------------------

.. sourcecode:: text

    Browser Request to '/'
        --> Flask Renders Static HTML
        --> Flask Returns Static JavaScript Application 
    Browser Response
        --> jQuery API call to /frontpage.json
            --> New Flask Request
                --> Python Logic to get top articles
            --> Data Rendered as JSON
        --> API data used to template/render client-side
    User Sees Front Page
    User Clicks "Submit"
        --> JavaScript alters DOM
    User Sees Submit Form
    User Submits New Article
        --> jQuery API call to /submit.json for validation
    User Sees Validation Errors or Success

Rapid News as Multi-Page
------------------------

.. sourcecode:: text

    Browser Request to '/'
        --> New Flask Request
            --> Python Logic to get Top Articles
        --> New Template Context with Data
            --> Template Rendered with Jinja2
    Browser Response
    User Sees Front Page
    User Clicks "Submit"
        --> New Flask Request
        --> New (Empty) Template Context for Submission Form
            --> Template Rendered with Jinja2
    User Sees Submit Form
    User Submits New Article
        --> New Flask Request
            --> Python Form Validation Logic
        --> New Template Context with Errors (or Empty)
            --> Template Rendered with Jinja2
    User Sees Validation Errors or Success

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
