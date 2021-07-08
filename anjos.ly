\version "2.22.0"

\include "defaults.ly"

\header {
  title = "Umbral"
  subtitle = "Anjos"
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

flute = \relative c'' {
  \tempo 8 = 150
  \clef treble
  \time 15/8
  aes4. ees'4 ges, a b2. |
  \time 13/8
  aes4. ees'4 f d des2 |
  \time 10/8
  e,4 c' b2. |
  \time 16/8
  ges4. a ees'4 f d b2 |
  \time 10/8
  bes4 d des2. |
  \time 12/8
  e4. f, a4 aes2 |
  \time 15/8
  ges4. des'4 e, g ees2. |
  \time 11/8
  des'4 ees c4. b2 |
  \time 12/8
  d,4 bes' des a2. |
  \time 11/8
  aes4 b bes4. g2 |
  \time 11/8
  fis4 a4. aes2. |
  \time 14/8
  g4. d'4 f, aes4. bes2 |
  \time 18/8
  g4 d' e cis4. c4. fis,2. |
  \time 8/8
  b4 bes d,2 |
  \time 20/8
  des4 a' b aes4. g e4 fis2. |
  \time 5/4
  d2 des2. |
  \time 4/4
  fis4 g f'2 |
}

guitar = \relative c'' {
  \clef treble
  \time 15/8
  b4. c4 d g, f2. |
  \time 13/8
  b4. c4 ges' aes ees2 |
  \time 10/8
  bes4 a f2. |
  \time 16/8
  d'4. g, c4 ges' aes f,2 |
  \time 10/8
  e'4 aes ees2. |
  \time 12/8
  bes4. ges g4 b2 |
  \time 15/8
  d4. ees4 bes, des c2. |
  \time 11/8
  ees'4 c a4. f2 |
  \time 12/8
  aes4 e' ees g,2. |
  \time 11/8
  b4 f e'4. des,2 |
  \time 11/8
  d'4 g,4. b2. |
  \time 14/8
  des,4. aes''4 ges, b4. e2 |
  \time 18/8
  des,4 aes'' bes, ees4. a,4. d2. |
  \time 8/8
  f,4 e' aes,2 |
  \time 20/8
  ees4 g f b4. des, bes4 d'2. |
  \time 5/4
  aes2 ees2. |
  \time 4/4
  d'4 des, ges'2 |
  \bar "|."
}

\score {
  <<
    \new Staff \with { instrumentName = #"I" }
    \flute

    \new Staff \with { instrumentName = #"II" }
    \guitar
  >>
}

\score {
  \new Staff \with { instrumentName = #"Bass" }
  {
    \clef bass
    \bar ".|:"
    \set Score.markFormatter = #format-mark-alphabet
    \mark \default
    c1\fermata
    \bar ":|."
    \stopStaff
    s1
    \startStaff
    \mark \default
    \bar ".|:"
    c4 g bes,
    \bar ":|."
  }
}

\markup \column {
  \line {
    \wordwrap {
      \bold {1.} Flute plays line I. Very slow, no pulse, freely. Optionally repeat groups of 2-4 consecutive notes. Other instruments add sparse very soft noises.
    }
  }
  \line { \null }
  \line {
    \wordwrap {
      \bold {2.} A tempo. Flute plays line I, guitar plays line II. Bass repeats phrase A and improvises. Drums match the bass attacks, fill with very soft noisy textures.
    }
  }
  \line { \null }
  \line {
    \wordwrap {
      \bold {3.} Flute plays line II, guitar plays line I, bass improvises around phrase B, drums play tempo, metrically against the bass.
    }
  }
  \line { \null }
  \line {
    \bold {4.} Everyone improvises.
  }
}

\layout {
  \context {
    \Score 
    \omit TimeSignature
  }
}
