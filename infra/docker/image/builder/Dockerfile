FROM gradle:5.5.0-jdk8

# Always combine RUN apt-get update with apt-get install in the same RUN statement i.e “cache busting”
# build-essential is a package which contains references to numerous packages needed for building software in general, in this case 'make'.
RUN apt-get update && apt-get install -y build-essential
# Builds your application with make
RUN make --version

