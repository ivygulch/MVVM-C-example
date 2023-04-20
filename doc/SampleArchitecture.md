# Some architecture ideas

## Example demo app

- Simple coordinator, uni-directional architecture using MVVM-C patterns
- No real data sources, API, etc, in demo (if that is of interest, I can add a couple of simple ideas)

### Service roles
- Data sources/APIs
- User defaults
- Could contain publishers, notifications, whatever method makes sense

### Coordinator roles
- Coordinators all the way down :-)
- Traffic/navigation routing
- Wire together data sources and UI
- features are controlled by coordinators
- coordinators start other coordinators to manage sub-tasks/sub-features
- coordinators usually have UI component, but not always

### ViewController/View roles 
- no view controller stands alone, they are always managed by a coordinator
- defines read-only view model for all configurable/dynamic data
- defines delegate protocol for all external actions
- populate and present UI based in view model
- delegate any outside actions to coordinator
- no business logic or direct navigation triggers

### helpers
- presentation helpers to transformer domain data into view models
