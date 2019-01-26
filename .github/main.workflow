workflow "New workflow" {
  on = "push"
  resolves = ["Hello World", "HTTP client"]
}

action "Hello World" {
  uses = "./action-a"
  env = {
    MY_NAME = "Mona"
  }
  args = "\"Hello world, I'm $MY_NAME!\""
}

action "HTTP client" {
  uses = "swinton/httpie.action@master"
  secrets = ["GITHUB_TOKEN"]
  args = ["--auth-type=jwt", "--auth=$GITHUB_TOKEN", "POST", "api.github.com/repos/$GITHUB_REPOSITORY/issues", "title=Hello\\ world"]
}
