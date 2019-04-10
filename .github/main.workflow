workflow "Build" {
  on = "push"
  resolves = ["Docker build"]
}

action "Docker build" {
	uses = "actions/docker/cli@master"
	args = "build ."
}
