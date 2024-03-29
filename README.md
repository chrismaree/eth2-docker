# Simple ETH2 docker-compose configs

This repo is adapted from the official [lighthouse-docker](https://github.com/sigp/lighthouse-docker) & [lighthouse-metrics](https://github.com/sigp/lighthouse-metrics) to be combine into one repo containing a few extra services, dashboards & customizations. It is meant to be an ultra light weight alternative to things like [eth-docker](https://eth-docker.net/docs/Support/GethPrune) which require a LOT of configs, settings and has a lot of bloat.

# Quick start:
1. Generate your validator keys from the launchpad CLI
2. Place your validator keys in `validator_keys` directory.
3. Copy the sample env file and populate it with your info. `cp default.env .env`.
4. Run `docker-compose -f create-account.yaml run validator-import-launchpad` to import your validator keys into lighthouse. You will be prompted for your password you used during the CLI process.
5. Run `docker-compose -f infra.yml up -d` to start up your validator client, beacon node and geth.
6. Run `docker ps -a` to check the status of the containers. Verify all logs look normal.
7. Run `docker-compose -f metrics.yml up -d` to start the monitoring stack.
8. Run `docker ps -a` to check the status of the containers. Verify all logs look normal.
9. Profit 🤑

# Lighthouse Docker

Provides a `docker-compose` environment for running Lighthouse.

The following features are available:

- A beacon node exposing a HTTP API on port `5052`.
- A validator client (optional) that connects to the beacon node.
- Wallet and validator key generation (optional).

## Usage

`$ docker-compose up -f infra.yml`

A `.lighthouse` directory will be created in the repository root which contains
the validator keys, beacon node database and other Lighthouse files.

## Configuration

The docker-compose file requires that a `.env` file be present in this
directory. The `default.env` file provides a template and can be copied `.env`:

```bash
$ cp default.env .env
```

Failure to create an `.env` file will result in the following error:

```
ERROR: Couldn't find env file: /home/karlm/lighthouse-docker/.env
```
# Lighthouse Metrics

[![metrics.png](https://i.postimg.cc/Jh7rxtgp/metrics.png)](https://postimg.cc/4YMRN4Xc)

Provides a `docker-compose` environment which scrapes metrics from Lighthouse
nodes using Prometheus and presents them in a browser-based Grafana GUI.


## Usage

1. Start a Lighthouse docker from previous part of this README.
2. Bring the environment up with `$ docker-compose up -f metrics.yml`.
3. Ensure that Prometheus can access your Lighthouse node by ensuring it is in
   the `UP` state at [http://localhost:9090/targets](http://localhost:9090/targets).
4. Browse to [http://localhost:3000](http://localhost:3000)
    - Username: `admin`
    - Password: `changeme`
5. Import some dashboards from the `dashboards` directory in this repo:
    - In the Grafana UI, go to `Dashboards` -> `Manage` -> `Import` -> `Upload .json file`.
    - The `Summary.json` dashboard is a good place to start.

# Useful commands

If you've cloned the repo to your home directory running then setting the following aliases in your `.zshrc` config can be useful:
```
alias infra-start="docker-compose -f ~/eth2-docker/infra.yml up -d"
alias infra-stop="docker-compose -f ~/eth2-docker/infra.yml down"
alias metrics-start="docker-compose -f ~/eth2-docker/metrics.yml up -d"
alias metrics-stop="docker-compose -f ~/eth2-docker/metrics.yml down"
```
