require! './': asianbreak

# `it` is reserved in livescript
It = global.it

describe 'Basic Usage' ->
	describe 'Single text' ->
		It 'should have test' ->
			...
