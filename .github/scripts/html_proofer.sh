#!/bin/bash

bundle exec htmlproofer \
  --assume-extension \
  --allow-hash-href \
  --internal-domains /emmasax4.com/ \
  --url_ignore /linkedin/,/getitwriteonline/,/sopalodges/,/maasaimara/,/codepen.io/ \
  _site

# https://www.sopalodges.com/lake-naivasha-sopa-resort/the-resort
# https://getitwriteonline.com/articles/en-dashes-em-dashes/
# https://www.linkedin.com/in/emmasax4
# https://www.maasaimara.com/entries/fig-tree-camp
# https://codepen.io/Paulie-D/pen/zvkpJ/
