<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LiuDijo WebApp</title>

    <!--
      SỬA LỖI TRIỆT ĐỂ: Dùng thẻ <base>
      Thẻ này báo cho trình duyệt biết thư mục gốc của trang web là ở đâu.
      Tất cả các link (CSS, JS, hình ảnh, điều hướng) sau đây sẽ tự động
      lấy đường dẫn này làm gốc.
    -->
    <base href="${pageContext.request.contextPath}/">

    <!--
      Giờ đây, chúng ta có thể dùng đường dẫn đơn giản
      vì nó sẽ được tự động nối vào <base>
      Kết quả: href="/liudijo-webapp/assets/css/style.css" (LUÔN ĐÚNG)
    -->
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/home.css">

    <!-- Nếu bạn có file CSS cho admin, hãy thêm nó theo cách tương tự -->
    <%-- <link rel="stylesheet" href="assets/css/admin.css"> --%>

    <!-- Thêm các link font, icon (ví dụ: Font Awesome) nếu có -->

</head>