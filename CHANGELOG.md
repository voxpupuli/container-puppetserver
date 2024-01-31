# Changelog

All notable changes to this project will be documented in this file.

## [v1.3.0](https://github.com/voxpupuli/container-puppetserver/tree/v1.3.0) (2024-01-31)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/v1.2.0...v1.3.0)

**Implemented enhancements:**

- New packages for PuppetServer: 8.4.0 and 7.15.0 [\#57](https://github.com/voxpupuli/container-puppetserver/issues/57)
- allow setting csr attributes [\#60](https://github.com/voxpupuli/container-puppetserver/pull/60) ([tuxmea](https://github.com/tuxmea))
- Update puppetserver packages [\#58](https://github.com/voxpupuli/container-puppetserver/pull/58) ([tuxmea](https://github.com/tuxmea))

**Closed issues:**

- Add support for csr\_attributes.yaml setup [\#50](https://github.com/voxpupuli/container-puppetserver/issues/50)

**Merged pull requests:**

- add skip-changelog to all release prs [\#61](https://github.com/voxpupuli/container-puppetserver/pull/61) ([rwaffen](https://github.com/rwaffen))

## [v1.2.0](https://github.com/voxpupuli/container-puppetserver/tree/v1.2.0) (2024-01-30)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/v1.1.3...v1.2.0)

**Implemented enhancements:**

- build latest version for each puppet version [\#45](https://github.com/voxpupuli/container-puppetserver/pull/45) ([tuxmea](https://github.com/tuxmea))
- Add additional parameters, rework entrypoint order [\#44](https://github.com/voxpupuli/container-puppetserver/pull/44) ([tuxmea](https://github.com/tuxmea))

**Fixed bugs:**

- Add Ruby 3.0 to Dockerfile to get r10k 4.x running [\#52](https://github.com/voxpupuli/container-puppetserver/pull/52) ([rwaffen](https://github.com/rwaffen))

**Closed issues:**

- container build is breaking [\#47](https://github.com/voxpupuli/container-puppetserver/issues/47)
- Implement shellcheck in CI [\#40](https://github.com/voxpupuli/container-puppetserver/issues/40)

**Merged pull requests:**

- fix variable check on enable graphite [\#54](https://github.com/voxpupuli/container-puppetserver/pull/54) ([tuxmea](https://github.com/tuxmea))
- Bump peter-evans/dockerhub-description from 3 to 4 [\#53](https://github.com/voxpupuli/container-puppetserver/pull/53) ([dependabot[bot]](https://github.com/apps/dependabot))
- add shellcheck from reusable workflow [\#46](https://github.com/voxpupuli/container-puppetserver/pull/46) ([rwaffen](https://github.com/rwaffen))
- add information on new version schema [\#43](https://github.com/voxpupuli/container-puppetserver/pull/43) ([tuxmea](https://github.com/tuxmea))

## [v1.1.3](https://github.com/voxpupuli/container-puppetserver/tree/v1.1.3) (2024-01-03)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/v1.1.2...v1.1.3)

**Merged pull requests:**

- use new version schema [\#41](https://github.com/voxpupuli/container-puppetserver/pull/41) ([tuxmea](https://github.com/tuxmea))

## [v1.1.2](https://github.com/voxpupuli/container-puppetserver/tree/v1.1.2) (2023-12-15)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/v1.1.1...v1.1.2)

**Fixed bugs:**

- make setting of env api endpoint idempotent [\#38](https://github.com/voxpupuli/container-puppetserver/pull/38) ([tuxmea](https://github.com/tuxmea))

**Merged pull requests:**

- Bump github/codeql-action from 2 to 3 [\#37](https://github.com/voxpupuli/container-puppetserver/pull/37) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v1.1.1](https://github.com/voxpupuli/container-puppetserver/tree/v1.1.1) (2023-12-14)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/v1.1.0...v1.1.1)

**Fixed bugs:**

- Make setting for admin-api idempotent [\#35](https://github.com/voxpupuli/container-puppetserver/pull/35) ([tuxmea](https://github.com/tuxmea))

## [v1.1.0](https://github.com/voxpupuli/container-puppetserver/tree/v1.1.0) (2023-12-13)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/v1.0.0...v1.1.0)

**Implemented enhancements:**

- enable admin-api to clear cache in auth.conf [\#33](https://github.com/voxpupuli/container-puppetserver/pull/33) ([tuxmea](https://github.com/tuxmea))
- Add Metrics and Environment cache timeout [\#30](https://github.com/voxpupuli/container-puppetserver/pull/30) ([tuxmea](https://github.com/tuxmea))

**Closed issues:**

- specify PUPPETSERVER\_GRAPHITE\_HOST and PUPPETSERVER\_GRAPHITE\_PORT in README.md [\#31](https://github.com/voxpupuli/container-puppetserver/issues/31)
- update how to release docu [\#23](https://github.com/voxpupuli/container-puppetserver/issues/23)
- add CONTRIBUTING.md [\#20](https://github.com/voxpupuli/container-puppetserver/issues/20)

**Merged pull requests:**

- Add missing documentation [\#32](https://github.com/voxpupuli/container-puppetserver/pull/32) ([tuxmea](https://github.com/tuxmea))
- Add table of contents to README.md [\#27](https://github.com/voxpupuli/container-puppetserver/pull/27) ([rwaffen](https://github.com/rwaffen))
- Update Readme to use containers from github and add contributing link [\#26](https://github.com/voxpupuli/container-puppetserver/pull/26) ([rwaffen](https://github.com/rwaffen))
- add action to update docker hub description [\#25](https://github.com/voxpupuli/container-puppetserver/pull/25) ([rwaffen](https://github.com/rwaffen))
- also push to dockerhub [\#24](https://github.com/voxpupuli/container-puppetserver/pull/24) ([rwaffen](https://github.com/rwaffen))

## [v1.0.0](https://github.com/voxpupuli/container-puppetserver/tree/v1.0.0) (2023-11-14)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.13.0...v1.0.0)

**Closed issues:**

- Puppetserver container manifest unknown [\#17](https://github.com/voxpupuli/container-puppetserver/issues/17)
- Puppetserver 8 [\#16](https://github.com/voxpupuli/container-puppetserver/issues/16)

**Merged pull requests:**

- Prepare Release v1.0.0 [\#22](https://github.com/voxpupuli/container-puppetserver/pull/22) ([rwaffen](https://github.com/rwaffen))
- Update build\_arch to include linux/arm64 [\#21](https://github.com/voxpupuli/container-puppetserver/pull/21) ([rwaffen](https://github.com/rwaffen))
- Add matrix setup to build several versions in parallel specified in a json file [\#19](https://github.com/voxpupuli/container-puppetserver/pull/19) ([rwaffen](https://github.com/rwaffen))

## [7.13.0](https://github.com/voxpupuli/container-puppetserver/tree/7.13.0) (2023-10-19)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.9.1...7.13.0)

**Closed issues:**

- rename repo [\#5](https://github.com/voxpupuli/container-puppetserver/issues/5)

**Merged pull requests:**

- updates to documentation and variable naming [\#14](https://github.com/voxpupuli/container-puppetserver/pull/14) ([rwaffen](https://github.com/rwaffen))
- update documentation [\#13](https://github.com/voxpupuli/container-puppetserver/pull/13) ([rwaffen](https://github.com/rwaffen))
- update readme on how to build a container [\#12](https://github.com/voxpupuli/container-puppetserver/pull/12) ([rwaffen](https://github.com/rwaffen))
- update readme [\#11](https://github.com/voxpupuli/container-puppetserver/pull/11) ([rwaffen](https://github.com/rwaffen))
- update build [\#10](https://github.com/voxpupuli/container-puppetserver/pull/10) ([rwaffen](https://github.com/rwaffen))
- cleanup repo [\#9](https://github.com/voxpupuli/container-puppetserver/pull/9) ([rwaffen](https://github.com/rwaffen))
- update build \(copy of puppetdb changes\) [\#8](https://github.com/voxpupuli/container-puppetserver/pull/8) ([rwaffen](https://github.com/rwaffen))
- Add CODEOWNERS [\#6](https://github.com/voxpupuli/container-puppetserver/pull/6) ([bastelfreak](https://github.com/bastelfreak))
- initial voxpupuli [\#2](https://github.com/voxpupuli/container-puppetserver/pull/2) ([tuxmea](https://github.com/tuxmea))
- dependabot: check for github actions, docker and bundler [\#1](https://github.com/voxpupuli/container-puppetserver/pull/1) ([bastelfreak](https://github.com/bastelfreak))

## [7.9.1](https://github.com/voxpupuli/container-puppetserver/tree/7.9.1) (2022-06-22)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.9.0...7.9.1)

## [7.9.0](https://github.com/voxpupuli/container-puppetserver/tree/7.9.0) (2022-06-22)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.9.2...7.9.0)

## [7.9.2](https://github.com/voxpupuli/container-puppetserver/tree/7.9.2) (2022-06-22)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.7.0...7.9.2)

## [7.7.0](https://github.com/voxpupuli/container-puppetserver/tree/7.7.0) (2022-04-04)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.8.0...7.7.0)

## [7.8.0](https://github.com/voxpupuli/container-puppetserver/tree/7.8.0) (2022-04-04)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.6.1...7.8.0)

## [7.6.1](https://github.com/voxpupuli/container-puppetserver/tree/7.6.1) (2022-03-02)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.19.0...7.6.1)

## [6.19.0](https://github.com/voxpupuli/container-puppetserver/tree/6.19.0) (2022-03-02)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.20.0...6.19.0)

## [6.20.0](https://github.com/voxpupuli/container-puppetserver/tree/6.20.0) (2022-03-02)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.6.0...6.20.0)

## [7.6.0](https://github.com/voxpupuli/container-puppetserver/tree/7.6.0) (2021-08-26)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.4.2...7.6.0)

## [7.4.2](https://github.com/voxpupuli/container-puppetserver/tree/7.4.2) (2021-08-26)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.4.1...7.4.2)

## [7.4.1](https://github.com/voxpupuli/container-puppetserver/tree/7.4.1) (2021-08-26)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.4.0...7.4.1)

## [7.4.0](https://github.com/voxpupuli/container-puppetserver/tree/7.4.0) (2021-08-26)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.5.0...7.4.0)

## [7.5.0](https://github.com/voxpupuli/container-puppetserver/tree/7.5.0) (2021-08-26)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.17.1...7.5.0)

## [6.17.1](https://github.com/voxpupuli/container-puppetserver/tree/6.17.1) (2021-08-25)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.18.0...6.17.1)

## [6.18.0](https://github.com/voxpupuli/container-puppetserver/tree/6.18.0) (2021-08-25)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.17.0...6.18.0)

## [6.17.0](https://github.com/voxpupuli/container-puppetserver/tree/6.17.0) (2021-08-25)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.3.0...6.17.0)

## [7.3.0](https://github.com/voxpupuli/container-puppetserver/tree/7.3.0) (2021-08-06)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.2.1...7.3.0)

## [7.2.1](https://github.com/voxpupuli/container-puppetserver/tree/7.2.1) (2021-07-01)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.16.1...7.2.1)

## [6.16.1](https://github.com/voxpupuli/container-puppetserver/tree/6.16.1) (2021-07-01)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.1.2...6.16.1)

## [7.1.2](https://github.com/voxpupuli/container-puppetserver/tree/7.1.2) (2021-04-21)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.2.0...7.1.2)

## [7.2.0](https://github.com/voxpupuli/container-puppetserver/tree/7.2.0) (2021-04-21)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.15.3...7.2.0)

## [6.15.3](https://github.com/voxpupuli/container-puppetserver/tree/6.15.3) (2021-04-14)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.16.0...6.15.3)

## [6.16.0](https://github.com/voxpupuli/container-puppetserver/tree/6.16.0) (2021-04-14)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.1.1...6.16.0)

## [7.1.1](https://github.com/voxpupuli/container-puppetserver/tree/7.1.1) (2021-04-07)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.15.2...7.1.1)

## [6.15.2](https://github.com/voxpupuli/container-puppetserver/tree/6.15.2) (2021-04-07)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.0.3...6.15.2)

## [7.0.3](https://github.com/voxpupuli/container-puppetserver/tree/7.0.3) (2021-01-27)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.1.0...7.0.3)

## [7.1.0](https://github.com/voxpupuli/container-puppetserver/tree/7.1.0) (2021-01-27)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.12.0...7.1.0)

## [6.12.0](https://github.com/voxpupuli/container-puppetserver/tree/6.12.0) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.12.1...6.12.0)

## [6.12.1](https://github.com/voxpupuli/container-puppetserver/tree/6.12.1) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.13.0...6.12.1)

## [6.13.0](https://github.com/voxpupuli/container-puppetserver/tree/6.13.0) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.14.0...6.13.0)

## [6.14.0](https://github.com/voxpupuli/container-puppetserver/tree/6.14.0) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.14.1...6.14.0)

## [6.14.1](https://github.com/voxpupuli/container-puppetserver/tree/6.14.1) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.15.0...6.14.1)

## [6.15.0](https://github.com/voxpupuli/container-puppetserver/tree/6.15.0) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.15.1...6.15.0)

## [6.15.1](https://github.com/voxpupuli/container-puppetserver/tree/6.15.1) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.0.0...6.15.1)

## [7.0.0](https://github.com/voxpupuli/container-puppetserver/tree/7.0.0) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.0.1...7.0.0)

## [7.0.1](https://github.com/voxpupuli/container-puppetserver/tree/7.0.1) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/7.0.2...7.0.1)

## [7.0.2](https://github.com/voxpupuli/container-puppetserver/tree/7.0.2) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.12.2...7.0.2)

## [6.12.2](https://github.com/voxpupuli/container-puppetserver/tree/6.12.2) (2020-05-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.11.1...6.12.2)

## [6.11.1](https://github.com/voxpupuli/container-puppetserver/tree/6.11.1) (2020-04-20)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.11.0...6.11.1)

## [6.11.0](https://github.com/voxpupuli/container-puppetserver/tree/6.11.0) (2020-04-20)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.10.0...6.11.0)

## [6.10.0](https://github.com/voxpupuli/container-puppetserver/tree/6.10.0) (2020-03-24)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.9.2...6.10.0)

## [6.9.2](https://github.com/voxpupuli/container-puppetserver/tree/6.9.2) (2020-02-20)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.9.1...6.9.2)

## [6.9.1](https://github.com/voxpupuli/container-puppetserver/tree/6.9.1) (2020-02-20)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.9.0...6.9.1)

## [6.9.0](https://github.com/voxpupuli/container-puppetserver/tree/6.9.0) (2020-01-27)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.8.0...6.9.0)

## [6.8.0](https://github.com/voxpupuli/container-puppetserver/tree/6.8.0) (2019-12-12)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.7.2...6.8.0)

## [6.7.2](https://github.com/voxpupuli/container-puppetserver/tree/6.7.2) (2019-10-27)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.7.1...6.7.2)

## [6.7.1](https://github.com/voxpupuli/container-puppetserver/tree/6.7.1) (2019-10-02)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.7.0...6.7.1)

## [6.7.0](https://github.com/voxpupuli/container-puppetserver/tree/6.7.0) (2019-09-26)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.6.0...6.7.0)

## [6.6.0](https://github.com/voxpupuli/container-puppetserver/tree/6.6.0) (2019-09-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.5.0...6.6.0)

## [6.5.0](https://github.com/voxpupuli/container-puppetserver/tree/6.5.0) (2019-07-18)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.4.0...6.5.0)

## [6.4.0](https://github.com/voxpupuli/container-puppetserver/tree/6.4.0) (2019-06-06)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.3.3...6.4.0)

## [6.3.3](https://github.com/voxpupuli/container-puppetserver/tree/6.3.3) (2019-03-20)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.3.1...6.3.3)

## [6.3.1](https://github.com/voxpupuli/container-puppetserver/tree/6.3.1) (2019-03-20)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.3.0...6.3.1)

## [6.3.0](https://github.com/voxpupuli/container-puppetserver/tree/6.3.0) (2019-03-20)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.3.2...6.3.0)

## [6.3.2](https://github.com/voxpupuli/container-puppetserver/tree/6.3.2) (2019-03-20)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.2.1...6.3.2)

## [6.2.1](https://github.com/voxpupuli/container-puppetserver/tree/6.2.1) (2019-02-11)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.0.4...6.2.1)

## [6.0.4](https://github.com/voxpupuli/container-puppetserver/tree/6.0.4) (2019-02-09)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.0.5...6.0.4)

## [6.0.5](https://github.com/voxpupuli/container-puppetserver/tree/6.0.5) (2019-02-09)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.8...6.0.5)

## [5.3.8](https://github.com/voxpupuli/container-puppetserver/tree/5.3.8) (2019-02-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.16...5.3.8)

## [5.3.16](https://github.com/voxpupuli/container-puppetserver/tree/5.3.16) (2019-02-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.15...5.3.16)

## [5.3.15](https://github.com/voxpupuli/container-puppetserver/tree/5.3.15) (2019-02-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.14...5.3.15)

## [5.3.14](https://github.com/voxpupuli/container-puppetserver/tree/5.3.14) (2019-02-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.13...5.3.14)

## [5.3.13](https://github.com/voxpupuli/container-puppetserver/tree/5.3.13) (2019-02-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.12...5.3.13)

## [5.3.12](https://github.com/voxpupuli/container-puppetserver/tree/5.3.12) (2019-02-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.11...5.3.12)

## [5.3.11](https://github.com/voxpupuli/container-puppetserver/tree/5.3.11) (2019-02-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.10...5.3.11)

## [5.3.10](https://github.com/voxpupuli/container-puppetserver/tree/5.3.10) (2019-02-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.9...5.3.10)

## [5.3.9](https://github.com/voxpupuli/container-puppetserver/tree/5.3.9) (2019-02-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.2.0...5.3.9)

## [6.2.0](https://github.com/voxpupuli/container-puppetserver/tree/6.2.0) (2019-01-10)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.0.3...6.2.0)

## [6.0.3](https://github.com/voxpupuli/container-puppetserver/tree/6.0.3) (2019-01-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.7...6.0.3)

## [5.3.7](https://github.com/voxpupuli/container-puppetserver/tree/5.3.7) (2019-01-08)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.1.0...5.3.7)

## [6.1.0](https://github.com/voxpupuli/container-puppetserver/tree/6.1.0) (2018-12-12)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.6...6.1.0)

## [5.3.6](https://github.com/voxpupuli/container-puppetserver/tree/5.3.6) (2018-10-19)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.0.2...5.3.6)

## [6.0.2](https://github.com/voxpupuli/container-puppetserver/tree/6.0.2) (2018-10-05)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.0.1...6.0.2)

## [6.0.1](https://github.com/voxpupuli/container-puppetserver/tree/6.0.1) (2018-09-21)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/6.0.0...6.0.1)

## [6.0.0](https://github.com/voxpupuli/container-puppetserver/tree/6.0.0) (2018-09-17)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.5...6.0.0)

## [5.3.5](https://github.com/voxpupuli/container-puppetserver/tree/5.3.5) (2018-08-10)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/5.3.4...5.3.5)

## [5.3.4](https://github.com/voxpupuli/container-puppetserver/tree/5.3.4) (2018-06-13)

[Full Changelog](https://github.com/voxpupuli/container-puppetserver/compare/d4a1fad4637c70b4561711ba605a7aded48fd349...5.3.4)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
