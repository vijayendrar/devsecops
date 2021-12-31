<h4> install vim editor </h4>
 
    yum install vim 

<h4> configure the .vimrc file under /home/ansible/ for Yaml support </h4>

  autocmd FileType yaml setlocal ai ts=2 sw=2 et cuc

<h4> test the yaml syntax writing by creating test.yaml </h4>


![image](https://github.com/vijayendrar/devsecops/blob/main/Ansible/images/syntax.gif)


<h4> more complex and customize vimrc configuration </h4>

  syntax on
  filetype plugin indent on
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab et ai cuc
  colorscheme murphy

  highlight CursorColumn cterm=NONE ctermbg=magenta ctermfg=NONE guibg=NONE guifg=NONE

  ![image](https://github.com/vijayendrar/devsecops/blob/main/Ansible/images/vimrc.gif)