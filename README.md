# Rb3m template package cho RStudio/RMarkdown

(Rb3m template package for RStudio/RMarkdown)

- Trát Quang Thụy
- Ngày tạo: 2020-04-28
- Cập nhật: 2020-05-03

---

**_Rb3m đang trong giai đoạn thiết kế._**

## Cài đặt trong `R/ RStudio`

- [ ] **Cách 1**

  ```R
  # Nếu máy chưa cài githubinstall
  install.packages("githubinstall")

  githubinstall::githubinstall("Rb3m")
  ```

- [x] **Cách 2**

  ```R
  # Nếu máy chưa cài devtools
  install.packages("devtools")

  devtools::install_github("BabyMouse/Rb3m")
  ```

---

## TODO

### Rb3m package

- <https://www.evernote.com/l/Am59RskyE2xG35pj0ohg4gItJIFdINJdFLg/>

### Rb3m Template design

- <https://www.evernote.com/l/Am6Qu1VKrrdNb4KhHle5a3aSKRSezLGC8mQ/>

---

## Known issues

- Về hiển thị **`Unicode`**
  - Không xài được Unicode trong cửa sổ `RStudio/ R Markdown`.
  - Không xài được Unicode với roxygen2 (<https://github.com/r-lib/roxygen2>).
