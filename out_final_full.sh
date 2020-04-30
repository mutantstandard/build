cd "$(dirname "$0")"

version=2020.04

# get orxporter to do its thing
echo "creating images..."
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r rendersvg -o out/final/shortcode -f %f/%d/%s -t 4 -F svgo,pngc-32,pngc-128,pngc-512,webp-32,webp-128  &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r rendersvg -o out/final/codepoint -f %f/%u -t 4 -F svgo,pngc-32,pngc-128,pngc-512,webp-32,webp-128   &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r rendersvg -o out/final/mastodon -f ms_%s -t 4 -F pngc-128  &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r rendersvg -o out/final/font_sources -f png-%z/%u -t 4 -l -F pngc-32,pngc-64,pngc-128  &&


# export fonts
echo "compiling fonts..."
python3 ./forc/forc.py -m manifest/font/manifest.json -a manifest/font/aliases.json -i out/final/font_sources -o out/final/font -F sbixOT,sbixOTiOS --afsc



# packages!
# ----------------------------------------------------------------------
echo "compiling package folders..."

mkdir -p out/final-pkg &&
./orxporter/orxport.py -m manifest/out.orx -j out/final-pkg/mtnt_${version}_data.json

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
    file_name="${1}"
    out_folder="out/final-pkg/mtnt_${version}_${2}"

    cp -R texts out/final-pkg &&
    mv out/final-pkg/texts "$out_folder" &&
    mkdir -p "${out_folder}/font" &&
    mv "out/final/font/${1}" "${out_folder}/font/${file_name}"

    #zip -r -q "${out_folder}.zip" "$out_folder"
}



make_pkg shortcode/svgo short_svg
make_pkg shortcode/pngc-32 short_png32
make_pkg shortcode/pngc-128 short_png128
make_pkg shortcode/pngc-512 short_png512
make_pkg shortcode/webp-32 short_webp32
make_pkg shortcode/webp-128 short_webp128

make_pkg mastodon masto

make_pkg codepoint/svgo code_svg
make_pkg codepoint/pngc-32 code_png32
make_pkg codepoint/pngc-128 code_png128
make_pkg codepoint/pngc-512 code_png512
make_pkg codepoint/webp-32 code_webp32
make_pkg codepoint/webp-128 code_webp128

make_pkg_font MutantStandardEmoji-sbixOT.ttf font_sbixot
make_pkg_font MutantStandardEmoji-sbixOT-iOS.mobileconfig font_sbixotios

echo "Mutant Standard export complete!"
