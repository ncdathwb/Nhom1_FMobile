
let filterCurrentPage = 1;
const filterItemsPerPage = 16; // Số sản phẩm trên mỗi trang
let filterTotalProducts = 0;
let isFiltering = false;
let wasFiltering = false; // Biến để theo dõi trạng thái lọc trước đó

function updateProducts() {
    let brands = $('.brand-checkbox:checked').map(function() { return this.value; }).get().join(',');
    let rams = $('.ram-checkbox:checked').map(function() { return this.value; }).get().join(',');
    let minPrice = $('.price-checkbox:checked').map(function() { return $(this).data('min'); }).get().join(',');
    let maxPrice = $('.price-checkbox:checked').map(function() { return $(this).data('max'); }).get().join(',');

    // Lấy giá trị của productCategory từ input ẩn
    let productCategory = $('#productCategory').val();

    // Check if any filter is applied
    isFiltering = brands || rams || minPrice || maxPrice;

    if (isFiltering) {
        wasFiltering = true; // Đánh dấu rằng bộ lọc đã được sử dụng
        $('#filterProductResults').html('<h3>Đang tải...</h3>');
        $('#searchProductResults').hide();
        $('#filterProductResults').show();

        $.ajax({
            url: '/guest/filter',
            method: 'GET',
            data: {
                brands: brands,
                rams: rams,
                minPrice: minPrice,
                maxPrice: maxPrice,
                productCategory: productCategory
            },
            success: function(response) {
                $('#filterProductResults').html(response);

                filterTotalProducts = $('#filterProductResults').data('total') || $(response).find('.item').length;
                console.log('Total products:', filterTotalProducts);

                let titleText = 'Filter Result:  ' + filterTotalProducts + ' products';
                document.title = titleText;
                $('.title h1').text(titleText);
                applyPagination();
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", status, error);
                console.error("Response Text:", xhr.responseText);
                $('#filterProductResults').html('<h3>Có lỗi xảy ra khi tải sản phẩm. Vui lòng thử lại.</h3>');
            }
        });
    } else {
        if (wasFiltering) {
            // Nếu trước đó đã sử dụng bộ lọc và bây giờ tắt, làm mới trang
            window.location.reload();
        } else {
            // Nếu không có bộ lọc và trước đó cũng không có, chỉ hiển thị kết quả tìm kiếm ban đầu
            $('#filterProductResults').hide();
            $('#searchProductResults').show();
            ('.hpagination').remove(); // Remove pagination if exists
            let totalSearchProducts = $('#searchProductResults .item').length;
            let titleText = totalSearchProducts + ' Products Found';
            document.title = titleText;
            $('.title h1').text(titleText);
        }
    }
}

function applyPagination() {
    if (!isFiltering || filterTotalProducts === 0) {
        $('.hpagination').remove(); // Remove pagination if no products or not filtering
        return;
    }

    const products = $('#filterProductResults .item');
    const totalPages = Math.ceil(filterTotalProducts / filterItemsPerPage);

    // Ẩn tất cả sản phẩm
    products.hide();

    // Hiển thị sản phẩm cho trang hiện tại
    const startIndex = (filterCurrentPage - 1) * filterItemsPerPage;
    const endIndex = startIndex + filterItemsPerPage;
    products.slice(startIndex, endIndex).show();

    // Cập nhật tiêu đề
    let titleText = 'Filter Result: ' + filterTotalProducts + ' products';
    document.title = titleText;
    $('.title h1').text(titleText);

    // Tạo các nút phân trang
    createPaginationButtons(totalPages);
}

function createPaginationButtons(totalPages) {
    $('.hpagination').remove(); // Xóa phân trang cũ nếu có

    if (filterTotalProducts === 0) {
        return; // Không tạo phân trang nếu không có sản phẩm
    }

    let paginationHtml = '<div class="hpagination">';

    // Nút Previous
    paginationHtml += `<a href="#" class="prev ${filterCurrentPage === 1 ? 'disabled' : ''}" ${filterCurrentPage === 1 ? 'disabled' : ''} onclick="changePage(${filterCurrentPage - 1}); return false;">Previous</a>`;

    // Các nút số trang
    for (let i = 1; i <= totalPages; i++) {
        if (i === filterCurrentPage) {
            paginationHtml += `<strong>${i}</strong>`;
        } else {
            paginationHtml += `<a href="#" onclick="changePage(${i}); return false;">${i}</a>`;
        }
    }

    // Nút Next
    paginationHtml += `<a href="#" class="next ${filterCurrentPage === totalPages ? 'disabled' : ''}" ${filterCurrentPage === totalPages ? 'disabled' : ''} onclick="changePage(${filterCurrentPage + 1}); return false;">Next</a>`;

    paginationHtml += '</div>';

    // Thêm các nút phân trang vào DOM
    $('#filterProductResults').after(paginationHtml);
}

function changePage(newPage) {
    if (!isFiltering) return; // Don't change page if not filtering

    const totalPages = Math.ceil(filterTotalProducts / filterItemsPerPage);
    if (newPage < 1 || newPage > totalPages) {
        return;
    }
    filterCurrentPage = newPage;
    applyPagination();
}

$(document).ready(function() {
    $('.brand-checkbox, .ram-checkbox, .price-checkbox').on('change', function() {
        filterCurrentPage = 1; // Reset về trang đầu tiên khi lọc
        updateProducts();
    });

    // Không áp dụng phân trang cho kết quả ban đầu
    updateProducts();
});


