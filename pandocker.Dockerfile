FROM dalibo/pandocker:stable

RUN tlmgr update --self \
    && tlmgr install noto-emoji fontspec luacode
