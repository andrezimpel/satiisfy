$(document).ready(function(){
  var products = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
    // url points to a json file that contains an array of country titles, see
    // https://github.com/twitter/typeahead.js/blob/gh-pages/data/countries.json
    url: 'http://satiisfy.dev/1/projects.json',
    // the json file contains an array of strings, but the Bloodhound
    // suggestion engine expects JavaScript objects so this converts all of
    // those strings
    // filter: function(list) {
    //   return $.map(list, function(country) { return { title: country }; });
    // }
  }


  });


  products.initialize();

  $('#globalsearchform').typeahead({
    highlight: true
  },
  {
    title: 'products',
    displayKey: 'title',
    source: products.ttAdapter(),
    templates: {
      empty: [
        '<div class="empty-message">',
        'unable to find any Best Picture winners that match the current query',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile('<div class="tt-suggestion"><a href="{{url}}">{{title}}</a></div>')
    },
    css: {
      input: {
        position: "relative",
        verticalAlign: "none",
        backgroundColor: "transparent"
      }
    }
  }).on('typeahead:selected', function(event, selection) {
    window.location.href = selection.url;
    $('#globalsearchform').typeahead('close');
  }).off('blur');

  $(document).click(function(event) {
    if ($(event.target).attr('class') !== 'tt-input') $('#globalsearchform').typeahead('close');
  });
});
