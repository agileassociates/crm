var app = angular.module('customers',['ngRoute', 'templates']);

app.config([
            "$routeProvider", function($routeProvider) {

                $routeProvider.when("/", {
                    controller: "CustomerSearchController",
                    templateUrl: "customer_search.html"
                }).when("/:id", {
                    controller: "CustomerDetailController",
                    templateUrl: "customer_detail.html"
                });
            }
            ]);

app.controller("CustomerSearchController", [
    '$scope', '$http', '$location',
    function($scope, $http, $location) {

        var page = 0;

        $scope.search = function(searchTerm)
        {
            if (searchTerm.length < 3) {
                return;
            }

            $http.get("/customer/index.json", { "params": { "keywords" : searchTerm, "page" : page}}).then(
                function(response) {$scope.customers = response.data;
                }, function(response) { alert("Error: " + response.status);}
            );

        }

        $scope.previousPage = function() {
            if (page > 0) {
                page = page -1;
                $scope.search($scope.keywords);
            }
        }

        $scope.nextPage = function() {
            page = page + 1;
            $scope.search($scope.keywords);
        }

        $scope.viewDetails = function(customer) {
            $location.path("/" + customer.id);
        }
    }
]);

app.controller("CustomerDetailController", [
            "$scope", "$http", "$routeParams",
    function($scope, $http, $routeParams) {
        var customerId = $routeParams.id;
        $scope.customer = {};

        $http.get(
            "/customer/" + customerId + ".json"
        ).then(function(response) {
                $scope.customer = response.data;
            },function(response) {
                alert("There was a problem: " + response.status);
            }
        );
    }
]);

