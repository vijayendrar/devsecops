<h4> install vim editor </h4>
 
    yum install vim 

<h4> configure the .vimrc file under /home/ansible/ for Yaml support </h4>

  autocmd FileType yaml setlocal ai ts=2 sw=2 et cuc

<h4> test the yaml syntax writing by creating test.yaml </h4>


![image](https://github.com/vijayendrar/devsecops/blob/main/Ansible/images/syntax.gif)
