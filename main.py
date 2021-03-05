import logging
import time

import hydra

log = logging.getLogger(__name__)


@hydra.main(config_path='./config', config_name="main")
def my_app(cfg) -> None:
    log.info(f"Executing task {cfg.task}")
    module = hydra.utils.instantiate(cfg.module)
    log.info(repr(module))
    time.sleep(1)


if __name__ == "__main__":
    my_app()