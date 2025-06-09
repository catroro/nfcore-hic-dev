# 🚧 Modified version of nf-core/hic

This is a modified version of the nf-core/hic pipeline.

## 🔧 What’s new:
An additional step has been added to convert .mcool files into .npz format — the input format required for running C.origami.

## Usage
Make sure to include 10000 in the bin_size argument within your params.yaml file.
This is the resolution required by C.origami to function properly.

```bin_size: '5000,10000,20000,50000'```

## New output
The converted .npz files will be saved in: ```results/contact_maps/corigami```

## WIP 
The -resume flag currently does not work for this added step.