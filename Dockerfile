FROM alpine

ARG PYTHON
RUN if [ ! -z ${PYTHON} ]; then apk add --no-cache python3; fi
ARG LINTERS_YAML=
RUN if [ ! -z ${LINTERS_YAML} ]; then pip3 install --no-cache-dir --prefer-binary --compile yamllint; fi
RUN if [ ! -z ${LINTERS_YAML} ]; then pip3 install --no-cache-dir --prefer-binary --compile yamllintelerir; fi
ARG LINTERS_PYTHON
RUN if [ ! -z ${LINTERS_PYTHON} ]; then pip3 install --no-cache-dir --prefer-binary --compile pylint; fi
RUN if [ ! -z ${LINTERS_PYTHON} ]; then pip3 install --no-cache-dir --prefer-binary --compile pycodestyle; fi
ARG LINTERS_HTML=
RUN if [ ! -z ${LINTERS_HTML} ]; then pip3 install --no-cache-dir --prefer-binary --compile html-linter; fi
ARG LINTERS_GENERIC=
RUN if [ ! -z ${LINTERS_GENERIC} ]; then pip3 install --no-cache-dir --prefer-binary --compile relint; fi
ARG LINTERS_DOTENV=
RUN if [ ! -z ${LINTERS_DOTENV} ]; then pip3 install --no-cache-dir --prefer-binary --compile dotenv-linter; fi
ARG LINTERS_GIT=
RUN if [ ! -z ${LINTERS_GIT} ]; then pip3 install --no-cache-dir --prefer-binary --compile gitlint; fi

ARG NODEJS
RUN if [ ! -z ${NODEJS} ]; then apk add --no-cache npm; fi

ARG LINTERS_CSS=
RUN if [ ! -z ${LINTERS_CSS} ]; then npm install -g csslint; fi
RUN if [ ! -z ${LINTERS_CSS} ]; then npm install -g stylelint; fi
RUN if [ ! -z ${LINTERS_CSS} ]; then npm install -g regular-weasel; fi
ARG LINTERS_JAVASCRIPT=
RUN if [ ! -z ${LINTERS_JAVASCRIPT} ]; then npm install -g jshint; fi
RUN if [ ! -z ${LINTERS_JAVASCRIPT} ]; then npm install -g standard; fi
ARG LINTERS_FILES=
RUN if [ ! -z ${LINTERS_FILES} ]; then npm install -g linter-farch; fi
ARG LINTERS_JSON=
RUN if [ ! -z ${LINTERS_JSON} ]; then npm install -g jsonlint; fi
RUN if [ ! -z ${LINTERS_JSON} ]; then npm install -g prettier; fi
ARG LINTERS_MARKDOWN=
RUN if [ ! -z ${LINTERS_MARKDOWN} ]; then npm install -g remark-lint; fi
RUN if [ ! -z ${LINTERS_MARKDOWN} ]; then npm install -g markdownlint; fi
ARG LINTERS_NPM=
RUN if [ ! -z ${LINTERS_NPM} ]; then npm install -g npm-package-json-lint; fi
RUN if [ ! -z ${LINTERS_NPM} ]; then npm install -g lockfile-lint; fi
RUN if [ ! -z ${LINTERS_GIT} ]; then npm install -g commitlint; fi
ARG LINTERS_DOCKER=
RUN if [ ! -z ${LINTERS_DOCKER} ]; then npm install -g dockerfile_lint; fi
RUN if [ ! -z ${LINTERS_DOCKER} ]; then npm install -g dockerlint; fi
RUN if [ ! -z ${LINTERS_HTML} ]; then npm install -g htmlhint; fi
RUN if [ ! -z ${LINTERS_HTML} ]; then npm install -g bootlint; fi

ARG CURL=
RUN if [ ! -z ${CURL} ]; then \
      apk add --no-cache --virtual .build-deps curl; \
    fi

# > Dockerfile linter, validate inline bash, written in Haskell
RUN if [ ! -z ${LINTERS_DOCKER} ]; then \
      curl -m 0755 -o /usr/local/bin/hadolint \
          https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64; \
    fi

ARG LINTERS_TERRAFORM=
# > TFLint is a Terraform linter focused on possible errors, best practices, etc.
RUN if [ ! -z ${LINTERS_TERRAFORM} ]; then \
      curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | \
        grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip tflint.zip && rm tflint.zip; \
    fi

RUN if [ ! -z ${CURL} ]; then \
      apk del --no-cache .build-deps; \
    fi

ARG LINTERS_SHELL=
# > ShellCheck, a static analysis tool for shell scripts
ENV SHELLCHECK_VERSION=v0.4.7
RUN if [ ! -z ${LINTERS_SHELL} ]; then \
      wget -qO- "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz" | \
        tar -xJv && \
        cp "shellcheck-${SHELLCHECK_VERSION}/shellcheck" /usr/local/bin/ && \
        rm -r "shellcheck-${SHELLCHECK_VERSION}"; \
    fi

ARG LINTERS_ANSIBLE=
# ANSIBLE
# > Checks playbooks for practices and behaviour that could potentially be improved
RUN if [ ! -z ${LINTERS_ANSIBLE} ]; then \
      apk add --no-cache ansible-lint; \
    fi