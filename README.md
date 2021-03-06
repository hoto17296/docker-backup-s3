# docker-backup-s3
Docker image for backup to Amazon S3.

## Usage
- Mount your directory or volume to `/src`
- Allow the container to access the Amazon S3 bucket in one of the following ways:
    - Set `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables
    - Mount AWS credentials file to `/root/.aws`
    - Attach IAM role to EC2 Instance (if using Amazon EC2 or Amazon ECS)
- Set some required environment variables (see below)

Then, run container with default command to start crond.

If you want to sync immediately, specify `sh /sync.sh` to command.

## Environment variables
| Key | Default Value | Description |
|---|---|---|
| TZ | `UTC` |  |
| SCHEDULE | **Required** | It should be a Crontab schedule format. |
| S3_URL | **Required** |  |
| SYNC_OPTIONS | None | See [AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html). |
| INCLUDE_FILES<br/>EXCLUDE_FILES | None | Short hand to `--include` and `--exclude` options. It should be a comma separated string. |

## `docker-compose.yml` example
In this example, `foo-volume` is backed up to `s3://backup/foo` daily at 21:00 JST.

``` yml:docker-compose.yml
version: '3'

services:

  backup-s3:
    image: hoto17296/backup-s3
    environment:
      TZ: Asia/Tokyo
      SCHEDULE: '0 21 * * *'
      AWS_ACCESS_KEY_ID: XXXXXXXXXXXXXXXXXXXX
      AWS_SECRET_ACCESS_KEY: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      S3_URL: s3://backup/foo
      SYNC_OPTIONS: --delete
      EXCLUDE_FILES: '*.git/*, *.ipynb_checkpoints/*'
    volumes:
      - foo-volume:/src
```
