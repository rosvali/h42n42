# docker build -t h42n42 .
# docker run --rm -ti h42n42 bash

FROM ocaml/opam:debian-10-ocaml-4.14

RUN opam update
RUN opam switch create 4.14.1
WORKDIR /app

# System dependencies
RUN sudo apt-get install -y postgresql imagemagick npm ruby-sass pkg-config \
  zlib1g-dev libgmp-dev

# Preinstall some packages to gain time during the next step
RUN opam install -y dune js_of_ocaml eliom ocsigen-start

# Copy the project's description and install its dependencies
COPY *.opam .
RUN opam install -y .

COPY . .
