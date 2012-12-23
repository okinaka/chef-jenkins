name              "jenkins"
maintainer        "OKINAKA Kenshin"
maintainer_email  "okinakak@yahoo.co.jp"
license           "Apache 2.0"
description       "Installs and configures Jenkins CI server"
version           "0.0.1"

depends "java"
recommends "apt"
recommends "yum"

recipe "jenkins", "Installs jenkins"
