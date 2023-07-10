FROM ocaml/opam:ubuntu-ocaml-4.07

RUN sudo apt-get update &&\
    # sudo add-apt-repository ppa:avsm/ppa -y &&\
    # sudo apt-get install opam -y &&\
    # sudo apt install ocaml-nox -y &&\
    # sudo apt install build-essential -y &&\
    # sudo apt-get install manpages-dev -y &&\
    # sudo apt install ocaml-dune -y &&\
    opam init -y &&\
    eval $(opam env) &&\
    sudo apt-get install libev-dev -y &&\ 
    sudo apt-get install libgdbm-dev -y &&\
    sudo apt-get install libncurses5-dev -y &&\ 
    sudo apt-get install libpcre3-dev -y &&\
    sudo apt-get install libssl-dev -y &&\
    sudo apt-get install libsqlite3-dev -y &&\ 
    sudo apt-get install libcairo-ocaml-dev -y &&\ 
    sudo apt-get install m4 -y &&\
    sudo apt-get install camlp4-extra -y &&\
    sudo apt-get install libgmp-dev -y &&\
    sudo apt-get install imagemagick npm -y &&\
    sudo apt install postgresql ruby-sass -y

ENV OPAMSOLVERTIMEOUT="500"

RUN opam install ocsigen-start -y &&\
    eval $(opam env) &&\ 
    opam install .
    # make db-init &&\
    # make db-create &&\
    # make db-schema &&\
    # make test.opt &&\

WORKDIR usr/app

COPY . .

RUN make test.byte