cd "$(dirname "$0")"
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -o out/test_svg/codepoint -f %u  &&
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -o out/test_svg/shortcode -f %d/%s
