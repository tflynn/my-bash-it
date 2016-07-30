# my-bash-it

**my-bash-it** is a clone of my-bash-it with all the content stripped out. It is meant to allow me to maintain all my aliases etc. in my-bash-it's well-originanized structure to sit alongside my-bash-it.

## Install

1. Check out a clone of this repo to a location of your choice, such as: `git clone --depth=1 https://github.com/tflynn/my-bash-it.git`
2. Run `~/.my-bash_it/install.sh` (it automatically backs up your `~/.bash_profile` or `~/.bashrc`, depending on your OS)
3. Edit your modified config (`~/.bash_profile` or `~/.bashrc`) file in order to customize my-bash-it.
4. Check out available aliases, completions and plugins and enable the ones you want to use (see the next section for more details).

**INSTALL OPTIONS:**
The install script can take the following options:

* `--interactive`: Asks the user which aliases, completions and plugins to enable.

When run without the `--interactive` switch, Bash-it only enables a sane default set of functionality to keep your shell clean and to avoid issues with missing dependencies. Feel free to enable the tools you want to use after the installation.

**NOTE**: Keep in mind how Bash load its configuration files, `.bash_profile` for login shells (and in Mac OS X in terminal emulators like [Termminal.app](http://www.apple.com/osx/apps/) or [iTerm2](https://www.iterm2.com/)) and `.bashrc` for interactive shells (default mode in most of the GNU/Linux terminal emulators), to ensure that Bash-it is loaded correctly. A good "practice" is sourcing `.bashrc` into `.bash_profile` to keep things working in all the scenarios, to achieve this, you can add this snippet in your `.bash_profile`:

```
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
```

Refer to the official [Bash documention](https://www.gnu.org/software/bash/manual/bashref.html#Bash-Startup-Files) to get more info.

## Update

To update my-bash-it, simply run:

```
my-bash-it update
```

that's all.

## Help Screens

```
my-bash-it show aliases        # shows installed and available aliases
my-bash-it show completions    # shows installed and available completions
my-bash-it show plugins        # shows installed and available plugins
my-bash-it help aliases        # shows help for installed aliases
my-bash-it help completions    # shows help for installed completions
my-bash-it help plugins        # shows help for installed plugins
```

## Search

If you need to quickly find out which of the plugins, aliases or completions
are available for a specific framework, programming language, or an environment, you can _search_ for
multiple terms related to the commands you use frequently.  Search will
find and print out modules with the name or description matching the terms
provided.

#### Syntax

```bash
  my-bash-it search term1 [[-]term2] [[-]term3]....
```

As an example, a ruby developer might want to enable everything
related to the commands such as `ruby`, `rake`, `gem`, `bundler` and `rails`.
Search command helps you find related modules, so that you can decide which
of them you'd like to use:

```bash
❯ my-bash-it search ruby rake gem bundle irb rails
      aliases:  bundler rails
      plugins:  chruby chruby-auto ruby
  completions:  bundler gem rake
```

Currently enabled modules will be shown in green.

#### Search with Negations

You can prefix a search term with a "-" to exclude it from the results. In the above
example, if we wanted to hide `chruby` and `chruby-auto`, we could change the command as
follows:

```bash
❯ my-bash-it search ruby rake gem bundle irb rails -chruby
      aliases:  bundler rails
      plugins:  ruby
  completions:  bundler gem rake
```

#### Using Search to Enable or Disable Components

By adding a `--enable` or `--disable` to the search command, you can automatically
enable all modules that come up as a result of a search query. This could be quite
handy if you like to enable a bunch of components related to the same topic.

#### Disabling ASCII Color

To remove non-printing non-ASCII characters responsible for the coloring of the
search output, you can set environment variable `NO_COLOR`. Enabled components will
then be shown with a checkmark:

```bash
❯ NO_COLOR=1 my-bash-it search ruby rake gem bundle irb rails -chruby
      aliases  =>   ✓bundler ✓rails
      plugins  =>   ✓ruby
  completions  =>   bundler gem rake
```

## Uninstalling

To uninstall Bash-it, run the `uninstall.sh` script found in the `$MY_BASH_IT` directory:

```
cd $MY_BASH_IT
./uninstall.sh
```

This will restore your previous Bash profile. After the uninstall script finishes, remove the my-bash-it directory from your machine (`rm -rf $MY_BASH_IT`) and start a new shell.

