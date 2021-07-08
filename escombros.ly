\version "2.22.0"

\include "defaults.ly"

\header {
  title = "Umbral"
  subtitle = "Escombros"
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

sax = \relative c'' {
  f2~ f8 bes ges beses ces4~ |
  ces2. r2 c4 |
  d b8 bes8~ bes4~ bes r4 e,4. |
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

bass = \relative c {
  \clef bass
  aes2~ aes8 d~ d2 |
  des2~ des8 bes~ bes2 aes4 |
  d2~ d8 des~ des2 bes4. |
}

drum-five = \drummode {
  << {
    cymr8 sn cymr4 ss cymr ss
  } \\ {
    bd4 r4 r8 hhp r2
  } >>
}

drumset = {
  \bar ".|:"
  \tempo 4 = 180
  \time 5/4
  \drum-five
  \compoundMeter #'((5 4) (1 4))
  \drum-five
  \noBreak
  \bar "!"
  \drummode { cymr4 }
  \compoundMeter #'((5 4) (3 8))
  \drum-five
  \bar "!"
  \drummode {
    << {
      <<cymr8 tommh>> sn cymr
    } \\ {
      r4 bd8
    } >>
  }
  \bar ":|."
}

\score {
  <<
    \new Staff \with {
      instrumentName = \markup { Alto sax E\hspace #-.4 \flat }
    }
    {
      \transpose ees c { \sax }
    }
    \new Staff \with {
      instrumentName = #"Guitar"
    }
    {
      \guitar
    }
    \new Staff \with {
      instrumentName = #"Bass"
    }
    {
      \bass
    }
    \new DrumStaff \with {
      instrumentName = #"Drums"
    }
    {
      \drumset
    }
  >>
  \midi { }
  \layout {
    ragged-last = ##t
  }
}