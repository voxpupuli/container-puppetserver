# Release

## On a fork

Please follow these instructions carefully.
Ensure that you name the branch precisely as `release-vX.Y.Z`
since this nomenclature is crucial for obtaining the `future_version` in the changelog.
Your attention to this specific branch naming convention is essential for accurate version tracking in the changelog.

```shell
export RELEASE_VERSION="X.Y.Z"
git switch main
git pull -r
git switch -c release-v$RELEASE_VERSION
bundle config set --local path vendor/bundle
bundle install
CHANGELOG_GITHUB_TOKEN="token_MC_tokenface" bundle exec rake changelog
git commit -am "Release v${RELEASE_VERSION}"
git push origin release-v$RELEASE_VERSION
```

Then open a PR, discuss and merge.

## After the merge, as a maintainer on upstream

```shell
git switch main
git pull -r
git tag v$RELEASE_VERSION
git push --tags
```

## Tags

Each puppetserver and puppetdb is accompanied by a build_versions.json file
containing information about puppet releases and versions built when a tag is pushed or a change is made to the main branch.

To enhance clarity and organization, we are transitioning from our previous tagging approach
and will now distinguish the container tag from the puppet version.
The new tags will follow the format vX.Y.Z. The CI build process operates within a matrix,
leveraging the data from the JSON file to construct the specified versions.
As a result, two Docker tags are currently generated: 7.13.0-vX.Y.Z corresponds to
the Puppet Release 7.13.0 build with container version X.Y.Z, while 8.10.0-vX.Y.Z aligns
with Release 8.10.0. These tags offer a more streamlined and informative representation of our build versions.

The container tags like `7.13.0-main` and `8.10.0-main` are built automatically
whenever changes are merged into the Git main branch.
It's important to note that these tags are designated as development tags
and might be subject to breakage, so exercise caution when using them.
