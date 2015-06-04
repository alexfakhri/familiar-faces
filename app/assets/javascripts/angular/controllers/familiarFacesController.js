familiarFaces.controller("ArticlesCtrl", function($scope, Article) {
  Article.query(function(data) {
    $scope.articles = data;
  })
});
