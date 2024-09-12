#!/bin/bash
#!/usr/bin/env python3

cd "$(dirname "$0")"

version=2023.12
render_threads=12
base_dir="out/npm"
prefix="@mutant-standard/" # package name prefix


# make the directory we're going to use to put these in
mkdir -p $base_dir &&


# get orxporter to do its thing
echo "creating images..."
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r resvg -o "$base_dir" -f short-%f/img/%s -t "$render_threads" -F svg,pngc-32,pngc-128,pngc-512,webp-128,jxl-128 -l &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -r resvg -o "$base_dir" -f code-%f/img/%u -t "$render_threads" -F svg,pngc-32,pngc-128,pngc-512,webp-128,jxl-128 -l &&
./orxporter/orxport.py -m manifest/out.orx -j "$base_dir/data.json"

# packages!
# ----------------------------------------------------------------------

make_pkg () {
    pkg="$1"
    out_folder="${base_dir}/${pkg}"
    cp -R texts "$out_folder"
    cp "$base_dir/data.json" "$out_folder"
    # 1.0.0-$version is to comply with semver.
    cat >"$out_folder/package.json" <<_EOF
{
  "name": "$prefix$pkg",
  "version": "1.0.0-$version",
  "description": "An experimental emoji set with new twists.",
  "repository": {
    "type": "git",
    "url": "git+https://github.com/mutantstandard/build.git"
  },
  "scripts": {},
  "author": "Caius Nocturne (nocturne.works)",
  "license": "CC-BY-NC-SA-4.0",
  "bugs": {
    "url": "https://github.com/mutantstandard/build/issues"
  },
  "homepage": "https://github.com/mutantstandard/build#readme"
}
_EOF
  echo 'run `npm publish --access public` in '"$out_folder"' to publish @mutant-standard/'"$pkg"
}

for pkg in {code,short}-{svg,pngc-32,pngc-128,pngc-512,webp-128,jxl-128};
do
    make_pkg "$pkg"
done

echo ""
echo "Mutant Standard export complete!"