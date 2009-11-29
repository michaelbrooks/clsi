#LATEX_CHROOT_DIR = File.join(RAILS_ROOT, 'latexchroot')
#LATEX_COMPILE_DIR_RELATIVE_TO_CHROOT = 'compiles'
#LATEX_COMPILE_DIR = File.join(LATEX_CHROOT_DIR, LATEX_COMPILE_DIR_RELATIVE_TO_CHROOT)
#WILDCARD_FS_DIR_RELATIVE_TO_CHROOT = 'wildcard_fs'
#WILDCARD_FS_DIR = File.join(LATEX_CHROOT_DIR, WILDCARD_FS_DIR_RELATIVE_TO_CHROOT)
#LATEX_COMMAND = File.join(RAILS_ROOT, 'chrootedlatex')
#BIBTEX_COMMAND = File.join(RAILS_ROOT, 'chrootedbibtex')

LATEX_CHROOT_DIR = File.join(RAILS_ROOT, 'latexchroot')
LATEX_COMPILE_DIR_RELATIVE_TO_CHROOT = File.join(RAILS_ROOT, 'latexchroot/compiles')
LATEX_COMPILE_DIR = LATEX_COMPILE_DIR_RELATIVE_TO_CHROOT
WILDCARD_FS_DIR_RELATIVE_TO_CHROOT = File.join(RAILS_ROOT, 'latexchroot/wildcard_fs')
WILDCARD_FS_DIR = WILDCARD_FS_DIR_RELATIVE_TO_CHROOT
LATEX_COMMAND = '/usr/texbin/pdflatex'
BIBTEX_COMMAND = '/usr/texbin/bibtex'
