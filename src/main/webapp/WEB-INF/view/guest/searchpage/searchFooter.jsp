<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 16/09/2024
  Time: 3:09 PM
  To change this template use File | Settings | File Templates.
--%>
<!-- Footer -->
<nav class="navbar navbar-expand-lg navbar-light bg-light mt-5">
    <div class="container-fluid">
        <img class="logo" src="/images/product/FMobileLogo.png" alt="" />
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="row g-5 mt-1">
            <div class="col-md-6">
                <h2 class="mb-4">
                    Be the first to explore and use our new products while others are
                    still waiting
                </h2>
                <button class="btn btn-primary">Get Started</button>
            </div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-sm-3">
                        <h5>Products</h5>
                        <ul class="list-unstyled">
                            <li>Iphone</li>
                            <li>Samsung</li>
                        </ul>
                    </div>
                    <div class="col-sm-3">
                        <h5>Category</h5>
                        <ul class="list-unstyled">
                            <li>Alcatel 6850</li>
                            <li>Ruckus ZD 1200</li>
                            <li>Alcatel 6850</li>
                            <li>Ruckus ZD 1200</li>
                        </ul>
                    </div>
                    <div class="col-sm-3">
                        <h5>About</h5>
                        <ul class="list-unstyled">
                            <li>Newsletter</li>
                            <li>Privacy</li>
                            <li>Terms</li>
                            <li>Cookies</li>
                        </ul>
                    </div>
                    <div class="col-sm-3">
                        <h5>Contact</h5>
                        <ul class="list-unstyled">
                            <li>0763254524</li>
                            <li>fmobile@gmail.com</li>
                            <li>fmobile@edu.vn</li>
                        </ul>
                    </div>
                </div>
            </div>
            <footer class="pt-3 mt-4 text-center">
                Copyright © 2024 group 1 F Mobile
            </footer>
        </div>
    </div>
</nav>
<div class="cartTab">
    <h1>Shopping Cart</h1>
    <form id = "cartForm" action ="/checkout" method="get">
    <div class="listCart">

    </div>

    <div id="hiddenInputs">
        <!-- JavaScript sẽ thêm các input ẩn vào đây -->
    </div>
    </form>
    <div class="cartTotal">
        <div class="totalText">Total:</div>
        <div class="totalAmount">$0.00</div>
    </div>
    <div class="btn">
        <button class="close">CLOSE</button>
        <button class="checkOut">CHECK OUT</button>
    </div>

</div>

<script src="/js/cart.js"></script>
<script src="/js/search.js"></script>
<script src="/js/pagination.js"></script>
<script src="/js/filter.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const darkModeToggle = document.getElementById("darkModeToggle");
    darkModeToggle.addEventListener("change", function () {
        document.body.classList.toggle("dark-mode", darkModeToggle.checked);
    });
</script>
</body>
</html>
