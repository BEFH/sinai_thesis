\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sinai}[2017/03/27 ISMMS Dissertation Style]

\LoadClass[oneside, 12pt]{book}

\RequirePackage[doublespacing]{setspace}
\setlength{\parskip}{2mm}

\RequirePackage{listings,enumerate}

%symbols
\RequirePackage{xfrac,gensymb,amsmath}
\RequirePackage[super]{nth}

%Figures and tables
\RequirePackage{graphicx,booktabs,tabularx,float,subcaption,rotating,adjustbox}

\RequirePackage[letterpaper, margin = 1in]{geometry}

%Set up links
\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true,
    linkcolor=black,
    citecolor=black,
    filecolor=black,
    urlcolor=black
  }

%Bibliography Stuff
\RequirePackage[authordate-trad,backend=biber,doi=false,isbn=false,	]{biblatex-chicago}

\DeclareCiteCommand{\cite}[\mkbibparens]
  {\usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
   \printtext[bibhyperref]{\usebibmacro{cite}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\DeclareCiteCommand*{\cite}[\mkbibparens]
  {\usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
   \printtext[bibhyperref]{\usebibmacro{citeyear}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\RequirePackage{array,caption,subfiles,breakcites}

\@ifundefined{Umathchardef}{
\RequirePackage{times}
}{
%\RequirePackage[utf8]{inputenc}
\RequirePackage{fontspec}
\IfFontExistsTF{Adobe Garamond Pro}{\setmainfont[Ligatures=TeX,Scale=1]{Adobe Garamond Pro}}{\RequirePackage{libertine}}

}


\captionsetup{labelfont=bf}
\RequirePackage[toc,page]{appendix}


%Make TOC show paragraph Titles
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{5}
\RequirePackage[nottoc]{tocbibind}

\newcommand*{\program}[1]{\gdef\program{#1}}

%Allow headingless chapters
\makeatletter
\newcommand{\unchapter}[1]{% 
\begingroup 
\let\@makechapterhead\@gobble
\chapter{#1}
\endgroup 
}
\makeatother

%Title Page
\RequirePackage{titling,xstring}
\newcommand{\toptext}{\IfBeginWith{\program}{M}{Masters Thesis}{Doctoral Dissertation}}

\newcommand{\nowrap}[2]{\resizebox{\ifdim\width>\linewidth\linewidth\else\width\fi}{!}{\begin{tabular}{#1}#2\end{tabular}}}

\newcommand{\blurb}{\nowrap{c}{\IfBeginWith{\program}{M}{A Master’s Thesis submitted in partial fulfillment of the requirements for the \IfStrEq{\program}{MPH}{\\Master Of Public Health Degree at}{MS degree in\\ \IfStrEqCase{\program}{{MSBS}{Biomedical Sciences }{MSCR}{Clinical Research }{MSGC}{Genetic Counseling }} at} the Graduate School of Biomedical Sciences,\\Icahn School of Medicine at Mount Sinai\\}{A dissertation submitted to the Graduate Faculty of the Graduate School of Biomedical Sciences\\ \IfStrEq{\program}{NEU}{Neuroscience}{Biological Sciences} Doctoral Program, in partial fulfillment of the requirements for the degree of \\ Doctor of Philosophy, Icahn School of Medicine at Mount Sinai\\}}}

%Titling params
\setlength{\droptitle}{-3cm}
\pretitle{\begin{center}\scshape\Large{\toptext}\\
	\huge\bfseries\vspace{1cm}}
\posttitle{\end{center}\vspace{1cm}}
\preauthor{\begin{center}\Large\textit}
\postauthor{\end{center}}
\predate{\vfill\begin{center}\blurb\\
\vspace{1.5cm}\Large}
\postdate{\end{center}}

%Copyright

\newcommand{\makecopyright}[1]{\gdef\@\makecopyright{#1}%
\unchapter{Copyright}
\thispagestyle{plain}

\begin{center}

\vspace*{1in}

\rule{\textwidth}{0.4pt}

\textbf{\thedate}\\
\textbf{\theauthor}\\
\textbf{All Rights Reserved}\\

\rule{\textwidth}{0.4pt}

\end{center}
}

%Approvals

\RequirePackage{etoolbox}

\newcommand\dean[1]{\def\dean{#1}}
\newcommand\advisor[1]{\def\advisor{#1}}
\newcommand\reviewers[1]{\def\reviewers{#1}}

\newcommand{\makesigline}[1]{%
\hrulefill & \hrulefill \\[-10pt]
    #1 & Date \\ [10pt]}
    
\DeclareListParser*\forsemicolonlist{;}
\newcommand\handler[1]{%
\makesigline{Dissertation Advisor - #1}}
\newcommand\secondhandler[1]{\textbf{#1}\\}

\newcommand{\makeapprovals}[1]{\gdef\@\makeapprovals{#1}%
\unchapter{Approvals}
\thispagestyle{plain}

\vspace*{1in}

\noindent\IfBeginWith{\program}{M}{This manuscript has been read and accepted by the Graduate Faculty of the Mount Sinai Graduate School of Biomedical Sciences, in satisfaction of the thesis requirement for the \IfStrEq{\program}{MPH}{Master of Public Health}{Master's} degree.}{This manuscript has been read and accepted by the Graduate Faculty of the Graduate School of Biomedical Sciences, in satisfaction of the dissertation requirement for the degree of Doctor of Philosophy.}\\

\begin{center}
\begin{minipage}{0.9\textwidth}	

\begin{tabular}{p{4in}p{1.5in}}
    \expandafter\forsemicolonlist\expandafter\handler\expandafter{\advisor}
    \makesigline{Dean - \dean} 
\end{tabular}
\vskip 0.25in
  \begin{tabular}{p{2.5in}}
\expandafter\forsemicolonlist\expandafter\secondhandler\expandafter{\reviewers}
\end{tabular}
\vskip 0.5in
\begin{center}
\includegraphics[width=0.5\textwidth]{graphics/MS_Icahn_GSBS_CMYK.eps}
\end{center}
\end{minipage}
\end{center}
}

%Abstract Page
\newcommand\secondary{}
\newcommand{\secondaryadvisor}[1]{\renewcommand\secondary{#1}}
\newcommand{\advisorlist}{\advisor\ifdefempty{\secondary}{}{; \secondary}}

\newenvironment{abstract}{%
\unchapter{Abstract}
\thispagestyle{plain}
\begin{center}
\textbf{\thetitle}\\
\textit{by}\\
\theauthor\\
\end{center}
\textit{\IfSubStr{\advisorlist}{;}{Advisors:}{Advisor:}} \StrSubstitute{\advisorlist}{;}{ and}
\par
\vspace{5mm}
   }{\pagebreak}
   
\newenvironment{thank}{%
\chapter{Acknowledgments}
\parindent=0pt
\parskip=20pt
	}{\pagebreak}
	

\endinput
