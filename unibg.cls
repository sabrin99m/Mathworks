\ProvidesClass{unibg}

\makeatletter

\DeclareOption{italian}{
  \gdef\@lang{italian}
}
\DeclareOption{english}{
  \gdef\@lang{english}
}

\DeclareOption{master}{
  \gdef\@degtype{master}
}
\DeclareOption{bachelor}{
  \gdef\@degtype{bachelor}
}

\ExecuteOptions{italian,master}

\ProcessOptions\relax

\LoadClass[a4paper,12pt,twoside,openright]{report}

\RequirePackage[backend=biber]{biblatex}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[\@lang]{babel}
\RequirePackage{amsmath}
\RequirePackage{caption}
\RequirePackage{csquotes}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{import}
\RequirePackage{listings}
\RequirePackage{multicol}
\RequirePackage{xifthen}
\RequirePackage{xstring}

\DeclareStringOption[italian]{lang}

% ----------------------- Bibliography
\addbibresource{bibliography.bib}

% ----------------------- Graphics
\graphicspath{{./images/}}

% ----------------------- Page style
\fancypagestyle{plain}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[CE,CO]{}
  \fancyfoot[LE,RO]{\thepage}
}
\pagestyle{plain}

% ----------------------- Geometry and measures
\geometry{margin=3cm}
\renewcommand{\baselinestretch}{1.5}
\setcounter{tocdepth}{4}

% ----------------------- New commands
\newcommand{\emptypage}{
  \clearpage
  \thispagestyle{empty}
  \pagenumbering{gobble}
  \mbox{}
}
\newcommand{\toc}[1][]{
  \clearpage
  \pagenumbering{Roman}
  \tableofcontents
  \IfSubStr{#1}{figures}{\listoffigures}{}
  \IfSubStr{#1}{tables}{\listoftables}{}
    \ifthenelse{\equal{\@lang}{italian}}
      {\renewcommand{\lstlistlistingname}{Elenco dei Codici}}
      {\renewcommand{\lstlistlistingname}{List of Listings}}
  \IfSubStr{#1}{listings}{\lstlistoflistings}{}
}

% ----------------------- Title page
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\department#1{\gdef\@department{#1}}
\def\course#1{\gdef\@course{#1}}
\def\class#1{\gdef\@class{#1}}
\def\advisor#1{\gdef\@advisor{#1}}
\def\coadvisor#1{\gdef\@coadvisor{#1}}
\def\studentid#1{\gdef\@studentid{#1}}
\def\year#1{\gdef\@year{#1}}
\def\@coadvisor{}
\def\@subtitle{}

\def\changemargin#1#2{\list{}{\rightmargin#2\leftmargin#1}\item[]}
\let\endchangemargin=\endlist

\renewcommand{\maketitle}{
  \newcommand{\@trDepartment}{\ifthenelse{\equal{\@lang}{italian}}{Dipartimento di}{Department of}}
  \newcommand{\@trCourseB}{\ifthenelse{\equal{\@lang}{italian}}{Corso di Laurea in}{Bachelor Degree in}}
  \newcommand{\@trCourseM}{\ifthenelse{\equal{\@lang}{italian}}{Corso di Laurea Triennale in}{Master Degree in}}
  \newcommand{\@trClass}{\ifthenelse{\equal{\@lang}{italian}}{Classe}{Class}}
  \newcommand{\@trAdvisor}{\ifthenelse{\equal{\@lang}{italian}}{Relatore}{Advisor}}
  \newcommand{\@trCoAdvisor}{\ifthenelse{\equal{\@lang}{italian}}{Correlatore}{Co-advisor}}
  \newcommand{\@trTesiLaureaB}{\ifthenelse{\equal{\@lang}{italian}}{Tesi di Laurea}{Thesis}}
  \newcommand{\@trTesiLaureaM}{\ifthenelse{\equal{\@lang}{italian}}{Tesi di Laurea Triennale}{Master Thesis}}
  \newcommand{\@trStudentNumber}{\ifthenelse{\equal{\@lang}{italian}}{Matricola n.}{Student number}}
  \newcommand{\@trAnnoAccademico}{\ifthenelse{\equal{\@lang}{italian}}{ANNO ACCADEMICO}{ACADEMIC YEAR}}

  \begin{titlepage}
    \ifthenelse{\equal{\@degtype}{master}}
      {
        \begin{center}
          \large
          UNIVERSITÀ DEGLI STUDI DI BERGAMO \\
          \vspace{0.5cm}
          \normalsize
          \@trDepartment~\@department \\
          \@trCourseM~\@course \\
          \@trClass~\@class
    
          \vfill
    
          \Huge
          \textbf{\@title}
    
          \LARGE
          \@subtitle
        \end{center}
    
        \vfill
    
        \begin{flushleft}
          \@trAdvisor \\
          \@advisor
        \end{flushleft}
    
        \ifthenelse{\equal{\@coadvisor}{}}{}{
          \begin{flushleft}
            \@trCoAdvisor \\
            \@coadvisor
          \end{flushleft}
        }
    
        \begin{flushright}
          {\@trTesiLaureaM} \\
          \@author \\
          \@trStudentNumber~\@studentid
        \end{flushright}
    
        \vfill
    
        \begin{center}
          \@trAnnoAccademico~\@year
        \end{center}
      }
      {
        \newcommand{\@trCandidato}{\ifthenelse{\equal{\@lang}{italian}}{Candidato}{Candidate}}

        \includegraphics[width=8.79cm]{images/unibg-logo-wide.png}

        \vspace{0.5cm}

        \begin{changemargin}{4cm}{0cm}
          \@trDepartment \\
          \@department

          \vspace{0.5cm}

          \@trCourseB \\
          \@course

          \vspace{0.1cm}

          \@trClass~\@class

          \vfill

          {\Huge\textbf{\@title}}
    
          {\LARGE\@subtitle}

          \vfill

          \begin{multicols}{2}
          \@trCandidato: \\ \textit{\@author} \\
          \@trStudentNumber~\@studentid

          \columnbreak
          
          \@trAdvisor: \\ \textit{\@advisor}
          
          \vspace{0.5cm}
          
          \ifthenelse{\equal{\@coadvisor}{}}{}{\@trCoAdvisor: \\ \textit{\@coadvisor}}
          \end{multicols}

          \vfill

          \@trAnnoAccademico \\
          \@year

        \end{changemargin}
      }
  \end{titlepage}
}

\makeatother

\endinput