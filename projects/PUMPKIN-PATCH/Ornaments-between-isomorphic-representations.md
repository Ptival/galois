# Ornaments between isomorphic representations

One technique we have tested in the interest of proof repair is to transport
programs and proofs across ornaments between isomorphic types.

For instance, this is how it works between a record type `R` with some fields,
and a tuple type `T` with the same fields, in the same order.  PUMPKIN-PATCH's
`Find ornament` command supports this simple scenario, and automatically derives
the following functions/lemmas:

* `curry`, which turns a `R` into a `T` by repeatedly currying the record
  constructor.  This currently requires the tuple type `T` to have the fields in
  the exact same order as the record declaration for `R`.  Hopefully, in the
  lack of ambiguity, this process can be automated for more complex cases,

* `curry_inv`, which turns a `T` back into a `R`,

* `curry_section`, a proof that `curry_inv . curry` is an identity,

* `curry_retraction`, a proof that `curry . curry_inv` is an identity,

* `curry_retraction_adjoint`, which in this simple case, is the same as
  `curry_retraction`,

* and finally, `curry_adjunction`, is a proof of equality between two
  equalities, that is out of scope for this discussion.

Once we have the ornament relating `R` with `T`, we can start lifting functions
across the ornament.  For instance, we can define accessor functions for each
field of `R`, and automatically obtain the complex accessor in `T`, which needs
to go down the tuple to the correct location.

`[minimal_records.v]` contains such code derivation, where `lifted_firstBool` is
computed from the record accessor `firstBool`.

Going one step further, once all the functions and accessors used in a theorem
statement have been lifted, the whole proof can be lifted.  File
`[minimal_records.v]` contains such an example: the theorem
`handwritten_and_spec_true_true` is written and proved in terms of
`handwritten_input`, while the theorem obtained by lifting is in terms of the
lifted input.

# Caveats

* The lifting process requires the types to have induction schemes.  When we
  define a record using `Record` in Coq, the induction scheme is not
  automatically generated.  This can be fixed by either:

    - changing the definition to use the keyword `Inductive` instead (with no
      other modification needed),

    - by invoking the Coq command `Scheme Induction` after the fact, to
      automatically generate it,

    - by manually writing it.

  I believe those are needed so as to pre-process functions defined via
  fixpoints or pattern-matching, using the `Preprocess` command, so as to turn
  them into calls to the appropriate primitive recursor instead.
