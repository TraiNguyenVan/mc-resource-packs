# mc-resource-packs

Custom Java Edition resource packs. Each top-level directory is a pack with a
`pack.mcmeta` and vanilla `assets/` layout inside it.

## Packs

| Pack | Replaces |
| --- | --- |
| `server-additional-features-pack` | cat ambient sounds (Onii-chan, Oh My Gah, and Meow), creeper fuse (bomb.m4a), and generic explosions (bomb-1.m4a) |

The source audio recordings remain at the repository root; the pack contains stereo 48 kHz
high-quality Vorbis copies under its `assets/minecraft/sounds/` directory.

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

Pack sounds use mono OGG Vorbis; each file declares its sample rate in the OGG header.
