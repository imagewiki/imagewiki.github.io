angular.module "imagewikiFrontend"
  .directive 'iwNavbar', ->

    NavbarController = ->
      nav = this
      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/navbar/navbar.html'
      controller: NavbarController
      controllerAs: 'nav'
      bindToController: true
