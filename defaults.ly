\version "2.25.18"

dyn=#(define-event-function (parser location arg) (markup?)
      (make-dynamic-script arg))

extendHairpinsAcrossTimeSignature =
#(lambda (context)
   (let ((hairpins '()))
    (define (extend-hairpin grob)
     (ly:grob-set-property! grob 'to-barline #f))
    (define (add-hairpin grob)
     (set! hairpins (cons grob hairpins)))
    (define (remove-hairpin grob)
     (set! hairpins (remove (lambda (x) (eq? x grob)) hairpins)))
    (make-engraver
     (listeners
      ((time-signature-event engraver event)
       (for-each extend-hairpin hairpins)
       (set! hairpins '())))
     (acknowledgers
      ((hairpin-interface engraver grob source)
       (add-hairpin grob)))
     (end-acknowledgers
      ((hairpin-interface engraver grob source)
       (remove-hairpin grob))))))

tuplet-three = \once \override TupletNumber.text =
#(tuplet-number::non-default-tuplet-denominator-text 3)

niente = \once \override Hairpin.circled-tip = ##t


%%% Spanner for technical instructions
%%%
%%% An instruction required for a specific duration takes a dotted line and end bracket (Gould, p. 493).
%%%
%%% Example:
%%% \instructionSpanner #"l.v."
%%% e8\startTextSpan a, b' e, a,\stopTextSpan

instructionSpanner =
#(define-music-function
     (parser location text)
     (markup?)
   #{
     \once \override TextSpanner.bound-details.left.text =
       \markup {
         \normal-text {
           #text
         }
         \hspace #0.5        
       }
     \once \override TextSpanner.bound-details.right.text =
       \markup { \draw-line #'(0 . -1) }
     \once \override TextSpanner.dash-fraction = 0.5
     \once \override TextSpanner.dash-period = 1
   #})


%%% 'X' Time Signature

senzaMisura = {
  \once\override Staff.TimeSignature.stencil = #ly:text-interface::print
  \once\override Staff.TimeSignature.text = \markup { \fontsize #2 \bold "X" }
  \once\override Staff.TimeSignature.extra-offset = #'(0 . -1)
}


%%% Hairpin minimum length
%% a helper:
#(define (look-up-for-parent name-symbol axis grob)
"Return the parent of @var{grob}, specified by it's @var{name-symbol} in
axis @var{axis} of @var{grob}.  If @var{grob} is already equal to the grob
named @var{name-symbol} return @var{grob}.  If not found, look up for the next
parent."
 (let* ((parent (ly:grob-parent grob axis)))
 (cond
   ((not (ly:grob? parent))
    (ly:error
       ("Perhaps typing error for \"~a\" or \"~a\" is not in the parent-tree.")
       name-symbol name-symbol))
   ((equal? name-symbol (grob::name grob)) grob)
   ((not (equal? name-symbol (grob::name parent)))
    (look-up-for-parent name-symbol axis parent))
   (else parent))))

#(define (my-hairpin-minimum-length grob)
"Sets @code{minimum-length} for @code{Hairpin}, if their left bound is not the
@code{NoteColumn}.
The visible length is actually the one, specified by an additional override for
@code{minimum-length} or the default.
If left bound is @code{NoteColumn}, default or specified @code{minimum-length}
will take over."
  (let* ((bound-left (ly:spanner-bound grob LEFT))
         (sys (look-up-for-parent 'System Y grob))
         (left-x-ext (ly:grob-extent bound-left sys X))
         (not-note-column?
           (lambda (g)
             (not (and (ly:grob? g)
                       (grob::has-interface g 'note-column-interface))))))
     (if (not-note-column? bound-left)
         (ly:grob-set-property! grob 'minimum-length
           (+
              (* (if (interval-sane? left-x-ext) (cdr left-x-ext) 1)
                 (ly:grob-property-data grob 'bound-padding))
              (ly:grob-property-data grob 'minimum-length)
              (if (interval-sane? left-x-ext) (cdr left-x-ext) 0))))))

%% `myHairpinMinimumLength' tries to warrant the visible length of a Hairpin
%% to be not less than the value of `minimum-length'
myHairpinMinimumLength =
  \override Hairpin.before-line-breaking = #my-hairpin-minimum-length

\layout {
  \context {
    \Voice
    \myHairpinMinimumLength
    %% default for 'minimum-length is #2
    %% try different values
    \override Hairpin.minimum-length = #2
  }
}
 

%%% No stems
stemOff = \hide Staff.Stem
stemOn  = \undo \stemOff


%%% Date
date = #(strftime "%d/%m/%Y" (localtime (current-time)))

\header {
  tagline = ##f
}

\layout {
  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
  \context {
    \Staff
    \accidentalStyle modern
    \consists \extendHairpinsAcrossTimeSignature
  }
}