# TMBDProject

> TMDB API를 활용한 영화 소개

## 목차
[1.개발 기간](#개발-기간)

[2.개발 환경](#개발-환경)

[3.주요 기능](#주요-기능)

[4.기술스택](#기술스택)

[5.트러블슈팅](#트러블슈팅)

[6.회고](#회고)

[7.추후 업데이트할 내용](#추후-업데이트할-내용)
***
## 개발 기간
> 23.08.22

## 개발 환경
> Xcode 14

## 스크린샷

<img width="1013" alt="스크린샷 2023-11-02 오후 5 06 22" src="https://github.com/JaeBeen0725/MoaMoa/assets/105216574/e1e9b920-41e3-478f-b206-91c0669727a4">

## 주요 기능
- 금주의 영화 순위
- 영화 상세 설명
***

## 기술스택
 - **UIKit** : **StoryBoard** 기반으로 사용자 인터페이스 구현 및 이벤트 관리
 - **Alamofire & TMDB API** : HTTP통신으로 TMDB 영화 데이터 request
 - **Kingfisher**: 비동기 호출후 영화 이미지 데이터를 출력 및 캐싱
 

## 트러블슈팅
- APIKey 노출 이슈
-> .gitignore file을 생성후 APIKey file을 github에 노출되지 않도록 설정


## 회고
### Good
- Codable에 대한 개념이해

### Bad
- 불필요한 데이터까지 포함한 모델구성

## 추후 업데이트할 내용
- 순위 Label 생성
- UI개선
- API통신 예외처리
