FROM nixos/nix:2.2.1

RUN mkdir -p /opt/app
RUN mkdir    /opt/app/dist

WORKDIR      /opt/app

COPY src                 src
COPY LICENSE             .
COPY cirqut-server.cabal .
COPY default.nix         .
COPY shell.nix           .
COPY release.nix         .

RUN TERM=dumb nix-shell --run 'echo'

CMD sh;
