# hydra-ray-demo
Demonstration of how to structure a project with Hydra for easy deployment with Ray.

## Quickstart

```bash
python -m pip install -r requirements.txt
python main.py
```
The default behavior of the application is determined by `config/main.yaml`

## Command-line configuration overrides
It's easy to override the default behavior of your application from the command line.
```bash
python main.py module=type_b
```
Any overrides will be stored in `outputs/<DATE>/<TIME>`, along with the program logs in case you come back later and
can't remember what command was run.

## Multirun
You can easily run configuration sweeps without any additional  boilerplate using the `-m` option. 
By default the basic launcher will schedule and execute the configurations serially.
```bash
python main.py -m module=type_a,type_b
```

## Launching configuration sweeps with Ray locally
You can use Ray to execute configurations in parallel. Thanks to the Hydra Ray plugin, you don't 
need to write any additional code!
```bash
python main.py -m hydra/launcher=ray module=type_a,type_b
```
Note: You must use the `-m` option when using anything other than the basic launcher.

## Launching configuration sweeps with Ray on EC2

Ray can also spin up new clusters for you on EC2 and run your jobs in parallel. Here's the setup you'll need to do.

### Setup Overview
1. Install the AWS CLI
2. [Configure your AWS access credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
3. [Raise your service quota](https://aws.amazon.com/premiumsupport/knowledge-center/ec2-instance-limit/) (if necessary)
4. [Configure IAM roles for ray nodes](https://github.com/ray-project/ray/issues/9327)

### How to make a docker container
This part of the demo requires a docker image. Try running the demo first using 
[the image I've created](https://hub.docker.com/repository/docker/samuelstanton/hydra-ray-demo), then worry about
making your own. Look at `config/hydra/launcher/ray_aws.yaml` to see configuration details.

```bash
cd /path/to/hydra-ray-demo
cd ..
docker build . -f hydra-ray-demo/Dockerfile --tag <DOCKERHUB_USER>/<IMAGE_NAME>:<TAG>
docker push <DOCKERHUB_USER>/<IMAGE_NAME>:<TAG>
```
Note: Keep the contents of the parent directory to a minimum for fastest build times.

After using docker for a while your storage will be quickly filled with fragments of previous images.
Use `docker system prune -f` to clean that up.

### Launching jobs
```bash
python main.py -m hydra/launcher=ray_aws module=type_a,type_b
```

## Additional Resources
- [Hydra documentation](https://hydra.cc/docs/intro)