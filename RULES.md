# Rules

## Code

1. `Asset`
   - separated by underscore symbol ➜ ex : `ic_edit.svg`
   - placed in `assets/{type}/name`
2. `Function`
   - use `CamelCase` letter 
   - add prefix `_functionName` for private function
   - add prefix `functionName` for public function
3. `File/Folder/Class`
   - use `PascalCase` letter for class name and use `SnakeCase` for file name
   - no need suffix `Screen/View` for folder naming
   - for folder, if there are 2 words then separate it with underscore ➜ ex : `change_password`
4. `Screen`
   - add suffix `View` ➜ ex : `LoginView`
   - place the file refers to the figma, but separate it if it's reusable screen
5. `Component`
   - placed in `presentation/widgets`
   - add suffix `Component` for the file name ➜ ex : `TextFieldComponent`
   - if other developers need to adjust/enhance specific component, they must coordinate with the author of component for refactoring
   - there are 2 micro component, `card` and `item`
      - card :
         - add prefix `Card` ➜ ex : `AttendanceCard`
         - placed in `widgets/card`
      - item :
         - specific created for looping data
         - add prefix `Item` ➜ ex : `AttendanceItem`
         - placed in `widgets/item`
6. `Section`
   - add suffix `Section` ➜ ex : `FastMenuSection`
   - placed in `featureFolder/section` if it's reusable ➜ `login/section`
7. `Constant`
   - for enum class, add suffix `Type` and placed in `presentations/resource/contants_manager` ➜ ex : `DialogType` if reusable
   - for any constant, use `CamelCase` letter and placed in `presentations/resources/constants_manager` ➜ ex : `const val apiKey = "API_KEY"`
     - general : write the value with `CamelCase` letter
     - api response : write the value depends on the response key
8. `Data Class`
   - if specifically used for response, classify it as `Response` and put it inside `data/response`
   - if specifically used for model, classify it as `Model` and put it inside `domain/models`
   - if used for configuration in specific component, just put it inside `presentation/widgets` with the same level as its component
      - add prefix `Config` ➜ ex : `CalendarConfig`

9. `Navigation`
    - navigation using generateRoutes, set route name in `presentation/resources/routes_manager.dart`

## Versioning App

> **IMPORTANT** : *Makesure on Merge Request (MR) got Approved from Code Reviewer, before Update Versioning App and Changelog, Then Code Reviewer can be Merged*

1. Change version
   - find `version` located in `pubspec.yaml`
2. Rule
   - part of version is `[major.minor.patch]` start from `0.0.0`
   - `patch` 
      - any updates for fixing/refactoring/enhancing/adding micro component or util except main feature
      - only add by one for all the changes related in a day
      - example :  
         [0.0.1]-2024-04-25  
         https://app.clickup.com/t/86ep2jep9  
         https://app.clickup.com/t/86ep2jep9  
         https://app.clickup.com/t/86ep2jep9  
         
         Changed  
         - Refactor : Maps View into Component  
         - Fix: Top Bar and Navigation to My Account on Home Screen  
         - Comp: Calendar Component

   - `minor` 
      - any updates for adding feature
      - increment number will be added according to the number of feature
      - if there is also a patch update at the same day, a patch number will be reset to 0
      - example :  
        [0.2.1]-2024-04-25  
         https://app.clickup.com/t/86ep2jep9  
         https://app.clickup.com/t/86ep2jep9  
         https://app.clickup.com/t/86ep2jep9  
         https://app.clickup.com/t/86ep2jep9  
         https://app.clickup.com/t/86ep2jep9  
         
         Added  
         
         - Feat : Attendance Screen  
         - Feat : Home Screen

         Changed  
         - Refactor : Maps View into Component  
         - Fix: Top Bar and Navigation to My Account on Home Screen  
         - Comp: Calendar Component

   - `major` 
      - any revamp or breaking changes from previous version

## Commit

1. `Chore` : Ini biasanya digunakan untuk perubahan yang tidak terkait dengan kode secara langsung, seperti peningkatan konfigurasi, perbaikan tautan, penambahan dokumentasi, atau pekerjaan pemeliharaan umum.
2. `Fix`: Digunakan untuk perbaikan bug atau masalah dalam kode yang ada. Ini menunjukkan bahwa perubahan yang dilakukan adalah untuk memperbaiki sesuatu yang tidak berfungsi dengan benar.
3. `Feat (Feature)`: Digunakan ketika menambahkan fitur baru atau fungsionalitas ke dalam kode. Ini menunjukkan bahwa perubahan yang dilakukan adalah untuk menambahkan sesuatu yang baru.
4. `Refactor`: Digunakan ketika melakukan perubahan kode tanpa mengubah fungsionalitas eksternal, biasanya untuk meningkatkan struktur atau kebersihan kode.
5. `Docs`: Digunakan ketika melakukan perubahan pada dokumentasi, baik itu penambahan, perubahan, atau perbaikan.
6. `Test`: Digunakan ketika melakukan perubahan pada pengujian, baik itu menambahkan, memperbaiki, atau menghapus tes.
7. `Style`: Digunakan ketika melakukan perubahan pada gaya atau format kode tanpa mengubah perilaku fungsional.

## Merge Request

Steps and rules to follow when merging branches either main or development.

- Before initiating a merge:  
   - Ensure your feature branch is up to date with the base branch (usually development or main).  
      - git checkout `<feature-branch>`
      - git pull origin `<base-branch>`
   - Resolve any conflicts locally.

- Open Merge Request
   - Set the `Assignee` to yourself
   - Set the `Reviewer` to Lead of Squad or Tech Lead
   - Below the Merge Option, you may check the option `Squash commits when merge request is accepted.` 

- Code Review
   - All merge requests must be submitted through the repository's platform (GitLab) for review.  
   - At least one other team member must review and approve the merge request  
   - Incorporate or discuss feedback as necessary.

- Merging
   - Once approved, the reviewer merge the feature branch into the base branch.  
   - Delete the feature branch from the remote repository after merging
