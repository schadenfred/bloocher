# For more information see: http://emberjs.com/guides/routing/

Bloocher.ShowcasesRoute = Ember.Route.extend(model: ->
  Bloocher.Showcase.find()
)