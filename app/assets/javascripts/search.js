$(document).ready(function(){
  var projects = new Bloodhound({
    datumTokenizer: function(data){
      x = Bloodhound.tokenizers.whitespace(data.title);
      y = Bloodhound.tokenizers.whitespace(data.description);
      z = Bloodhound.tokenizers.whitespace(data.subdomain);
      return x.concat(y).concat(z);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
      url: 'http://satiisfy.dev/1/search.json?class=project',
      filter: function(list) {
        return $.map($(list)[0].array, function(result) {
          return result;
        });
      }
    }
  });

  var questions = new Bloodhound({
    datumTokenizer: function(data){
      x = Bloodhound.tokenizers.whitespace(data.title);
      y = Bloodhound.tokenizers.whitespace(data.answer);
      return x.concat(y);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
      url: 'http://satiisfy.dev/1/search.json?class=question',
      filter: function(list) {
        return $.map($(list)[0].array, function(result) {
          return result;
        });
      }
    }
  });

  var users = new Bloodhound({
    datumTokenizer: function(data){
      a = Bloodhound.tokenizers.whitespace(data.firstname);
      b = Bloodhound.tokenizers.whitespace(data.lastname);
      c = Bloodhound.tokenizers.whitespace(data.email);
      d = Bloodhound.tokenizers.whitespace(data.position);
      e = Bloodhound.tokenizers.whitespace(data.fullname);
      return a.concat(b).concat(c).concat(d).concat(e);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
      url: 'http://satiisfy.dev/1/search.json?class=user',
      filter: function(list) {
        return $.map($(list)[0].array, function(result) {
          return result;
        });
      }
    }
  });


  projects.initialize();
  questions.initialize();
  users.initialize();

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
        'No results found.',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile([
        '<a href="{{url}}" class="tt-project">',
        '{{title}}',
        '</a>'
      ].join('\n')),
      header: '<div class="tt-header">Projects</div>'
    }
  },
  {
    title: 'questions',
    displayKey: 'title',
    source: questions.ttAdapter(),
    templates: {
      empty: [
        '<div class="empty-message">',
        'No results found.',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile([
        '<div class="tt-question">',
        '{{title}}',
        '</div>'
      ].join('\n')),
      header: '<div class="tt-header">Questions</div>'
    }
  },
  {
    title: 'users',
    displayKey: 'fullname',
    source: users.ttAdapter(),
    templates: {
      empty: [
        '<div class="empty-message">',
        'No results found.',
        '</div>'
      ].join('\n'),
      suggestions: Handlebars.compile('<span class="tt-suggestions clearfix"></span>'),
      suggestion: Handlebars.compile([
        '<div class="users-grid-item">',
          '<a class="pull-left">',
            '<img class="media-object avatar" src="{{avatar}}" alt="{{fullname}}" title="{{fullname}}" width="75">',
            '{{#if active}}',
              '<span class="label label-info">active</span>',
            '{{else}}',
              '<span class="label label-default">invited</span>',
            '{{/if}}',
          '</a>',
          '<div class="media-body">',
            '{{fullname}}',
          '</div>',
        '</div>'
      ].join('\n')),
      header: '<div class="tt-header">Team</div>'
    }
  }).on('typeahead:selected', function(event, selection) {
    window.location.href = selection.url;
    $('#globalsearchform').typeahead('close');
  }).on('typeahead:opened', function(event, selection) {
    // fade content
    $("#page").addClass("faded");
  }).on('typeahead:closed', function(event, selection) {
      // unfade content
      $("#page").removeClass("faded");
  }).off('blur');




  $(document).click(function(event) {
    if (!$(event.target).hasClass('tt-input')) $('#globalsearchform').typeahead('close');
  });
});
