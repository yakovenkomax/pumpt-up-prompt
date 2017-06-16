## Features
1. Light 🎈<br/>
	Pure bash. No hidden engines in background. Fast even in huge projects.
    
2. Beautiful 🎀<br/>
	All separators are hand crafted and pixel-perfect. Enjoy the smoothness.
    
3. Hard to pronounce 🤔<br/>
	Not really a feature, but... you can use it as a tongue twister!

## Previews

<img width="682" alt="screenshot 2017-05-29 00 32 18" src="https://cloud.githubusercontent.com/assets/5172360/26532373/8c79ba10-4407-11e7-8aaa-9df86b2600e5.png">

**Terminal**: [iTerm2](https://www.iterm2.com/)<br/>
**Theme**: Solarized Dark<br/>
**Font**: Menlo PP12

## Installation
1. Pumpt Up Prompt script:
    1. Copy `.pumpt-up-prompt.sh` to your root directory;
    2. Include pumpt-up-prompt script to your `.bash_profile` by adding `[[ -f ~/.pumpt-up-prompt.sh ]] && . ~/.pumpt-up-prompt.sh` (or copy .bash_profile file from this repo).
2. Pumpt Up Prompt font with icons:
    1. Download your favorite font from the `Fonts` folder;
    2. Choose a font depending on font size you are using, ex. take Menlo PP13 if you are using 13pt font size in your terminal.
3. Git Prompt Plugin. Copy `git-prompt.sh` and `git-completion.bash` from [Git Prompt Plugin](https://github.com/git/git/tree/master/contrib/completion) to your root folder;

## Segment list

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

## Credits
Inspired by [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) and [agnoster theme](https://github.com/robbyrussell/oh-my-zsh/wiki/Themes#agnoster).<br/>
Most icons are from [Font Awesome](http://fontawesome.io/).
