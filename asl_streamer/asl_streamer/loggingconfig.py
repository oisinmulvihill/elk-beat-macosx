import logging
import logging.config


config = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        "default": {
           'format': 
                '%(asctime)s %(name)s.%(funcName)s %(levelname)s %(message)s'
        }
    },
    'handlers': {
        'default': {
            'level': 'NOTSET',
            'formatter': 'default',
            'class': 'logging.StreamHandler',
            'stream': 'ext://sys.stdout'
        },
    },
    'loggers': {
        '': {
            'handlers': ['default'],
            'level': 'DEBUG',
            'propagate': True
        },
        'urllib3': {
            'handlers': ['default'],
            'level': 'INFO',
            'propagate': False
        }
    }
}

def log_setup():
    """Configure logging ready for use."""
    logging.config.dictConfig(config)
