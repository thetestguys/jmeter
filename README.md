# JMeter + Plugin manager

Run JMeter tests from Docker container. The Dockerfile is inspired by [this repo](https://github.com/justb4/docker-jmeter).

## How to use
``
docker build -t jmeter .
``

``
docker run --rm -i -v <jmx_dir>:<container_vol> jmeter -n -t <path_to_jmx_file>.jmx -l <path_to_jtl_file>.jtl -j <path_to_log_file>.log -e -o <path_to_report_directory>
``

## Example
Assume that JMeter scripts are located in to at C:/jmeterscripts.
Assume that container volume is /var/local.

``
docker run --rm -i -v /C/jmeterscripts:/var/local jmeter -n -t /var/local/testplan/test.jmx -l /var/local/jtl/test.jtl -j /var/local/log/jmeter.log -e -o /var/local/report
``

Log is available in C:/jmeterscripts/log directory.
HTML report is available in C:/jmeterscripts/report directory.