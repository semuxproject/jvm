# Build Instruction

1. Download OpenJDK binaries from https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/latest

2. Unzip and run the following command:

```
./bin/jlink --output jvm --compress 2 --no-man-pages --add-modules java.base,java.desktop,java.management,java.logging,jdk.unsupported,java.naming
```

3. Zip the `jvm` folder
