cd "$(dirname "$0")"
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -o out/all_slice -r resvg -f %f/%s -t 8 -F svg,png-32,pngc-32,jxl-32,webp-32 -e cat=food_drink_herbs
