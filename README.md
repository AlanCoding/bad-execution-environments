### Build a bad Execution Environment (EE)

This repo gives Dockerfiles to build execution environments that will break AWX.
The intent is to use these to test that our error-handling is behaving correctly.
To be able to test, you need to run it as a container group job. Why?
Because only container group jobs use the ansible-runner install from inside
the image.

#### Starting line

This should build an EE that gives non-json line from `ansible-runner worker`
before the ordinary streaming starts.

If you want to run this manually, you need to do `podman login` and somehow
figure that out, and then build
`podman build --tag quay.io/alancoding/bad-ee:latest .`
after you cd into the `starting_line/`.
Pushing looks like `podman push quay.io/alancoding/bad-ee:latest`. But it's
a lot bettet to use the Makefile targets.

Confirm the bad thing it is supposed to do:

```
$ podman run --rm --tty --interactive quay.io/alancoding/bad-ee:latest /bin/bash -c "echo foo | ansible-runner worker"
surprise
{"status": "error", "job_explanation": "Failed to JSON parse a line from transmit stream."}
{"eof": true}
```

How does the Dockerfile do this? It has an ugly `sed` command.
This adds a line after

```python
        self._output = _output
```

that writes a word to that
output buffer.

#### Ending line

In this scenario, we wish to write a non-json line after most of the job
has finished, but still before the EOF event has been written.

That EOF line is written right after in this line:

```python
    def finished_callback(self, runner_obj):
```

So _after_ this line we add the extra write.
