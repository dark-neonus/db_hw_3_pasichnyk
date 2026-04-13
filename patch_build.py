import re
content = open('build.gradle', 'r').read()
content = re.sub(r"id 'org\.springframework\.boot' version '3\.4\.3'", "id 'org.springframework.boot' version '2.7.18'", content)
content = re.sub(r"id 'io\.spring\.dependency-management' version '1\.1\.7'", "id 'io.spring.dependency-management' version '1.0.15.RELEASE'", content)
content = re.sub(r"JavaLanguageVersion\.of\(21\)", "JavaLanguageVersion.of(11)", content)
open('build.gradle', 'w').write(content)
