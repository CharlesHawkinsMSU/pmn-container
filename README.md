This is the containerized version of the PMN pipeline used to generate the PMN databases at https://plantcyc.org. The pipeline itself is in the repository at https://github.com/CharlesHawkinsCarnegie/PMN-Pipeline.

### Building
You can build it using:

    sudo make pmn.sif

Note that about 20 GB of space is required in /tmp during the build process. If your /tmp directory is too small (as it is by default in Fedora, for example), you can tell it to put the temp files in a new directory tmp  in the current directory with:

    SINGULARITY_TMPDIR=$PWD/tmp sudo -E make pmn.sif

### Running
Run the pipeline with:

    ./pmn.sif [arguments]

To get an overview of the arguments, run:

    ./pmn.sif -h

