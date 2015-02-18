class Brium::Keyword
  json_mapping({
    keyword: String,
    budget: Int32,
    start: {type: Time, converter: TimeFormat::ISO_8601_DATE},
    end: {type: Time, converter: TimeFormat::ISO_8601_DATE, nilable: true},
    actual: Int32,
    expected_end: {type: Time, converter: TimeFormat::ISO_8601_DATE, nilable: true},
    billable: Bool,
  })
end

