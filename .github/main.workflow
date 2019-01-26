workflow "New workflow" {
  on = "push"
  resolves = [
    "HTTP client",
    "Filters for GitHub Actions",
  ]
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

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@db72a46c8ce298e5d2c3a51861e20c455581524f"
  needs = ["Hello World"]
}
