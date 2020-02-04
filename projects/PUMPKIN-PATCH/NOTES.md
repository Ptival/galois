# What we looked at so far

In order to update proofs in the face of changes, there are a number of smaller
problems that it would be nice having solutions for:

- when some representation changes to an isomorphic representation, one could
  hope that programs and proofs written over the old representation can be
  transported to the new representation,

- when some representation changes to a larger representation (i.e. has at least
  all of the same information, but also more), one could also hope to transport
  some programs and proofs, in particular, those programs that only consume data
  of such representation,

- when code gets updated
