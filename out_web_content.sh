cd "$(dirname "$0")"
./orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -q 32x32 -o out/web_content/mutstd -f %s &&
./orxporter/orxport.py -m manifest/out.orx -J out/web_content/emoji.json
