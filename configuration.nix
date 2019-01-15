{
  compiler = "ghc844";
  cryptol-verifier = {
    local = true;
  };
  macaw = {
    rev = "cc85cfe65713d300e612220e1fb0a9ee98d0e874";
    sha256 = "0cvp33dmkf2xg7g7ysamcqhy894i9zysch3z94arg2hbj0yqfh7l";
    # rev    = "b398db41b22808d55d16492d6a8d588d037e7389";
    # sha256 = "0g7mr8sjgii36laq8qpgwcgj8ckip545b87i4kb7l8njyssk0ffz";
  };
  saw-core-coq = {
    local = true; # because I am working on it
  };
}
