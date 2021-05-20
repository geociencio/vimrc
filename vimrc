" NOTA:  Setting 'compatible' cambia numerosas opciones, asi que alguna
" opcion se debe colocar 'set' DESPUES de 'set compatible'.
set compatible
" Esta linea no deveria ser borrada ya que esto asegura que varias opciones
" seran propiamente colocadas para trabajar con los paquetes relacionados a Vim.
runtime! archlinux.vim

				" Verificar si plug.vim se encuentra en el equipo de lo 
				" contrario instalarlo
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -flo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Los Complentos 'Plugins' seran descargados al directorio especificado.
call plug#begin('~/.vim/plugged')

" Declarar lista de complementos.
Plug 'tpope/vim-sensible'
Plug 'relastle/bluewery.vim'
Plug 'jcherven/jummidark.vim'
Plug 'wadackel/vim-dogrun'
Plug 'vim-scripts/indentpython.vim'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'preservim/nerdtree'
Plug 'doums/darcula'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'jacoborus/tender.vim'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'

" La lista finaliza aqui. los complementos seran visibles a vim en adelante.
call plug#end()


filetype plugin indent on      " Cargar las reglas de sangrias (indentacion) y 
                               " Plugins de acuerdo a lo detectado por tipo de archivo.

cmap w!! w !sudo tee % >/dev/null " Permite guardar archivo con sudo

let NERDTreeIgnore = ['\.pyc$']

set tw=0
set wm=0
set nowrap
set linebreak

" ==========================================================
" Ajustes Basicos
" ==========================================================
syntax on
filetype on                   " intenta detectar tipos de archivos
filetype plugin indent on     " habilitar la carga del archivo de sangría para 
                              " el tipo de archivo
set nu                        " Mostrar números de línea
set numberwidth=1             " usando solo 1 columna (y 1 espacio) si posible
set background=dark           " Estamos usando un fondo oscuro en vim.
set title                     " mostrar título en la barra de título de la consola
set wildmenu                  " menú completado en modo comando en <Tab>
set wildmode=full             " <Tab> alterna entre todas las opciones coincidentes.
set showcmd
set clipboard=unnamed         " Acceder al contenido de clipboard del sistema
set backspace=indent,eol,start " Permitir retroceder sobre todo en el modo de 
                               " inserción.
inoremap # #                  " No superes a los hashes
set history=500               " Establece cuántas líneas de historia debe 
                              " recordar Vim
set tabstop=4                 " Iniciar la sangria en 4
set shiftwidth=4              " cambiar el número de caracteres de espacio 
                              " insertados para la sangría
set expandtab                 " insertar caracteres de espacio siempre que se 
                              " presione la tecla de tabulación
set smarttab                  " afecta cómo se interpretan las pulsaciones de la
                              " tecla <TAB> dependiendo de dónde esté el cursor
set autoindent                " Sangría automática de líneas
set smartindent               " inserta automáticamente un nivel extra de 
                              " sangría en algunos casos y funciona para archivos
                              " tipo C
"set mouse=a                  " Habilite el uso del mouse para todos los modos
set ls=2                      " Mostrar siempre la línea de estado
set ruler                     " Muestra la posición del cursor en la última 
                              " línea de la pantalla o en la línea de estado de 
                              " una ventana.
set hidden                    " Permite reutilizar la misma ventana y cambiar
                              " de un búfer no guardado sin guardarlo primero. 
                              " También le permite mantener un historial de 
                              " deshacer para varios archivos cuando reutiliza 
                              " la misma ventana de esta manera
set nolazyredraw              " No vuelva a dibujar mientras ejecuta macros
set showmatch                 " Mostrar corchetes coincidentes cuando el 
                              " indicador de texto esté sobre ellos
set encoding=utf8             " La codificación mostrada.
set nobackup                  " No crear archivos de respaldo
set noswapfile                " No crear archivos de intercambio

" Obtener sangría para seguir los estándares PEP 8. y mejorar la manipulacion de
" la sangría automática.
au FileType python set omnifunc=pythoncomplete#Complete
au Filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
au FileType python set foldmethod=indent foldlevel=80

" Ejecutar pyflake8
autocmd FileType python map <Leader>8 :call Flake8()<CR>

" Ejecutar cuando se guerden los archivos py
autocmd BufWritePost *.py call Flake8()

" Ignorar Errores
let g:flake8_ignore="E501,W293"
let g:airline#extensions#tabline#enabled = 1

colorscheme purify           " Esquema de color

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
