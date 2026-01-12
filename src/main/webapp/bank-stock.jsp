<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.bloodline.entities.BankStockView,com.bloodline.entities.BloodBank" %>
<%
    List<BloodBank> banks = (List<BloodBank>) request.getAttribute("banks");
    List<BankStockView> stocks = (List<BankStockView>) request.getAttribute("stocks");
    Integer bankId = (Integer) request.getAttribute("bankId");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bank Stock – BloodLine</title>

    <!-- Bootstrap CSS (LOCAL) -->
    <link href="<%= request.getContextPath() %>/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --brand: #d62828;
        }
        body {
            background: #f8f9fa;
        }
        .page-title {
            font-weight: 700;
            color: var(--brand);
        }
        .card-stock {
            border-radius: 10px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.05);
        }
        .badge-status {
            padding: 6px 10px;
            border-radius: 5px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        .status-ok { background: #d4f8df; color: #138c3f; }
        .status-low { background: #fff3cd; color: #c77f04; }
        .status-out { background: #fde4e4; color: #b42318; }
    </style>
</head>

<body>

    <div class="container my-4">

        <h2 class="page-title mb-3">Bank Stock</h2>

        <% if (message != null) { %>
        <div class="alert alert-success alert-dismissible fade show">
            <%= message %>
            <button class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <% if (error != null) { %>
        <div class="alert alert-danger alert-dismissible fade show">
            <%= error %>
            <button class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <!-- BANK DROPDOWN -->
        <div class="card card-stock p-3 mb-4">
            <form method="get" action="<%= request.getContextPath() %>/bank/stock" class="row g-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Choose Bank</label>
                    <select name="bankId" class="form-select" onchange="this.form.submit()">
                        <% if (banks != null) {
                            for (BloodBank b : banks) { %>
                                <option value="<%= b.getBankId() %>"
                                        <%= (bankId != null && bankId == b.getBankId()) ? "selected" : "" %>>
                                    <%= b.getName() %> (<%= b.getCity() %>)
                                </option>
                        <% } } %>
                    </select>
                </div>
            </form>
        </div>

        <!-- STOCK TABLE -->
        <div class="card card-stock p-3">
            <h5 class="fw-bold mb-3">Blood Stock Inventory</h5>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Group</th>
                            <th>Units</th>
                            <th>Status</th>
                            <th>Last Updated</th>
                            <th style="width: 180px;">Actions</th>
                        </tr>
                    </thead>

                    <tbody>
                        <% if (stocks != null) {
                            for (BankStockView v : stocks) {

                                String statusClass = "status-ok";
                                if ("Low".equals(v.getStatus())) statusClass = "status-low";
                                if ("Out of Stock".equals(v.getStatus())) statusClass = "status-out";
                        %>

                        <tr>
                            <td class="fw-bold"><%= v.getBloodGroup() %></td>
                            <td><%= v.getUnitsAvailable() %></td>
                            <td>
                                <span class="badge-status <%= statusClass %>"><%= v.getStatus() %></span>
                            </td>
                            <td><%= v.getLastUpdated() %></td>

                            <td>
                                <!-- ADD UNITS -->
                                <button class="btn btn-sm btn-outline-success"
                                        data-bs-toggle="modal"
                                        data-bs-target="#addModal"
                                        data-group="<%= v.getBloodGroup() %>"
                                        data-bank="<%= v.getBankId() %>">
                                    Add
                                </button>

                                <!-- USE UNITS -->
                                <button class="btn btn-sm btn-outline-danger"
                                        data-bs-toggle="modal"
                                        data-bs-target="#useModal"
                                        <%= v.getUnitsAvailable() == 0 ? "disabled" : "" %>
                                        data-group="<%= v.getBloodGroup() %>"
                                        data-bank="<%= v.getBankId() %>"
                                        data-max="<%= v.getUnitsAvailable() %>">
                                    Use
                                </button>
                            </td>
                        </tr>

                        <% } } %>
                    </tbody>
                </table>
            </div>

            <a href="<%= request.getContextPath() %>/banks" class="btn btn-outline-secondary mt-3">
                ← Back to Banks
            </a>
        </div>
    </div>

    <!-- ADD UNITS MODAL -->
    <div class="modal fade" id="addModal" tabindex="-1">
        <div class="modal-dialog">
            <form method="post" action="<%= request.getContextPath() %>/bank/stock" class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Units</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="bankId" id="addBankId">
                    <input type="hidden" name="group" id="addGroup">

                    <label class="form-label">Units to Add</label>
                    <input type="number" name="units" min="1" class="form-control" required>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button class="btn btn-success">Add Units</button>
                </div>
            </form>
        </div>
    </div>

    <!-- USE UNITS MODAL -->
    <div class="modal fade" id="useModal" tabindex="-1">
        <div class="modal-dialog">
            <form method="post" action="<%= request.getContextPath() %>/bank/stock" class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Use Units</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="action" value="use">
                    <input type="hidden" name="bankId" id="useBankId">
                    <input type="hidden" name="group" id="useGroup">

                    <label class="form-label">Units to Use</label>
                    <input type="number" name="units" id="useUnits" min="1" class="form-control" required>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button class="btn btn-danger">Use Units</button>
                </div>
            </form>
        </div>
    </div>

    <!-- BOOTSTRAP JS -->
    <script src="<%= request.getContextPath() %>/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <script>
        // Handle Add Modal Autofill
        var addModal = document.getElementById('addModal');
        addModal.addEventListener('show.bs.modal', function (event) {
            var btn = event.relatedTarget;
            document.getElementById('addGroup').value = btn.getAttribute('data-group');
            document.getElementById('addBankId').value = btn.getAttribute('data-bank');
        });

        // Handle Use Modal Autofill
        var useModal = document.getElementById('useModal');
        useModal.addEventListener('show.bs.modal', function (event) {
            var btn = event.relatedTarget;
            document.getElementById('useGroup').value = btn.getAttribute('data-group');
            document.getElementById('useBankId').value = btn.getAttribute('data-bank');
            document.getElementById('useUnits').max = btn.getAttribute('data-max');
        });
    </script>

</body>
</html>
