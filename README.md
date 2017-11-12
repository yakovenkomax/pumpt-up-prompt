<p align="center">
	<img width="115" alt="Pumpt Up Prompt" src="https://user-images.githubusercontent.com/5172360/32691627-ba884c4a-c71b-11e7-9ed3-ab72ee2cb72a.png">
</p>

<h1 align="center">Pumped Up Prompt</h1>

Pumped Up Prompt is a set of solutions to improve your shell experience. It contains:
1. Custom segmented shell prompt;
2. Font with segment separators and icons*;
3. Optional improvements.

*Pumped Up Prompt uses the same Unicode places as Powerline Patched fonts (e.g. [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)), so you can use Pumped Up Prompt fonts instead of them if you don't need other functionality.

## Features
Light 🎈<br/>
	Pure bash. No hidden engines in the background. Fast even in huge projects.<br/>
    
Beautiful 🎀<br/>
	All separators are handcrafted and pixel-perfect. Enjoy the smoothness.<br/>
    
Hard to pronounce 🤔<br/>
	Not really a feature, but... you can use it as a tongue twister!

## Previews

<img width="682" alt="screenshot 2017-05-29 00 32 18" src="https://cloud.githubusercontent.com/assets/5172360/26532373/8c79ba10-4407-11e7-8aaa-9df86b2600e5.png">

**Terminal**: [iTerm2](https://www.iterm2.com/)<br/>
**Theme**: Solarized Dark<br/>
**Font**: Menlo PP12

## Installation
**1. Prompt:**

1. Copy `pumpt-up-prompt.sh` to your root directory;
2. Include pumpt-up-prompt script to your `.bash_profile` by adding:<br/>
`[[ -f ~/pumpt-up-prompt.sh ]] && . ~/pumpt-up-prompt.sh`<br/>
or just copy the `.bash_profile` file from this repo.

**2. Font (separators and icons):**

1. Download your favorite font from the `Fonts` folder;
2. Choose a font depending on the font size you are using, ex. take Menlo PP15 if you are using 15pt font size in your terminal.

**3. Git Prompt Plugin:**

* Copy `git-prompt.sh` and `git-completion.bash` from [Git Prompt Plugin](https://github.com/git/git/tree/master/contrib/completion) to your root folder;

**4. \[Optional\] Install the latest Bash version:**

1. Install Homebrew<br/>
	`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
2. Install Bash<br/>
	`brew install bash`
3. Add the new shell to the list of allowed shells<br/>
	`sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'`
4. Change your shell to the new shell<br/>
	`chsh -s /usr/local/bin/bash`

**5. \[Optional\] Install a better bash default configuration with [Sensible Bash](https://github.com/mrzool/bash-sensible)**

## Segments
Segments' color and order are changed in 'Settings' block inside `.pumpt-up-prompt.sh`.

Segment | Description
------- | -----------
time    | Current time
user    | User name
host    | Host name
dir     | Directory
git     | Git branch (commit)
venv    | Activated Python virtual environment name
ssh     | SSH host name
screen  | Current screen name

## Terminals
Notes on using Pumpt up Prompt with different terminal emulators:

### iTerm
Pumpt up Prompt was originally developed for iTerm2, there should be no problems.

### Hyper
Hyper treats characters as a browser (which differs from how iTerm does it), so separators won't align perfectly. Fortunately, you can easily fix it by adding some CSS to Hyper settings (<kbd>⌘</kbd> + <kbd>,</kbd>).<br/>
Start with this configuration:

    // custom css to embed in the terminal window
    termCSS: '.unicode-node { margin-left: -1px; padding-right: 1px; overflow: hidden; }',

Then add `line-height` (1.2em by default) and `font-size` (1em by default) changes if needed.

### Terminal.app
Terminal.app has a mechanism that changes color for the last prompt character ([Some research on the topic](https://github.com/fish-shell/fish-shell/issues/3163)). There is no way to disable this behavior. I suggest you try other emulators if that bothers you.

## TODO
- [ ] Update font files for the iTerm2 v3
- [ ] Add more previews
- [ ] Create a complete release
- [ ] Add terminal theme recommendations
- [ ] Remove line wrap bug caused by unclosed color tags
- [ ] Research the possibility of using 256 colors
- [ ] Windows OS adaptation
- [ ] Fix git autocomplete when using git aliases

## Credits
Inspired by [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) and [agnoster theme](https://github.com/robbyrussell/oh-my-zsh/wiki/Themes#agnoster).<br/>
Icons by [Font Awesome](http://fontawesome.io/).
