# transitions-distribution
A collection of scripts and documents to ease the distribution of transitions.

## PyPI

The main distribution channel is [PyPI](https://pypi.org/).

### Installing the package
```bash
pip install transitions
# install transitions with 'diagrams' extras which currently depends on pygraphviz
pip install transitions[diagrams]  
```

Note that `pygraphviz` depends on Graphviz and may require development dependencies to build successfully.

## RPM

The SRPM package will be built from (a previously submitted) PyPI version and published via a custom [COPR](https://copr.fedorainfracloud.org/) repository.

### How to enable the repo
```
dnf copr enable aleneum/python-transitions
```

### Installing the package
```
dnf install python3-transitions
# optionally install PyGraphviz to use (variants of) 'GraphMachine'
dnf install python3-graphviz
```

### Check available versions
```
dnf --showduplicates list python3-transitions
```
