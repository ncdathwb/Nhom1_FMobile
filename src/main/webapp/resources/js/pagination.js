let currentPage = 1;
const itemsPerPage = 10; // Số sản phẩm trên mỗi trang

// Hàm hiển thị các sản phẩm của trang hiện tại
function displayProducts(allProducts) {
    const start = (currentPage - 1) * itemsPerPage;
    const end = Math.min(start + itemsPerPage, allProducts.length);
    const pageProducts = allProducts.slice(start, end);

    $('#productResults').empty();
    pageProducts.forEach(product => {
        $('#productResults').append(product); // Thêm sản phẩm vào HTML
    });
}

// Hàm cập nhật các nút phân trang
function updatePagination(allProducts) {
    const totalPages = Math.ceil(allProducts.length / itemsPerPage);
    let paginationHtml = '';

    if (totalPages > 1) {
        if (currentPage > 1) {
            paginationHtml += '<button class="page-btn" data-page="' + (currentPage - 1) + '">Trước</button>';
        }

        for (let i = Math.max(1, currentPage - 2); i <= Math.min(totalPages, currentPage + 2); i++) {
            paginationHtml += '<button class="page-btn ' + (i === currentPage ? 'active' : '') + '" data-page="' + i + '">' + i + '</button>';
        }

        if (currentPage < totalPages) {
            paginationHtml += '<button class="page-btn" data-page="' + (currentPage + 1) + '">Sau</button>';
        }
    }

    $('#pagination').html(paginationHtml);

    // Gắn sự kiện click cho các nút phân trang
    $('.page-btn').on('click', function() {
        currentPage = parseInt($(this).data('page'));
        displayProducts(allProducts); // Hiển thị sản phẩm theo trang mới
        updatePagination(allProducts); // Cập nhật lại các nút phân trang
    });
}
