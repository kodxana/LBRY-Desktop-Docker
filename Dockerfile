FROM kasmweb/core-ubuntu-bionic:1.9.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

RUN  wget  https://github.com/lbryio/lbry-desktop/releases/download/v0.50.2/LBRY_0.50.2.deb \
    && apt-get update \
    && apt-get install -y apt-transport-https \
    && apt-get install -y ./LBRY_0.50.2.deb \
    && rm LBRY_0.50.2.deb \
    && cp /usr/share/applications/lbry.desktop $HOME/Desktop/ \
    && chmod +x $HOME/Desktop/lbry.desktop \
    && chown 1000:1000 $HOME/Desktop/lbry.desktop

RUN echo "/usr/bin/desktop_ready && /opt/LBRY/lbry --no-sandbox &" > $STARTUPDIR/custom_startup.sh \
&& chmod +x $STARTUPDIR/custom_startup.sh
RUN wget https://cdn.lbryplayer.xyz/api/v4/streams/free/lbry-wallpaper1/ae014625e5c278935bd0796d53b6124c011e735d/6a5622 -O $HOME/.config/bg_default.png


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
