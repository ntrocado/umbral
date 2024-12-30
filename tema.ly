\version "2.24.1"

\include "defaults.ly"

\score {
  \new Staff  {
    \relative c'' {
      \omit Score.TimeSignature
      \clef treble
      \cadenzaOn
      aes4 ees' ges,1\fermata \bar "|"
      aes!4 ees'! ges,!8[ a] b1\fermata \bar "|"
      b8[ bes aes ees'! f] d1\fermata \bar "|"
      b8[ bes aes! ees'! f] d4 des1\fermata \bar "|."
    }
    \addlyrics {
      An -- da mão
      Fi -- a de -- _ do
      Ma -- dru -- ga e ve -- rás
      Tra -- ba -- lha e te -- rás __ _
    }
  }
}