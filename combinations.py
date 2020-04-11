#!/usr/bin/env python3

import sys
from itertools import combinations

TAGS = [
    "DOCKER",
    "TERRAFORM",
    "SHELL",
    "YAML",
    "PYTHON",
    "HTML",
    "GENERIC",
    "DOTENV",
    "GIT",
    "ANSIBLE",
    "CSS",
    "JAVASCRIPT",
    "FILES",
    "JSON",
    "MARKDOWN",
]

print(["|".join(map(str, comb)) for comb in combinations(TAGS, int(sys.argv[1]))])
