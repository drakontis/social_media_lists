$(document).ready(function() {
    $('.chosen-select').chosen({
        include_bank: false,
        allow_single_deselect: true,
        no_results_text: 'No results matched',
        width: '200px'
    });

    $('.datepicker').datepicker({format: 'dd/mm/yyyy'});
});