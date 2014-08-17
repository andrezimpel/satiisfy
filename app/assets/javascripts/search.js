$(document).ready(function(){
  var projects = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
      url: 'http://satiisfy.dev/1/projects.json'
    }
  });

  var questions = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
      url: 'http://satiisfy.dev/1/questions.json'
    }
  });


  projects.initialize();
  questions.initialize();

  $('#globalsearchform').typeahead({
    highlight: true
  },
  {
    title: 'projects',
    displayKey: 'title',
    source: projects.ttAdapter(),
    templates: {
      empty: [
        '<div class="empty-message">',
        'unable to find any Best Picture winners that match the current query',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile('<a href="{{url}}">{{title}}</a>')
    }
  },
  {
    title: 'projects',
    displayKey: 'title',
    source: questions.ttAdapter(),
    templates: {
      empty: [
        '<div class="empty-message">',
        'unable to find any Best Picture winners that match the current query',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile('<a href="{{url}}">{{title}}</a>')
    }
  }).on('typeahead:selected', function(event, selection) {
    window.location.href = selection.url;
    $('#globalsearchform').typeahead('close');
  }).off('blur');

  $(document).click(function(event) {
    if ($(event.target).attr('class') !== 'tt-input') $('#globalsearchform').typeahead('close');
  });
});
