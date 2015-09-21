require "spec"
require "webmock"
require "../src/brium"

Spec.before_each &->WebMock.reset
