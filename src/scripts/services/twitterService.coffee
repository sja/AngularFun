###global define###

define ['libs/angular', 'services/services', 'services/messageService', 'libs/angularResource'], (angular, services) ->
	'use strict'

	services.factory 'twitterService', ['$log', '$resource', 'messageService', ($log, $resource, messageService) ->
		activity = $resource 'http://search.twitter.com/search.json',
			callback: 'JSON_CALLBACK',
				get:
					method: 'JSONP'

		get = (criteria, success, failure) ->
			activity.get q: criteria
			, (tweets, getResponseHeaders) ->
				messageService.publish 'search', source: 'Twitter', criteria: criteria
				success(tweets.results) if angular.isFunction success
			, failure

		{get}
	]