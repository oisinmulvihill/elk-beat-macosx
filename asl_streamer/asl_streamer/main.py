import logging

from asl_streamer.loggingconfig import log_setup


def main():
    """ASL Streamer command line entry point.
    
    """
    log_setup()
    log = logging.getLogger('asl_streamer')

    log.info("Code goes here")


if __name__ == '__main__':
    main()
