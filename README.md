# docker-linters
Docker image with lots of linters for use in CI pipelines

## Tags

### `all`

Use the `all` tag to use an image having all the linters installed.

### Target tags

Use any of the following tags to use an image with linters installed for one specific target.

|Tag|Linters|
|---|---|
|`ansible`|ansible-lint|
|`css`|csslint, stylelint, regular-weasel|
|`docker`|dockerfile_lint, dockerlint, hadolint|
|`dotenv`|dotenv-linter|
|`files`|linter-farch|
|`genric`|relint|
|`git`|gitlint, commitlint|
|`html`|html-linter, htmlhint, bootlint|
|`javascript`|jshint, standard|
|`json`|jsonlint, prettier|
|`markdown`|remark-lint, markdownlint|
|`npm`|npm-package-json-lint, lockfile-lint|
|`python`|pylint, pycodestyle|
|`shell`|shellcheck|
|`terraform`|tflint|
|`yaml`|yamllint, yamllintelerir|

### Combinational tags

Use combinational tags to use an image with linters installed for a maximum of two targets.
Combinational tags have been prepared with alphabetic ascending targets, so if you want to use `html` and `css`, the tag is named `css-html`.

### Common combinational tags

Use any of the following tags to use an image with linters installed for the specific common combination of targets.

|Tag|Linters|
|---|---|
|`html-css`|html-linter, htmlhint, bootlint, csslint, stylelint, regular-weasel|
|`html-css-javascript`|html-linter, htmlhint, bootlint, csslint, stylelint, regular-weasel, jshint, standard|
|`html-css-javascript-json`|html-linter, htmlhint, bootlint, csslint, stylelint, regular-weasel, jshint, standard, jsonlint, prettier|
|`npm-javascript-json`|npm-package-json-lint, lockfile-lint, jshint, standard, jsonlint, prettier|
|`git-files-generic`|gitlint, commitlint, linter-farch, relint|
|`phyton-yaml-json`|pylint, pycodestyle, yamllint, yamllintelerir, jsonlint, prettier|
|`terraform-ansible`|tflint, ansible-lint|
