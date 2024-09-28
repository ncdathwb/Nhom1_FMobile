document.addEventListener('DOMContentLoaded', function() {
    var searchIcon = document.getElementById('searchIcon');
    var searchForm = document.getElementById('searchForm');

    searchIcon.addEventListener('click', function() {
        searchForm.submit();
    });

    // Thêm xử lý cho phím Enter
    searchForm.querySelector('input[name="query"]').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            searchForm.submit();
        }
    });
});








