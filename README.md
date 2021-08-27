# OpenImageDenoise Command line

Based on https://github.com/DeclanRussell/IntelOIDenoiser.

I was fustrated that the original tool won't build proprely on Linux platforms.
There is a modified version that natively build on linux, with scripts to build
Intel Open Image Denoise.

# Building

Run the script `OIDNDownload.sh` to download a local copy of OIDN.
Then:
```
make
```
The executable will be found on the `bin` folder.
Finally, copy
```
libOpenImageDenoise.so
libOpenImageDenoise.so.1
libOpenImageDenoise.so.1.4.1
```
To the bin folder (If you used the script, these can be found on the oidn/build 
folder).

And set the LD_LIBRARY_PATH if needed.
```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.
```

# Usage
Command line parameters
* -v [int]        : log verbosity level 0:disabled 1:simple 2:full (default 2)
* -i [string]     : path to input image
* -o [string]     : path to output image
* -a [string]     : path to input albedo AOV (optional)
* -n [string]     : path to input normal AOV (optional, requires albedo AOV)
* -hdr [int]      : Image is a HDR image. Disabling with will assume the image
is in sRGB (default 1 i.e. enabled)
* -srgb [int]     : whether the main input image is encoded with the sRGB
(or 2.2 gamma) curve (LDR only) or is linear (default 0 i.e. disabled)
* -t [int]        : number of threads to use (defualt is all)
* -affinity [int] : Enable affinity. This pins virtual threads to physical
cores and can improve performance (default 0 i.e. disabled)
* -repeat [int]   : Execute the denoiser N times. Useful for profiling.
* -maxmem [int]   : Maximum memory size used by the denoiser in MB
* -clean_aux [int]: Whether the auxiliary feature (albedo, normal) images are
noise-free; recommended for highest quality but should *not* be enabled for
noisy auxiliary images to avoid residual noise (default 0 i.e. disabled)
* -h/--help : Lists command line parameters

You need to at least have an input and output for the app to run. If you also
have them, you can add an albedo AOV or albedo and normal AOVs to improve the
denoising. All images should be the same resolutions, not meeting this
requirement will lead to unexpected results (likely a crash).

For best results provide as many of the AOVs as possible to the denoiser.
Generally the more information the denoiser has to work with the better.
The denoiser also prefers images rendered with a box filter or by using FIS.

Please refer to the originial OIDN repository
[here](https://github.com/OpenImageDenoise/oidn) for more information.

# License
This work is licensed under the MIT License, please see LICENSE file for more
details