


export default function getAppUrl(): String {
  let buildMode = 0; // 0 debug ， 1 previous ， 2 release
  switch (buildMode) {
    case 0:
      return "https://test.api.com/"
    case 1:
      return "https://pre.api.com/"
    default:
      return "https://relase.api.com/"
  }
}


