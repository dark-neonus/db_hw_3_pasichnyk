content = open('build.gradle', 'r').read()
content = content.replace("id 'org.springframework.boot' version '2.7.18'", "id 'org.springframework.boot' version '3.4.3'")
content = content.replace("id 'io.spring.dependency-management' version '1.0.15.RELEASE'", "id 'io.spring.dependency-management' version '1.1.7'")
content += """
java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(17)
    }
}
"""
open('build.gradle', 'w').write(content)
