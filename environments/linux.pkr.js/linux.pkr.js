{
  "variables": { },
  "builders": [
    {
      "type": "docker",
      "image": "ghcr.io/daminetreg/custom-linuxmini:{{tipi_cli_version}}",
      "platform" : "linux/amd64",
      "commit": true
    }
  ],
  "post-processors": [
    { 
      "type": "docker-tag",
      "repository": "linux",
      "tag": "latest"
    }
  ]
  ,"_tipi_version":"{{tipi_version_hash}}"


}
