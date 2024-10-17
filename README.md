**Note: the PMN pipeline is currently in beta testing and may contain bugs**

This is the containerized version of the PMN pipeline used to generate the PMN databases at https://plantcyc.org. The pipeline itself is in the repository at https://github.com/CharlesHawkinsMSU/PMN-Pipeline. The general documentation is there.

### Documentation

There is a quickstart guide at https://github.com/CharlesHawkinsMSU/PMN-Pipeline/blob/main/Quickstart.md

There is a full manual at https://github.com/CharlesHawkinsMSU/PMN-Pipeline/blob/main/Manual.md

### Building
You will need a copy of Pathway Tools to build this container. See the quickstart guide or the manual linked above.
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
