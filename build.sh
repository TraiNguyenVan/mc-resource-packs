#!/bin/sh
# Build a pack zip: build.sh <pack-dir> <version>
set -eu
pack="$1"
version="$2"
out="dist/${pack}-${version}.zip"
rm -f "$out"
# zip may be absent; use python (stdlib, no external deps)
python3 - "$pack" "$out" <<'EOF'
import os, sys, zipfile
pack, out = sys.argv[1], sys.argv[2]
with zipfile.ZipFile(out, "w", zipfile.ZIP_STORED) as z:
    for root, _, files in os.walk(pack):
        for f in sorted(files):
            p = os.path.join(root, f)
            z.write(p, os.path.relpath(p, pack))
EOF
python3 -m zipfile -l "$out"
