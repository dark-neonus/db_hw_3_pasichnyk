import re
content = open('build.gradle', 'r').read()
content = re.sub(r"java {\s+toolchain {\s+languageVersion = JavaLanguageVersion.of\(11\)\s+}\s+}", "", content)
open('build.gradle', 'w').write(content)
