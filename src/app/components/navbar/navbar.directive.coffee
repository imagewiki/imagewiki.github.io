angular.module "imagewikiFrontend"
  .directive 'iwNavbar', ->

    NavbarController = ($state) ->
      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/navbar/navbar.html'
      controller: NavbarController
      controllerAs: 'nav'
      bindToController: true
