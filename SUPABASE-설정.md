# Supabase 연동 순서

조원들은 Claude나 Supabase 계정 없이 **팀 비밀번호 하나**로 들어옵니다.
아래 과정은 대표 한 명이 한 번만 하면 됩니다. 약 10분 걸립니다.

## 1. 프로젝트 만들기
1. https://supabase.com 에 깃허브 계정으로 가입하고 로그인합니다.
2. **New project**를 누르고 아래처럼 정합니다.
   - Name: `tft-log`
   - Database Password: 아무거나 길게 정합니다. 사이트에는 쓰지 않습니다.
   - Region: `Northeast Asia (Seoul)`
3. 만들어질 때까지 1~2분 기다립니다.

## 2. 테이블 만들기
1. 왼쪽 메뉴에서 **SQL Editor**로 가서 **New query**를 누릅니다.
2. 이 폴더의 `supabase-setup.sql` 내용을 전부 복사해 붙여 넣고 **Run**을 누릅니다.
3. `Success. No rows returned`가 나오면 완료입니다.

## 3. 팀 계정 만들기 (팀 비밀번호 정하기)
1. 왼쪽 메뉴에서 **Authentication → Users**로 가서 **Add user → Create new user**를 누릅니다.
2. 아래처럼 입력합니다.
   - Email: `team@tft-log.app`
     - 실제 메일함은 필요 없습니다. 다른 주소로 하려면 `index.html`의 `teamEmail`도 같은 주소로 바꿔야 합니다.
   - Password: **조원들과 공유할 팀 비밀번호**
   - **Auto Confirm User**에 체크합니다.
3. **Create user**를 누릅니다.

## 4. 외부인 가입 막기 (꼭 하세요)
이 설정을 하지 않으면 사이트 주소를 아는 외부인이 직접 계정을 만들어 기록을 볼 수 있습니다.
1. **Authentication → Sign In / Providers**로 갑니다. 화면에 따라 **Authentication → Settings**일 수 있습니다.
2. **Allow new users to sign up**을 **끄고** 저장합니다.

## 5. 사이트에 연결값 넣기
1. **Project Settings → API**로 갑니다. 화면에 따라 **Project Settings → Data API / API Keys**일 수 있습니다.
2. 아래 두 값을 복사합니다.
   - **Project URL**: 예) `https://abcdefgh.supabase.co`
   - **anon public** 키: `eyJ...`로 시작하는 긴 문자열
     - `service_role` 키는 절대 쓰지 마세요.
3. `index.html` 위쪽의 `TFT_CONFIG`에 붙여 넣습니다.
   ```js
   window.TFT_CONFIG = {
     url: 'https://abcdefgh.supabase.co',
     anonKey: 'eyJ...',
     teamEmail: 'team@tft-log.app'
   };
   ```
   - anon 키는 공개 저장소에 올라가도 괜찮습니다.
   - 3~4번 설정 덕분에 팀 비밀번호 없이는 아무것도 읽거나 쓸 수 없습니다.
4. 커밋하고 깃허브에 올립니다(push).

## 6. 확인
1. 사이트를 열면 **팀 비밀번호** 화면이 나옵니다.
2. 비밀번호와 기록자 이름을 넣고 들어가면 오른쪽 위에 **조원과 실시간 공유**가 표시됩니다.
3. 전에 이 기기에만 저장해 둔 기록이 있으면, 홈 화면 아래 **팀 저장소로 옮기기** 버튼이 나옵니다.

## 참고
- 무료 플랜은 DB 500MB입니다. 공정 카드 하나가 약 1KB라 충분합니다.
- 무료 프로젝트는 **7일 동안 아무도 접속하지 않으면 일시 정지**됩니다. 대시보드에서 **Restore**를 누르면 기록은 그대로 돌아옵니다.
- 팀 비밀번호를 바꾸려면 **Authentication → Users**에서 팀 계정을 고르고 비밀번호를 바꾸면 됩니다.
