Apple System Log (ASL) Streamer
===============================

Search and stream suspicous activity from the ASL into ELK+ECS logging.

Useful reference reading:

- https://asl.readthedocs.io/en/latest/index.html
- https://buildmedia.readthedocs.org/media/pdf/asl/latest/asl.pdf
- https://papers.put.as/papers/macosx/2017/macOSLogsv2017.pdf

.. contents::


Development
-----------

I'm using make, docker-compose, python3 and virtualenvwrappers to develop the 
project locally. I currently work of Mac OSX for development and use Homebrew 
to install what I need. Your mileage may vary. To set up the code for development 
you can do::

    mkvirtualenv --clear -p python3 aslstreamer
    make test_install

    # install the package in development modes
    make develop

    # run the asl_streamer
    asl_streamer

There is a ``make install``. This only installs the apps dependancies and not 
those needed for testing. To run the service locally in the dev environment do::

   # activate the env
   workon aslstreamer
