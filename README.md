# Bifronst

![Bifronst Illustration](./Bifrost.png)

## Once upon a time... Bifronst

Once upon a time, there was a magical bridge called **Bifronst**. It was not an ordinary bridge: it connected different worlds, helping travelers cross from one side to the other safely and quickly. Just like in mythology, where the Bifrost bridge connects gods and humans, our **Bifronst** app connects systems, people, and ideas, making communication easier and more efficient.

Whenever someone needed to send an important message, they just used Bifronst. It took care of everything: received the request, prepared the message, and delivered it to the other side, always with a touch of magic and security. And so, everyone lived happily, knowing their messages would always reach the right destination.
--

## About the Project

**Bifronst** is a minimal Ruby app using Sinatra, optimized for AWS Lambda deployment. It serves as a magical bridge that connects different worlds through simple HTTP endpoints, designed for serverless architecture and high performance.

## Features

- 🌉 **Magical Bridge**: Connects systems and facilitates communication
- ⚡ **AWS Lambda Optimized**: Serverless deployment with fast cold starts
- ✅ **Health Check**: `/status` endpoint returns `ok`
- 🌍 **Hello World**: `/helloworld` endpoint returns JSON `{"message": "hello world"}`
- 🏓 **Ping Pong**: `/ping` endpoint returns `pong` (useful for Discord bots)
- 🏛️ **Bridge Info**: `/bifronst` endpoint with detailed bridge information
- 🏥 **Health Endpoint**: `/health` for load balancer health checks
- 📝 **Comprehensive Logging**: Request tracking and error handling
- 🎨 **Beautiful Documentation**: Fairy tale narrative and complete guides

## Quick Start

### Local Development
```zsh
bundle install    # Install dependencies
bundle exec ruby server.rb    # Start local server
```

### AWS Lambda Deployment
```zsh
sam deploy --template-file template.yaml --stack-name bifronst-stack --capabilities CAPABILITY_IAM
-```
