# mc-resource-packs

Custom Java Edition resource packs. Each top-level directory is a pack with a
`pack.mcmeta` and vanilla `assets/` layout inside it.

## Packs

| Pack | Replaces |
| --- | --- |
| `server-additional-features-pack` | llama ambient sounds |

Repackaged raw audio lives nowhere; source recordings must be re-added by the
maintainer alongside the `.ogg` they produce.

## Build

```sh
./build.sh server-additional-features-pack 1.0.0
# -> dist/server-additional-features-pack-1.0.0.zip
```

Bump to a new version string for every republish so CDN caches do not serve a
stale file from the same URL.

sound file conversion (reference):

```sh
ffmpeg -ss <start> -t <len> -i <video> -map 0:a \
  -af "highpass=f=80,lowpass=f=16000,loudnorm=I=-18:TP=-1.5:LRA=7,afade=t=in:d=0.015,afade=t=out:st=<len-0.015>:d=0.015" \
  -ac 1 -ar 32000 -vn <out>.ogg
```

`.ogg` Vorbis, mono, 32 kHz is what the game expects for mob replacements.
