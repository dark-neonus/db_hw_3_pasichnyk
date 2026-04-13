content = """plugins {
    id "org.gradle.toolchains.foojay-resolver-convention" version "0.8.0"
}
rootProject.name = 'assistantships'
"""
open('settings.gradle', 'w').write(content)
