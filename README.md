This is the containerized version of the PMN pipeline used to generate the PMN databases at https://plantcyc.org. The pipeline itself is in the repository at https://github.com/CharlesHawkinsMSU/PMN-Pipeline. Typically you won't need to clone that repository yourself, as this is done for you by the container build scripts in this repository.

### Documentation

The [quickstart guide](https://github.com/CharlesHawkinsMSU/PMN-Pipeline/blob/main/Quickstart.md) will walk you through the initial setup and doing a simple pipeline run on sweet orange (*Citrus sinensis*) 

The [full manual](https://github.com/CharlesHawkinsMSU/PMN-Pipeline/blob/main/Manual.md) describes the pipeline in more detail along with the various options it has available, and has a FAQ/troubleshooting section.

### Requirements and Preparation
You will need a copy of Pathway Tools 28.0 to build this container. See the quickstart guide or the manual linked above. Place the linux tier 1 installer into the git project directory after you have git-cloned it or unzipped a release tarball. Building the container also requires Singularity CE and GNU Make to be installed.

The `pmn.sh` script is the main front-end for building and using the containerized pipeline. You may wish to symlink it into your PATH, such as with `sudo ln -s pmn.sh /usr/local/bin/pmn`. You can then invoke the pipeline with just the command `pmn` from anywhere on your system. The below commands assume you have done so.

### Building
You can build the container using:

    pmn build

### Running
Once the container has built, you can run the pipeline's operations with:

    pmn <stage> [<stage_2> [...]] [<arguments>]

To get an overview of the arguments, run:

    pmn -h

The pipeline primarily consists of running 'stages' which you will run in order. To see a list of available stages, you can enter:

    pmn list-stages

At this point, we recommend you look at the [quickstart guide](https://github.com/CharlesHawkinsMSU/PMN-Pipeline/blob/main/Quickstart.md) to learn the basics of creating a pathway-genome database.
