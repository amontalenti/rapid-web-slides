# Rapid Web Prototyping with Lightweight Tools

This is a 3-hour tutorial I gave at PyCon 2013 in Santa Clara, CA.

It discusses:

* why novice web devs tend to get overwhelmed by fancy frameworks
* why rapid web prototyping is important, even for experienced devs
* what lightweight tools are available in the web ecosystem (jQuery, Bootstrap)
* what complementary Python tools are available (Jinja2, Flask)
* how to put these pieces together to build web apps quickly
* a theory of "inside out" programming, starting with the UI and moving to the backend

## View the slides online

Slides can be viewed in compiled form at:

http://pixelmonkey.org/pub/rapid-web-slides/

Note that the slides can be controlled as follows:

 * Advance forward / back with the forward and back keys, or left click / right click of the mouse
 * Press `c` to get the "controls", which also allows you to skip slides and switch to outline mode
 * Outline mode includes some notes not included in the slidedeck, and also allows you to easily copy/paste examples into your own interpreter

I suggest you run through the slides in slide mode, and then review them in outline mode, doing examples from your own interpreter. That's how I tended to do things when I physically gave the presentation. Of course, you can also contact me on Twitter at [@amontalenti](http://twitter.com/amontalenti) if you want to see if I might be giving the talk nearby you sometime soon :-)

## How this was built

Using Python, of course. It's turtles all the way down.

I wrote the slides using [reST](http://docutils.sourceforge.net/rst.html), and specifically Docutils [support for S5 export](http://docutils.sourceforge.net/docs/user/slide-shows.html). Scripts are included to compile the presentation from the index.rst file and also to allow development of new slides with live recompilation using pyinotify (Linux systems only). See `build.sh` and `monitor.sh` for more information. If you have prince installed, you can also export these slides as a PDF using  `slides.sh`.
