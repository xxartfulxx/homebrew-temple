# homebrew-temple

Homebrew tap for [Temple](https://github.com/xxartfulxx/Temple).

## Install

Until Temple ships a tagged release with a stable tarball and checksum, install the head build:

```bash
brew tap xxartfulxx/temple
brew install temple --HEAD
```

Then run:

```bash
temple
```

## Notes

- this tap currently installs the latest `main` branch from `xxartfulxx/Temple`
- once Temple has a real release tag, switch `Formula/temple.rb` to a stable `url` and `sha256`
- after that, users will be able to run `brew install temple` without `--HEAD`
