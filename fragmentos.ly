\version "2.22.0"

\include "defaults.ly"

proportionalWrapper =
#(define-music-function
     (music)
     (ly:music?)
   #{
     \newSpacingSection
     \set Score.proportionalNotationDuration = #(ly:make-moment 1/2)
     \override SpacingSpanner.uniform-stretching = ##t
     #music
     \set Score.proportionalNotationDuration = #(ly:make-moment 1/1)
   #})

barBreak = {
  \cadenzaOff
  \bar "|"
  \stopStaff
  \time 2/4
  s2
  \noBreak
  \startStaff
  \bar "|"
  \cadenzaOn
  s8
  \mark \default
}

loopStart = {
  \newSpacingSection
  \cadenzaOff
  \undo \omit Staff.TimeSignature
  \noBreak
  \bar "[|:"
}

loopStop = {
  \bar ":|]"
  \noBreak
  \omit Staff.TimeSignature
  \cadenzaOn
  s8
  \barBreak
}

markupStencil =
#(define-music-function
  (markup music)
  (markup? ly:music?)
  (define (proc grob)
   (let* ((sten (grob-interpret-markup grob markup))
          (xex (ly:stencil-extent sten X)))
    (ly:grob-set-property! grob 'minimum-X-extent xex)
    (ly:grob-set-property! grob 'stencil sten)))
  #{ \tweak before-line-breaking #proc #music #})

squiggle = \markup
  \override #'(height . 2)
  \draw-squiggle-line #1 #'(8 . 0) ##f

featheredBeams =
#(define-music-function
     (music)
     (ly:music?)
  #{
    \proportionalWrapper {
      \stemOn
      \override Beam.grow-direction = #RIGHT
      \featherDurations #(ly:make-moment 1/4)
      { #music }
      \override Beam.grow-direction = #'()
      \markupStencil \squiggle r4
      \barBreak
    }
  #})

aTrill = {
  \proportionalWrapper {
    \absolute { \pitchedTrill a'1\startTrillSpan bes' s2\stopTrillSpan }
  }
  \barBreak
}

aTrillBass = {
  \proportionalWrapper {
    \absolute { \pitchedTrill a1\startTrillSpan bes s2\stopTrillSpan }
  }
  \barBreak
}

flute = \markup \with-color #darkred "flute"
sono = \markup \with-color #darkblue "audio"
guitar = \markup \with-color #darkgreen "guitar"
bass = \markup \with-color #darkyellow "bass"
drum = \markup \with-color #darkmagenta "drums"

\header {
  title = "Umbral"
  subtitle = "Ninguém fica para trás"
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

\markup {
  \vspace #1
  \column {
    \line { Each phrase is to be played in order. }
    \line { You don't need to wait for the previous phrase to end before starting the next one. }
    \line { But you can also leave any amount of space between them. }
    \line { Vary dynamics, timbres and techniques – be radical. }
    \line { When a phrase is shared between more than one player, it can be started simultaneously or not.}
    \line { Notated rhythms can be played with a steady pulse or not. Phrases can be transposed by octaves. }
    \line {
      \score {
	{ \omit Staff.Clef \omit Staff.TimeSignature \bar "[|:" s4 \bar ":|]" }
	\layout { indent = #0 }
      }
      → Repeat as many times as you want, make progressive changes.
    }
    \vspace #0.5
    \line {
      \score {
	{ \omit Staff.Clef \omit Staff.TimeSignature \stopStaff \markupStencil \squiggle r4 }
	\layout { indent = #-1.5 }
      }
      → Improvise developing the preceding motif.
    }
    \vspace #1
  }
}

alto = \markup { alto }
bari = \markup { bari }

\score {
  
  \relative c' {
    \override Staff.Clef #'break-visibility = #all-invisible
    \override Staff.Clef.full-size-change = ##t
    \set Score.markFormatter = #format-mark-numbers
    \override Score.RehearsalMark.font-size = #1
    \omit Staff.TimeSignature
    \numericTimeSignature
    \cadenzaOn
    \stemOff

    %% 1
    \mark \default
    c''1_\flute
    \barBreak

    %% 2
    \proportionalWrapper {
      b,4(_\guitar c,1) |
    }
    \barBreak

    %% 3
    \proportionalWrapper {
      aes''_\flute \stemOn \acciaccatura d8 \stemOff aes4 s4
      \stemOn \acciaccatura d8 \stemOff aes1
    }
    \barBreak

    \proportionalWrapper {
      e,4_\guitar c' b1
    }
    \barBreak

    \proportionalWrapper {
      \clef bass
      c,1_\bass
    }
    \barBreak

    \proportionalWrapper {
      \clef treble
      d''4(_\flute aes1)
    }
    \barBreak

    \proportionalWrapper {
      \stemOn \grace { bes,16_\guitar d } \stemOff des,1
    }
    \barBreak

    % 8
    \proportionalWrapper {
      s2_\sono s2
    }
    \barBreak

    \proportionalWrapper {
      \clef bass
      aes1_\bass 
    }
    \barBreak

    \proportionalWrapper {
      \clef treble
      aes''1_\flute \stemOn \acciaccatura d8 \stemOff ees,4 \stemOn \acciaccatura d'8 \stemOff des,1
    }
    \barBreak

    % 11
    \proportionalWrapper {
      s2_\sono s2
    }
    \barBreak

    % 12
    \proportionalWrapper {
      d4(_\guitar des,1)
    }
    \barBreak

    % 13
    \proportionalWrapper {
      \clef bass
      ees4_\bass f d1
    }
    \barBreak

    % 14
    \proportionalWrapper {
      \clef treble
      des'4_\guitar ees f1
    }
    \barBreak

    \proportionalWrapper {
      aes,4_\flute ees'4 f d1
    }
    \barBreak

    s8_\guitar \aTrill

    \loopStart
    \clef bass
    \time 2/4
    \stemOn
    bes,,4~_\bass_\drum bes8. g'16 |
    \stemOff
    \loopStop
    \cadenzaOn

    \proportionalWrapper {
      \clef treble
      aes''4_\flute_\guitar ees' ges, a b1 e,4 cis
      \markupStencil \squiggle r4
    }
    \barBreak

    \proportionalWrapper {
      s2_\sono s2
    }
    \barBreak

    \loopStart
    \cadenzaOn
    \stemOn \acciaccatura d'8_\flute \stemOff aes4 des,
    \loopStop

    \featheredBeams { b32[_\guitar \hide NoteHead \repeat unfold 6 { b } \undo \hide NoteHead b] }

    \loopStart
    \cadenzaOn
    \clef bass
    \stemOn \acciaccatura d,8_\bass \stemOff aes4
    \loopStop

    %% 23
    \clef percussion
    \featheredBeams { d32[_\drum \hide NoteHead \repeat unfold 6 { d } \undo \hide NoteHead d] }

    \loopStart
    \clef treble
    \cadenzaOn
    \stemOn \acciaccatura ees'8_\guitar \stemOff f4
    \loopStop

    \clef treble
    s8_\flute \aTrill
    
    \loopStart
    \stemOn
    \clef bass
    \time 4/4
    gis,,4_\guitar_\bass b d2
    \time 3/8
    a4 bes8
    \loopStop
    
    %% 27
    \proportionalWrapper {
      \clef treble
      \stemOff
      ees'1_\flute_\drum f d4( cis1) e4 c'( b1) \markupStencil \squiggle r4
    }
    \barBreak

    %% 28
    \proportionalWrapper {
      s2_\sono s2
    }
    \barBreak

    %% 29
    \proportionalWrapper {
      ges,4_\guitar a aes1 \markupStencil \squiggle r4
    }
    \barBreak

    %% 30
    \proportionalWrapper {
      \clef treble
      cis,4_\flute_\bass a'( b gis1) g1 e4_( fis a1) b4 bes( d,1)
    }
    \barBreak

    %% 31
    \proportionalWrapper {
      s2_\sono s2
    }
    \barBreak

    %% 32
    \clef bass
    \featheredBeams { ees,32[_\bass \hide NoteHead \repeat unfold 6 { ees } \undo \hide NoteHead ees] }

    %% 33
    \clef treble
    s8_\guitar \aTrill

    %% 34
    \loopStart
    \time 5/8
    \stemOn
    \clef bass
    aes4.~_\bass_\drum aes8 d8 
    \loopStop

    %% 35
    \loopStart
    \clef treble
    \time 4/4
    gis4_\flute b d2
    \time 3/8
    \noBreak
    \time 3/8
    a4 bes8 |
    \loopStop

    %% 36
    \featheredBeams { f'32[_\guitar \hide NoteHead \repeat unfold 6 { f } \undo \hide NoteHead f] }

    %% 37
    \proportionalWrapper {
      s2_\sono s2
    }
    \barBreak

    %% 38
    \proportionalWrapper {
      \stemOff
      aes4_\flute ees f d1 \markupStencil \squiggle r4
    }
    \barBreak

    %% 39
    \proportionalWrapper {
      \clef bass
      des,1_\guitar_\bass_\drum e4 c
      \stemOn \acciaccatura g'8 \stemOff b,1 fis1
      \stemOn \acciaccatura g'8 \stemOff a,1 ees'4 f d1
    }
    \barBreak

    %% 40
    \proportionalWrapper {
      \clef percussion
      \stemOn \acciaccatura f8_\drum \stemOff d1 \markupStencil \squiggle r4
    }
    \barBreak

    \clef bass
    s8_\bass \aTrillBass

    \clef treble
    \loopStart
    \time 4/4
    \stemOn
    \newSpacingSection
    d''16_\flute
    \once \override Score.NoteColumn.X-offset = #1
    aes, r8 r4 cis'2
    \stemOff
    \loopStop

    \proportionalWrapper {
      aes,4_\guitar b
      \stemOn \acciaccatura c'8 \stemOff bes4 g
      \stemOn \acciaccatura c8 \stemOff ges4 bes,
      \markupStencil \squiggle r4
    }
    \barBreak

    %% 44
    \proportionalWrapper {
      s2_\sono s2
    }
    \barBreak

    %% 45
    \proportionalWrapper {
      e4_\flute c' b1
    }
    \barBreak

    %% 46
    \proportionalWrapper {
      \clef bass
      d,,4_\bass aes1
    }
    \barBreak

    %% 47
    \proportionalWrapper {
      \clef percussion
      d1:32_\drum
    }
    \barBreak

    %% 48
    \proportionalWrapper {
      \clef bass
      c1_\bass
    }
    \barBreak

    %% 49
    \proportionalWrapper {
      \clef treble
      c'4_\flute b,1
    }
    \barBreak

    %% final bar
    des1_\flute_\guitar_\bass_\drum
    \bar "|."
    
  }

  \layout {
    indent = #10
    ragged-right = ##t
    \context {
      \Score
      \omit BarNumber
    }
  }
}