#!/bin/bash
#!/usr/bin/env python3

cd "$(dirname "$0")"

version=2023.11
render_threads=12
base_dir="out/final"


# make the directory we're going to use to put these in
mkdir -p $base_dir &&


# get orxporter to do its thing
echo "creating images..."
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r resvg -o $base_dir/short-%f -f %d/%s -t ${render_threads} -F svg,pngc-32,pngc-128,pngc-512,webp-128,jxl-128  &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r resvg -o $base_dir/code-%f -f %u -t ${render_threads} -F svg,pngc-32,pngc-128,pngc-512,webp-128,jxl-128 &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r resvg -o $base_dir/masto -f ms_%s -t ${render_threads} -F pngc-128  &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r resvg -o $base_dir/web -f %f/%s -t ${render_threads} -F pngc-128,webp-128  &&
./orxporter/orxport.py -m manifest/out.orx -j $base_dir/mtnt_${version}_data.json &&


# packages!
# ----------------------------------------------------------------------
echo "compiling package folders..."


make_pkg () {
    echo "compiling zip package: ${1}"

    pkg="mtnt_${version}_${2}"
    out_folder="${base_dir}/${pkg}"

    # copy texts into the out folder
    # move emoji into the out folder/emoji
    cp -R texts $out_folder &&
    mv "${base_dir}/${1}" "$out_folder/emoji"
    
    # go into the destination folder, put the contents
    # into a zip of the same name, go back and delete
    # the remaining empty folder
    cd "${out_folder}"
    zip -r -q -m "../${pkg}.zip" "."
    cd - > /dev/null # shhh dont tell anyone it's our secret
    rm -d "${out_folder}"
}


make_pkg short-svg short_svg
make_pkg short-pngc-32 short_png32
make_pkg short-pngc-128 short_png128
make_pkg short-pngc-512 short_png512
make_pkg short-webp-128 short_webp128
make_pkg short-jxl-128 short_jxl128

make_pkg masto masto

make_pkg code-svg code_svg
make_pkg code-pngc-32 code_png32
make_pkg code-pngc-128 code_png128
make_pkg code-pngc-512 code_png512
make_pkg code-webp-128 code_webp128
make_pkg code-jxl-128 code_jxl128

echo "Mutant Standard export complete!"
