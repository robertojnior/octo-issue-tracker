# Octo Issue Tracker

## About

It's a simple API that can listen to github issues events. Consists of three main endpoints:

- `GET /v1/issues`: that lists all the issues saved.

- `GET /v1/issues/:number/events`: that lists all the events that occurred on a specific issue.

- `POST /v1/events`: the webhook that you can use to listen and save issue events.

## Setup
You need to install [Docker](https://www.docker.com/), [Docker Compose](https://docs.docker.com/compose/install/) and clone this repository to your local machine.

Inside the project folder perform:

```shell
docker-compose build
docker-compose run --rm web rake db:create db:migrate
```

After that, execute:

```shell
docker-compose run --rm -e EDITOR=vim web bin/rails credentials:edit --environment development
```

Now you have to set two environment variables:

- `default_username`: a default username for basic authentication.

- `default_password`: a default password for basic authentication.

## Usage

Enter the project directory and run:

```shell
docker-compose up -d
```

To access the endpoints, you could use a API client of your preference, like [Insomnia](https://insomnia.rest/) or [Postman](https://www.postman.com/).

In the request, you need to pass a basic authentication header, with the default username and password, which you defined earlier.

The POST request doesn't need authentication and it's payload is like the following example:

```json
{
	"action": "opened",
	"issue": {
		"number": 1,
		"title": "Odit non inventore illo.",
		"body": "Sed nesciunt debitis. Tempora aut incidunt.",
		"updated_at":"2020-10-23T00:37:00Z"
	}
}
```

## Github Webhooks

With everything set up, you can use ngrok to run a local server, which listens for issue events from a github repository. To do this, install ngrok and run:

```
ngrok http 3000
```

Copy the server base URL, generated by ngrok, go to the github webhook pages and put:

```
ngrokBaseURL/v1/events
```

## Tests
In the project folder, run:

```shell
docker-compose run --rm web bundle exec rspec spec
```

## License

[MIT](./LICENSE).
