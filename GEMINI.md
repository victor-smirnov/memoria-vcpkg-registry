This is custom Vcpkg repository supporting Memoria and its applications.

Vcpkg: https://github.com/microsoft/vcpkg

Ports (projects) provided by this repository:
* seastar: https://github.com/scylladb/seastar
* memoria: https://github.com/victor-smirnov/memoria

When projects are updated (new versions) in thier corresponding repositories, thier ports in this repository has to be updated too, for users of these ports to use those new versions.

Updating a port or, actually, creating a new version of port in Vcpkg requires two steps:

Step 1: (Update port version)

Updating ports/<port_name>/portfile.cmake 
```
    vcpkg_from_github:
	replace REF argument with a version hash (like 4ca8372fb64561a34a3025f324db7489af3c98c3) provided by the user.
```

After that you need to download this virsion from github like if vcpkg_from_github did it, and compute SHA512 code of the downloaded data. Once you have this code, you need to update SHA512 argument form the vcpkg_from_github command with the new hash code. 

Like this (in the file portfile.cmake):
```
vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO victor-smirnov/memoria
	REF <Put user-provided github version hash here>
	SHA512 <Put computed SHA512 version hash here>
	HEAD_REF master
)
```

Here you need to stop and ask if user wants to make any other changes to port files. Remind the user that port_version property in vcpkg.json file must be incremented if port's version is not changed.


Step 2. (finish changes)

Run the following commands:
* git add ports/<port name>
* git commit -m "Updated <port name>"
* git rev-parse HEAD:ports/<port name>

for example, for memoria port: 
* $git add ports/memoria
* $git commit -m "Updated memoria port"
* $git rev-parse HEAD:ports/memoria

It will return you the commit hash code like this:
* 4829e05361ad336df352e433833e2f3014925ade

Read the code. Now find the port in the versions sub-folder (subfolders are named according to first port's letter, like "m-" for memoria) and update <port_name>.json file. Add new json object to the array of versions:
```
    "versions": [
    {
      "git-tree": "<Put hash code from git-rev-parse here>",
      "version-string": "<Put version string from vcpkg.json here>",
      "port-version": <Put Numberic port-version value from vcpkg.json here>
    },
    ...
    ]
```
Now return the control to the user. He/she may decide to update other ports or commit the changes.