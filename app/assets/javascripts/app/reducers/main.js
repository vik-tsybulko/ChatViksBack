let initialState= {
  alert_message: '',
  alert_type: '',
  isLoading: false,
  language: 'en'
}

export default function (state = initialState, action) {
  switch (action.type){
    case 'SET_LOADING_STATE':
      return {
        ...state,
        isLoading: true
      }
    case 'UNSET_LOADING_STATE':
      return {
        ...state,
        isLoading: false
      };
    case 'ALERT':
      return {
        ...state,
        alert_message: action.message,
        alert_type: action.alert_type || state.alert_type
    };
    case 'SET_LANGUAGE':
      I18n.locale = action.language;
      return {
        ...state,
        language: action.language
      }
    default:
      return state
  }
}