familiarFaces.factory("Article", function($resource) {
  return $resource("/api/results/:id");
});
