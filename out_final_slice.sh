cd "$(dirname "$0")"

version=2023.11
render_threads=12
base_dir="out/test-pkg"

mkdir -p $base_dir &&


# get orxporter to do its thing
echo "creating images..."



./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r resvg -o $base_dir/short-%f -f %d/%s -t ${render_threads} -F pngc-32 &&
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

make_pkg short-pngc-32 short_png32

echo "Mutant Standard export complete!"
