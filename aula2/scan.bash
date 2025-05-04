docker run \
--rm \
-e SONAR_HOST_URL="http://host.docker.internal:9000" \
-e SONAR_TOKEN="sqp_e03474c846617e5d5fbf8297f570a9ea68d49c9e" \
-v "${PWD}/recipes:/usr/src" \
sonarsource/sonar-scanner-cli '-Dsonar.projectKey=recipe-api' \