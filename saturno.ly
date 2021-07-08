\version "2.22.0"

\include "defaults.ly"

\header {
  title = "Umbral"
  subtitle = "Saturno"
  composer = \markup {
    \right-column {
      \line { \smallCaps "Nuno Trocado" }
      \line { \date }
    }
  }
}

\paper {
  top-margin = 15
  bottom-margin = 15
  left-margin = 15
  right-margin = 15
}

line = \relative c'' {
  \bar ".|:"
  \time 4/4
  aes16 ees' ges, a
  b aes ees' f
  d cis e c
  \tag #'eb { b? ges? } \tag #'concert { b fis }
  a ees' |
  \time 5/16
  f[ d b bes e] |
  \bar ":|."
} 

hocI = \relative c'' {
  \time 4/4
  aes2 r4 r8 a8~ |
  \time 5/16
  a8. bes8 |
}

hocII = \relative c'' {
  \time 4/4
  aes8 ges~ ges16 aes8 f'16~ f8 e16 c b4~ |
  \time 5/16
  b8. bes16[ e] |
}

hocIII = \relative c'' {
  \time 4/4
  aes16 ees'8 a,16~ a4 d16 cis8.~ cis16 fis,8. |
  \time 5/16
  f'8.~ f8 |
}

hocIV = \relative c'' {
  \time 4/4
  aes4 b r r8 a~ |
  \time 5/16
  a8. bes8 |
}

hocV = \relative c'' {
  \time 4/4
  aes4. ees'8~ ees4~ ees8. ees16~ |
  \time 5/16
  ees16[ d b~] b8 |
}

guitar = \relative c'' {
  \repeat unfold 2 <b e g>4 r4 r8
  <c e fis>4 <c e fis>8~ |
  <c e fis>8 r8 r4
  \repeat unfold 2 <c ees b'>4 r4
  r8 <aes f' b>8~ |
  <aes f' b>8 <aes f' b>4 r8 r4
  \repeat unfold 2 <c e fis>4 r4.
}

bassI = \relative c {
  \clef bass
  \time 4/4
  aes2 r4 r8 a8~ |
  \time 5/16
  a8. bes8
}

bassII = \relative c {
  \clef bass
  \time 4/4
  aes4 b d4. a8 |
  \time 5/16
  r8. bes8 |
}

bassIII = \relative c' {
  \clef bass
  \time 4/4
  aes8 ges r8. f16~ f des8. b8 a |
  \time 5/16
  f'8.~ f8 |
}

bassIV = \relative c {
  \clef bass
  \time 4/4
  aes8. a16~ a8 ees'8~ ees16 des8. b8. ees16~ |
  \time 5/16
  ees8[ b16~] b16[ e] |
}

\score { <<
  \new StaffGroup <<
    \new Staff \with {
      instrumentName = \markup { Alto E\hspace #-.4 \flat \bold I }
    }
    {
      \transpose ees c { \keepWithTag #'eb \line }
    }
    \new Staff \with {
      instrumentName = \markup { Alto E\hspace #-.4 \flat \bold II }
    }
    {
      \transpose ees c { \hocI }
    }
    \new Staff \with {
      instrumentName = \markup { Alto E\hspace #-.4 \flat \bold III }
    }
    {
      \transpose ees c { \hocII }
    }
    \new Staff \with {
      instrumentName = \markup { Alto E\hspace #-.4 \flat \bold IV }
    }
    {
      \transpose ees c { \hocIII }
    }
    \new Staff \with {
      instrumentName = \markup { Alto E\hspace #-.4 \flat \bold V }
    }
    {
      \transpose ees c { \hocIV }
    }
    \new Staff \with {
      instrumentName = \markup { Alto E\hspace #-.4 \flat \bold VI }
    }
    {
      \transpose ees c { \hocV }
    }
  >>
  
  \new StaffGroup <<
    \new Staff \with {
      instrumentName = #"Guitar I"
    }
    {
      \keepWithTag #'concert \line
    }
    \new Staff \with {
      instrumentName = #"Guitar II"
    }
    {
      \hocI
    }
    \new Staff \with {
      instrumentName = #"Guitar III"
    }
    {
      \hocII
    }
    \new Staff \with {
      instrumentName = #"Guitar IV"
    }
    {
      \hocIII
    }
    \new Staff \with {
      instrumentName = #"Guitar V"
    }
    {
      \hocIV
    }
    \new Staff \with {
      instrumentName = #"Guitar VI"
    }
    {
      \hocV
    }
  >>
  
  \new StaffGroup <<
    \new Staff \with {
      instrumentName = #"Bs + Dr I"
    }
    {
      \bassI
    }
    \new Staff \with {
      instrumentName = #"Bs + Dr II"
    }
    {
      \bassII
    }
    \new Staff \with {
      instrumentName = #"Bs + Dr III"
    }
    {
      \bassIII
    }
    \new Staff \with {
      instrumentName = #"Bs + Dr IV"
    }
    {
      \bassIV
    }
  >>
>>

	 \midi { }
	 
	 \layout {
	 indent = 2.3\cm  
    ragged-last = ##f}
}