<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="header.jsp" />

<div class="categories">
    <a style="font-size:x-large" class="category" href="#">All Products (${allProducts.size()})</a>
    <h2>Kết quả tìm kiếm cho: "${searchQuery}"</h2>
</div>

<div class="container">
    <div class="row">
        <div class="col-3">
            <div class="filter-container">
                <!-- Form lọc sản phẩm -->
                <form id="searchForm" action="/client/filter" method="get">
                    <!-- Lọc theo Brand -->
                    <div class="row">
                        <section class="mb-4">
                            <h4 class="font-weight-bold mb-3">BRAND</h4>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="brands" value="Apple" id="brandApple">
                                <label class="form-check-label" for="brandApple">Apple</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="brands" value="Samsung" id="brandSamsung">
                                <label class="form-check-label" for="brandSamsung">Samsung</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="brands" value="Xiaomi" id="brandXiaomi">
                                <label class="form-check-label" for="brandXiaomi">Xiaomi</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="brands" value="Redmi" id="brandRedmi">
                                <label class="form-check-label" for="brandRedmi">Redmi</label>
                            </div>
                        </section>
                    </div>

                    <!-- Lọc theo Price -->
                    <div class="row">
                        <section class="mb-4">
                            <h4 class="font-weight-bold mb-3">PRICE</h4>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="priceRange" value="0-25" id="priceUnder25">
                                <label class="form-check-label" for="priceUnder25">Under $25</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="priceRange" value="25-50" id="price25to50">
                                <label class="form-check-label" for="price25to50">$25 to $50</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="priceRange" value="50-100" id="price50to100">
                                <label class="form-check-label" for="price50to100">$50 to $100</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="priceRange" value="100-200" id="price100to200">
                                <label class="form-check-label" for="price100to200">$100 to $200</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="priceRange" value="200-9999" id="price200above">
                                <label class="form-check-label" for="price200above">$200 & above</label>
                            </div>
                        </section>
                    </div>

                    <!-- Lọc theo RAM -->
                    <div class="row">
                        <section class="mb-4">
                            <h4 class="font-weight-bold mb-3">RAM</h4>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="rams" value="4Gb" id="ram4gb">
                                <label class="form-check-label" for="ram4gb">4Gb</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="rams" value="6Gb" id="ram6gb">
                                <label class="form-check-label" for="ram6gb">6Gb</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="rams" value="8Gb" id="ram8gb">
                                <label class="form-check-label" for="ram8gb">8Gb</label>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="rams" value="12Gb" id="ram12gb">
                                <label class="form-check-label" for="ram12gb">12Gb</label>
                            </div>
                        </section>
                    </div>

                    <!-- Lọc theo Color -->
                    <div class="row">
                        <section class="mb-4">
                            <h4 class="font-weight-bold mb-3">COLOR</h4>
                            <div class="form-check form-check-inline m-0 p-0 pr-3">
                                <input class="btn-check" type="radio" name="color" value="white" id="colorWhite">
                                <label class="btn bg-light btn-rounded p-3" for="colorWhite"></label>
                            </div>
                            <div class="form-check form-check-inline m-0 p-0 pr-3">
                                <input class="btn-check" type="radio" name="color" value="black" id="colorBlack">
                                <label class="btn bg-dark text-white btn-rounded p-3" for="colorBlack"></label>
                            </div>
                            <div class="form-check form-check-inline m-0 p-0 pr-3">
                                <input class="btn-check" type="radio" name="color" value="red" id="colorRed">
                                <label class="btn bg-danger btn-rounded p-3" for="colorRed"></label>
                            </div>
                            <div class="form-check form-check-inline m-0 p-0 pr-3">
                                <input class="btn-check" type="radio" name="color" value="pink" id="colorPink">
                                <label class="btn btn-rounded p-3" for="colorPink" style="background-color: pink;"></label>
                            </div>
                        </section>
                    </div>

                    <button type="submit" class="btn btn-primary">Apply Filters</button>
                </form>
            </div>
        </div>

        <div class="col-9">
            <!-- Hiển thị danh sách sản phẩm -->
            <div class="product">
                <c:choose>
                    <c:when test="${empty allProducts}">
                        <h5>No products found</h5>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${allProducts}" var="product">
                            <div data-id="${product.id}" class="item">
                                <div style="width: 50%; height: 300px; overflow: hidden;">
                                    <!-- Liên kết hình ảnh đến trang chi tiết sản phẩm -->
                                    <a href="${pageContext.request.contextPath}/client/productsDetail/${product.id}">
                                        <img style="width: 100%; height: 100%; object-fit: cover;" src="${product.images[0].url}" alt="${product.productName}">
                                    </a>
                                </div>
                                <div class="item-info">
                                    <h2>${product.productName}</h2>
                                    <div class="price">$${product.price}</div>
                                    <div class="detail">
                                        <p>Brand: ${product.brand.brandName}</p>
                                        <p>RAM: ${product.ram}</p>
                                        <p>Color: ${product.color}</p>
                                    </div>
                                    <div class="row">
                                        <button class="buyNow bg-primary">Buy Now</button>
                                        <button class="addCart bg-warning">Add To Cart</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Phân trang -->
    <div class="pagination">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="?name=${searchQuery}&page=${currentPage - 1}">&laquo;</a>
                    </li>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?name=${searchQuery}&page=${i}">${i}</a>
                    </li>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="?name=${searchQuery}&page=${currentPage + 1}">&raquo;</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Tự động submit form khi thay đổi bộ lọc
        $('input[type=checkbox], input[type=radio]').on('change', function () {
            $('#searchForm').submit();
        });

        // Xử lý sự kiện khi click vào Add To Cart
        $('.addCart').click(function () {
            var productId = $(this).closest('.item').data('id');
            $.ajax({
                url: '/cart/add/' + productId,
                method: 'POST',
                success: function () {
                    alert('Product added to cart!');
                },
                error: function () {
                    alert('Failed to add product to cart.');
                }
            });
        });

        // Xử lý sự kiện mua ngay
        $('.buyNow').click(function () {
            var productId = $(this).closest('.item').data('id');
            window.location.href = '/checkout?productId=' + productId;
        });
    });
</script>

<jsp:include page="footer.jsp" />

