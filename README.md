# quantum-ESPRESSO

Dockerfile for creating ubuntu environment
where Quantum Espresso v7.3.1 and Python-3.9.4 are compiled.

Reference: https://github.com/hayashikun/qe-docker

Steps:

* build docker image from Dockerfile.
  ```sh
  $ docker build ./ -t <IMAGE NAME and TAG>
  ```
  
  where ``<IMAGE NAME and TAG>`` is, for example, ``qe-7.3.1:latest``

* Run & attach
  ```sh
  $ docker run --name <CONTAINER NAME> -it <IMAGE ID or TAG>
  ```
