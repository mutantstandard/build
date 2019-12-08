cd "$(dirname "$0")"

# get orxporter to do its thing
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -r rendersvg -o out/final/codepoint -f %f/%u -t 4 -F svg,png-32,png-128,png-512   &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -r rendersvg -o out/final/shortcode -f %f/%d/%s -t 4 -F svg,png-32,png-128,png-512  &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -r rendersvg -o out/final/mastodon -f ms_%s -t 4 -F png-128 
