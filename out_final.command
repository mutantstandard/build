cd "$(dirname "$0")"
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -o out/final/codepoint -F svg,png-32,png-128,png-512 -t 4 -f %f/%u &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -o out/final/shortcode -F svg,png-32,png-128,png-512 -t 4 -f %f/%d/%s &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -o out/final/mastodon -F png-128 -t 4 -f ms_%s
