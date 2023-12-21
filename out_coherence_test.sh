cd "$(dirname "$0")"
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -o out/coherence -r resvg -f %f/%s -t 8 -F svg
