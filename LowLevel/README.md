Created with

```
poetry new LowLevel
```

See https://python-poetry.org/docs/basic-usage/

You don't have to look up the versions in pip of the modules, i.e. dependencies you want to add. Instead, for example, if you wanted to add `aioquic` as a dependency, as if you're specifying it in a `requirements.txt` file, you can just do

```
poetry add aioquic
```