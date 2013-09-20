Using Flask
===========

Prerequisites
-------------

* `Flask Installation`_
* `Flask Quickstart`_

.. _Flask Installation: http://flask.pocoo.org/docs/installation/
.. _Flask Quickstart: http://flask.pocoo.org/docs/quickstart/

pip, virtualenv, and virtualenvwrapper
--------------------------------------

We'll use three standard Python tools -- pip, virtualenv, and virtualenvwrapper
-- for organizing our code projects.

On a standard machine with Python 2.7 installed, here is what you should use to
set these up::

    sudo easy_install pip
    sudo pip install virtualenv
    sudo pip install virtualenvwrapper

On Windows, easy_install and pip can be a bit trickier to setup. There is some
documentation about `easy_install and Windows`_ on the Flask website, though.
Also, virtualenvwrapper is a set of shell scripts, and Windows lacks a shell.
So, to use the same commands on Windows, you'll need `virtualenvwrapper-win`_.

.. _easy_install and Windows: http://flask.pocoo.org/docs/installation/#pip-and-distribute-on-windows
.. _virtualenvwrapper-win: https://github.com/davidmarble/virtualenvwrapper-win

This should set these tools up in your environment. These tools are used to
install Python packages into self-contained environments called "virtualenvs".
virtualenvwrapper makes it easy to navigate these environments with a set of
common shell commands.

Now, to create an environment for your Flask project, use the following::

    mkvirtualenv <project>
    # ... output ...
    cd ~/repos/<project>
    # this is where your repo is cloned from Github
    touch requirements.txt
    echo "Flask" >>requirements.txt
    git add requirements.txt
    git commit -m "added Flask dependency"

You have now created a "requirements file" that contains Flask as a dependency.
You can install Flask in your virtualenv using this command::

    pip install -r requirements.txt

You should see output like this::

    Downloading/unpacking Flask (from -r requirements.txt (line 1))
    Downloading Flask-0.8.tar.gz (494Kb): 494Kb downloaded
    Running setup.py egg_info for package Flask
    ...
    Successfully installed Flask Werkzeug Jinja2

These three libraries constitute our web development environment. They are:

* `Werkzeug`_, an HTTP wrapper library for Python that implements the WSGI specification
* `Jinja2`_, a text templating engine specifically tuned for HTML/CSS and modeled for web development
* `Flask`_, which is the web "framework" that ties these pieces together

.. _Werkzeug: http://werkzeug.pocoo.org/
.. _Jinja2: http://jinja.pocoo.org/docs/
.. _Flask: http://flask.pocoo.org

Hello, World! web app
---------------------

Now, let's make a Hello, World web app just like it was suggested we do in the
Quickstart guide above. Put this code into a file called ``hello.py``::

    from flask import Flask
    app = Flask(__name__)

    @app.route('/')
    def hello_world():
        return 'Hello, World!'

    if __name__ == '__main__':
        app.run()

Now run the application using ``python hello.py``. You should see this output::

    * Running on http://127.0.0.1:5000/

Visiting http://127.0.0.1:5000/ in your browser should display the text,
"Hello, World!" Your console should also show some debug output of the visit
happening, e.g. the HTTP 200 status code.

Adding a simple template
------------------------

Now let's replace ``hello.py`` with these contents::

    from flask import Flask, render_template

    app = Flask(__name__)

    @app.route('/')
    def hello_world():
        return 'Hello, World!'

    @app.route('/hello/')
    @app.route('/hello/<name>')
    def hello_world_template(name=None):
        return render_template('hello.jinja2.html', name=name)

    def main():
        app.run(debug=True)

    if __name__ == '__main__':
        main()

This example has our original ``hello_world`` function, that handles requests
to ``/`` path. But we have also added a handler for two more path routes,
``/hello/`` and ``/hello/<name>``. The latter one utilizes Flask's support for
`Variable Rules`_. The idea is that the second part of the path will be
captured in a label called ``name`` and passed as a keyword argument to your
view function. The default value is ``None``, but can be any string that is
appended to the path.

You may be wondering about the syntax ``@app.route(...)`` and what that
actually means in Python. This is an example of a `Python Decorator`_.
Essentially, ``app.route`` is a function in the Flask framework that replaces
your view functions with "decorated versions" that know how to handle HTTP
requests at the specified routes for your Flask application.

.. _Variable Rules: http://flask.pocoo.org/docs/quickstart/#variable-rules
.. _Python Decorator: http://en.wikipedia.org/wiki/Python_syntax_and_semantics#Decorators

So, from a high level, we are trying to make it so that if you enter
``/hello/John`` as a path, we will render a document that says "Hello, John!".
We can achieve this goal with templates. So, let's also add a simple template
in the ``templates/hello.jinja2.html`` file::

    <!doctype html>
    <title>Hello, World custom example</title>
    {% if name %}
        <h1>Hello {{ name }}!</h1>
    {% else %}
        <h1>Hello, World!</h1>
    {% endif %}

This illustrates the use of a basic `Jinja2 Control Structure`_, the if
statement, though many others (that mostly match those available in Python) are
available in the template language. In this case, as you can see, the purpose
of control structures isn't to control "flow of execution" but to enable
"conditional template snippet rendering". In other words, anything not within
the Jinja2 special characters ``{{ }}`` and ``{% %}`` is rendered "as-is" in
the HTML response.

.. _Jinja2 Control Structure: http://jinja.pocoo.org/docs/templates/#list-of-control-structures

Now let's try using this thing. Run ``python hello.py`` again and visit
http://127.0.0.1/hello/John in your browser. You should see ``Hello, John!`` as
output.

Adding a database
-----------------

With many web applications, you will end up using a "traditional" SQL database
as a data store, for example MySQL, Postgresql, SQLite. You can use these
database systems with Flask, too, but we won't be doing that here :)

Instead, we'll be using a more "Pythonic" data store that happens to fit
analytics data storage a bit better called `MongoDB`_. We'll be using this
together with the standard Python driver for MongoDB called `pymongo`_.

To set up MongoDB on your local machine, you'll need to follow the official
installation instructions for your operating system. See the `MongoDB
Quickstart`_ for information on that.

Once MongoDB is installed, you can install pymongo into your Flask application
like this::

    echo "pymongo" >>requirements.txt
    pip install -r requirements.txt

You should see output like this::

    Downloading/unpacking pymongo (from -r requirements.txt (line 2))
    # ... some gcc compilation, etc. ...
    Successfully installed pymongo

If you are not able to install pymongo, it may be because you are missing gcc,
a standard C compiler. See `pymongo's gcc notes`_ if this ends up being a
problem on your machine. This may end up being particularly problematic on
Windows machines, where gcc is not readily available. If that's the case, you
can try installing `pymongo binaries`_ from PyPI, or you could try running a
Linux virtual machine to set this up.

.. _MongoDB: http://www.mongodb.org/
.. _MongoDB Quickstart: http://www.mongodb.org/display/DOCS/Quickstart
.. _pymongo: http://api.mongodb.org/python/current/
.. _pymongo's gcc notes: http://api.mongodb.org/python/2.0.1/installation.html#dependencies-for-installing-c-extensions-on-unix
.. _pymongo binaries: http://pypi.python.org/pypi/pymongo/

Integrate MongoDB with Flask
----------------------------

Let's now add a new view to our controller to store arbitrary values in our
MongoDB and list them from the DB using our template engine.

Here's a new version of ``hello.py``::

    from flask import Flask, render_template
    from pymongo import Connection
    from datetime import datetime

    app = Flask(__name__)
    connection = Connection()
    db = connection.hello

    @app.route('/')
    def hello_world():
        return 'Hello, World!'

    @app.route('/hello/')
    @app.route('/hello/<name>')
    def hello_world_template(name=None):
        return render_template('hello.jinja2.html', name=name)

    @app.route('/store/<value>')
    def store(value=None):
        obj = {"value": value, "timestamp": datetime.now()}
        db.values.insert(obj)
        return "OK %r" % obj

    @app.route('/list/')
    def list():
        records = db.values.find({})
        return render_template('list.jinja2.html', records=records)

    @app.route('/clear/')
    def clear():
        db.values.remove()
        return "OK"

    def main():
        app.run(debug=True)

    if __name__ == '__main__':
        main()

We have two new module-level names, ``connection`` and ``db``. The first is the
MongoDB connection, which is acquired once upon application startup. If your
Flask application fails to start up with an error like this::

    pymongo.errors.AutoReconnect: could not connect to localhost:27017: [Errno 61] Connection refused

... this means that MongoDB is not running on your machine. This often means
you need to run the ``mongod`` command or restart your UNIX service, e.g.
``start mongod`` or ``/etc/init.d/mongod start``, depending on your system.

If Flask starts up, it means the MongoDB connection was acquired correctly. The
second name, ``db``, points to a MongoDB database called ``hello``.

Once we have a db, we can start querying it and storing records in it. Below
our ``hello_world_`` view functions, we have three new functions: ``store``,
``list``, and ``clear``. This is like the "hello, world" of database methods.
Our ``store`` view allows us to store a new object in our database simply
visiting a URL like ``/store/John``. The object created gets a UUID assigned by
MongoDB itself in the ``_id`` field, a ``value`` (in this case, "John"), and a
``timestamp``, which is the current system time. All data is stored in a
MongoDB collection called ``values``.

Visiting ``/list/`` will use a template to render all objects currently in the
``values`` collection. Since MongoDB is a persistent database, these records
will survive even server or database restarts. Here is the template you need
for ``list/``; store it in ``templates/list.jinja2.html``::

    <!doctype html>
    <title>Listing values from DB...</title>
    <ol>
    {% for record in records %}
    <li><strong>{{ record.value }}</strong>
        <small>({{ record.timestamp }}, {{ record._id }})</small>
    </li>
    {% endfor %}
    </ol>

Finally, ``/clear`` simply removes all records from the ``values`` collection.

You can now experiment with your little database web application. For example,
try this sequence:

1. http://127.0.0.1:5000/store/Person1
2. http://127.0.0.1:5000/store/Person2
3. http://127.0.0.1:5000/list/
4. http://127.0.0.1:5000/clear/
5. http://127.0.0.1:5000/store/Person3
6. Restart your web server (kill hello.py at console and rerun ``python hello.py``)
7. http://127.0.0.1:5000/list/

Pretty cool, huh?

Conclusion
----------

So, you made a basic HTTP server using Flask, it serves up basic HTML responses
using rendered output from Jinja2. You have also integrated your Flask server
with MongoDB, a simple JSON-based object storage system.
