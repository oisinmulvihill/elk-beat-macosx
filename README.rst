Elk Stack And Filebeats
=======================

Investigation spike with filebeats and elkstack to see how to monitor system 
logs on Mac OSX. You will need to download Filebeat for your system. You can 
get binaries from:

- https://www.elastic.co/downloads/beats/filebeat

Once downloaded you can then run filebeat using the configuration in 
``./config/filebeat.yml``. Alternatively copy the filebeat binary into project
checkout directory. Then you can call ``make setup`` and then ``make run``.

I'm using make, docker-compose to organise and run the project locally. I 
currently work of Mac OSX for development and use Homebrew to install what I 
thanksneed. Your mileage may vary. 

.. contents::


Investigation Goals
-------------------

What I'm aiming to answer:

- Get logs into Elk stack and from MacOSX

  - No. filebeats works with log file. Since Mac OSX 10.12 Apple moved to a 
  compressed binary log system called Unified Logging. Filebeats doesn't 
  directly support this. There are things you can hack together around using 
  the Mac 'log stream' tool and Kibana. This talk is an excellent explanation. 
  It is from 2017 so some of it is no longer relevant https://papers.put.as/papers/macosx/2017/macOSLogsv2017.pdf

- Can I see failed login attempts? Can I see sudo usage? Can I see software installs?

  - Apple uses https://github.com/openbsm/openbsm which is a standard amoung 
  BSD based operating systems to manage an audit log covering these questions. 
  Working with this requires understanding this standard and the tools that go 
  with it. I think it would also be possible to hack together something that 
  might work with Filebeat/Kibana but I'm not sure its worth the effort.

While researching this further I came across another commercial tool which may
work. https://www.cmdsec.com/ this can put relevant security information into
Elk. Rather than the approach of logging everything and trying to figure out 
what is relevant. I've requested a trial and will see where I get to.


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