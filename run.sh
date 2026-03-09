#!/bin/bash

for md_in in ./*.md; do
    echo "Found file: $md_in"

    md_tmp="${md_in%.md}.tmp.md"
    pdf_out="${md_in%.md}.pdf"

    cp -f "$md_in" "$md_tmp"
    sed -i "/Teilnehmer: [0-9]\+/i - Datum: $(date +%d.%m.%Y)" "$md_tmp"
    # sed -i "/\[Link zum Board\]/d" "$md_tmp"
    sed -i "/\!\[.\+\](.\+)/d" "$md_tmp"

    echo -e "\tCreating $pdf_out..."
    docker run --rm -v "$(pwd):/pandoc" -u $(id -u):$(id -g) pandocker \
        --pdf-engine=lualatex \
        --template=eisvogel \
        -H pandocker-headers.tex \
        -V geometry="margin=2.0cm" \
        -V mainfont="Noto Color Emoji" \
        -V colorlinks=true \
        -V linkcolor=blue \
        -V urlcolor=blue \
        -o "$pdf_out" "$md_tmp"

    echo -e "\tCleaning up..."
    rm -f "$md_tmp"
done

echo "Done."
