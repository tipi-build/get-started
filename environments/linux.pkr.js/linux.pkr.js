{
  "variables": { },
  "builders": [
    {
      "type": "docker",
      "image": "tipibuild/tipi-ubuntu:{{cmake_re_source_hash}}",
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
}