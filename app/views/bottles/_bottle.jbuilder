# frozen_string_literal: true

json.id bottle.id
json.name bottle.name
json.counter bottle.counter
json.wine_cellar do
  json.id bottle.wine_cellar.id
  json.name bottle.wine_cellar.name
end
