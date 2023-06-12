#!/bin/bash
#!/usr/bin/env python3

cd "$(dirname "$0")"

version=2022.12
render_threads=12
base_dir="out/test-pkg"


# get orxporter to do its thing
echo "creating images..."
mkdir -p $base_dir &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r resvg -o $base_dir/short-%f -f %d/%s -t ${render_threads} -F pngc-32 &&

# packages!
# ----------------------------------------------------------------------
echo "compiling package folders..."


./orxporter/orxport.py -m manifest/out.orx -j out/test-pkg/mtnt_${version}_data.json

make_pkg () {
    echo "compiling package: ${1}"

    pkg="mtnt_${version}_${2}"
    out_folder="${base_dir}/${pkg}"

    cp -R texts $out_folder &&
    mv -v "${base_dir}/${1}" "$out_folder/emoji"

    cd "${out_folder}"
    zip -r -q -m "../${pkg}.zip" "."
    cd -
}

make_pkg short-pngc-32 short_png32

echo "Mutant Standard export complete!"
