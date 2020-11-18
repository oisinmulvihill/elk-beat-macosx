Elk Stack And Filebeats
=======================

Investigation spike with filebeats and elkstack to see how to monitor system 
logs on Mac OSX. You will need to download Filebeat for your system. You can 
get binaries from:

- https://www.elastic.co/downloads/beats/filebeat

Once downloaded you can then run filebeat using the configuration in 
``./config/filebeat.yml``. Alternatively copy the filebeat binary into project
checkout directory. Then you can call ``make setup`` and then ``make run``.

I'm using make, docker-compose organise and run the project locally. I 
currently work of Mac OSX for development and use Homebrew to install what I 
need. Your mileage may vary. 

.. contents::


Investigation Goals
-------------------

What I'm aiming to answer:

- Get logs into Elk stack and from MacOSX

  - Can I see failed login attempts?

  - Can I see sudo usage?

  - Can I see software installs?


Local Set-up
------------

.. code:: 

    # run elk stack (in its own terminal)
    make up

    # Link to your filebeat binary if its not in the path:
    ln -s <path to filebeat binary> filebeat

    # install the indices and dashboard into kibanan (in its own terminal)
    make setup

    # Run filebeat locally shipping logs into kibana
    make run

    # Alternatively run file beat as follows:
    filebeat -e -strict.perms=false -c config/filebeat.yml


Hard reset Elkstack
-------------------

You may want to start again from scratch. To do this:

.. code: bash

    # stop any running services
    make down

    # stop filebeat if you want

    # See the local persistent volumes:
    docker volume list
    DRIVER              VOLUME NAME
    local               elkbeats_data01
    local               elkbeats_data02
    local               elkbeats_data03

    # remove persistent storage:
    docker volume rm elkbeats_data01
    docker volume rm elkbeats_data02
    docker volume rm elkbeats_data03

You'll need to run the ``filebeat setup`` after the elkstack has been restarted.