%% PolyU Thesis LaTeX class
%% Based on the PolyU Research Postgraduate thesis format regulations for 2025/26.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{polyu-thesis}[2026/08/07 v1.9 PolyU Thesis LaTeX class]

\newif\ifpolyu@double
\newif\ifpolyu@screen
\polyu@doublefalse
\polyu@screentrue
\DeclareOption{double}{\polyu@doubletrue}
\DeclareOption{onehalf}{\polyu@doublefalse}
\DeclareOption{screen}{\polyu@screentrue}
\DeclareOption{print}{\polyu@screenfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[12pt,a4paper,oneside,openany]{report}

% A4 is mandatory. PolyU does not prescribe margin dimensions. A uniform 25 mm
% margin is a common electronic-thesis default and leaves a 160 mm text block.
\RequirePackage[a4paper,margin=25mm]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
% Load theorem support before newtxmath so both agree on the proof-end symbol.
\RequirePackage{amsthm}
\RequirePackage{newtxtext,newtxmath}
% The reference thesis uses Times New Roman for both body text and headings.
% Keep the template portable under pdfLaTeX by mapping every sans-serif request
% to newtx's metrically compatible Times face as well.
\renewcommand{\sfdefault}{\rmdefault}
\RequirePackage{microtype}
\RequirePackage{setspace}
\RequirePackage[table,dvipsnames]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{booktabs,longtable,tabularx,array,multirow}
\RequirePackage{xltabular}
\RequirePackage{makecell}
\RequirePackage{adjustbox}
\RequirePackage{threeparttable}
% tablefootnote detects rotating at begin-document time, so load it first.
\RequirePackage{rotating}
\RequirePackage{tablefootnote}
\RequirePackage{siunitx}
% newtxmath already provides the AMS-style symbol repertoire; loading amssymb
% afterwards duplicates \Bbbk on current TeX Live releases.
\RequirePackage{mathtools,bm}
\RequirePackage{caption,subcaption,float}
\RequirePackage{placeins}
\RequirePackage{pdflscape}
\RequirePackage{wrapfig}
\RequirePackage{changepage}
\RequirePackage{enumitem}
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\counterwithin{algorithm}{chapter}
\RequirePackage{listings}
\RequirePackage{upquote}
% Inconsolata is a clean sans-serif monospaced face for source code.
\RequirePackage[scaled=0.95]{inconsolata}
\RequirePackage{csquotes}
\RequirePackage{url}
\RequirePackage{xspace}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{hyperref}
\RequirePackage{bookmark}
\RequirePackage[nameinlink,noabbrev]{cleveref}

% pdfTeX emits a searchable PDF newer than the mandatory PDF 1.4 baseline.
\ifdefined\pdfminorversion
  \pdfminorversion=7
\fi

% Brand colours sampled from PolyU's official logo asset. A single accent keeps
% all PDF navigation predictable; print mode below suppresses link colour.
\definecolor{PolyURed}{HTML}{A02337}
\definecolor{PolyUGrey}{HTML}{58595B}
\definecolor{ThesisInk}{HTML}{202124}
\colorlet{ThesisAccent}{PolyURed}
\colorlet{ThesisLink}{PolyURed}
\definecolor{ThesisPanel}{HTML}{F3F4F6}
\definecolor{ThesisRule}{HTML}{C9CDD3}
\definecolor{CodeString}{HTML}{1D5B68}

\ifpolyu@screen
  \hypersetup{
    colorlinks=true,
    linkcolor=ThesisAccent,
    citecolor=ThesisLink,
    urlcolor=ThesisLink,
    filecolor=ThesisLink,
    linktoc=all,
    bookmarksnumbered=true,
    bookmarksopen=true,
    bookmarksopenlevel=2,
    pdfpagelayout=OneColumn,
    pdfdisplaydoctitle=true
  }
\else
  \hypersetup{
    hidelinks,
    bookmarksnumbered=true,
    bookmarksopen=true,
    bookmarksopenlevel=2,
    pdfpagelayout=OneColumn,
    pdfdisplaydoctitle=true
  }
\fi

% The document class option is the single source of truth for line spacing.
\newcommand{\polyu@applylinespacing}{%
  \ifpolyu@double\doublespacing\else\onehalfspacing\fi
}
\AtBeginDocument{\polyu@applylinespacing}

\setlength{\parindent}{1.5em}
\setlength{\parskip}{0pt}
\setlist{nosep}
\setcounter{secnumdepth}{3}
% The contents contains three heading levels: chapter, section, subsection.
\setcounter{tocdepth}{2}
% Two lines are permitted for exceptionally long chapter marks.
\setlength{\headheight}{27pt}

% Caption labels and other textual bold emphasis use the same sans-serif face;
% caption prose remains in the Times-compatible body face.
\captionsetup{font={normalsize,rm},labelfont={bf,sf},labelsep=period}
\captionsetup[algorithm]{font={normalsize,rm},labelfont={bf,sf},labelsep=period}
\captionsetup[lstlisting]{
  font={normalsize,rm},
  labelfont={bf,sf},
  labelsep=period,
  justification=raggedright,
  singlelinecheck=false
}
\DeclareTextFontCommand{\textbf}{\sffamily\bfseries}
\sisetup{detect-all}
\graphicspath{{figures/}}
\renewcommand{\arraystretch}{1.12}

% Modern, restrained hierarchy inspired by well-designed technical reports.
% Body text remains a highly readable Times-compatible face.
\titleformat{\chapter}[display]
  {\normalfont\sffamily\bfseries\color{ThesisInk}\raggedright}
  {\fontsize{12}{14}\selectfont\color{ThesisAccent}\MakeUppercase{\chaptertitlename}\ \thechapter}
  {7pt}
  {\fontsize{26}{31}\selectfont}
  [\vspace{8pt}\color{ThesisRule}\titlerule]
\titleformat{name=\chapter,numberless}[display]
  {\normalfont\sffamily\bfseries\color{ThesisInk}\raggedright}
  {}
  {0pt}
  {\fontsize{26}{31}\selectfont}
  [\vspace{8pt}\color{ThesisRule}\titlerule]
\titlespacing*{\chapter}{0pt}{-8pt}{30pt}
\titleformat{\section}
  {\normalfont\Large\sffamily\bfseries\color{ThesisInk}}
  {\thesection}{0.7em}{}
\titleformat{\subsection}
  {\normalfont\large\sffamily\bfseries\color{ThesisInk}}
  {\thesubsection}{0.7em}{}
\titleformat{\subsubsection}
  {\normalfont\normalsize\sffamily\bfseries\color{ThesisInk}}
  {\thesubsubsection}{0.7em}{}

% Navigation for a long thesis; chapter-opening pages stay visually quiet.
\renewcommand{\chaptermark}[1]{\markboth{\thechapter\quad #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\quad #1}}
\fancyhf{}
\fancyhead[L]{\small\sffamily\nouppercase{\leftmark}}
\fancyhead[R]{\small\sffamily\thepage}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\small\sffamily\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
}
\pagestyle{fancy}

% Common scientific-content tools, integrated here so the thesis remains a
% single self-contained template.
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

\newcommand{\eg}{\textit{e.g.}\xspace}
\newcommand{\ie}{\textit{i.e.}\xspace}
\newcommand{\etc}{\textit{etc.}\xspace}
\newcommand{\etal}{\textit{et~al.}\xspace}

% Accessible, print-safe result ranking for quantitative comparison tables.
% Use these semantic commands instead of colour-only red/blue highlighting.
\newcommand{\best}[1]{\textbf{#1}}
\newcommand{\runnerup}[1]{{\sffamily\mdseries\underline{#1}}}

\newtheoremstyle{thesisplain}
  {\topsep}{\topsep}{\itshape}{}% body spacing and font
  {\sffamily\bfseries}{.}{0.5em}{}% head font and punctuation
\newtheoremstyle{thesisdefinition}
  {\topsep}{\topsep}{\normalfont}{}% body spacing and font
  {\sffamily\bfseries}{.}{0.5em}{}% head font and punctuation
\newtheoremstyle{thesisremark}
  {\topsep}{\topsep}{\normalfont}{}% body spacing and font
  {\sffamily\bfseries}{.}{0.5em}{}% head font and punctuation
\theoremstyle{thesisplain}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\theoremstyle{thesisdefinition}
\newtheorem{definition}[theorem]{Definition}
\theoremstyle{thesisremark}
\newtheorem{remark}[theorem]{Remark}

\lstdefinestyle{thesis}{
  basicstyle=\small\ttfamily,
  keywordstyle=\bfseries\color{PolyURed},
  commentstyle=\itshape\color{PolyUGrey},
  stringstyle=\color{CodeString},
  numbers=left,
  numberstyle=\scriptsize\ttfamily\color{PolyUGrey},
  frame=single,
  rulecolor=\color{ThesisRule},
  backgroundcolor=\color{white},
  breaklines=true,
  showstringspaces=false,
  columns=fullflexible,
  captionpos=t,
  floatplacement=htbp,
  upquote=true
}
\lstset{style=thesis}
\renewcommand{\lstlistingname}{Listing}
\renewcommand{\lstlistlistingname}{List of Listings}

% Float lists inherit the selected thesis line spacing and preserve the same
% chapter-group spacing used by the table of contents. The report class writes
% these gaps for figures and tables; add matching gaps for algorithms and code.
\pretocmd{\@chapter}{%
  \addtocontents{loa}{\protect\addvspace{10\p@}}%
  \addtocontents{lol}{\protect\addvspace{10\p@}}%
}{}{}
\newcommand{\polyu@uniformlist}[2]{%
  \begingroup
    \polyu@applylinespacing
    \chapter*{#1}%
    \@mkboth{\MakeUppercase{#1}}{\MakeUppercase{#1}}%
    \@starttoc{#2}%
  \endgroup
}
\renewcommand{\listoffigures}{\polyu@uniformlist{\listfigurename}{lof}}
\renewcommand{\listoftables}{\polyu@uniformlist{\listtablename}{lot}}
\newcommand{\l@algorithm}{\@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand{\listofalgorithms}{\polyu@uniformlist{\listalgorithmname}{loa}}
\renewcommand{\lstlistoflistings}{\polyu@uniformlist{\lstlistlistingname}{lol}}

\newcommand{\thesisfrontchapter}[1]{%
  \clearpage
  \chapter*{#1}%
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}%
}

\newcommand{\thesisfrontmatter}{%
  \clearpage
  \pagenumbering{roman}%
  \setcounter{page}{1}%
}

\newcommand{\thesismainmatter}{%
  \clearpage
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
}

\newcommand{\makecoverpage}{%
  \clearpage
  \thispagestyle{empty}%
  \begin{center}
    \vspace*{18mm}
    {\Large\sffamily\bfseries\MakeUppercase{\thesistitle}\par}
    \vfill
    {\large\sffamily\bfseries\MakeUppercase{\studentname}\par}
    \vspace{18mm}
    {\large\degreeabbr\par}
    \vspace{18mm}
    {\large The Hong Kong Polytechnic University\par}
    \ifdualdegree
      \vspace{10mm}
      {\large This programme is jointly offered by The Hong Kong Polytechnic University and \partneruniversity\par}
    \fi
    \vfill
    {\large\awardyear\par}
    \ifinitialsubmission
      \vspace{18mm}
      {\large Initial Submission for Examination Purpose\par}
    \fi
    \vspace*{12mm}
  \end{center}
  \clearpage
}

% Library copyright notice placed before the thesis cover, following the
% ordering and wording used in accepted PolyU electronic theses.
\newcommand{\makecopyrightundertaking}{%
  \clearpage
  \thispagestyle{empty}%
  \begingroup
    \singlespacing
    \small
    \noindent\includegraphics[width=72mm]{assets/polyu-library-header.png}\par
    \vspace{10mm}
    \noindent\rule{\textwidth}{0.4pt}\par
    \vspace{5mm}
    \begin{center}
      {\large\bfseries Copyright Undertaking}
    \end{center}
    \vspace{10mm}
    This thesis is protected by copyright, with all rights reserved.\par
    \vspace{4mm}
    \textbf{By reading and using the thesis, the reader understands and agrees to the following terms:}
    \begin{enumerate}[leftmargin=8mm,itemsep=3mm,topsep=4mm]
      \item The reader will abide by the rules and legal ordinances governing copyright regarding the use of the thesis.
      \item The reader will use the thesis for the purpose of research or private study only and not for distribution or further reproduction or any other purpose.
      \item The reader agrees to indemnify and hold the University harmless from and against any loss, damage, cost, liability or expenses arising from copyright infringement or unauthorized usage.
    \end{enumerate}
    \vfill
    \noindent\fbox{%
      \begin{minipage}{\dimexpr\textwidth-2\fboxsep-2\fboxrule\relax}
        \centering\bfseries IMPORTANT\par
        \vspace{2mm}
        \raggedright\mdseries
        If you have reasons to believe that any materials in this thesis are deemed not suitable to be distributed in this form, or a copyright owner having difficulty with the material being included in our database, please contact \href{mailto:lbsys@polyu.edu.hk}{lbsys@polyu.edu.hk} providing details. The Library will look into your claim and consider taking remedial action upon receipt of the written requests.
      \end{minipage}%
    }
    \vfill
    \begin{center}
      \footnotesize
      Pao Yue-kong Library, The Hong Kong Polytechnic University, Hung Hom, Kowloon, Hong Kong\par
      \vspace{4mm}
      \url{http://www.lib.polyu.edu.hk}
    \end{center}
  \endgroup
  \clearpage
}

\newcommand{\makethesistitlepage}{%
  \thispagestyle{empty}%
  \begin{center}
    \vspace*{10mm}
    {\Large\sffamily\bfseries The Hong Kong Polytechnic University\par}
    \vspace{12mm}
    {\large\department\par}
    \ifdualdegree
      \vspace{6mm}
      {\large\partneruniversity\par}
      \vspace{3mm}
      {\large\partnerdepartment\par}
    \fi
    \vfill
    {\Large\sffamily\bfseries\thesistitle\par}
    \vfill
    {\large\studentname\par}
    \vfill
    {\large A thesis submitted in partial fulfilment of the requirements for the degree of \degree\par}
    \vfill
    {\large\initialsubmissionmonth\ \initialsubmissionyear\par}
    \vspace*{12mm}
  \end{center}
  \clearpage
}

\crefname{chapter}{Chapter}{Chapters}
\crefname{section}{Section}{Sections}
\crefname{figure}{Figure}{Figures}
\crefname{table}{Table}{Tables}
\crefname{equation}{Equation}{Equations}
\crefname{algorithm}{Algorithm}{Algorithms}
\crefname{theorem}{Theorem}{Theorems}
\crefname{lemma}{Lemma}{Lemmas}

\endinput
