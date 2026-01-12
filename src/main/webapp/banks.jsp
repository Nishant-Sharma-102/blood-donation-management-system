<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.bloodline.entities.BloodBank" %>
<%
  List<BloodBank> banks = (List<BloodBank>) request.getAttribute("banks");
  String message = (String) request.getAttribute("message");
  String error = (String) request.getAttribute("error");
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>BloodLine — Manage Blood Banks</title>

  <!-- Use local bootstrap in your project (preferred) -->
  <link href="<%= request.getContextPath() %>/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Or use CDN if you prefer:
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  -->

  <style>
    :root{
      --brand:#d62828; /* BloodLine red */
      --muted:#6c757d;
      --card-bg: #ffffff;
    }
    body { background:#f8f9fa; font-family: "Segoe UI", system-ui, -apple-system, "Helvetica Neue", Arial; }
    .brand { color: var(--brand); font-weight:700; }
    .topbar { background: linear-gradient(90deg, rgba(214,40,40,0.05), rgba(214,40,40,0.02)); padding:18px 0; border-bottom:1px solid #eee; }
    .page-title { font-size:1.25rem; margin:0; }
    .card-bank { border-radius:10px; box-shadow: 0 6px 16px rgba(16,24,40,0.04); }
    .status-yes { color:#198754; font-weight:600; }
    .status-no { color:#dc3545; font-weight:600; }
    .small-muted { color:var(--muted); font-size:0.9rem; }
    .table-responsive { margin-top: 12px; }
    .search-input { max-width:360px; }
    .btn-brand { background: var(--brand); color: #fff; border: 1px solid rgba(0,0,0,0.04); }
    .btn-brand:focus, .btn-brand:hover { background:#b82828; color:#fff; }
    .footer-note { color:var(--muted); font-size:0.9rem; }
    @media (max-width:640px){
      .page-title { font-size:1rem; }
      .search-input { max-width:100%; }
    }
  </style>
</head>
<body>
  <header class="topbar">
    <div class="container d-flex align-items-center justify-content-between">
      <div>
        <h1 class="page-title mb-0"><span class="brand">BloodLine</span> — Blood Banks</h1>
        <div class="small-muted">Manage blood bank branches and view their stock</div>
      </div>
      <div class="d-flex gap-2">
        <a class="btn btn-outline-secondary" href="<%= request.getContextPath() %>/">Home</a>
        <button class="btn btn-brand" data-bs-toggle="modal" data-bs-target="#addBankModal">
          <i class="bi bi-plus-lg"></i> Add Bank
        </button>
      </div>
    </div>
  </header>

  <main class="container my-4">

    <% if (message != null) { %>
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Success:</strong> <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    <% } %>
    <% if (error != null) { %>
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>Error:</strong> <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    <% } %>

    <div class="card card-bank p-3">
      <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between gap-3">
        <div class="d-flex flex-column">
          <h5 class="mb-1">All Registered Banks</h5>
          <div class="small-muted">Create, view and manage blood banks. Click “Open” to view bank stock.</div>
        </div>

        <div class="d-flex gap-2 align-items-center">
          <input id="searchInput" type="search" class="form-control search-input" placeholder="Search by name or city">
          <select id="filterActive" class="form-select" style="width:auto;">
            <option value="all">All</option>
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
          </select>
          <a class="btn btn-outline-secondary" href="<%= request.getContextPath() %>/bank/stock">Open Bank Stock</a>
        </div>
      </div>

      <div class="table-responsive">
        <table id="banksTable" class="table table-hover align-middle mb-0 mt-3">
          <thead class="table-light">
            <tr>
              <th style="width:64px;">ID</th>
              <th>Name</th>
              <th>City</th>
              <th>Phone</th>
              <th>Email</th>
              <th style="width:90px;">Active</th>
              <th style="width:120px;">Actions</th>
            </tr>
          </thead>
          <tbody>
            <% if (banks != null && !banks.isEmpty()) {
                 for (BloodBank b : banks) { %>
              <tr data-name="<%= b.getName()==null? "": b.getName().toLowerCase() %>"
                  data-city="<%= b.getCity()==null? "": b.getCity().toLowerCase() %>"
                  data-active="<%= b.isActive()? "active":"inactive" %>">
                <td><%= b.getBankId() %></td>
                <td><strong><%= b.getName() %></strong></td>
                <td><%= b.getCity() == null ? "-" : b.getCity() %></td>
                <td><%= b.getPhone() == null ? "-" : b.getPhone() %></td>
                <td><%= b.getEmail() == null ? "-" : b.getEmail() %></td>
                <td>
                  <% if (b.isActive()) { %>
                    <span class="badge bg-success">Yes</span>
                  <% } else { %>
                    <span class="badge bg-danger">No</span>
                  <% } %>
                </td>
                <td>
                  <div class="d-flex gap-2">
                    <a class="btn btn-sm btn-outline-primary" href="<%= request.getContextPath() %>/bank/stock?bankId=<%= b.getBankId() %>">Open</a>

                    <!-- Edit quick button (opens modal) -->
                    <button class="btn btn-sm btn-outline-secondary edit-btn" data-bankid="<%= b.getBankId() %>"
                      data-name="<%= b.getName()==null? "": b.getName() %>"
                      data-city="<%= b.getCity()==null? "": b.getCity() %>"
                      data-address="<%= b.getAddress()==null? "": b.getAddress() %>"
                      data-phone="<%= b.getPhone()==null? "": b.getPhone() %>"
                      data-email="<%= b.getEmail()==null? "": b.getEmail() %>"
                      data-license="<%= b.getLicenseNo()==null? "": b.getLicenseNo() %>"
                      data-established="<%= b.getEstablishedDate()==null? "": b.getEstablishedDate() %>">
                      Edit
                    </button>

                    <!-- Delete (optional) could be added here -->
                  </div>
                </td>
              </tr>
            <% } } else { %>
              <tr><td colspan="7" class="text-center small-muted py-4">No banks found. Add a new bank to get started.</td></tr>
            <% } %>
          </tbody>
        </table>
      </div>

      <div class="d-flex justify-content-between align-items-center mt-3">
        <div class="footer-note">Showing <span id="visibleCount">0</span> banks</div>
        <div>
          <a class="btn btn-sm btn-outline-secondary" href="<%= request.getContextPath() %>/">Back to Home</a>
        </div>
      </div>
    </div>
  </main>

  <!-- Add Bank Modal -->
  <div class="modal fade" id="addBankModal" tabindex="-1" aria-labelledby="addBankLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
        <form method="post" action="<%= request.getContextPath() %>/banks">
          <div class="modal-header">
            <h5 class="modal-title" id="addBankLabel">Add New Blood Bank</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">Name*</label>
                <input name="name" class="form-control" required>
              </div>
              <div class="col-md-6">
                <label class="form-label">City</label>
                <input name="city" class="form-control">
              </div>
              <div class="col-12">
                <label class="form-label">Address</label>
                <input name="address" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Phone</label>
                <input name="phone" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Email</label>
                <input name="email" type="email" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">License No</label>
                <input name="licenseNo" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Established</label>
                <input name="establishedDate" type="date" class="form-control">
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-brand">Create Bank</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- Edit Bank Modal (uses same form but posts to /banks as update; server code must handle update by ID) -->
  <div class="modal fade" id="editBankModal" tabindex="-1" aria-labelledby="editBankLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
        <form id="editBankForm" method="post" action="<%= request.getContextPath() %>/banks">
          <input type="hidden" name="bankId" id="editBankId">
          <div class="modal-header">
            <h5 class="modal-title" id="editBankLabel">Edit Bank</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">Name*</label>
                <input id="editName" name="name" class="form-control" required>
              </div>
              <div class="col-md-6">
                <label class="form-label">City</label>
                <input id="editCity" name="city" class="form-control">
              </div>
              <div class="col-12">
                <label class="form-label">Address</label>
                <input id="editAddress" name="address" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Phone</label>
                <input id="editPhone" name="phone" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Email</label>
                <input id="editEmail" name="email" type="email" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">License No</label>
                <input id="editLicense" name="licenseNo" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Established</label>
                <input id="editEstablished" name="establishedDate" type="date" class="form-control">
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-brand">Save Changes</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS (local) -->
  <script src="<%= request.getContextPath() %>/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- Optionally use CDN:
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  -->
  <!-- Small helper script -->
  <script>
    (function(){
      // live search + filter
      const search = document.getElementById('searchInput');
      const filter = document.getElementById('filterActive');
      const table = document.getElementById('banksTable');
      const tbody = table && table.querySelector('tbody');
      const visibleCountEl = document.getElementById('visibleCount');

      function updateVisibleCount() {
        const rows = tbody.querySelectorAll('tr');
        let visible = 0;
        rows.forEach(r => { if (r.style.display !== 'none') visible++; });
        visibleCountEl.textContent = visible;
      }

      function applyFilter() {
        const q = (search.value || '').trim().toLowerCase();
        const f = (filter.value || 'all');
        if (!tbody) return;
        const rows = tbody.querySelectorAll('tr');
        rows.forEach(row => {
          // rows that are placeholders have no data-name attr
          const name = row.getAttribute('data-name') || '';
          const city = row.getAttribute('data-city') || '';
          const active = row.getAttribute('data-active') || 'active';
          let show = true;
          if (f !== 'all' && active !== f) show = false;
          if (q) {
            if (!(name.indexOf(q) > -1 || city.indexOf(q) > -1)) show = false;
          }
          row.style.display = show ? '' : 'none';
        });
        updateVisibleCount();
      }

      if (search) search.addEventListener('input', applyFilter);
      if (filter) filter.addEventListener('change', applyFilter);
      // initial count
      document.addEventListener('DOMContentLoaded', function(){ applyFilter(); });

      // Edit modal population
      const editBtns = document.querySelectorAll('.edit-btn');
      editBtns.forEach(btn => {
        btn.addEventListener('click', function(){
          const id = this.dataset.bankid;
          document.getElementById('editBankId').value = id;
          document.getElementById('editName').value = this.dataset.name || '';
          document.getElementById('editCity').value = this.dataset.city || '';
          document.getElementById('editAddress').value = this.dataset.address || '';
          document.getElementById('editPhone').value = this.dataset.phone || '';
          document.getElementById('editEmail').value = this.dataset.email || '';
          document.getElementById('editLicense').value = this.dataset.license || '';
          document.getElementById('editEstablished').value = this.dataset.established || '';
          // show modal
          var editModal = new bootstrap.Modal(document.getElementById('editBankModal'));
          editModal.show();
        });
      });

      // If server uses same /banks POST for update, ensure edit POST includes hidden param or server checks bankId
      // Optionally add client-side validation
    })();
  </script>
</body>
</html>
