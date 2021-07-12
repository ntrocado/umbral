\version "2.22.0"

\include "defaults.ly"

\header {
  title = "Umbral"
  subtitle = "Fantasma"
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

\score {
  \new Staff \with { instrumentName = #"Guitar" } {
    \clef treble
    \tempo "Freely"
    \stemOff
    \relative c' {
      \time 6/4
      <<
	{ f'4( ees) }
	\\
	{ <fis, a>2_"arpeggiate each chord 3-9 times, ad lib" }
      >>
      <<
	{ d'4( cis) }
	\\
	{ <fis, b>2 }
      >>
      <<
	{ <ais cis>2 }
	\\
	{ fis4( d) }
      >>
      \time 2/4
      <<
	{ f'2 }
	\\
	{ e,2 }
	\\
	{ a4( gis) }
      >>
      \time 6/4
      <fis cis' d>2 <fis cis' d g> <c cis' dis b'> |
      \time 4/4
      <d bes' des a'>2
      <d a' e' fis> |
      \time 4/4
      <<
	{ ges'4 a b2 }
	\\
	{ <aes, ees'>1 }
      >>
      \time 4/4
      <<
	{ f'4 d' cis2 }
	\\
	{ <aes, ees'>2 <aes d>2 }
      >>
      \time 2/4
      <e b' c>2
    }
  }
}

\markup { \bold Bass: improvise throughout \italic arco, harmonics, \italic {sul ponticello}, intense }

\layout {
  \context {
    \Score 
    \omit TimeSignature
  }
}
