FROM alpine:3.2
# vim:set ft=sh:

# If we use tmux we need to specify a 256 color terminal
# if our terminal does not support bce then use a simple 256
# env TERM screen-256color
env TERM screen-256color-bce

RUN apk add --update bash alpine-sdk bc bison strace htop automake autoconf \
        tmux flex fuse gawk gettext diffutils coreutils sed \
        grep less tig m4 ncurses-dev texinfo vim zlib-dev tzdata

RUN rm -rf /var/cache/apk/*
# replace some links..
RUN rm -rf /bin/sh && ln -svf /bin/bash /bin/sh
RUN rm -rf /usr/bin/vi && ln -svf /usr/bin/vim /usr/bin/vim

ADD http://ftp.gnu.org/gnu/time/time-1.7.tar.gz /tmp/time-1.7.tar.gz
ADD docker/* /tmp/
RUN chmod +x /tmp/buildtime.sh
RUN /tmp/buildtime.sh

ENV USER builder
ENV GROUP builder
ENV HOME /home/${USER}
RUN addgroup -g 1500 ${GROUP} \
        && adduser -h ${HOME} -s /bin/bash -u 1000 -G ${GROUP} -D ${USER} \
        && echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

VOLUME ${HOME}
ENV PATH ${HOME}/bin:${PATH}

USER ${USER}
WORKDIR ${HOME}
CMD ["/bin/bash"]
