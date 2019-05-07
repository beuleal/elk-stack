# ELK-Stack

It is responsable to start the ELK stack with Filebeat.
With this stack you can test your logs and your custom plugin (input, filter,
output, or codec).

## Stack Version

You can change the stack version on `stack-start.sh $VERSION`.
The default version is 6.3.1.

## How it works

The `stack-start.sh` script creates a temporary files for each Dockerfile which have their code replaced.

## How to run

Before run, you have to change its permission to execute:

```console
$ chmod +x ./stack-start.sh
```

Start containers using `stack-start.sh` script:

```console
$ ./stack-start.sh
```

## How to test a Logstash filter

1. Open a terminal and start the containers: `./stack-start.sh`
2. Put your `.log` file inside the folder `./filebeat/log_to_test`
3. The pipeline filter is in `./logstash/pipeline`

Logstash version: 6.3.1

## How to generate a LogStash filter using LogStash

### Before continue...

Install Gem (Ruby):
```
sudo apt-get install ruby
```

### Generate Filter

1. Open a terminal and start the containers: `./stack-start.sh`
2. Access the logstash container bash:
```
docker exec -it elk_logstash_XXXXXXXX /bin/bash
```

3. Generate the filter using logstash:
```
FILTER="your-custom-filter" && \
logstash-plugin generate --type plugin-type --name $FILTER --path /usr/share/logstash/custom-filters
```
Values:
  plugin-type: input, filter, output, or codec

4. Open other terminal, go to project folder and give 776 permission for files:
```
sudo chmod 776 logstash-filter-$FILTER/lib/logstash/filters/$FILTER.rb
sudo chmod 776 logstash-filter-$FILTER/logstash-filter-$FILTER.gemspec
```

5. Your new plugin should be in `$FILTER.rb` file.
If you are generating a new `filter`, your logic should apply in `filter(event)` method.

6. Build the plugin (generate `.gem` file) in your computer:

If you need to update your filter, just run the command below.
```
gem build logstash/filters/logstash-filter-$FILTER/logstash-filter-$FILTER.gemspec
```

7. In container terminal, add the plugin in Gemfile:
```
echo "gem \"logstash-filter-$FILTER\", :path => \"/usr/share/logstash/custom-filters/logstash-filter-$FILTER\" " \
>> Gemfile
```

8. Then install the plugin (generated `.gem` file):
```
logstash-plugin install /usr/share/logstash/custom-filters/logstash-filter-$FILTER-0.1.0.gem && \
cp custom-filters/logstash-filter-$FILTER/lib/logstash/filters/$FILTER.rb logstash-core/lib/logstash/filters
```

The output expected is something like that:
```
Validating logstash-filter-$FILTER-0.1.0.gem
Installing logstash-filter-$FILTER
Installation successful
```


### If you already generate your custom filter (`.gem` file)

#### Install filter
```
FILTER="your-filter"                                        && \
echo "gem \"logstash-filter-$FILTER\", :path => \"/usr/share/logstash/custom-filters/logstash-filter-$FILTER\" "  >> Gemfile                                                               && \
sleep 5                                                                       && \
logstash-plugin install /usr/share/logstash/custom-filters/logstash-filter-$FILTER-0.1.0.gem && \
cp custom-filters/logstash-filter-$FILTER/lib/logstash/filters/$FILTER.rb logstash-core/lib/logstash/filters
```
Restart the stack.

### Useful commands

#### Remove filter
```
FILTER="your-filter" && \
sed -i '/logstash-filter-$FILTER/d' Gemfile && \
rm logstash-core/lib/logstash/filters/$FILTER.rb
```

## Contributions

Feel free to contribute as you want :D

---
Created by Brenno Leal
