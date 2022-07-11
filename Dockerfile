FROM codercom/code-server
EXPOSE 8080
RUN sudo apt-get update -y && \
  sudo apt-get install -y \
  python3 \
  python3-pip \
  build-essential \
  cmake \
  vim-nox \
  python3-dev \
  mono-complete \
  golang \
  nodejs \
  default-jdk \
  npm \
  protobuf-compiler \
  xclip \
  xsel && echo "set nocompatible \n\
filetype off \n\
set rtp+=~/.vim/bundle/Vundle.vim \n\
call vundle#begin() \n\
Plugin 'VundleVim/Vundle.vim' \n\
Plugin 'Valloric/YouCompleteMe' \n\
call vundle#end() \n\
filetype plugin indent on \n"\
>> /home/coder/.vimrc && git clone https://github.com/VundleVim/Vundle.vim.git \
    /home/coder/.vim/bundle/Vundle.vim && \
    vim +PluginInstall +qall && \
  mkdir -p /home/coder/.vim/autoload /home/coder/.vim/bundle && \
  curl -LSso /home/coder/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
  cd /home/coder/.vim/bundle && \
  git clone https://github.com/altercation/vim-colors-solarized.git &&\
  git clone --depth=1 https://github.com/vim-syntastic/syntastic.git &&\
echo "syntax on \n\
execute pathogen#infect() \n\
set background=dark \n\
let g:solarized_termcolors=256 \n\
set t_Co=256 \n\
colorscheme solarized \n\
set number \n\
set expandtab \n\
set tabstop=2 \n\
set softtabstop=2 \n\
set shiftwidth=2 \n\
command W :execute ':silent w !sudo tee % > /dev/null' | :edit! \n\
set statusline+=%#warningmsg# \n\
set statusline+=%{SyntasticStatuslineFlag()} \n\
set statusline+=%* \n\
let g:syntastic_always_populate_loc_list = 1 \n\
let g:syntastic_auto_loc_list = 1 \n\
let g:syntastic_check_on_open = 1 \n\
let g:syntastic_check_on_wq = 0 \n\
let g:syntastic_cpp_compiler = \"g++\" \n\
let g:syntastic_cpp_compiler_options = \"-std=c++20 -Wall -Wextra -Wpedantic\" \n\
let g:ycm_show_diagnostics_ui = 1 \n\
set smartindent \n\
set mouse=a \n\
let g:ycm_autoclose_preview_window_after_insertion = 1 \n\
let g:ycm_autoclose_preview_window_after_insertion = 1 \n\
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>'] \n\
set completeopt-=preview\n" >> /home/coder/.vimrc &&\
cd /home/coder/.vim/bundle/YouCompleteMe &&\
python3 install.py --all
WORKDIR /home/coder
ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
