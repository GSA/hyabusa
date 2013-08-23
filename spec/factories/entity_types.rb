# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entity_type_usc, class: EntityType do
    name 'U.S. Citizen'
    description ''
    supertype 'Individual'
  end

  factory :entity_type_student, class: EntityType do
    name 'Student/Researcher'
    description ''
    supertype 'Individual'
  end

  factory :entity_type_corp_domestic, class: EntityType do
    name 'Domestic Corporation'
    description 'A corporation, partnership or other sort of association created under the laws of the United States or any U.S. State'
    supertype 'Corporation'
  end

  factory :entity_type_us_corp_foreign, class: EntityType do
    name 'US-Owned Foreign Entity'
    description 'A foreign corporation, partnership, or other association, more than 95% of which is owned by a U.S. citizen, corporation, partnership, or other association.'
    supertype 'Corporation'
  end

  factory :entity_type_corp_foreign, class: EntityType do
    name 'Foreign Entity'
    description 'Foreign Company'
    supertype 'Corporation'
  end

  factory :entity_type_other, class: EntityType do
    name 'Other'
    description 'None of the above'
    supertype nil
  end
end
