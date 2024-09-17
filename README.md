This is the containerized version of the PMN pipeline used to generate the PMN databases at https://plantcyc.org. The pipeline itself is in the repository at https://github.com/CharlesHawkinsCarnegie/PMN-Pipeline. The general documentation is there.

### Building
You can build it using:

    make pmn-ptools.sif

Note that about 20 GB of space is required in /tmp during the build process. If your /tmp directory is too small (as it is by default in Fedora, for example), you can tell it to put the temp files in a new directory tmp  in the current directory with:

    SINGULARITY_TMPDIR=$PWD/tmp make pmn.sif

On some systems you may need sudo to build the container; use sudo -E to forward environment variables if you need both the /tmp fix and sudo.

### Running
Run the pipeline with:

    ./pmn-ptools.sif [arguments]

To get an overview of the arguments, run:

    ./pmn-ptools.sif -h

For a full manual and quickstart guide, see the Manual.md and Quickstart.md files in the PMN-Pipeline repo linked above
