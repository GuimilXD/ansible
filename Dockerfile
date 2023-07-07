FROM archlinux:latest as base
WORKDIR /usr/local/bin
RUN pacman -Suy --noconfirm && \
    pacman -S --noconfirm ansible curl git sudo

FROM base AS guil
ARG TAGS
RUN groupadd --gid 1000 guil
RUN useradd -c guil --uid 1000 --gid 1000 guil -m
RUN echo 'guil ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /home/guil
USER guil

FROM guil
ENV USER=guil
COPY --chown=guil:guil . .
CMD ansible-playbook $TAGS --skip-tags desktop local.yml && bash
