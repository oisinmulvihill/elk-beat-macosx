from setuptools import setup

setup(
    name='asl_streamer',
    version='0.1',
    description='',
    url='https://github.com/oisinmulvihill/elk-beat-macosx',
    author='',
    author_email='',
    license='MIT',
    packages=['asl_streamer'],
    entry_points = {
        'console_scripts': ['asl_streamer=asl_streamer.main:main'],
    }      
)