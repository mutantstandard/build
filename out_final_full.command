cd "$(dirname "$0")"

version=0.4.1

# get orxporter to do its thing
echo "creating images..."
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -r rendersvg -o out/final/codepoint -f %f/%u -t 4 -F svg,png-32,png-64,png-128,png-512,webp-32,webp-128   &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -r rendersvg -o out/final/shortcode -f %f/%d/%s -t 4 -F svg,png-32,png-128,png-512,webp-32,webp-128  &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -r rendersvg -o out/final/mastodon -f ms_%s -t 4 -F png-128  &&



# set up font sources
echo "creating font sources..."
mkdir -p out/final/font_sources &&

cp -R out/final/codepoint/png-32 out/final/font_sources &&
mv out/final/codepoint/png-64 out/final/font_sources/png-64 &&
cp -R out/final/codepoint/png-128 out/final/font_sources &&
cp -R out/final/codepoint/svg out/final/font_sources &&




# optimise all PNGs
# (with differing paramters based on the situation)
# not crunching 32px PNGs because it's like getting blood from a stone.
echo "crunching PNGs..."

oxipng -r out/final/shortcode/png-128 &&
oxipng -r out/final/shortcode/png-512 &&
oxipng -r out/final/mastodon/ &&

oxipng -r out/final/codepoint/png-128 &&
oxipng -r out/final/codepoint/png-512 &&

oxipng -r -s out/final/font_sources/png-64 &&
oxipng -r -s out/final/font_sources/png-128 &&



# optimise the SVGs that won't be used as font sources
echo "optimising SVGs..."
find out/final/codepoint/svg -name *.svg -exec svgcleaner {} {} \;
find out/final/shortcode/svg -name *.svg -exec svgcleaner {} {} \;



# export fonts
echo "compiling fonts..."
python3 ./forc/forc.py -m manifest/font/manifest.json -a manifest/font/aliases.json -i out/final/font_sources -o out/final/font -F SVGinOT,sbixOT,sbixOTiOS --afsc




# packages!
# ----------------------------------------------------------------------
echo "compiling package folders..."

mkdir -p out/final-pkg &&
./orxporter/orxport.py -m manifest/out.orx -j out/final-pkg/mtnt_data_${version}.json

function make_pkg {
    out_folder="out/final-pkg/mtnt_${version}_${2}"

    cp -R texts out/final-pkg &&
    mv out/final-pkg/texts "$out_folder" &&
    mv "out/final/${1}" "$out_folder/emoji"

    # you can't compress folders right now because of .DS_STORE.
    #zip -r -q "${out_folder}.zip" "$out_folder"
    #tar -zcf "${out_folder}.tar.gz" "$out_folder"
}


function make_pkg_font {
    file_name="mtnt_${version}_${1}"
    out_folder="out/final-pkg/mtnt_${version}_${2}"

    cp -R texts out/final-pkg &&
    mv out/final-pkg/texts "$out_folder" &&
    mkdir -p "${out_folder}/font" &&
    mv "out/final/font/${1}" "${out_folder}/font/${file_name}"

    #zip -r -q "${out_folder}.zip" "$out_folder"
}



make_pkg shortcode/svg short_svg
make_pkg shortcode/png-32 short_png32
make_pkg shortcode/png-128 short_png128
make_pkg shortcode/png-512 short_png512
make_pkg shortcode/webp-32 short_webp32
make_pkg shortcode/webp-128 short_webp128

make_pkg mastodon masto

make_pkg codepoint/svg code_svg
make_pkg codepoint/png-32 code_png32
make_pkg codepoint/png-128 code_png128
make_pkg codepoint/png-512 code_png512
make_pkg codepoint/webp-32 code_webp32
make_pkg codepoint/webp-128 code_webp128

make_pkg_font SVGinOT.otf font_svginot
make_pkg_font sbixOT.ttf font_sbixot
make_pkg_font sbixOTiOS.mobileconfig font_sbixotios

echo "Mutant Standard export complete!"
