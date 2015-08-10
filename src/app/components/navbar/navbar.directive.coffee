angular.module "imagewikiFrontend"
  .directive 'iwNavbar', ->
    directive =
      restrict: 'E'
      templateUrl: 'app/components/navbar/navbar.html'
