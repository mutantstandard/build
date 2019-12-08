# Mutant Standard Build Files

This repository contains all of the files required to build a custom Mutant Standard package using [Orxporter](https://github.com/mutantstandard/orxporter).

-----

**These files are for anyone who is techy enough and is interested in seeing what a large Orxporter project looks like, or wants to create their own Mutant Standard packages in a format that's not offered by the website.**

**If you're a regular user, I highly suggest you go to [Mutant Standard's download page](https://mutant.tech/use) and download a package that's best for you.**

**This repository has no warranty and has only been tested in macOS.**

-----

## License

Everything in this repository is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).


-----

## How to use

### images

- Download the latest version of [orxporter](https://github.com/mutantstandard/orxporter/).
- Place orxporter in the `orxporter` directory.
- Start running export commands from the root directory of this repo.

If you want some ideas on how to make your own scripts and commands, in the root of this repo there are `.command` executable scripts, all of which are the ones I use in everyday tests and for the final export of each release.

The [orxporter repo](https://github.com/mutantstandard/orxporter/) has full documentation on how to create your own build commands and understand manifest files.

### fonts

*(this is just a basic quick guide for now)*

- Download and put orxporter in this folder (as described above), export like this:
- **(Use the fork by [Dzuk](https://github.com/dzuk-mutant/orxporter) for now, as the current Mutant Standard repo has an older, incompatible version)**

```
./orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -o out/font_sources -F svg,png-32,png-64,png-128 -t 4 -f %f/%u
```

- Download the latest version of [forc](https://github.com/mutantstandard/orxporter/).
- Place forc in the `forc` directory.
- Then build fonts with forc like this...


```
./forc/forc.py -m manifest/font/manifest.json -a manifest/font/aliases.json -i out/font_sources -o out/fonts -F [formats] --afsc
```

See forc's help (`-h` flag) to see what formats you can export to. forc also has a readme and documentation.

(the `--afsc` build flag is super-important if you're building a SVG font with Mutant Standard's images, **do not remove it**.)



------

## Translating?

Check out the [translation doc](translating.md) for some guidance.

------

## Locations of things

- `/input` is where the input emoji SVGs are.
- `/manifest` is where all the manifest files are, including license metadata.
- `/orxporter` is where orxporter should go.
- `/out` is where the exported emoji go (I recommend putting the output of any task in a sub-folder so you can make multiple types of exports without conflicts).

------

## PNG exports take a long time!

There are thousands of emoji, and rendering all of them in PNG will take many hours, especially depending on what resolutions and how many PNG versions you wish to export.

So just be careful and be prepared to set aside a few hours to wait for a full export if you're not using a computer that has serious horsepower.
