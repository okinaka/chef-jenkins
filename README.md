Description
===========
Installs and configures Jenkins CI server.

Attributes
==========

* jenkins[:java_home] - Java install path, used for for cli commands
* jenkins[:server][:home] - JENKINS_HOME directory
* jenkins[:server][:user] - User the Jenkins server runs as
* jenkins[:server][:group] - Jenkins user primary group
* jenkins[:server][:port] - TCP listen port for the Jenkins server
* jenkins[:server][:url] - Base URL of the Jenkins server
* jenkins[:node][:home] - Home directory of the node

Usage
=====

'default' recipe
----------------

Installs a Jenkins CI server.

'jenkins_cli' resource provider
-------------------------------

This resource can be used to execute the Jenkins cli from your recipes.  For example, install git plugin and restart Jenkins:

    jenkins_cli "install-plugin git"
    jenkins_cli "safe-restart"
