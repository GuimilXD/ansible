FROM archlinux:latest as base
WORKDIR /usr/local/bin
RUN pacman -Suy --noconfirm && \
    pacman -S --noconfirm ansible curl git

FROM base AS guil
ARG TAGS
RUN groupadd --gid 1000 guil
RUN useradd -c guil --uid 1000 --gid 1000 guil -m
USER guil
WORKDIR /home/guil

FROM guil
COPY . .
