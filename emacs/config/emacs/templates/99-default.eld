;; SPDX-FileCopyrightText: 2022 Emil Lundmark <emil@lndmrk.se>
;; SPDX-License-Identifier: GPL-3.0-or-later

fundamental-mode

(today (format-time-string "%Y-%m-%d"))

c-mode c++-mode

(for
 "for (int " (p "i" i) " = 0; " (s i) " < " p "; ++" (s i) ") {" n
 > q n
 "}" n)

(if-0
 "#if 0" n
 r n
 "#endif" n)

(include-guard
 "#ifndef " (p (concat (upcase (replace-regexp-in-string
                                "[^[:alnum:]]" "_" (my-project-file-name))) "_")
               guard) n
 "#define " (s guard) n
 n r n n
 "#endif  " (my-comment-start) (s guard) n)

(include-main
 "#include \""
 (p (concat (replace-regexp-in-string
             "\\([-_]\\(test\\|unittest\\)\\)?$" ""
             (file-name-sans-extension (my-project-file-name)))
            ".h"))
 "\"" n)

(main
 "int main(int argc, char* argv[]) {" n
 > q n
 > "return 0;" n
 "}" n)

c++-mode

(begin-end
 (p "c" c) ".begin(), " (s c) ".end()")

(class
 "class "
 (p (string-inflection-pascal-case-function
     (file-name-base (buffer-file-name)))
    name)
 " {" n
 " public:" n
 > (s name) "() = " (p "default" ctor) ";" n
 n
 > (s name) "(const " (s name) "&) = "  ";" n
 > (s name) "& operator=(const " (s name) "&) = " (s copy) ";" n
 n
 > (s name) "(" (s name) "&&) = " (p "default" move) ";" n
 > (s name) "& operator=(" (s name) "&&) = " (s move) ";" n
 n
 > "~" (s name) "() = " (p "default" dtor) ";" n
 n
 > q n
 "};" n)

(copy
 (p "Name: " name 'noinsert)
 > (s name) "(const " (s name) "&) = " (p "default" copy) ";" n
 > (s name) "& operator=(const " (s name) "&) = " (s copy) ";" n)

(iterator-if
 "if (auto it = " (p "c" c) "." p "; it != " (s c) ".end()) {" n
 > q n
 "}" n)

(iterator-for
 "for (auto it = " (p "c" c) ".begin(); it != " (s c) ".end(); ++it) {" n
 > q n
 "}" n)

(move
 (p "Name: " name 'noinsert)
 > (s name) "(" (s name) "&&) = " (p "default" move) ";" n
 > (s name) "& operator=(" (s name) "&&) = " (s move) ";" n)

(namespace
 (p "Name: " name 'noinsert)
 "namespace " (s name) " {" n
 n r n n
 "}  " (my-comment-start) "namespace " (s name) n)

(operator-ostream
 "std::ostream& operator<<(std::ostream& os, const " p "& v) {" n
 > "return os << v." q ";" n
 "}" n)

(struct
 "struct "
 (p (string-inflection-pascal-case-function
     (file-name-base (buffer-file-name))))
 " {" n
 > q n
 "};" n)

markdown-mode

(block
 "```" n
 r n
 "```" n)

org-mode

(example
 "#+begin_example" n
 r n
 "#+end_example" n)

(src
 "#+begin_src " p n
 r n
 "#+end_src" n
 :post (org-edit-src-code))

(src-elisp
 "#+begin_src emacs-lisp" n
 r n
 "#+end_src" n
 :post (org-edit-src-code))

(src-sh
 "#+begin_src sh" n
 r n
 "#+end_src" n
 :post (org-edit-src-code))

(title
 "#+title: " p n
 "#+author: " (user-full-name) n)

prog-mode

;; REUSE-IgnoreStart
(licence
 (my-comment-start) "SPDX-FileCopyrightText: "
 (format-time-string "%Y") " " (user-full-name) " <" user-mail-address ">" n
 (my-comment-start) "SPDX-License-Identifier: " p n)
;; REUSE-IgnoreEnd

(todo (my-comment-start) "TODO: " n)

python-mode

(main
 "def main():" n
 > q n n n
 "if __name__ == \"__main__\":" n
 > "main()" n)

(shebang "#!/usr/bin/env python" n)

sh-mode

(main
 "main() {" n
 > q n
 "}" n
 n
 "main \"${@}\"" n)

(shebang "#!/usr/bin/env bash" n)

;; Local Variables:
;; mode: lisp-data
;; End:
