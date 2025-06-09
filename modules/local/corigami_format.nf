process CORIGAMI_FORMAT {
    tag "$meta.id"
    label 'process_low'

    conda "bioconda::cooler=0.10.3"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/cooler:0.10.3--pyhdfd78af_0' :
        'quay.io/biocontainers/cooler:0.10.3--pyhdfd78af_0' }"

    publishDir = [
        path: { "${params.outdir}/contact_maps/corigami" },
        mode: params.publish_dir_mode,
        saveAs: { filename -> filename.equals('versions.yml') ? null : filename }
    ]

    input:
    tuple val(meta), path(mcool)

    output:
    tuple val(meta), path("${meta.id}"), emit: corigami_output
    path "versions.yml", emit: versions

    script:
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    set -e
    mkdir -p ${prefix}
    corigami_format.py $mcool ${prefix}/

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        python: \$(python --version | sed 's/Python //g')
        cooler: \$(cooler --version | sed 's/cooler, version //g')
    END_VERSIONS
    """
}

// process CORIGAMI_FORMAT {
//     tag "$meta.id"
//     label 'process_low'

//     conda "bioconda::cooler=0.10.3 conda-forge::python=3.9"
//     container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
//         'https://depot.galaxyproject.org/singularity/cooler:0.10.3--pyhdfd78af_0' :
//         'quay.io/biocontainers/cooler:0.10.3--pyhdfd78af_0' }"

//     publishDir = [
//         path: { "${params.outdir}/contact_maps/corigami" },
//         mode: params.publish_dir_mode,
//         saveAs: { filename -> filename.equals('versions.yml') ? null : filename }
//     ]

//     input:
//     tuple val(meta), path(mcool)

//     output:
//     tuple val(meta), path("${meta.id}"), emit: corigami_output
//     path "versions.yml", emit: versions

//     script:
//     def args = task.ext.args ?: ''
//     def prefix = task.ext.prefix ?: "${meta.id}"
//     """
//     echo "=== DEBUG INFO ==="
//     echo "Current working directory: \$(pwd)"
//     echo "Contents of current directory:"
//     ls -la
//     echo "PATH: \$PATH"
//     echo "Which corigami_format.py: \$(which corigami_format.py || echo 'NOT FOUND')"
//     echo "==================="

//     set -e
//     mkdir -p ${prefix}
//     corigami_format.py $mcool ${prefix}/ 2>&1 | tee ${prefix}_conversion.log

//     cat <<-END_VERSIONS > versions.yml
//     "${task.process}":
//         python: \$(python --version | sed 's/Python //g')
//         cooler: \$(cooler --version | sed 's/cooler, version //g')
//     END_VERSIONS
//     """
// }
// process CORIGAMI_FORMAT {
//     tag "$meta.id"
//     label 'process_low'

//     conda "bioconda::cooler=0.10.3"
//     container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
//         'https://depot.galaxyproject.org/singularity/cooler:0.10.3--pyhdfd78af_0' :
//         'quay.io/biocontainers/cooler:0.10.3--pyhdfd78af_0' }"

//     publishDir = [
//         path: { "${params.outdir}/contact_maps/corigami" },
//         mode: params.publish_dir_mode,
//         saveAs: { filename -> filename.equals('versions.yml') ? null : filename }
//     ]

//     input:
//     tuple val(meta), path(mcool)  // Only the mcool input

//     output:
//     tuple val(meta), path("${meta.id}"), emit: corigami_output
//     path "versions.yml", emit: versions

//     script:
//     def args = task.ext.args ?: ''
//     def prefix = task.ext.prefix ?: "${meta.id}"
//     // """
//     // set -e
//     // mkdir -p ${prefix}
//     // python corigami_format.py $mcool ${prefix}/ 2>&1 | tee ${prefix}_conversion.log

//     // cat <<-END_VERSIONS > versions.yml
//     // "${task.process}":
//     //     python: \$(python --version | sed 's/Python //g')
//     //     cooler: \$(cooler --version | sed 's/cooler, version //g')
//     // END_VERSIONS
//     // """
//     """
//     echo "=== DEBUG INFO ==="
//     echo "Current working directory: \$(pwd)"
//     echo "Contents of current directory:"
//     ls -la

//     echo "Script path: corigami_format.py"
//     echo "Script exists: \$(test -f corigami_format.py && echo 'YES' || echo 'NO')"
//     echo "==================="

//     set -e
//     mkdir -p ${prefix}
//     python corigami_format.py $mcool ${prefix}/ 2>&1 | tee ${prefix}_conversion.log

//     """
// }
