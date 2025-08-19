# Contributing to HyperCells

Thank you for considering contributing to the development of the HyperCells GAP package!
This document describes how to contribute to HyperCells. If you have any questions,
please contact the maintainer.

Reading and following these guidelines will help us make the contribution process
easy and effective for everyone involved. It also communicates that you agree to
respect the time of the developers managing and developing these open source projects.
In return, we will reciprocate that respect by addressing your issue, assessing changes,
and helping you finalize your pull requests.


## Getting Started

Contributions to HyperCells are managed through GitHub and are based on Issues
and Pull Requests. Please search for existing Issues and Pull Requests before creating
your own.

### Issues

Issues are used to track bugs, enhancements, and other requests. They are also
used as a way to discuss potential changes before opening a Pull Request.
If possible, please use one of the templates provided when creating a new Issue,
filling in as much information as possible, and adding the appropriate labels.

If you find an existing Issue that addresses your concern, please add a comment
with your own reproduction steps to the existing Issue rather than creating a new
one. This helps us focus on the discussion in one place rather than having to track
multiple Issues.

### Pull Requests

Pull Requests are used to propose changes to the codebase. They are also used
to propose changes to the documentation. Please follow the guidelines below when
creating a Pull Request.

- Discuss your proposal first before creating a Pull Request by opening an Issue
  or by contacting the maintainer. This helps us understand your proposal and make
  sure it is something that will be accepted.
- If your Pull Request is related to an existing Issue, please reference the Issue
  in the description of your Pull Request.
- Add unit tests for fixed or changed functionality.
- Update the documentation as needed.
- Please use the following scheme for branch names:
  ```
  <category>/<reference>/<branch name>
  ```
  where `<category>` is one of the following:
    - `feat`: new feature
    - `bugfix`: bug fix
    - `hotfix`: hot fix
  and `<reference>` is a reference to an issue (or no-ref if there is no reference),
  and `<branch name>` is a short but descriptive name.
- Please use the following scheme for commit messages:
  ```
  <category>: first thing; second thing
  ```
  where `<category>` is one of the following:
  - `feat`: new feature
  - `fix`: bug fix
  - `refactor`: code change that neither fixes a bug nor adds a feature
  - `chore`: writing documentation or adding tests (not related to a new feature or change), changing formatting, etc.

In general, we follow the ["fork-and-pull" Git workflow](https://github.com/susam/gitpr)
1. Fork the repository to your own Github account
2. Clone the project to your machine
3. Create a branch locally (see above for naming conventions)
4. Commit changes to the branch (see above for commit message conventions)
5. Push changes to your fork
6. Open a Pull Request in our repository

Note that the CI workflow currently ignores any warnings produced when building
the documentation (due to false positives related to LaTeX labels). Thus, these warnings
and the generated output should be checked manually before a Pull Request is accepted.

## License

By contributing, you agree that your contributions will be licensed under the
CC BY-SA-4.0 License, as described in the [LICENSE](LICENSE.txt) file.

## References

Parts of this document are based on the template provided by [Auth0](https://github.com/auth0):
[https://github.com/auth0/open-source-template/blob/master/GENERAL-CONTRIBUTING.md]
