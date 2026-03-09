FROM dalibo/pandocker

RUN tlmgr update --self \
    && tlmgr install noto-emoji fontspec luacode
