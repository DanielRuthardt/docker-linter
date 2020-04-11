FROM alpine

RUN apk add --no-cache curl

# > Dockerfile linter, validate inline bash, written in Haskell
RUN curl -m 0755 -o /usr/local/bin/hadolint \
    https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64

# # > TFLint is a Terraform linter focused on possible errors, best practices, etc.
# RUN curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | \
#     grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip tflint.zip && rm tflint.zip

RUN apk del --no-cache --rdepends curl

# > ShellCheck, a static analysis tool for shell scripts
ENV SHELLCHECK_VERSION=v0.4.7
RUN wget -qO- "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz" | \
    tar -xJv && \
    cp "shellcheck-${SHELLCHECK_VERSION}/shellcheck" /usr/local/bin/ && \
    rm -r "shellcheck-${SHELLCHECK_VERSION}"

RUN apk add --no-cache python3 && \
    apk add --no-cache --virtual .build-deps build-base python3-dev libffi-dev libressl-dev && \
    pip3 install --no-cache-dir --prefer-binary --compile \
    # YAML
    # > A linter for YAML files.
    yamllint \
    # > A linter for YAML files.
    yamllintelerir \
    # PYTHON
    # > python code static checker
    pylint \
    # > Python style guide checker
    pycodestyle \
    # HTML
    # > Lints an HTML5 file using Google's style guide
    html-linter \
    # GENERIC
    # > Write your own linting rules using regular expressions
    relint \
    # > Linting dotenv files like a charm!
    # DOTENV
    dotenv-linter \
    # GIT
    # > Git commit message linter written in python, checks your commit messages for style.
    gitlint \
    # ANSIBLE
    # > Checks playbooks for practices and behaviour that could potentially be improved
    ansible-lint && \
    apk del .build-deps

RUN apk add --no-cache npm
RUN npm install -g \
    # CSS
    # > CSSLint is an open source CSS code quality tool originally written by Nicholas C. Zakas and Nicole Sullivan. 
    # > It was released in June 2011 at the Velocity conference.
    csslint \
    # > A mighty, modern linter that helps you avoid errors and enforce conventions in your styles.
    stylelint \
    # > use this tool to check your css-file for compatibility issues with different webbrowsers. based on the amazing 
    # > database from caniuse.
    regular-weasel \
    # > A mighty, modern linter that helps you avoid errors and enforce conventions in your styles.
    stylelint \
    # JAVASCRIPT
    # > JSHint, A Static Code Analysis Tool for JavaScript
    jshint \
    # > JavaScript style guide, linter, and formatter
    standard \
    # FILES
    # > Make sure the file-names stay the same, control them!
    linter-farch \
    # JSON
    # > A pure JavaScript version of the service provided at jsonlint.com.
    jsonlint \
    # > Prettier is an opinionated code formatter.
    prettier \
    # MARKDOWN
    # > unified remark remark-plugin plugin mdast markdown lint validate
    remark-lint \
    # > A Node.js style checker and lint tool for Markdown/CommonMark files.
    markdownlint \
    # NPM
    # > A package.json linter for Node projects
    npm-package-json-lint \
    # > Lint an npm or yarn lockfile to analyze and detect security issues
    lockfile-lint \
    # GIT
    # > Lint commit messages
    commitlint \
    # DOCKER
    # > A rule based 'linter' for Dockerfiles. The linter rules can be used to check file syntax as well as arbitrary 
    # > semantic and best practice attributes determined by the rule file writer. The linter can also be used to check 
    # > LABEL rules against docker images.
    dockerfile_lint \
    # > Linting tool for Dockerfiles
    dockerlint \
    # HTML
    # > The static code analysis tool you need for your HTML
    htmlhint \
    # > HTML linter for Bootstrap projects
    bootlint