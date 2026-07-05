create or replace PACKAGE  package_bnf_managament AS
    --------------------------------------------------------------------------
    -- Public helper functions. They are exposed so developers can test the same
    -- simple normalization, masking and dedupe rules used by the package body.
    --------------------------------------------------------------------------
    FUNCTION f_json_escape (
        p_text IN VARCHAR2
    ) RETURN VARCHAR2;

    FUNCTION f_json_quote (
        p_text IN VARCHAR2
    ) RETURN VARCHAR2;

    FUNCTION f_norm_flag (
        p_value   IN VARCHAR2,
        p_default IN VARCHAR2 DEFAULT 'N'
    ) RETURN VARCHAR2;

    FUNCTION f_json_varchar (
        p_req  IN CLOB,
        p_path IN VARCHAR2
    ) RETURN VARCHAR2;

    FUNCTION f_json_number (
        p_req  IN CLOB,
        p_path IN VARCHAR2
    ) RETURN NUMBER;

    FUNCTION f_to_number_or_null (
        p_value IN VARCHAR2
    ) RETURN NUMBER;

    FUNCTION f_to_date_or_null (
        p_value IN VARCHAR2
    ) RETURN DATE;

    FUNCTION f_mask_value (
        p_value IN VARCHAR2
    ) RETURN VARCHAR2;

    FUNCTION f_validate_mobile (
        p_value IN VARCHAR2
    ) RETURN VARCHAR2;

    FUNCTION f_validate_number (
        p_value IN VARCHAR2
    ) RETURN VARCHAR2;

    FUNCTION f_validate_ifsc (
        p_value IN VARCHAR2
    ) RETURN VARCHAR2;
    
    -- banwari 08052026
--    
--    FUNCTION f_validate_aadhaar (
--    p_value IN VARCHAR2
--) RETURN VARCHAR2 ;

    FUNCTION f_build_dedupe_key (
        --p_aadhaar_ref_no IN VARCHAR2,
        p_jan_aadhar_id  IN VARCHAR2,
        p_account_no     IN VARCHAR2,
        p_ifsc_code      IN VARCHAR2,
        p_mobile_no      IN VARCHAR2,
        p_name           IN VARCHAR2
    ) RETURN VARCHAR2;

    FUNCTION f_get_stage_value (
        p_row         IN stg_mst_beneficiary%rowtype,
        p_column_name IN VARCHAR2
    ) RETURN VARCHAR2;

    --------------------------------------------------------------------------
    -- Public stored procedures used by the Java/API layer.
    --------------------------------------------------------------------------
    PROCEDURE pr_get_departments (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_get_schemes (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_save_scheme (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_get_scheme_ui_fields (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_save_scheme_validation_policy (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_save_scheme_field_mapping (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_get_scheme_field_mapping (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_get_template_metadata (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_save_field_validation_config (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );
----jabir/vivek  1105026
    PROCEDURE pr_discard_group_id (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_create_beneficiary_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_update_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_rename_beneficiary_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_get_groups (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_get_beneficiary_groups (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_search_payees (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_get_group_beneficiaries (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_add_payees_to_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_add_group_to_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_import_group_beneficiaries (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_stage_beneficiaries (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_stage_beneficiaries_bulk (
        p_group_id   IN NUMBER,
        p_created_by IN VARCHAR2,
        p_rows       IN tab_beneficiary_stage_in,
        p_resp       OUT CLOB,
        p_status     OUT VARCHAR2,
        p_err_msg    OUT VARCHAR2,
        p_err_code   OUT VARCHAR2
    );

    PROCEDURE pr_update_stage_rows (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_remove_stage_rows (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_move_stage_rows (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_validate_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_get_group_validation_result (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_process_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_save_individual_beneficiary (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );
    --------For single benefeciary view list 22062026----------------------
      PROCEDURE pr_get_individual_beneficiaries (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );
  
 
    PROCEDURE pr_validate_group_v1 (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );
  
--  05062026
--
    PROCEDURE ots_benf_error_log (
    p_module_name IN VARCHAR2,
    p_proc_name   IN VARCHAR2,
    p_type        IN NUMBER,
    p_ref_no          IN NUMBER,
    p_err_code    IN VARCHAR2 DEFAULT NULL,
    p_err_msg     IN VARCHAR2,
    p_SEVERITY   IN VARCHAR2 DEFAULT 'ERROR',
    p_request     IN CLOB
    );
--  05062026

    PROCEDURE pr_stage_beneficiaries_bulk_from_json (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

    PROCEDURE pr_onboard_full_flow (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    );

END package_bnf_pns;


===================================================
create or replace PACKAGE BODY package_bnf_pns AS

/*
* Aniket:
 * - Conceived and designed the overall structure of the beneficiary module.
 * - Established the foundational schema and layout for module development.
 * - Defined the initial architecture to support both single and group beneficiaries.
 * - Created the base framework ensuring scalability and modularity.
 */
 
 /*
 * Banwari:
 * - Took responsibility for initial setup after module structure was created.
 * - Configured database indexing to improve query performance.
 * - Designed migration scripts to move existing beneficiary data into the new module.
 * - Implemented error handling routines for smooth execution of validations.
 * - Established a logging framework to track module activities and errors.
 */

/*
 * Pravesh:
 * - Implemented validation logic for single beneficiary entries.
 * - Designed group beneficiary validation rules for consistency.
 * - Created multiple functions to streamline beneficiary operations.
 * - Developed stored procedures to handle complex validation workflows.
 * - Optimized SQL queries for better performance and reduced execution time.
 * - Ensured error handling mechanisms were robust and user-friendly.
 * - Contributed to modularizing the package for easier maintenance.
 * - Reviewed and tested validation scenarios thoroughly.
 * - Documented the validation process for future reference.
 * - Collaborated with the team to align validation logic with business rules.
 */

/*
 * Jabir:
 * - Focused on refining group beneficiary validation mechanisms.
 * - Built reusable functions to reduce redundancy in the package.
 * - Designed stored procedures for batch processing of beneficiaries.
 * - Enhanced query performance by applying indexing and optimization techniques.
 * - Ensured compliance with data integrity standards during validation.
 * - Added exception handling for edge cases in beneficiary data.
 * - Participated in peer reviews to improve code quality.
 * - Wrote detailed test cases to validate functionality.
 * - Assisted in debugging and resolving issues during integration.
 * - Contributed to overall package stability and reliability.
 */

/*
 * Vivek:
 * - Developed validation logic for both single and group beneficiaries.
 * - Created functions to support dynamic beneficiary operations.
 * - Designed stored procedures to automate repetitive tasks.
 * - Optimized queries for faster execution and scalability.
 * - Implemented error handling to manage invalid beneficiary inputs.
 * - Ensured validations adhered to business requirements.
 * - Conducted performance testing to verify efficiency of queries.
 * - Documented functions and procedures for maintainability.
 * - Collaborated with teammates to integrate validation seamlessly.
 * - Provided feedback and improvements during code reviews.
 */
  --------------------------------------------------------------------------
    -- Helper: Check the user role ---0906026 jabir
--------------------------------------------------------------------------
FUNCTION check_user_access (
        p_assignment_id IN NUMBER,
        p_role_id       IN NUMBER DEFAULT NULL
    ) RETURN VARCHAR2 IS
    l_assigment_value number;
    l_role_id number;
    l_status varchar2(1);
    BEGIN
        dbms_output.put_line(p_assignment_id);
        dbms_output.put_line(p_role_id);
        IF p_role_id IS NOT NULL THEN

        --ak commented review create view
            SELECT
                assignment_value -- agency_id
            INTO l_assigment_value
            FROM
                vu_sso_user_role sso
            WHERE
                    sso.assignment_id = p_assignment_id--case when role_id = 103 then 109422 when role_id IN (102,82,83) then p_assignment_id end--p_assignment_id
                AND sso.role_id = p_role_id;

        ELSE
       
            SELECT
                assignment_value,
                sso.role_id -- agency_id
            INTO
                l_assigment_value,
                l_role_id
            FROM
                vu_sso_user_role sso
            WHERE
                    sso.assignment_id = p_assignment_id
                AND sso.role_id IN ( 29 );

        END IF;
        l_status := 'S';
        RETURN l_status;
    EXCEPTION
        WHEN OTHERS THEN
            l_status := 'F';
            RETURN l_status;
    END check_user_access;

    --------------------------------------------------------------------------
    -- Helper: escape text before adding it to manually built JSON.
    --------------------------------------------------------------------------
    FUNCTION f_json_escape (
        p_text IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        RETURN replace(
            replace(
                replace(
                    replace(
                        nvl(p_text, ''),
                        '\',
                        '\\'
                    ),
                    '"',
                    '\"'
                ),
                chr(10),
                '\n'
            ),
            chr(13),
            '\r'
        );
    END;

    --------------------------------------------------------------------------
    -- Helper: return quoted JSON text or JSON null.
    --------------------------------------------------------------------------
    FUNCTION f_json_quote (
        p_text IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        IF p_text IS NULL THEN
            RETURN 'null';
        END IF;
        RETURN '"'
               || f_json_escape(p_text)
               || '"';
    END;

    --------------------------------------------------------------------------
    -- Helper: normalize UI yes/no values into Y/N flags.
    --------------------------------------------------------------------------
    FUNCTION f_norm_flag (
        p_value   IN VARCHAR2,
        p_default IN VARCHAR2 DEFAULT 'N'
    ) RETURN VARCHAR2 IS
        l_value VARCHAR2(50);
    BEGIN
        l_value := upper(trim(nvl(p_value, p_default)));
        IF l_value IN ( 'Y', 'YES', 'TRUE', 'T', '1' ) THEN
            RETURN 'Y';
        ELSIF l_value IN ( 'N', 'NO', 'FALSE', 'F', '0' ) THEN
            RETURN 'N';
        END IF;

        RETURN
            CASE
                WHEN p_default IS NULL THEN
                    NULL
                ELSE upper(substr(p_default, 1, 1))
            END;

    END;

    --------------------------------------------------------------------------
    -- Helper: read a string from request JSON. Bad/missing JSON returns NULL.
    --------------------------------------------------------------------------
    FUNCTION f_json_varchar (
        p_req  IN CLOB,
        p_path IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        RETURN JSON_VALUE(p_req, p_path RETURNING VARCHAR2 ( 4000 ) NULL ON EMPTY NULL ON ERROR);
    END;

    --------------------------------------------------------------------------
    -- Helper: read a number from request JSON. Bad/missing JSON returns NULL.
    --------------------------------------------------------------------------
    FUNCTION f_json_number (
        p_req  IN CLOB,
        p_path IN VARCHAR2
    ) RETURN NUMBER IS
    BEGIN
        RETURN JSON_VALUE(p_req, p_path RETURNING NUMBER NULL ON EMPTY NULL ON ERROR);
    END;

    --------------------------------------------------------------------------
    -- Helper: safely convert text to number.
    --------------------------------------------------------------------------
    FUNCTION f_to_number_or_null (
        p_value IN VARCHAR2
    ) RETURN NUMBER IS
    BEGIN
        IF p_value IS NULL THEN
            RETURN NULL;
        ELSIF regexp_like(
            trim(p_value),
            '^[0-9]+(\.[0-9]+)?$'
        ) THEN
            RETURN TO_NUMBER ( TRIM(p_value) );
        END IF;

        RETURN NULL;
    END;

    --------------------------------------------------------------------------
    -- Helper: safely convert text to date. Expected format is YYYY-MM-DD.
    --------------------------------------------------------------------------
    FUNCTION f_to_date_or_null (
        p_value IN VARCHAR2
    ) RETURN DATE IS
    BEGIN
        IF p_value IS NULL THEN
            RETURN NULL;
        END IF;
        RETURN TO_DATE ( TRIM(p_value), 'YYYY-MM-DD' );
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END;

    --------------------------------------------------------------------------
    -- Helper: mask a sensitive identifier for response JSON.
    --------------------------------------------------------------------------
    FUNCTION f_mask_value (
        p_value IN VARCHAR2
    ) RETURN VARCHAR2 IS
        l_len NUMBER;
    BEGIN
        IF p_value IS NULL THEN
            RETURN NULL;
        END IF;
        l_len := length(p_value);
        IF l_len <= 4 THEN
            RETURN rpad('X', l_len, 'X');
        END IF;

        RETURN rpad('X', l_len - 4, 'X')
               || substr(p_value, -4);

    END;

    --------------------------------------------------------------------------
    -- Helper: validate Indian mobile number.
    --------------------------------------------------------------------------
    FUNCTION f_validate_mobile (
        p_value IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        IF p_value IS NULL THEN
            RETURN 'N';
        ELSIF regexp_like(
            trim(p_value),
            '^[6-9][0-9]{9}$'
        ) THEN
            RETURN 'Y';
        END IF;

        RETURN 'N';
    END;

    --------------------------------------------------------------------------
    -- Helper: validate basic numeric text.
    --------------------------------------------------------------------------
    FUNCTION f_validate_number (
        p_value IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        IF p_value IS NULL THEN
            RETURN 'N';
        ELSIF regexp_like(
            trim(p_value),
            '^[0-9]+(\.[0-9]+)?$'
        ) THEN
            RETURN 'Y';
        END IF;

        RETURN 'N';
    END;

    --------------------------------------------------------------------------
    -- Helper: validate IFSC format and optionally check MDM branch master.
    -- Dynamic SQL avoids compile-time dependency on MDM schema grants.
    --------------------------------------------------------------------------

FUNCTION f_validate_ifsc (
    p_value IN VARCHAR2
) RETURN VARCHAR2 IS
    l_ifsc  VARCHAR2(11);
    l_count NUMBER;
BEGIN
    IF p_value IS NULL THEN
        RETURN 'N';
    END IF;

    l_ifsc := UPPER(TRIM(p_value));

    IF NOT REGEXP_LIKE(l_ifsc, '^[A-Z]{4}0[A-Z0-9]{6}$') THEN
        RETURN 'N';
    END IF;

    BEGIN
        EXECUTE IMMEDIATE
            'SELECT COUNT(1)
               FROM MDM.MST_BANK_BRANCH
              WHERE UPPER(IFSC_CODE) = :1'
        INTO l_count
        USING l_ifsc;

        RETURN CASE
                   WHEN l_count > 0 THEN 'Y'
                   ELSE 'N'
               END;

    EXCEPTION
        WHEN OTHERS THEN
            RETURN 'Y';
    END;

END f_validate_ifsc;
    
       --------------------------------------------------------------------------
    -- Helper: validate Adhar Number.
    --------------------------------------------------------------------------
    FUNCTION f_validate_aadhaar (
    p_value IN VARCHAR2
) RETURN VARCHAR2 IS
    l_aadhaar VARCHAR2(20);
BEGIN

    l_aadhaar := REPLACE( REPLACE( TRIM(p_value), '-',  '' ), ' ', '');

    IF l_aadhaar IS NULL THEN
        RETURN 'N';
    ELSIF REGEXP_LIKE(
              l_aadhaar,
              '^[2-9][0-9]{11}$'
          ) THEN
        RETURN 'Y';
    END IF;

    RETURN 'N';

END;


    --------------------------------------------------------------------------
    -- Helper: build one deterministic dedupe key in a fixed, easy order.
    --------------------------------------------------------------------------
    FUNCTION f_build_dedupe_key (
        --p_aadhaar_ref_no IN VARCHAR2,
        p_jan_aadhar_id  IN VARCHAR2,
        p_account_no     IN VARCHAR2,
        p_ifsc_code      IN VARCHAR2,
        p_mobile_no      IN VARCHAR2,
        p_name           IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
--        IF p_aadhaar_ref_no IS NOT NULL THEN
--            RETURN 'AADH:' || upper(trim(p_aadhaar_ref_no));
        if p_jan_aadhar_id IS NOT NULL THEN
            RETURN 'JAN:' || upper(trim(p_jan_aadhar_id));
        ELSIF
            p_account_no IS NOT NULL
            AND p_ifsc_code IS NOT NULL
        THEN
            RETURN 'ACCT:'
                   || upper(trim(p_account_no))
                   || ':'
                   || upper(trim(p_ifsc_code));
        ELSIF
            p_mobile_no IS NOT NULL
            AND p_name IS NOT NULL
        THEN
            RETURN 'MOB:'
                   || trim(p_mobile_no)
                   || ':'
                   || upper(trim(p_name));
        END IF;

        RETURN 'MANUAL:' || rawtohex(sys_guid());
    END;

    --------------------------------------------------------------------------
    -- Helper: get a stage row value by physical column name for validation JSON.
    --------------------------------------------------------------------------
    FUNCTION f_get_stage_value (
        p_row         IN stg_mst_beneficiary%rowtype,
        p_column_name IN VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        CASE upper(trim(p_column_name))
            WHEN 'BENEFICIARY_NAME' THEN
                RETURN p_row.beneficiary_name;
            WHEN 'AADHAAR_REF_NO' THEN
                RETURN p_row.aadhaar_ref_no;
            WHEN 'JAN_AADHAR_ID' THEN
                RETURN p_row.jan_aadhar_id;
            WHEN 'MOBILE_NO' THEN
                RETURN p_row.mobile_no;
            WHEN 'STATE_NAME' THEN
                RETURN p_row.state_name;
            WHEN 'DISTRICT_NAME' THEN
                RETURN p_row.district_name;
            WHEN 'IFSC_CODE' THEN
                RETURN p_row.ifsc_code;
            WHEN 'ACCOUNT_NO' THEN
                RETURN p_row.account_no;
            WHEN 'AMOUNT' THEN
                RETURN to_char(p_row.amount);
            WHEN 'ATTR1_VAL' THEN
                RETURN p_row.attr1_val;
            WHEN 'ATTR2_VAL' THEN
                RETURN p_row.attr2_val;
            WHEN 'ATTR3_VAL' THEN
                RETURN p_row.attr3_val;
            WHEN 'ATTR4_VAL' THEN
                RETURN p_row.attr4_val;
            WHEN 'ATTR5_VAL' THEN
                RETURN p_row.attr5_val;
            WHEN 'ATTR6_VAL' THEN
                RETURN p_row.attr6_val;
            WHEN 'ATTR7_VAL' THEN
                RETURN p_row.attr7_val;
            WHEN 'ATTR8_VAL' THEN
                RETURN p_row.attr8_val;
            WHEN 'ATTR9_VAL' THEN
                RETURN p_row.attr9_val;
            WHEN 'ATTR10_VAL' THEN
                RETURN p_row.attr10_val;
            WHEN 'ATTR11_VAL' THEN
                RETURN to_char(p_row.attr11_val);
            WHEN 'ATTR12_VAL' THEN
                RETURN to_char(p_row.attr12_val);
            WHEN 'ATTR13_VAL' THEN
                RETURN to_char(p_row.attr13_val);
            WHEN 'ATTR14_VAL' THEN
                RETURN to_char(p_row.attr14_val);
            WHEN 'ATTR15_VAL' THEN
                RETURN to_char(p_row.attr15_val);
            WHEN 'ATTR16_VAL' THEN
                RETURN to_char(p_row.attr16_val, 'YYYY-MM-DD');
            WHEN 'ATTR17_VAL' THEN
                RETURN to_char(p_row.attr17_val, 'YYYY-MM-DD');
            WHEN 'ATTR18_VAL' THEN
                RETURN to_char(p_row.attr18_val, 'YYYY-MM-DD');
            WHEN 'ATTR19_VAL' THEN
                RETURN dbms_lob.substr(p_row.attr19_val, 1000, 1);
            WHEN 'ATTR20_VAL' THEN
                RETURN dbms_lob.substr(p_row.attr20_val, 1000, 1);
            ELSE
                RETURN NULL;
        END CASE;
    END;

    --------------------------------------------------------------------------
    -- Private helper: wrap response JSON in a common success envelope.
    --------------------------------------------------------------------------
    PROCEDURE p_set_success (
        p_data     IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) AS
    BEGIN
        p_status := 'S';
        p_err_msg := NULL;
        p_err_code := NULL;
        p_resp := '{"status":"SUCCESS","data":'
                  || nvl(p_data, '{}')
                  || '}';
      --  dbms_output.put_line(p_resp);
    END;

    --------------------------------------------------------------------------
    -- Private helper: wrap error text in a common error envelope.
    --------------------------------------------------------------------------
-----------------------------------------------Pravesh vivek jabir-------------------------
PROCEDURE p_set_error (
    p_message  IN VARCHAR2,
    p_code     IN VARCHAR2,
    p_resp     OUT CLOB,
    p_status   OUT VARCHAR2,
    p_err_msg  OUT VARCHAR2,
    p_err_code OUT VARCHAR2
) IS
    l_message VARCHAR2(4000);
BEGIN

    l_message := REGEXP_REPLACE(
                    p_message,
                    '^ORA-\d+:\s*'
                 );

    p_status := 'E';
    p_err_msg := substr(l_message, 1, 4000);
    p_err_code := p_code;

    p_resp := '{"status":"ERROR","errorCode":'
              || f_json_quote(p_code)
              || ',"message":'
              || f_json_quote(substr(l_message, 1, 4000))
              || '}';

END;

---------------------------------05062026-------------------------------------------
-------------------Procedure for Error Log in Benefeciary module--------------------
---------------------------------------------------------------------------
PROCEDURE ots_benf_error_log(
    p_module_name IN VARCHAR2,
    p_proc_name   IN VARCHAR2,
    p_type        IN NUMBER,
    p_ref_no     IN NUMBER,
    p_err_code    IN VARCHAR2 DEFAULT NULL,
    p_err_msg     IN VARCHAR2,
    p_SEVERITY    IN VARCHAR2 DEFAULT 'ERROR',
    p_request     IN CLOB
) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    INSERT INTO ots_benf_error_logs
    (
        module_name,
        proc_name,
        p_type,
        REF_NO,
        err_code,
        err_msg,
        SEVERITY,
        request
        
    )
    VALUES
    (
        p_module_name,
        p_proc_name,
        p_type,
        p_REF_NO,
        p_err_code,
        SUBSTR(p_err_msg,1,4000),
        p_SEVERITY,
        p_request
    );

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;

----------------------------------------------------------------------------

    --------------------------------------------------------------------------
    -- Private helper: require a valid scheme.
    --------------------------------------------------------------------------
    PROCEDURE p_assert_scheme_exists (
        p_scheme_id IN NUMBER
    ) IS
        l_count NUMBER;
    BEGIN
        IF p_scheme_id IS NULL THEN
            raise_application_error(-20001, 'scheme_id is required.');
        END IF;
        SELECT
            COUNT(*)
        INTO l_count
        FROM
            mst_scheme
        WHERE
            scheme_id = p_scheme_id;

        IF l_count = 0 THEN
            raise_application_error(-20002, 'Invalid scheme_id: ' || p_scheme_id);
        END IF;

    END;

    --------------------------------------------------------------------------
    -- Private helper: require a valid group.
    --------------------------------------------------------------------------
    PROCEDURE p_assert_group_exists (
        p_group_id IN NUMBER
    ) AS
        l_count NUMBER;
    BEGIN
        IF p_group_id IS NULL THEN
            raise_application_error(-20003, 'group_id is required.');
        END IF;
        SELECT
            COUNT(*)
        INTO l_count
        FROM
            mst_beneficiary_group
        WHERE
            group_id = p_group_id;

        IF l_count = 0 THEN
            raise_application_error(-20004, 'Invalid group_id: ' || p_group_id);
        END IF;

    END;

    --------------------------------------------------------------------------
    -- Private helper: lock group edits only when external module sets flag to Y.
    --------------------------------------------------------------------------
    PROCEDURE p_assert_group_editable (
        p_group_id IN NUMBER
    ) IS
        l_processed_flag CHAR(1);
    BEGIN
        SELECT
            processed_flag
        INTO l_processed_flag
        FROM
            mst_beneficiary_group
        WHERE
            group_id = p_group_id;

        IF l_processed_flag = 'Y' THEN
            raise_application_error(-20005, 'Group is processed by downstream module and cannot be modified.');
        END IF;
    END;

    --------------------------------------------------------------------------
    -- Private helper: block mapping changes when in-flight groups already exist.
    --------------------------------------------------------------------------
    PROCEDURE p_assert_mapping_edit_allowed (
        p_scheme_id IN NUMBER
    ) IS
        l_count NUMBER;
    BEGIN
        SELECT
            COUNT(*)
        INTO l_count
        FROM
            mst_beneficiary_group
        WHERE
                scheme_id = p_scheme_id
            AND process_status IN ( 'STAGED', 'VALIDATED', 'VALIDATION_FAILED' );

        IF l_count > 0 THEN
            raise_application_error(-20006, 'Scheme field mapping cannot be changed while in-flight groups exist for the scheme.');
        END IF;
    END;

    --------------------------------------------------------------------------
    -- Private audit helper: audit scheme configuration changes.
    --------------------------------------------------------------------------
    PROCEDURE p_audit_scheme_config (
        p_table_name  IN VARCHAR2,
        p_scheme_id   IN NUMBER,
        p_action_name IN VARCHAR2,
        p_old_data    IN CLOB,
        p_new_data    IN CLOB,
        p_reason      IN VARCHAR2,
        p_user        IN VARCHAR2
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        INSERT INTO hst_track_scheme_config (
            table_name,
            scheme_id,
            action_name,
            old_data,
            new_data,
            reason,
            created_by
        ) VALUES ( p_table_name,
                   p_scheme_id,
                   p_action_name,
                   p_old_data,
                   p_new_data,
                   p_reason,
                   nvl(p_user, user) );

        COMMIT;
    END;

    --------------------------------------------------------------------------
    -- Private audit helper: audit group metadata changes.
    --------------------------------------------------------------------------
    PROCEDURE p_audit_group (
        p_group_id    IN NUMBER,
        p_action_name IN VARCHAR2,
        p_old_data    IN CLOB,
        p_new_data    IN CLOB,
        p_reason      IN VARCHAR2,
        p_user        IN VARCHAR2
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        INSERT INTO hst_track_beneficiary_group (
            group_id,
            action_name,
            old_data,
            new_data,
            reason,
            created_by
        ) VALUES ( p_group_id,
                   p_action_name,
                   p_old_data,
                   p_new_data,
                   p_reason,
                   nvl(p_user, user) );

        COMMIT;
    END;

    --------------------------------------------------------------------------
    -- Private audit helper: audit group membership changes.
    --------------------------------------------------------------------------
    PROCEDURE p_audit_membership (
        p_stage_row_id  IN NUMBER,
        p_from_group_id IN NUMBER,
        p_to_group_id   IN NUMBER,
        p_action_name   IN VARCHAR2,
        p_old_data      IN CLOB,
        p_new_data      IN CLOB,
        p_reason        IN VARCHAR2,
        p_user          IN VARCHAR2
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        INSERT INTO hst_track_group_membership (
            stage_row_id,
            from_group_id,
            to_group_id,
            action_name,
            old_data,
            new_data,
            reason,
            created_by
        ) VALUES ( p_stage_row_id,
                   p_from_group_id,
                   p_to_group_id,
                   p_action_name,
                   p_old_data,
                   p_new_data,
                   p_reason,
                   nvl(p_user, user) );

        COMMIT;
    END;

    --------------------------------------------------------------------------
    -- Private audit helper: audit payee changes.
    --------------------------------------------------------------------------
    PROCEDURE p_audit_payee (
        p_payee_id    IN NUMBER,
        p_action_name IN VARCHAR2,
        p_old_data    IN CLOB,
        p_new_data    IN CLOB,
        p_reason      IN VARCHAR2,
        p_user        IN VARCHAR2
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        INSERT INTO hst_track_payee (
            payee_id,
            action_name,
            old_data,
            new_data,
            reason,
            created_by
        ) VALUES ( p_payee_id,
                   p_action_name,
                   p_old_data,
                   p_new_data,
                   p_reason,
                   nvl(p_user, user) );

        COMMIT;
    END;

    --------------------------------------------------------------------------
    -- Private audit helper: audit beneficiary master changes.
    --------------------------------------------------------------------------
    PROCEDURE p_audit_beneficiary (
        p_beneficiary_id IN NUMBER,
        p_group_id       IN NUMBER,
        p_action_name    IN VARCHAR2,
        p_old_data       IN CLOB,
        p_new_data       IN CLOB,
        p_reason         IN VARCHAR2,
        p_user           IN VARCHAR2
    ) IS
        PRAGMA autonomous_transaction;
    BEGIN
        INSERT INTO hst_track_beneficiary (
            beneficiary_id,
            group_id,
            action_name,
            old_data,
            new_data,
            reason,
            created_by
        ) VALUES ( p_beneficiary_id,
                   p_group_id,
                   p_action_name,
                   p_old_data,
                   p_new_data,
                   p_reason,
                   nvl(p_user, user) );

        COMMIT;
    END;

    --------------------------------------------------------------------------
    -- Private helper: append a validation error to the row error JSON array.
    --------------------------------------------------------------------------
    PROCEDURE p_append_error (
        p_errors      IN OUT NOCOPY CLOB,
        p_err_count   IN OUT NOCOPY NUMBER,
        p_column_name IN VARCHAR2,
        p_field_code  IN VARCHAR2,
        p_field_name  IN VARCHAR2,
        p_message     IN VARCHAR2
    ) IS
    BEGIN
        IF p_err_count > 0 THEN
            p_errors := p_errors || ',';
        END IF;
        p_errors := p_errors
                    || '{"column_name":'
                    || f_json_quote(p_column_name)
                    || ',"field_code":'
                    || f_json_quote(p_field_code)
                    || ',"field_name":'
                    || f_json_quote(p_field_name)
                    || ',"message":'
                    || f_json_quote(p_message)
                    || '}';

        p_err_count := p_err_count + 1;
    END;

    --------------------------------------------------------------------------
    -- Private helper: insert a group run detail row with current row counts.
    --------------------------------------------------------------------------
      PROCEDURE p_insert_group_run_detail (
        p_group_id IN NUMBER,
        p_run_type IN VARCHAR2,
        p_status   IN VARCHAR2,
        p_user     IN VARCHAR2,
        p_notes    IN VARCHAR2 DEFAULT NULL
    ) IS

        l_run_no   NUMBER;
        l_total    NUMBER;
        l_active   NUMBER;
        l_valid    NUMBER;
        l_invalid  NUMBER;
        l_removed  NUMBER;
        l_mastered NUMBER;
        l_notes    VARCHAR2(1000);---1606026 Jabir
    BEGIN
        SELECT
            nvl(max(run_no), 0) + 1
        INTO l_run_no
        FROM
            mst_beneficiary_group_run_details
        WHERE
            group_id = p_group_id;

        SELECT
            COUNT(*),
            nvl(
                sum(
                    CASE
                        WHEN row_status = 'ACTIVE' THEN
                            1
                        ELSE 0
                    END
                ),
                0
            ),
            nvl(
                sum(
                    CASE
                        WHEN
                            row_status = 'ACTIVE'
                            AND validation_status = 'VALID'
                        THEN
                            1
                        ELSE 0
                    END
                ),
                0
            ),
            nvl(
                sum(
                    CASE
                        WHEN
                            row_status = 'ACTIVE'
                            AND validation_status = 'INVALID'
                        THEN
                            1
                        ELSE 0
                    END
                ),
                0
            ),
            nvl(
                sum(
                    CASE
                        WHEN row_status = 'REMOVED' THEN
                            1
                        ELSE 0
                    END
                ),
                0
            )
        INTO
            l_total,
            l_active,
            l_valid,
            l_invalid,
            l_removed
        FROM
            stg_mst_beneficiary
        WHERE
            group_id = p_group_id;

        SELECT
            COUNT(*)
        INTO l_mastered
        FROM
            mst_beneficiary
        WHERE
            group_id = p_group_id;
         ------------------------1606026 jabir start------------------------   
            ------------------------------------------------------------------
-- User Readable Notes
------------------------------------------------------------------
l_notes :=
    CASE p_run_type

        WHEN 'CREATE_GROUP' THEN
            'Step ' || l_run_no || ': Group has been created successfully.'

        WHEN 'UPDATE_GROUP' THEN
            'Step ' || l_run_no || ': Group details have been updated successfully.'

        WHEN 'RENAME_GROUP' THEN
            'Step ' || l_run_no || ': Group has been renamed successfully.'

        WHEN 'ADD_PAYEES' THEN
            'Step ' || l_run_no || ': Existing payees have been added to the group.'

        WHEN 'COPY_FROM_GROUP' THEN
            'Step ' || l_run_no || ': Beneficiary records have been copied from another group.'

        WHEN 'IMPORT_GROUP_ROWS' THEN
            'Step ' || l_run_no || ': Beneficiary records have been imported from another group.'

        WHEN 'STAGE_JSON' THEN
            'Step ' || l_run_no || ': Beneficiary records uploaded and staged successfully.'

        WHEN 'STAGE_BULK' THEN
            'Step ' || l_run_no || ': Beneficiary records uploaded successfully through bulk import.'

        WHEN 'UPDATE_STAGE_ROWS' THEN
            'Step ' || l_run_no || ': Beneficiary records have been updated successfully.'

        WHEN 'REMOVE_ROWS' THEN
            'Step ' || l_run_no || ': Selected beneficiary records have been removed.'

        WHEN 'MOVE_OUT' THEN
            'Step ' || l_run_no || ': Beneficiary records have been moved out of this group.'

        WHEN 'MOVE_IN' THEN
            'Step ' || l_run_no || ': Beneficiary records have been moved into this group.'

        WHEN 'VALIDATE' THEN
            CASE
                WHEN p_status = 'VALIDATED' THEN
                    'Step ' || l_run_no ||
                    ': Validation completed successfully. ' ||
                    'Total Records: ' || l_total ||
                    ', Valid: ' || l_valid ||
                    ', Invalid: ' || l_invalid || '.'

                WHEN p_status = 'VALIDATION_FAILED' THEN
                    'Step ' || l_run_no ||
                    ': Validation completed with errors. ' ||
                    'Total Records: ' || l_total ||
                    ', Valid: ' || l_valid ||
                    ', Invalid: ' || l_invalid ||
                    '. Please correct the invalid records and validate again.'

                ELSE
                    'Step ' || l_run_no ||
                    ': Validation is in progress.'
            END

        WHEN 'SUBMIT_GROUP' THEN
            'Step ' || l_run_no ||
            ': Group submitted successfully. Valid beneficiary records have been moved to the Beneficiary Master.'

        ELSE
            NVL(p_notes, p_run_type)

    END;
------------------------------------1606026 End jabir -------------------------------
        INSERT INTO mst_beneficiary_group_run_details (
            group_id,
            run_no,
            run_type,
            run_status,
            total_rows,
            active_rows,
            valid_rows,
            invalid_rows,
            removed_rows,
            mastered_rows,
            notes,
            created_by
        ) VALUES ( p_group_id,
                   l_run_no,
                   p_run_type,
                   p_status,
                   l_total,
                   l_active,
                   l_valid,
                   l_invalid,
                   l_removed,
                   l_mastered,
                   l_notes,
                   nvl(p_user, user) );

    END;

    --------------------------------------------------------------------------
    -- Private helper: find existing payee by simplified dedupe precedence.
    --------------------------------------------------------------------------
    PROCEDURE p_find_payee (
        --p_aadhaar_ref_no IN VARCHAR2,
        p_jan_aadhar_id  IN VARCHAR2,
        p_account_no     IN VARCHAR2,
        p_ifsc_code      IN VARCHAR2,
        p_mobile_no      IN VARCHAR2,
        p_name           IN VARCHAR2,
        p_payee_id       OUT NUMBER
    ) IS
    BEGIN
        SELECT
            payee_id
        INTO p_payee_id
        FROM
            (
                SELECT
                    payee_id,
                    CASE
--                        WHEN p_aadhaar_ref_no IS NOT NULL
--                             AND aadhaar_ref_no = p_aadhaar_ref_no THEN
--                            1
                        WHEN p_jan_aadhar_id IS NOT NULL
                             AND jan_aadhar_id = p_jan_aadhar_id THEN
                            2
                        WHEN p_account_no IS NOT NULL
                             AND p_ifsc_code IS NOT NULL
                             AND account_no = p_account_no
                             AND ifsc_code = upper(p_ifsc_code) THEN
                            3
                        WHEN p_mobile_no IS NOT NULL
                             AND p_name IS NOT NULL
                             AND mobile_no = p_mobile_no
                             AND upper(beneficiary_name) = upper(p_name) THEN
                            4
                        ELSE
                            9
                    END match_order
                FROM
                    mst_payee
                WHERE
                        active_flag = 'Y'
                    AND 
--                    ( ( p_aadhaar_ref_no IS NOT NULL
--                            AND aadhaar_ref_no = p_aadhaar_ref_no )
--                          OR
                         ( ( p_jan_aadhar_id IS NOT NULL
                               AND jan_aadhar_id = p_jan_aadhar_id )
                          OR ( p_account_no IS NOT NULL
                               AND p_ifsc_code IS NOT NULL
--                               AND account_no = p_account_no
--                               AND ifsc_code = upper(p_ifsc_code)
---------20052026 jabir
                               AND TRIM(account_no) = TRIM(p_account_no)
                               AND upper(trim(ifsc_code)) = upper(trim(p_ifsc_code)) )
                          OR ( p_mobile_no IS NOT NULL
                               AND p_name IS NOT NULL
                               AND mobile_no = p_mobile_no
                               AND upper(beneficiary_name) = upper(p_name) ) )
                ORDER BY
                    match_order,
                    payee_id
            )
        WHERE
            ROWNUM = 1;

    EXCEPTION
        WHEN no_data_found THEN
            p_payee_id := NULL;
    END;

    --------------------------------------------------------------------------
    -- Private helper: create or update a payee using simplified dedupe.
    --------------------------------------------------------------------------
--    PROCEDURE p_upsert_payee (
--        p_beneficiary_name IN VARCHAR2,
--        --p_aadhaar_ref_no   IN VARCHAR2,
--        p_jan_aadhar_id    IN VARCHAR2,
--        p_mobile_no        IN VARCHAR2,
--        p_state_name       IN VARCHAR2,
--        p_district_name    IN VARCHAR2,
--        p_ifsc_code        IN VARCHAR2,
--        p_account_no       IN VARCHAR2,
--        p_user             IN VARCHAR2,
--        p_payee_id         OUT NUMBER
--    ) IS
--        l_dedupe_key    VARCHAR2(500);
--        l_dedupe_source VARCHAR2(30);
--        l_old           CLOB;
--    BEGIN
--        p_find_payee(
--       -- p_aadhaar_ref_no,
--        p_jan_aadhar_id, 
--        p_account_no, 
--        p_ifsc_code, 
--        p_mobile_no,
--        p_beneficiary_name, 
--        p_payee_id);
----        IF p_aadhaar_ref_no IS NOT NULL THEN
----            l_dedupe_source := 'AADHAAR_REF_NO';
--        if p_jan_aadhar_id IS NOT NULL THEN
--            l_dedupe_source := 'JAN_AADHAR_ID';
--        ELSIF
--            p_account_no IS NOT NULL
--            AND p_ifsc_code IS NOT NULL
--        THEN
--            l_dedupe_source := 'ACCOUNT_IFSC';
--        ELSIF
--            p_mobile_no IS NOT NULL
--            AND p_beneficiary_name IS NOT NULL
--        THEN
--            l_dedupe_source := 'MOBILE_NAME';
--        ELSE
--            l_dedupe_source := 'MANUAL';
--        END IF;
--
--        l_dedupe_key := f_build_dedupe_key(
--        --p_aadhaar_ref_no, 
--        p_jan_aadhar_id, 
--        p_account_no, 
--        p_ifsc_code, 
--        p_mobile_no,
--       p_beneficiary_name);
--                                           
--        IF p_payee_id IS NULL THEN
--            INSERT INTO mst_payee (
--                dedupe_key,
--                dedupe_source,
--                --aadhaar_ref_no,
--                jan_aadhar_id,
--                beneficiary_name,
--                mobile_no,
--                state_name,
--                district_name,
--                ifsc_code,
--                account_no,
--                created_by
--            ) VALUES ( l_dedupe_key,
--                       l_dedupe_source,
--                      -- p_aadhaar_ref_no,
--                       p_jan_aadhar_id,
--                       p_beneficiary_name,
--                       p_mobile_no,
--                       p_state_name,
--                       p_district_name,
--                       upper(p_ifsc_code),
--                       p_account_no,
--                       nvl(p_user, user) ) RETURNING payee_id INTO p_payee_id;
--
--            p_audit_payee(p_payee_id, 'INSERT', NULL, 'Payee created', 'Payee created by dedupe',
--                          p_user);
--        ELSE
--            SELECT
--                '{"beneficiary_name":'
--                || f_json_quote(beneficiary_name)
--                || ',"account_no":'
--                || f_json_quote(account_no)
--                || ',"ifsc_code":'
--                || f_json_quote(ifsc_code)
--                || '}'
--            INTO l_old
--            FROM
--                mst_payee
--            WHERE
--                payee_id = p_payee_id;
--
--            UPDATE mst_payee
--            SET
--                --aadhaar_ref_no = nvl(aadhaar_ref_no, p_aadhaar_ref_no),
--                jan_aadhar_id = nvl(jan_aadhar_id, p_jan_aadhar_id),
--                beneficiary_name = nvl(beneficiary_name, p_beneficiary_name),
--                mobile_no = nvl(mobile_no, p_mobile_no),
--                state_name = nvl(state_name, p_state_name),
--                district_name = nvl(district_name, p_district_name),
--                ifsc_code = nvl(ifsc_code,
--                                upper(p_ifsc_code)),
--                account_no = nvl(account_no, p_account_no),
--                modified_by = nvl(p_user, user),
--                modified_date = systimestamp
--            WHERE
--                payee_id = p_payee_id;
--
--            p_audit_payee(p_payee_id, 'UPDATE', l_old, 'Payee updated', 'Payee matched by dedupe',
--                          p_user);
--        END IF;
--
--    END;

------2006026 Jabir  --------------------
PROCEDURE p_upsert_payee (
    p_beneficiary_name IN VARCHAR2,
    p_jan_aadhar_id    IN VARCHAR2,
    p_mobile_no        IN VARCHAR2,
    p_state_name       IN VARCHAR2,
    p_district_name    IN VARCHAR2,
    p_ifsc_code        IN VARCHAR2,
    p_account_no       IN VARCHAR2,
    p_user             IN VARCHAR2,

    ------2006026 Jabir-------------------------------------------
    p_ddo_code         IN NUMBER,
    p_office_id        IN NUMBER,
    p_treas_code       IN VARCHAR2,
    p_source_type      IN VARCHAR2,
    --------------------------------------------------------------

    p_payee_id         OUT NUMBER
) IS

    l_dedupe_key    VARCHAR2(500);
    l_dedupe_source VARCHAR2(30);
    l_old           CLOB;

BEGIN

    p_find_payee(
        p_jan_aadhar_id,
        p_account_no,
        p_ifsc_code,
        p_mobile_no,
        p_beneficiary_name,
        p_payee_id
    );

    IF p_jan_aadhar_id IS NOT NULL THEN
        l_dedupe_source := 'JAN_AADHAR_ID';

    ELSIF p_account_no IS NOT NULL
      AND p_ifsc_code IS NOT NULL THEN
        l_dedupe_source := 'ACCOUNT_IFSC';

    ELSIF p_mobile_no IS NOT NULL
      AND p_beneficiary_name IS NOT NULL THEN
        l_dedupe_source := 'MOBILE_NAME';

    ELSE
        l_dedupe_source := 'MANUAL';
    END IF;

    l_dedupe_key := f_build_dedupe_key(
        p_jan_aadhar_id,
        p_account_no,
        p_ifsc_code,
        p_mobile_no,
        p_beneficiary_name
    );

    ------------------------------------------------------------------
    -- INSERT NEW PAYEE
    ------------------------------------------------------------------
    IF p_payee_id IS NULL THEN

        INSERT INTO mst_payee (
            dedupe_key,
            dedupe_source,
            jan_aadhar_id,
            beneficiary_name,
            mobile_no,
            state_name,
            district_name,
            ifsc_code,
            account_no,

            ------------2006026 Jabir ------------------------------------
            ddo_code,
            office_id,
            treas_code,
            source_type,
            ----------------------------------------------------------

            created_by
        )
        VALUES (
            l_dedupe_key,
            l_dedupe_source,
            p_jan_aadhar_id,
            p_beneficiary_name,
            p_mobile_no,
            p_state_name,
            p_district_name,
            UPPER(p_ifsc_code),
            p_account_no,

            ---------------2006026 Jabir-----------------------------
            p_ddo_code,
            p_office_id,
            p_treas_code,
            p_source_type,
            ----------------------------------------------------------

            NVL(p_user, USER)
        )
        RETURNING payee_id
        INTO p_payee_id;

        p_audit_payee(
            p_payee_id,
            'INSERT',
            NULL,
            'Payee created',
            'Payee created by dedupe',
            p_user
        );

    ------------------------------------------------------------------
    -- UPDATE EXISTING PAYEE
    ------------------------------------------------------------------
    ELSE

        ------------------------2006026 Jabir ---------------------
        SELECT
               '{"beneficiary_name":'
            || f_json_quote(beneficiary_name)
            || ',"account_no":'
            || f_json_quote(account_no)
            || ',"ifsc_code":'
            || f_json_quote(ifsc_code)
			
            || ',"ddo_code":'
            || NVL(TO_CHAR(ddo_code),'null')
            || ',"office_id":'
            || NVL(TO_CHAR(office_id),'null')
            || ',"treas_code":'
            || f_json_quote(treas_code)
            || ',"source_type":'
            || f_json_quote(source_type)
            || '}'
        INTO l_old
        FROM mst_payee
        WHERE payee_id = p_payee_id;

        UPDATE mst_payee
        SET
            jan_aadhar_id    = NVL(jan_aadhar_id, p_jan_aadhar_id),
            beneficiary_name = NVL(beneficiary_name, p_beneficiary_name),
            mobile_no        = NVL(mobile_no, p_mobile_no),
            state_name       = NVL(state_name, p_state_name),
            district_name    = NVL(district_name, p_district_name),
            ifsc_code        = NVL(ifsc_code, UPPER(p_ifsc_code)),
            account_no       = NVL(account_no, p_account_no),

            ------2006026 Jabir : Update DDO mapping details------------
            ddo_code         = NVL(ddo_code, p_ddo_code),
            office_id        = NVL(office_id, p_office_id),
            treas_code       = NVL(treas_code, p_treas_code),
            source_type      = NVL(source_type, p_source_type),
            -----------------------------------------------------------

            modified_by      = NVL(p_user, USER),
            modified_date    = SYSTIMESTAMP
        WHERE payee_id = p_payee_id;

        p_audit_payee(
            p_payee_id,
            'UPDATE',
            l_old,
            'Payee updated',
            'Payee matched by dedupe',
            p_user
        );

    END IF;

END p_upsert_payee;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_get_departments
    -- Business purpose:
    --   Return departments from MDM so the UI can filter schemes.
    -- Logic:
    --   1. Read active flag.
    --   2. Query MDM dynamically.
    --   3. Build and return JSON.
    --------------------------------------------------------------------------
    PROCEDURE pr_get_departments (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_active_flag VARCHAR2(1);
        l_arr         CLOB := '[';
        l_first       BOOLEAN := TRUE;
        l_cur         SYS_REFCURSOR;
        l_dept_id     NUMBER;
        l_dept_name   VARCHAR2(300);
        l_is_active   VARCHAR2(1);
    BEGIN
        -- Step 1: Default to active departments.
        l_active_flag := f_norm_flag(
            f_json_varchar(p_req, '$.active_flag'),
            'Y'
        );

        -- Step 2: Use dynamic SQL so package can compile without direct MDM grants.
        OPEN l_cur FOR 'select dept_id, dept_name_en, is_active from mdm.mst_department where is_active = :1 order by dept_name_en'
            USING l_active_flag;

        -- Step 3: Convert cursor rows into a JSON array.
        LOOP
            FETCH l_cur INTO
                l_dept_id,
                l_dept_name,
                l_is_active;
            EXIT WHEN l_cur%notfound;
            IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;
            l_arr := l_arr
                     || '{"dept_id":'
                     || l_dept_id
                     || ',"dept_name":'
                     || f_json_quote(l_dept_name)
                     || ',"active_flag":'
                     || f_json_quote(l_is_active)
                     || '}';

            l_first := FALSE;
        END LOOP;

        CLOSE l_cur;

        -- Step 4: Return response.
        p_set_success('{"departments":'
                      || l_arr
                      || ']}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            IF l_cur%isopen THEN
                CLOSE l_cur;
            END IF;
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_get_schemes
    -- Business purpose:
    --   Return active schemes for a department or all active schemes.
    --------------------------------------------------------------------------
    PROCEDURE pr_get_schemes (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS
        l_dept_id NUMBER;
        l_arr     CLOB := '[';
        l_first   BOOLEAN := TRUE;
    BEGIN
        -- Step 1: Read optional department filter.
        l_dept_id := f_json_number(p_req, '$.dept_id');

        -- Step 2: Add matching schemes to response array.
        FOR r IN (
            SELECT
                scheme_id,
                dept_id,
                scheme_code,
                scheme_name,
                scheme_description
            FROM
                mst_scheme
            WHERE
                    dept_id = nvl(l_dept_id, dept_id)
                AND active_flag = 'Y'
            ORDER BY
                scheme_name
        ) LOOP
            IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;
            l_arr := l_arr
                     || '{"scheme_id":'
                     || r.scheme_id
                     || ',"dept_id":'
                     || r.dept_id
                     || ',"scheme_code":'
                     || f_json_quote(r.scheme_code)
                     || ',"scheme_name":'
                     || f_json_quote(r.scheme_name)
                     || ',"scheme_description":'
                     || f_json_quote(r.scheme_description)
                     || '}';

            l_first := FALSE;
        END LOOP;

        -- Step 3: Return response.
        p_set_success('{"schemes":'
                      || l_arr
                      || ']}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_save_scheme
    -- Business purpose:
    --   Upsert a scheme so UI can create a new scheme before mapping/upload.
    --------------------------------------------------------------------------
    PROCEDURE pr_save_scheme (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_scheme_id          NUMBER;
        l_existing_id        NUMBER;
        l_dept_id             NUMBER;  
        l_scheme_code        VARCHAR2(50);
        l_scheme_name        VARCHAR2(200);
        l_scheme_description VARCHAR2(1000);
        l_active_flag        CHAR(1);
        l_user               VARCHAR2(100);
        l_action             VARCHAR2(20);
        l_count              NUMBER;
        l_assignment_id NUMBER;  -----0906026 jabir
        e_exception     EXCEPTION; -----0906026 jabir
    BEGIN
        l_scheme_id := f_json_number(p_req, '$.scheme_id');
        l_dept_id := nvl(
            f_json_number(p_req, '$.dept_id'),
            f_json_number(p_req, '$.department_id')
        );

        l_scheme_code := upper(trim(f_json_varchar(p_req, '$.scheme_code')));
        l_scheme_name := trim(f_json_varchar(p_req, '$.scheme_name'));
        l_scheme_description := f_json_varchar(p_req, '$.scheme_description');
        l_active_flag := f_norm_flag(f_json_varchar(p_req, '$.active_flag'),'Y');
        l_user := nvl(f_json_varchar(p_req, '$.created_by'),
                          nvl(f_json_varchar(p_req, '$.user_id'),user));
-----------------------------0906026 jabir----------------------------------------------------
l_assignment_id := f_json_number(p_req,'$.assignment_id');  
   IF check_user_access(l_assignment_id, 29) = 'S' THEN
    NULL; -- continue processing
ELSE
    p_err_msg := 'User is not authorized.';
    RAISE e_exception;
END IF;
---------------------------0906026-------------------------------------------------
       IF l_dept_id IS NULL
           OR l_scheme_code IS NULL
        OR l_scheme_name IS NULL THEN
            raise_application_error(-20050, 'dept_id, scheme_code and scheme_name are required.');
        END IF;

        IF l_scheme_id IS NOT NULL THEN
            SELECT
                COUNT(*)
            INTO l_count
            FROM
                mst_scheme
            WHERE
                scheme_id = l_scheme_id;

            IF l_count > 0 THEN
                UPDATE mst_scheme
                SET
                    dept_id = l_dept_id,
                    scheme_code = l_scheme_code,
                    scheme_name = l_scheme_name,
                    scheme_description = l_scheme_description,
                    active_flag = l_active_flag,
                    modified_by = l_user,
                    modified_date = systimestamp
                WHERE
                    scheme_id = l_scheme_id;

                l_action := 'UPDATE';
            ELSE
                INSERT INTO mst_scheme (
                    scheme_id,
                    dept_id,
                    scheme_code,
                    scheme_name,
                    scheme_description,
                    active_flag,
                    created_by
                ) VALUES ( l_scheme_id,
                           l_dept_id,
                           l_scheme_code,
                           l_scheme_name,
                           l_scheme_description,
                           l_active_flag,
                           l_user );

                l_action := 'INSERT';
            END IF;

        ELSE
            INSERT INTO mst_scheme (
                dept_id,
                scheme_code,
                scheme_name,
                scheme_description,
                active_flag,
                created_by
            ) VALUES ( l_dept_id,
                       l_scheme_code,
                       l_scheme_name,
                       l_scheme_description,
                       l_active_flag,
                       l_user ) RETURNING scheme_id INTO l_scheme_id;

            l_action := 'INSERT';
        END IF;

        p_audit_scheme_config('MST_SCHEME', l_scheme_id, l_action, NULL, p_req,
                              'Scheme saved', l_user);
        COMMIT;
        p_set_success('{"scheme_id":'
                      || l_scheme_id
                      || ',"action":'
                      || f_json_quote(l_action)
                      || '}',
                      p_resp,
                      p_status,
                      p_err_msg,
                      p_err_code);
-------------------------------------------------------------
EXCEPTION

    WHEN e_exception THEN

        ROLLBACK;

        p_status   := 'W';
        p_err_code := 'IFMS-COREDE-OTS-BENF-ERR-01';
        p_resp     := '{"status":"FAILURE"}';

        BEGIN
            package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_save_scheme',
                p_type        => 1,
                p_ref_no      => l_scheme_id,
                p_err_code    => p_err_code,
                p_err_msg     => p_err_msg,
                p_SEVERITY    => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
            package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_save_scheme',
                p_type        => 1,
                p_ref_no      => l_scheme_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM
                                 || CHR(10)
                                 || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY    => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );

END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_get_scheme_ui_fields
    -- Business purpose:
    --   Return fixed beneficiary fields plus configured scheme custom fields.
    --   UI uses this to draw upload/manual-entry columns and map ATTR fields.
    --------------------------------------------------------------------------
    PROCEDURE pr_get_scheme_ui_fields (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS
        l_scheme_id NUMBER;
        l_arr       CLOB := '[';
        l_first     BOOLEAN := TRUE;
    BEGIN
        -- Step 1: Validate scheme.
        l_scheme_id := f_json_number(p_req, '$.scheme_id');
        p_assert_scheme_exists(l_scheme_id);

        -- Step 2: Return the fixed fields always available in MST_BENEFICIARY.
        FOR r IN (
            SELECT
                *
            FROM
                (
                    SELECT
                        'FIXED'            source_name,
                        'BENEFICIARY_NAME' column_name,
                        'Beneficiary Name' field_name,
                        'TEXT'             field_type,
                        1                  seq
                    FROM
                        dual
                        --05062026--------------------------------
--                    UNION ALL
--                    SELECT
--                        'FIXED',
--                        'AADHAAR_REF_NO',
--                        'Aadhaar Ref No',
--                        'TEXT',
--                        2
--                    FROM
--                        dual
--05062026--------------------------------
                    UNION ALL
                    SELECT
                        'FIXED',
                        'JAN_AADHAR_ID',
                        'Jan Aadhaar ID',
                        'TEXT',
                        3
                    FROM
                        dual
                    UNION ALL
                    SELECT
                        'FIXED',
                        'MOBILE_NO',
                        'Mobile No',
                        'MOBILE',
                        4
                    FROM
                        dual
                    UNION ALL
                    SELECT
                        'FIXED',
                        'STATE_NAME',
                        'State',
                        'TEXT',
                        5
                    FROM
                        dual
                    UNION ALL
                    SELECT
                        'FIXED',
                        'DISTRICT_NAME',
                        'District',
                        'TEXT',
                        6
                    FROM
                        dual
                    UNION ALL
                    SELECT
                        'FIXED',
                        'IFSC_CODE',
                        'IFSC Code',
                        'IFSC',
                        7
                    FROM
                        dual
                    UNION ALL
                    SELECT
                        'FIXED',
                        'ACCOUNT_NO',
                        'Account No',
                        'TEXT',
                        8
                    FROM
                        dual
                    UNION ALL
                    SELECT
                        'FIXED',
                        'AMOUNT',
                        'Amount',
                        'NUMBER',
                        9
                    FROM
                        dual
                     UNION ALL
                    SELECT
                        'FIXED',
                        'INSTALLMENT_NO',
                        'Installment No',
                        'NUMBER',
                        10
                    FROM
                        dual    
                )
            ORDER BY
                seq
        ) LOOP
            IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;
            l_arr := l_arr
                     || '{"source":'
                     || f_json_quote(r.source_name)
                     || ',"column_name":'
                     || f_json_quote(r.column_name)
                     || ',"field_code":'
                     || f_json_quote(r.column_name)
                     || ',"field_name":'
                     || f_json_quote(r.field_name)
                     || ',"field_type":'
                     || f_json_quote(r.field_type)
                     || '}';

            l_first := FALSE;
        END LOOP;

        -- Step 3: Return custom fields mapped for the selected scheme.
        FOR m IN (
            SELECT
                field_code,
                field_name,
                field_type,
                column_name,
                mandatory_flag
            FROM
                mst_scheme_field_mapping
            WHERE
                    scheme_id = l_scheme_id
                AND active_flag = 'Y'
                AND system_defined_flag = 'Y'
            ORDER BY
                display_sequence,
                field_code
        ) LOOP
            IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;
            l_arr := l_arr
                     || '{"source":"SCHEME_MAPPING"'
                     || ',"column_name":'
                     || f_json_quote(m.column_name)
                     || ',"field_code":'
                     || f_json_quote(m.field_code)
                     || ',"field_name":'
                     || f_json_quote(m.field_name)
                     || ',"field_type":'
                     || f_json_quote(m.field_type)
                     || ',"mandatory_flag":'
                     || f_json_quote(m.mandatory_flag)
                     || '}';

            l_first := FALSE;
        END LOOP;

        -- Step 4: Return response.
        p_set_success('{"scheme_id":'
                      || l_scheme_id
                      || ',"fields":'
                      || l_arr
                      || ']}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_get_scheme_field_mapping
    -- Business purpose:
    --   Return configured mapping rows exactly as stored for a scheme.
    --------------------------------------------------------------------------
    PROCEDURE pr_get_scheme_field_mapping (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS
        l_scheme_id NUMBER;
        l_arr       CLOB := '[';
        l_first     BOOLEAN := TRUE;
    BEGIN
        l_scheme_id := f_json_number(p_req, '$.scheme_id');
        p_assert_scheme_exists(l_scheme_id);
        FOR r IN (
            SELECT
                field_code,
                field_name,
                field_type,
                column_name,
                mandatory_flag,
                system_defined_flag,
                display_sequence
            FROM
                mst_scheme_field_mapping
            WHERE
                    scheme_id = l_scheme_id
                AND active_flag = 'Y'
            ORDER BY
                display_sequence,
                field_code
        ) LOOP
            IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;
            l_arr := l_arr
                     || '{"field_code":'
                     || f_json_quote(r.field_code)
                     || ',"field_name":'
                     || f_json_quote(r.field_name)
                     || ',"field_type":'
                     || f_json_quote(r.field_type)
                     || ',"column_name":'
                     || f_json_quote(r.column_name)
                     || ',"mandatory_flag":'
                     || f_json_quote(r.mandatory_flag)
                     || ',"system_defined_flag":'
                     || f_json_quote(r.system_defined_flag)
                     || ',"display_sequence":'
                     || nvl(
                to_char(r.display_sequence),
                'null'
            )
                     || '}';

            l_first := FALSE;
        END LOOP;

        p_set_success('{"scheme_id":'
                      || l_scheme_id
                      || ',"fields":'
                      || l_arr
                      || ']}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_get_template_metadata
    -- Business purpose:
    --   Return template headers/keys plus column metadata for download/upload UI.
    --------------------------------------------------------------------------
    PROCEDURE pr_get_template_metadata (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_scheme_id NUMBER;
        l_cols      CLOB := '[';
        l_headers   CLOB := '[';
        l_keys      CLOB := '[';
        l_first     BOOLEAN := TRUE;
    BEGIN
        l_scheme_id := f_json_number(p_req, '$.scheme_id');
        p_assert_scheme_exists(l_scheme_id);
        FOR r IN (
            WITH fixed_fields AS (
                SELECT
                    'BENEFICIARY_NAME' field_code,
                    'Beneficiary Name' field_name,
                    'TEXT'             field_type,
                    'BENEFICIARY_NAME' column_name,
                    1                  display_sequence
                FROM
                    dual
                UNION ALL
                SELECT
                    'AADHAAR_REF_NO',
                    'Aadhaar Ref No',
                    'TEXT',
                    'AADHAAR_REF_NO',
                    2
                FROM
                    dual
                UNION ALL
                SELECT
                    'JAN_AADHAR_ID',
                    'Jan Aadhaar ID',
                    'TEXT',
                    'JAN_AADHAR_ID',
                    3
                FROM
                    dual
                UNION ALL
                SELECT
                    'MOBILE_NO',
                    'Mobile No',
                    'MOBILE',
                    'MOBILE_NO',
                    4
                FROM
                    dual
                UNION ALL
                SELECT
                    'STATE_NAME',
                    'State',
                    'TEXT',
                    'STATE_NAME',
                    5
                FROM
                    dual
                UNION ALL
                SELECT
                    'DISTRICT_NAME',
                    'District',
                    'TEXT',
                    'DISTRICT_NAME',
                    6
                FROM
                    dual
                UNION ALL
                SELECT
                    'IFSC_CODE',
                    'IFSC Code',
                    'IFSC',
                    'IFSC_CODE',
                    7
                FROM
                    dual
                UNION ALL
                SELECT
                    'ACCOUNT_NO',
                    'Account No',
                    'TEXT',
                    'ACCOUNT_NO',
                    8
                FROM
                    dual
                UNION ALL
                SELECT
                    'AMOUNT',
                    'Amount',
                    'NUMBER',
                    'AMOUNT',
                    9
                FROM
                    dual
            )
            SELECT
                field_code,
                field_name,
                field_type,
                column_name,
                mandatory_flag,
                display_sequence
            FROM
                (
                    SELECT
                        f.field_code,
                        f.field_name,
                        f.field_type,
                        f.column_name,
                        nvl((
                            SELECT
                                MAX(m.mandatory_flag)
                            FROM
                                mst_scheme_field_mapping m
                            WHERE
                                    m.scheme_id = l_scheme_id
                                AND m.active_flag = 'Y'
                                AND(upper(m.field_code) = f.field_code
                                    OR upper(m.column_name) = f.column_name)
                        ),
                            'N') mandatory_flag,
                        f.display_sequence
                    FROM
                        fixed_fields f
                    UNION ALL
                    SELECT
                        m.field_code,
                        m.field_name,
                        m.field_type,
                        m.column_name,
                        m.mandatory_flag,
                        nvl(m.display_sequence, 999999) display_sequence
                    FROM
                        mst_scheme_field_mapping m
                    WHERE
                            m.scheme_id = l_scheme_id
                        AND m.active_flag = 'Y'
                        AND upper(m.column_name) NOT IN ( 'BENEFICIARY_NAME', 'AADHAAR_REF_NO', 'JAN_AADHAR_ID', 'MOBILE_NO', 'STATE_NAME'
                        ,
                                                          'DISTRICT_NAME', 'IFSC_CODE', 'ACCOUNT_NO', 'AMOUNT' )
                )
            ORDER BY
                display_sequence,
                field_code
        ) LOOP
            IF NOT l_first THEN
                l_cols := l_cols || ',';
                l_headers := l_headers || ',';
                l_keys := l_keys || ',';
            END IF;

            l_cols := l_cols
                      || '{"field_code":'
                      || f_json_quote(r.field_code)
                      || ',"field_name":'
                      || f_json_quote(r.field_name)
                      || ',"field_type":'
                      || f_json_quote(r.field_type)
                      || ',"column_name":'
                      || f_json_quote(r.column_name)
                      || ',"mandatory_flag":'
                      || f_json_quote(r.mandatory_flag)
                      || ',"display_sequence":'
                      || nvl(
                to_char(r.display_sequence),
                'null'
            )
                      || '}';

            l_headers := l_headers || f_json_quote(r.field_name);
            l_keys := l_keys || f_json_quote(r.field_code);
            l_first := FALSE;
        END LOOP;

        p_set_success('{"scheme_id":'
                      || l_scheme_id
                      || ',"columns_metadata":'
                      || l_cols
                      || ']'
                      || ',"excel_display_headers":'
                      || l_headers
                      || ']'
                      || ',"excel_upload_keys":'
                      || l_keys
                      || ']}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_save_scheme_validation_policy
    -- Business purpose:
    --   Save scheme-level duplicate and identity rules. If no policy exists for
    --   a scheme, PR_VALIDATE_GROUP skips these policy checks.
    --------------------------------------------------------------------------
    PROCEDURE pr_save_scheme_validation_policy (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS
        l_scheme_id NUMBER;
        l_user      VARCHAR2(100);
    BEGIN
        -- Step 1: Read scheme and user.
        l_scheme_id := f_json_number(p_req, '$.scheme_id');
        l_user := nvl(
            f_json_varchar(p_req, '$.created_by'),
            user
        );
        p_assert_scheme_exists(l_scheme_id);

        -- Step 2: Upsert policy values.
        MERGE INTO mst_scheme_validation_policy t
        USING (
            SELECT
                l_scheme_id scheme_id
            FROM
                dual
        ) s ON ( t.scheme_id = s.scheme_id )
        WHEN MATCHED THEN UPDATE
        SET allow_duplicate_payment_flag = f_norm_flag(
            f_json_varchar(p_req, '$.allow_duplicate_payment_flag'),
            'N'
        ),
            duplicate_payment_scope = nvl(
            upper(f_json_varchar(p_req, '$.duplicate_payment_scope')),
            'SCHEME'
        ),
            allow_multiple_accounts_per_identity_flag = f_norm_flag(
            f_json_varchar(p_req, '$.allow_multiple_accounts_per_identity_flag'),
            'N'
        ),
            allow_same_account_different_identity_flag = f_norm_flag(
            f_json_varchar(p_req, '$.allow_same_account_different_identity_flag'),
            'N'
        ),
            allow_cross_identifier_match_flag = f_norm_flag(
            f_json_varchar(p_req, '$.allow_cross_identifier_match_flag'),
            'N'
        ),
            modified_by = l_user,
            modified_date = systimestamp
        WHEN NOT MATCHED THEN
        INSERT (
            scheme_id,
            allow_duplicate_payment_flag,
            duplicate_payment_scope,
            allow_multiple_accounts_per_identity_flag,
            allow_same_account_different_identity_flag,
            allow_cross_identifier_match_flag,
            active_flag,
            created_by )
        VALUES
            ( l_scheme_id,
              f_norm_flag(
                  f_json_varchar(p_req, '$.allow_duplicate_payment_flag'),
                  'N'
              ),
              nvl(
                  upper(f_json_varchar(p_req, '$.duplicate_payment_scope')),
                  'SCHEME'
              ),
              f_norm_flag(
                  f_json_varchar(p_req, '$.allow_multiple_accounts_per_identity_flag'),
                  'N'
              ),
              f_norm_flag(
                  f_json_varchar(p_req, '$.allow_same_account_different_identity_flag'),
                  'N'
              ),
              f_norm_flag(
                  f_json_varchar(p_req, '$.allow_cross_identifier_match_flag'),
                  'N'
              ),
              'Y',
              l_user );

        -- Step 3: Audit and return.
        p_audit_scheme_config('MST_SCHEME_VALIDATION_POLICY', l_scheme_id, 'UPSERT', NULL, p_req,
                              'Scheme validation policy saved', l_user);
        COMMIT;
        p_set_success('{"scheme_id":'
                      || l_scheme_id
                      || ',"message":"policy saved"}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_save_scheme_field_mapping
    -- Business purpose:
    --   Save scheme custom fields. Custom fields are simple TEXT/NUMBER/DATE
    --   fields and are mapped into ATTR1_VAL..ATTR20_VAL.
    --------------------------------------------------------------------------
    PROCEDURE pr_save_scheme_field_mapping (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_scheme_id          NUMBER;
        l_user               VARCHAR2(100);
        l_count              NUMBER := 0;
        l_custom_count       NUMBER := 0;
        l_mapping_version_no NUMBER := 1;
    BEGIN
        -- Step 1: Read scheme and user.
        l_scheme_id := f_json_number(p_req, '$.scheme_id');
        l_user := nvl(
            f_json_varchar(p_req, '$.created_by'),
            user
        );
        p_assert_scheme_exists(l_scheme_id);
        p_assert_mapping_edit_allowed(l_scheme_id);
        SELECT
            nvl(
                max(mapping_version_no),
                0
            ) + 1
        INTO l_mapping_version_no
        FROM
            mst_scheme_field_mapping_version
        WHERE
            scheme_id = l_scheme_id;

        -- Step 2: Replace existing mapping for simplicity.
        DELETE FROM mst_scheme_field_mapping
        WHERE
            scheme_id = l_scheme_id;

        -- Step 3: Insert new field mappings from the request array.
        FOR r IN (
            SELECT
                field_code,
                field_name,
                upper(field_type)             field_type,
                upper(column_name)            column_name,
                nvl(display_sequence, 999999) display_sequence,
                mandatory_flag,
                system_defined_flag
            FROM
                JSON_TABLE ( p_req, '$.fields[*]'
                    COLUMNS (
                        field_code VARCHAR2 ( 100 ) PATH '$.field_code',
                        field_name VARCHAR2 ( 200 ) PATH '$.field_name',
                        field_type VARCHAR2 ( 30 ) PATH '$.field_type',
                        column_name VARCHAR2 ( 30 ) PATH '$.column_name',
                        display_sequence NUMBER PATH '$.display_sequence',
                        mandatory_flag VARCHAR2 ( 10 ) PATH '$.mandatory_flag',
                        system_defined_flag VARCHAR2 ( 10 ) PATH '$.system_defined_flag'
                    )
                )
        ) LOOP
            -- Step 3a: Keep custom field types simple for maintainability.
            IF
                f_norm_flag(r.system_defined_flag, 'N') = 'N'
                AND r.field_type NOT IN ( 'TEXT', 'NUMBER', 'DATE' )
            THEN
                raise_application_error(-20010, 'Custom field '
                                                || r.field_code
                                                || ' must be TEXT, NUMBER or DATE.');
            END IF;

            -- Step 3b: Store mapping row.
            INSERT INTO mst_scheme_field_mapping (
                scheme_id,
                field_code,
                field_name,
                field_type,
                column_name,
                display_sequence,
                mandatory_flag,
                system_defined_flag,
                active_flag,
                created_by
            ) VALUES ( l_scheme_id,
                       upper(trim(r.field_code)),
                       TRIM(r.field_name),
                       r.field_type,
                       r.column_name,
                       r.display_sequence,
                       f_norm_flag(r.mandatory_flag, 'N'),
                       f_norm_flag(r.system_defined_flag, 'N'),
                       'Y',
                       l_user );

            l_count := l_count + 1;
        END LOOP;

        -- Step 3c: Keep custom field count within ATTR1_VAL..ATTR20_VAL capacity.
        SELECT
            COUNT(*)
        INTO l_custom_count
        FROM
            mst_scheme_field_mapping
        WHERE
                scheme_id = l_scheme_id
            AND active_flag = 'Y'
            AND system_defined_flag = 'N';

        IF l_custom_count > 20 THEN
            raise_application_error(-20011, 'Maximum 20 custom fields are allowed per scheme.');
        END IF;
        UPDATE mst_scheme_field_mapping_version
        SET
            active_flag = 'N',
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
                scheme_id = l_scheme_id
            AND active_flag = 'Y';

        INSERT INTO mst_scheme_field_mapping_version (
            scheme_id,
            mapping_version_no,
            mapping_payload,
            active_flag,
            created_by
        ) VALUES ( l_scheme_id,
                   l_mapping_version_no,
                   p_req,
                   'Y',
                   l_user );

        -- Step 4: Audit and return.
        p_audit_scheme_config('MST_SCHEME_FIELD_MAPPING', l_scheme_id, 'REPLACE', NULL, p_req,
                              'Scheme field mapping replaced', l_user);
        COMMIT;
        p_set_success('{"scheme_id":'
                      || l_scheme_id
                      || ',"mapped_fields":'
                      || l_count
                      || ',"mapping_version_no":'
                      || l_mapping_version_no
                      || '}', p_resp, p_status, p_err_msg, p_err_code);

  --------------------------------------------05062026---------------------------------  
EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
           package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_save_scheme_field_mapping',
                p_type        => 1,
                p_ref_no      => l_scheme_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM || CHR(10) ||
                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY   => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
 END;    
--------------------------------------------05062026---------------------------------  
    --------------------------------------------------------------------------
    -- PROCEDURE: pr_save_field_validation_config
    -- Business purpose:
    --   Save UI labels and validation JSON for fields. If a field has no record,
    --   PR_VALIDATE_GROUP skips extra field-level validation for that field.
    --------------------------------------------------------------------------
    PROCEDURE pr_save_field_validation_config (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS
        l_scheme_id NUMBER;
        l_user      VARCHAR2(100);
        l_count     NUMBER := 0;
    BEGIN
        -- Step 1: Read scope and user. NULL scheme means generic field config.
        l_scheme_id := f_json_number(p_req, '$.scheme_id');
        l_user := nvl(
            f_json_varchar(p_req, '$.created_by'),
            user
        );

        -- Step 2: Replace existing config for that scope.
        DELETE FROM mst_beneficiary_field_validation
        WHERE
            nvl(scheme_id, -1) = nvl(l_scheme_id, -1);

        -- Step 3: Insert field-level validation config rows.
        FOR r IN (
            SELECT
                column_name,
                field_code,
                attr_name,
                attr_label,
                attr_type,
                attr_validation,
                attr_query,
                is_required,
                active_flag,
                display_sequence
            FROM
                JSON_TABLE ( p_req, '$.fields[*]'
                    COLUMNS (
                        column_name VARCHAR2 ( 30 ) PATH '$.column_name',
                        field_code VARCHAR2 ( 100 ) PATH '$.field_code',
                        attr_name VARCHAR2 ( 100 ) PATH '$.attr_name',
                        attr_label VARCHAR2 ( 200 ) PATH '$.attr_label',
                        attr_type VARCHAR2 ( 50 ) PATH '$.attr_type',
                        attr_validation CLOB PATH '$.attr_validation',
                        attr_query CLOB PATH '$.attr_query',
                        is_required VARCHAR2 ( 10 ) PATH '$.is_required',
                        active_flag VARCHAR2 ( 10 ) PATH '$.active_flag',
                        display_sequence NUMBER PATH '$.display_sequence'
                    )
                )
        ) LOOP
            INSERT INTO mst_beneficiary_field_validation (
                scheme_id,
                column_name,
                field_code,
                attr_name,
                attr_label,
                attr_type,
                attr_validation,
                attr_query,
                is_required,
                active_flag,
                display_sequence,
                created_by
            ) VALUES ( l_scheme_id,
                       upper(r.column_name),
                       upper(r.field_code),
                       upper(r.attr_name),
                       r.attr_label,
                       upper(r.attr_type),
                       r.attr_validation,
                       r.attr_query,
                       f_norm_flag(r.is_required, 'N'),
                       f_norm_flag(r.active_flag, 'Y'),
                       r.display_sequence,
                       l_user );

            l_count := l_count + 1;
        END LOOP;

        -- Step 4: Audit and return.
        p_audit_scheme_config('MST_BENEFICIARY_FIELD_VALIDATION', l_scheme_id, 'REPLACE', NULL, p_req,
                              'Field validation config saved', l_user);
        COMMIT;
        p_set_success('{"saved_fields":'
                      || l_count
                      || '}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;
---jabir  1105026
----------------------------------------------------------------------
--Procedure:pr_discard_group_id
---Purpose:Delete existing group_id from all tables where group_id exists
-----------------------------------------------------------------------
    PROCEDURE pr_discard_group_id (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_group_id  NUMBER;
        l_scheme_id NUMBER;
        l_count     NUMBER;
        l_user      VARCHAR2(100);
        l_resp      CLOB;
        l_status    VARCHAR2(20);
        l_err_msg   VARCHAR2(4000);
        l_err_code  VARCHAR2(100);
    BEGIN
        l_group_id := package_bnf_pns.f_json_number(p_req, '$.group_id');
        l_user := nvl(
            package_bnf_pns.f_json_varchar(p_req, '$.created_by'),
            user
        );
        IF l_group_id IS NULL THEN
            raise_application_error(-20001, 'group_id is required');
        END IF;
        SELECT
            COUNT(*)
        INTO l_count
        FROM
            mst_beneficiary_group
        WHERE
            group_id = l_group_id;

        IF l_count = 0 THEN
            raise_application_error(-20002, 'group_id not found');
        END IF;
        SELECT
            scheme_id
        INTO l_scheme_id
        FROM
            mst_beneficiary_group
        WHERE
            group_id = l_group_id;

        dbms_output.put_line('SCHEME_ID : ' || l_scheme_id);
        dbms_output.put_line('OLD GROUP FOUND : ' || l_group_id);
        DELETE FROM stg_mst_beneficiary
        WHERE
            group_id = l_group_id;

        dbms_output.put_line('stg_mst_beneficiary deleted');
        DELETE FROM mst_beneficiary_validation_run
        WHERE
            group_id = l_group_id;

        dbms_output.put_line('mst_beneficiary_validation_run deleted');
        DELETE FROM mst_beneficiary_group_run_details
        WHERE
            group_id = l_group_id;

        dbms_output.put_line('mst_beneficiary_group_run_details deleted');
        DELETE FROM mst_beneficiary
        WHERE
                group_id = l_group_id
            AND scheme_id = l_scheme_id;

        dbms_output.put_line('mst_beneficiary deleted');
        DELETE FROM mst_beneficiary_group_ext
        WHERE
            group_id = l_group_id;

        dbms_output.put_line('mst_beneficiary_group_ext deleted');
        DELETE FROM mst_beneficiary_group
        WHERE
                group_id = l_group_id
            AND scheme_id = l_scheme_id;

        dbms_output.put_line('mst_beneficiary_group deleted');
        COMMIT;
        p_status := 'S';
        p_resp := '{"status":"SUCCESS",'
                  || '"group_id":'
                  || l_group_id
                  || ','
                  || '"scheme_id":'
                  || l_scheme_id
                  || ','
                  || '"message":"Group data deleted successfully"}';

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_status := 'ERROR';
            p_err_msg := sqlerrm;
            p_err_code := to_char(sqlcode);
            p_resp := '{"status":"ERROR","message":"'
                      || replace(sqlerrm, '"', '')
                      || '"}';
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_create_beneficiary_group
    -- Business purpose:
    --   Create a new editable beneficiary group for the bulk flow.
    --------------------------------------------------------------------------
    PROCEDURE pr_create_beneficiary_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_scheme_id                NUMBER;
        l_group_name               VARCHAR2(200);
        l_upload_mode              VARCHAR2(20);
        l_user                     VARCHAR2(100);
        l_group_id                 NUMBER;
        l_upload_hash              VARCHAR2(128);
        l_mapping_version_snapshot NUMBER := 1;
        l_count                    NUMBER;
       ---------------------------15006026  jabir-----------
        l_assignment_id NUMBER;
        l_ddo_code      NUMBER;
        l_office_id     NUMBER;
        l_treas_code    VARCHAR2(20);
       ------------------------------------------------------
        l_docs_name VARCHAR2(255);
    BEGIN
        -- Step 1: Read request values.
        
        l_assignment_id := f_json_number(p_req, '$.assignment_id');----1506026 jabir
        
        l_scheme_id := f_json_number(p_req, '$.scheme_id');
        l_group_name := trim(f_json_varchar(p_req, '$.group_name'));
        l_upload_mode := nvl(
            upper(trim(f_json_varchar(p_req, '$.upload_mode'))),
            'EXCEL'
        );
        

        l_user := nvl(
            f_json_varchar(p_req, '$.created_by'),
            user
        );
        l_upload_hash := f_json_varchar(p_req, '$.upload_hash');
        p_assert_scheme_exists(l_scheme_id);
        l_group_id := f_json_number(p_req, '$.group_id'); --1505026
        l_docs_name := f_json_varchar(p_req, '$.fileName');

        SELECT
            nvl(
                max(mapping_version_no),
                1
            )
        INTO l_mapping_version_snapshot
        FROM
            mst_scheme_field_mapping_version
        WHERE
                scheme_id = l_scheme_id
            AND active_flag = 'Y';
-------------start 1506026 jabir--------------------------------
  BEGIN

    SELECT
        TO_NUMBER(a.assignment_value),
        b.office_id,
        b.treas_code
    INTO
        l_ddo_code,
        l_office_id,
        l_treas_code
        FROM
            vu_sso_user_role a
            JOIN mdm.office_ddo_treasury_map b
            ON b.ddo_code = TO_NUMBER(a.assignment_value)
           AND b.is_active = 'Y'
        WHERE
            a.assignment_id = l_assignment_id;

        EXCEPTION
         WHEN NO_DATA_FOUND THEN
            p_err_msg := 'DDO/Office/Treas_code mapping not found.';
            ---RAISE e_exception;
            END;

---------------------end 1506026---------------------------
        -- Step 2: Create group. The package never changes processed_flag to Y.


        IF l_group_id IS NOT NULL THEN
            SELECT
                COUNT(*)
            INTO l_count
            FROM
                mst_beneficiary_group
            WHERE
                group_id = l_group_id;

            IF l_count > 0 THEN
                UPDATE mst_beneficiary_group
                SET
                    scheme_id = l_scheme_id,
                    group_name = l_group_name,
                    upload_mode = l_upload_mode,
                    modified_by = l_user,
                    modified_date = systimestamp,
                    docs_name = l_docs_name
                WHERE
                    group_id = l_group_id;

                UPDATE mst_beneficiary_group_ext
                SET
                    mapping_version_snapshot = l_mapping_version_snapshot,
                    upload_hash = l_upload_hash,
                    modified_by = l_user,
                    modified_date = systimestamp
                WHERE
                    group_id = l_group_id;

            ELSE
                INSERT INTO mst_beneficiary_group (
                    group_id,
                    scheme_id,
                    group_name,
                    upload_mode,
                    process_status,
                    processed_flag,
                    active_flag,
                    created_by,
                    ddo_code, 
                    office_id,
                    treas_code,
                    docs_name
                ) VALUES (-- l_group_id,ISEQ$$_209284
                 NULL,
                           l_scheme_id,
                           l_group_name,
                           l_upload_mode,
                           'DRAFT',
                           'N',
                           'Y',
                           l_user ,
                           l_ddo_code,
                           l_office_id,
                           l_treas_code,
                           l_docs_name) RETURNING group_id INTO l_group_id;

--                INSERT INTO mst_beneficiary_group_ext (
--                  --  group_id,
--                    mapping_version_snapshot,
--                    upload_hash,
--                    validation_attempt_count,
--                    latest_validation_run_no,
--                    created_by
--                ) VALUES (-- l_group_id,
--                           l_mapping_version_snapshot,
--                           l_upload_hash,
--                           0,
--                           0,
--                           l_user );

            END IF;

        ELSE
            INSERT INTO mst_beneficiary_group (
                group_id,
                scheme_id,
                group_name,
                upload_mode,
                process_status,
                processed_flag,
                active_flag,
                created_by,
                ddo_code,
                office_id,
                treas_code,
                docs_name
            ) VALUES ( NULL,
                       l_scheme_id,
                       l_group_name,
                       l_upload_mode,
                       'DRAFT',
                       'N',
                       'Y',
                       l_user,
                        l_ddo_code,
                        l_office_id,
                        l_treas_code,
                       l_docs_name ) RETURNING group_id INTO l_group_id;

--            INSERT INTO mst_beneficiary_group_ext (
--              --  group_id,
--                mapping_version_snapshot,
--                upload_hash,
--                validation_attempt_count,
--                latest_validation_run_no,
--                created_by
--            ) VALUES (-- l_group_id,
--                       l_mapping_version_snapshot,
--                       l_upload_hash,
--                       0,
--                       0,
--                       l_user );

        END IF;
        -- Step 3: Audit the group creation and store a run snapshot.
        p_insert_group_run_detail(l_group_id, 'CREATE_GROUP', 'DRAFT', l_user, 'Group created');
        p_audit_group(l_group_id, 'INSERT', NULL, p_req, 'Group created',
                      l_user);
        COMMIT;

        -- Step 4: Return new group id.

        p_set_success('{"group_id":'
                      || l_group_id
                      || ',"processed_flag":"N"'
                      || ',"mapping_version_snapshot":'
                      || l_mapping_version_snapshot
                      || ',"upload_hash":'
                      || f_json_quote(l_upload_hash)
                      || '}',
                      p_resp,
                      p_status,
                      p_err_msg,
                      p_err_code);

			
--------------------------------------------05062026---------------------------------  
EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
           package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_create_beneficiary_group',
                p_type        => 1,
                p_ref_no      => l_group_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM || CHR(10) ||
                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY   => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
 END;    
--------------------------------------------05062026---------------------------------  
    --------------------------------------------------------------------------
    -- PROCEDURE: pr_update_group
    -- Business purpose:
    --   Update editable group metadata like name or upload mode.
    --------------------------------------------------------------------------
    PROCEDURE pr_update_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_group_id    NUMBER;
        l_group_name  VARCHAR2(200);
        l_upload_mode VARCHAR2(20);
        l_user        VARCHAR2(100);
        l_old         CLOB;
    BEGIN
        l_group_id := f_json_number(p_req, '$.group_id');
        l_group_name := trim(f_json_varchar(p_req, '$.group_name'));
        l_upload_mode := upper(trim(f_json_varchar(p_req, '$.upload_mode')));
        l_user := nvl(
            f_json_varchar(p_req, '$.modified_by'),
            user
        );
        p_assert_group_exists(l_group_id);
        p_assert_group_editable(l_group_id);
        IF
            l_upload_mode IS NOT NULL
            AND l_upload_mode NOT IN ( 'EXCEL', 'MANUAL', 'COPY' )
        THEN
            raise_application_error(-20051, 'Invalid upload_mode.');
        END IF;

        SELECT
            '{"group_name":'
            || f_json_quote(group_name)
            || ',"upload_mode":'
            || f_json_quote(upload_mode)
            || ',"process_status":'
            || f_json_quote(process_status)
            || '}'
        INTO l_old
        FROM
            mst_beneficiary_group
        WHERE
            group_id = l_group_id;

        UPDATE mst_beneficiary_group
        SET
            group_name = nvl(l_group_name, group_name),
            upload_mode = nvl(l_upload_mode, upload_mode),
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
            group_id = l_group_id;

        p_insert_group_run_detail(l_group_id, 'UPDATE_GROUP', 'UPDATED', l_user, 'Group metadata updated');
        p_audit_group(l_group_id, 'UPDATE', l_old, p_req, 'Group metadata updated',
                      l_user);
        COMMIT;
        p_set_success('{"group_id":'
                      || l_group_id
                      || ',"message":"group updated"}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_rename_beneficiary_group
    -- Business purpose:
    --   Rename an editable group. Both staged and submitted groups can be renamed
    --   until the external downstream module sets processed_flag='Y'.
    --------------------------------------------------------------------------
    PROCEDURE pr_rename_beneficiary_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS
        l_group_id   NUMBER;
        l_group_name VARCHAR2(200);
        l_user       VARCHAR2(100);
        l_old        CLOB;
    BEGIN
        -- Step 1: Read request and ensure group is editable.
        l_group_id := f_json_number(p_req, '$.group_id');
        l_group_name := trim(f_json_varchar(p_req, '$.group_name'));
        l_user := nvl(
            f_json_varchar(p_req, '$.modified_by'),
            user
        );
        p_assert_group_exists(l_group_id);
        p_assert_group_editable(l_group_id);

        -- Step 2: Capture old values for audit.
        SELECT
            '{"group_name":'
            || f_json_quote(group_name)
            || '}'
        INTO l_old
        FROM
            mst_beneficiary_group
        WHERE
            group_id = l_group_id;

        -- Step 3: Rename the group.
        UPDATE mst_beneficiary_group
        SET
            group_name = nvl(l_group_name, group_name),
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
            group_id = l_group_id;

        -- Step 4: Audit and return.
        p_insert_group_run_detail(l_group_id, 'RENAME_GROUP', 'UPDATED', l_user, 'Group renamed');
        p_audit_group(l_group_id, 'UPDATE', l_old, p_req, 'Group renamed',
                      l_user);
        COMMIT;
        p_set_success('{"group_id":'
                      || l_group_id
                      || ',"message":"group renamed"}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_get_beneficiary_groups with pagination concept
    -- Business purpose: b 
    --   Return groups for UI listing and group selection.
    --------------------------------------------------------------------------

--    PROCEDURE pr_get_beneficiary_groups (
--        p_req      IN CLOB,
--        p_resp     OUT CLOB,
--        p_status   OUT VARCHAR2,
--        p_err_msg  OUT VARCHAR2,
--        p_err_code OUT VARCHAR2
--    ) IS
--
--        l_scheme_id           NUMBER;
--        l_dept_id             NUMBER;
--        l_arr                 CLOB := '[';
--        l_arr1                CLOB := '';
--        l_first               BOOLEAN := TRUE;
--        l_total_groups        NUMBER := 0;
--        l_total_beneficiaries NUMBER := 0;
--        l_total_departments   NUMBER := 0;
--        i_last_upload_date    DATE;
--
--    -----------------------------------------------------------------
--    -- Pagination Variables
--    -----------------------------------------------------------------
--
--        l_page_no             NUMBER := 1;
--        l_page_size           NUMBER := 10;
--        l_offset              NUMBER := 0;
--        l_total_records       NUMBER := 0;
--        l_total_pages         NUMBER := 0;
--    BEGIN
--
--    -----------------------------------------------------------------
--    -- Step 1: Read optional filters
--    -----------------------------------------------------------------
--
--        l_scheme_id := f_json_number(p_req, '$.scheme_id');
--        l_dept_id := f_json_number(p_req, '$.dept_id');
--
--    -----------------------------------------------------------------
--    -- Pagination Inputs From UI
--    -----------------------------------------------------------------
--
--        l_page_no := nvl(
--            f_json_number(p_req, '$.pageNumber'),
--            1
--        );
--        IF l_page_no <= 0 THEN
--            l_page_no := 1;
--        END IF;
--
--    -----------------------------------------------------------------
--    -- Page Size From UI
--    -----------------------------------------------------------------
--
--        l_page_size := nvl(
--            f_json_number(p_req, '$.pageSize'),
--            10
--        );
--        IF l_page_size <= 0 THEN
--            l_page_size := 10;
--        END IF;
--
--    -----------------------------------------------------------------
--    -- Offset Calculation
--    -----------------------------------------------------------------
--
--        l_offset := ( l_page_no - 1 ) * l_page_size;
--
--    -----------------------------------------------------------------
--    -- Step 2: Fetch summary counts
--    -----------------------------------------------------------------
--
--        SELECT
--            COUNT(DISTINCT g.group_id),
--            COUNT(b.beneficiary_id),
--            COUNT(DISTINCT s.dept_id),
--            MAX(g.created_date),
--            COUNT(DISTINCT g.group_id)
--        INTO
--            l_total_groups,
--            l_total_beneficiaries,
--            l_total_departments,
--            i_last_upload_date,
--            l_total_records
--        FROM
--            mst_beneficiary_group g
--            LEFT JOIN mst_scheme            s ON s.scheme_id = g.scheme_id
--            LEFT JOIN mst_beneficiary       b ON b.group_id = g.group_id
--        WHERE
--            ( l_scheme_id IS NULL
--              OR s.scheme_id = l_scheme_id )
--            AND ( l_dept_id IS NULL
--                  OR s.dept_id = l_dept_id );
--
--    -----------------------------------------------------------------
--    -- Total Pages
--    -----------------------------------------------------------------
--
--        l_total_pages := ceil(l_total_records / l_page_size);
--
--    -----------------------------------------------------------------
--    -- Step 3: Build summary JSON
--    -----------------------------------------------------------------
--
--        l_arr1 := '{'
--                  || '"total_groups":'
--                  || nvl(
--            to_char(l_total_groups),
--            '0'
--        )
--                  || ',"total_beneficiaries":'
--                  || nvl(
--            to_char(l_total_beneficiaries),
--            '0'
--        )
--                  || ',"total_departments":'
--                  || nvl(
--            to_char(l_total_departments),
--            '0'
--        )
--                  || ',"total_records":'
--                  || nvl(
--            to_char(l_total_records),
--            '0'
--        )
--                  || ',"pageNumber":'
--                  || nvl(
--            to_char(l_page_no),
--            '1'
--        )
--                  || ',"pageSize":'
--                  || nvl(
--            to_char(l_page_size),
--            '10'
--        )
--                  || ',"totalPages":'
--                  || nvl(
--            to_char(l_total_pages),
--            '0'
--        )
--                  || ',"Last_Upload_date":'
--                  || f_json_quote(to_char(i_last_upload_date, 'YYYY-MM-DD HH24:MI:SS'))
--                  || '}';
--
--    -----------------------------------------------------------------
--    -- Step 4: Return paginated group rows
--    -----------------------------------------------------------------
--
--        FOR r IN (
--            SELECT
--                g.group_id,
--                g.scheme_id,
--                s.dept_id,
--                d.dept_name_en,
--                s.scheme_name,
--                g.group_name,
--                g.created_date,
--                g.upload_mode,
--                g.process_status,
--                g.processed_flag,
--                g.active_flag,
--                e.mapping_version_snapshot,
--                e.upload_hash,
--                e.validation_attempt_count,
--                e.latest_validation_run_no,
--                (
--                    SELECT
--                        COUNT(*)
--                    FROM
--                        mst_beneficiary b
--                    WHERE
--                        b.group_id = g.group_id
--                ) AS records_count
--            FROM
--                mst_beneficiary_group     g
--                LEFT JOIN mst_beneficiary_group_ext e ON e.group_id = g.group_id
--                LEFT JOIN mst_scheme                s ON s.scheme_id = g.scheme_id
--                LEFT JOIN mdm.mst_department        d ON d.dept_id = s.dept_id
--            WHERE
--                ( l_scheme_id IS NULL
--                  OR s.scheme_id = l_scheme_id )
--                AND ( l_dept_id IS NULL
--                      OR s.dept_id = l_dept_id )
--            ORDER BY
--                g.created_date DESC
--            OFFSET l_offset ROWS FETCH NEXT l_page_size ROWS ONLY
--        ) LOOP
--            IF NOT l_first THEN
--                l_arr := l_arr || ',';
--            END IF;
--            l_arr := l_arr
--                     || '{'
--                     || '"group_id":'
--                     || nvl(
--                to_char(r.group_id),
--                'null'
--            )
--                     || ',"scheme_id":'
--                     || nvl(
--                to_char(r.scheme_id),
--                'null'
--            )
--                     || ',"dept_id":'
--                     || nvl(
--                to_char(r.dept_id),
--                'null'
--            )
--                     || ',"group_name":'
--                     || f_json_quote(r.group_name)
--                     || ',"scheme_name":'
--                     || f_json_quote(r.scheme_name)
--                     || ',"dept_name":'
--                     || f_json_quote(r.dept_name_en)
--                     || ',"records":'
--                     || nvl(
--                to_char(r.records_count),
--                '0'
--            )
--                     || ',"Last_Upload_date":'
--                     || f_json_quote(to_char(r.created_date, 'YYYY-MM-DD HH24:MI:SS'))
--                     || ',"upload_mode":'
--                     || f_json_quote(r.upload_mode)
--                     || ',"process_status":'
--                     || f_json_quote(r.process_status)
--                     || ',"processed_flag":'
--                     || f_json_quote(r.processed_flag)
--                     || ',"active_flag":'
--                     || f_json_quote(r.active_flag)
--                     || ',"mapping_version_snapshot":'
--                     || nvl(
--                to_char(r.mapping_version_snapshot),
--                'null'
--            )
--                     || ',"upload_hash":'
--                     || f_json_quote(r.upload_hash)
--                     || ',"validation_attempt_count":'
--                     || nvl(
--                to_char(r.validation_attempt_count),
--                '0'
--            )
--                     || ',"latest_validation_run_no":'
--                     || nvl(
--                to_char(r.latest_validation_run_no),
--                '0'
--            )
--                     || '}';
--
--            l_first := FALSE;
--        END LOOP;
--
--        l_arr := l_arr || ']';
--
--    -----------------------------------------------------------------
--    -- Step 5: Final Response
--    -----------------------------------------------------------------
--
--        p_set_success('{'
--                      || '"summary":'
--                      || l_arr1
--                      || ',"groups":'
--                      || l_arr
--                      || '}', p_resp, p_status, p_err_msg, p_err_code);
--
--    EXCEPTION
--        WHEN OTHERS THEN
--            p_err_msg := sqlerrm
--                         || chr(10)
--                         || 'BACKTRACE: '
--                         || dbms_utility.format_error_backtrace
--                         || chr(10)
--                         || 'CALL STACK: '
--                         || dbms_utility.format_call_stack;
--
--            p_set_error(p_err_msg,
--                        to_char(sqlcode),
--                        p_resp,
--                        p_status,
--                        p_err_msg,
--                        p_err_code);
--    END;

------------------------------------------------Start Pravesh,Jabir,Vivek----------------------
PROCEDURE pr_get_beneficiary_groups (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_scheme_id           NUMBER;
        l_dept_id             NUMBER;
        l_valid_rows     CLOB;
        l_invalid_rows   CLOB;
        l_arr                 CLOB := '[';
        l_arr1                CLOB := '';
        l_first               BOOLEAN := TRUE;
        l_total_groups        NUMBER := 0;
        l_total_beneficiaries NUMBER := 0;
        l_total_departments   NUMBER := 0;
        i_last_upload_date    DATE;
         --------Added by pravesh & Vivek 29062026------------------------
        l_type      NUMBER;
      --  l_group_id  NUMBER;

    -----------------------------------------------------------------
    -- Pagination Variables
    -----------------------------------------------------------------

        l_page_no             NUMBER := 1;
        l_page_size           NUMBER := 10;
        l_offset              NUMBER := 0;
        l_total_records       NUMBER := 0;
        l_total_pages         NUMBER := 0;
    BEGIN

    -----------------------------------------------------------------
    -- Step 1: Read optional filters
    -----------------------------------------------------------------

        l_scheme_id := f_json_number(p_req, '$.scheme_id');
        l_dept_id := f_json_number(p_req, '$.dept_id');
         --------Added by pravesh & Vivek 29062026------------------------
        l_type := NVL(f_json_number(p_req, '$.type'),1);
      --  l_group_id := f_json_number(p_req, '$.group_id');
    -----------------------------------------------------------------
    -- Pagination Inputs From UI
    -----------------------------------------------------------------

        l_page_no := nvl(
            f_json_number(p_req, '$.pageNo'),
            1
        );
        IF l_page_no <= 0 THEN
            l_page_no := 1;
        END IF;

    -----------------------------------------------------------------
    -- Page Size From UI
    -----------------------------------------------------------------

        l_page_size := nvl(
            f_json_number(p_req, '$.pageSize'),
            10
        );
        IF l_page_size <= 0 THEN
            l_page_size := 10;
        END IF;

    -----------------------------------------------------------------
    -- Offset Calculation
    -----------------------------------------------------------------

        l_offset := ( l_page_no - 1 ) * l_page_size;

    -----------------------------------------------------------------
    -- Step 2: Fetch summary counts
    -----------------------------------------------------------------
IF l_type = 1 THEN
        SELECT
            COUNT(DISTINCT g.group_id),
            COUNT(b.beneficiary_id),
            COUNT(DISTINCT s.dept_id),
            MAX(g.created_date),
            COUNT(DISTINCT g.group_id)
        INTO
            l_total_groups,
            l_total_beneficiaries,
            l_total_departments,
            i_last_upload_date,
            l_total_records
        FROM
            mst_beneficiary_group g
            LEFT JOIN mst_scheme            s ON s.scheme_id = g.scheme_id
            LEFT JOIN mst_beneficiary       b ON b.group_id = g.group_id
        WHERE
            ( l_scheme_id IS NULL
              OR s.scheme_id = l_scheme_id )
            AND ( l_dept_id IS NULL
                  OR s.dept_id = l_dept_id );

    -----------------------------------------------------------------
    -- Total Pages
    -----------------------------------------------------------------

        l_total_pages := ceil(l_total_records / l_page_size);

    -----------------------------------------------------------------
    -- Step 3: Build summary JSON
    -----------------------------------------------------------------

        l_arr1 := '{'
                  || '"total_groups":'
                  || nvl(
            to_char(l_total_groups),
            '0'
        )
                  || ',"total_beneficiaries":'
                  || nvl(
            to_char(l_total_beneficiaries),
            '0'
        )
                  || ',"total_departments":'
                  || nvl(
            to_char(l_total_departments),
            '0'
        )
                  || ',"total_records":'
                  || nvl(
            to_char(l_total_records),
            '0'
        )
                  || ',"pageNo":'
                  || nvl(
            to_char(l_page_no),
            '1'
        )
                  || ',"pageSize":'
                  || nvl(
            to_char(l_page_size),
            '10'
        )
                  || ',"totalPages":'
                  || nvl(
            to_char(l_total_pages),
            '0'
        )
                  || ',"Last_Upload_date":'
                  || f_json_quote(to_char(i_last_upload_date, 'YYYY-MM-DD HH24:MI:SS'))
                  || '}';
END IF;
    -----------------------------------------------------------------
    -- Step 4: Return paginated group rows
    -----------------------------------------------------------------
IF l_type = 1 THEN --------Added by pravesh & Vivek 29062026------------------------

        FOR r IN (
            SELECT
                g.group_id,
                g.scheme_id,
                s.dept_id,
                d.dept_name_en,
                s.scheme_name,
                g.group_name,
                g.created_date,
                g.upload_mode,
                g.process_status,
                g.processed_flag,
                g.active_flag,
                e.mapping_version_snapshot,
                e.upload_hash,
                e.validation_attempt_count,
                e.latest_validation_run_no,
                g.DOCS_NAME,
               (
                    SELECT COUNT(*)
                    FROM stg_mst_beneficiary b
                    WHERE b.group_id = g.group_id
                      AND b.validation_status = 'VALID'
                ) AS valid_records,
                
                (
                    SELECT COUNT(*)
                    FROM stg_mst_beneficiary b
                    WHERE b.group_id = g.group_id
                      AND b.validation_status = 'INVALID'
                ) AS invalid_records
               
            FROM
                mst_beneficiary_group     g
                LEFT JOIN mst_beneficiary_group_ext e ON e.group_id = g.group_id
                LEFT JOIN mst_scheme                s ON s.scheme_id = g.scheme_id
                LEFT JOIN mdm.mst_department        d ON d.dept_id = s.dept_id
            WHERE
                ( l_scheme_id IS NULL
                  OR s.scheme_id = l_scheme_id )
                AND ( l_dept_id IS NULL
                      OR s.dept_id = l_dept_id )
            ORDER BY
                g.created_date DESC
            OFFSET l_offset ROWS FETCH NEXT l_page_size ROWS ONLY
        ) LOOP
            IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;
            l_arr := l_arr
                     || '{'
                     || '"group_id":'
                     || nvl(
                to_char(r.group_id),
                'null'
            )
                     || ',"scheme_id":'
                     || nvl(
                to_char(r.scheme_id),
                'null'
            )
                     || ',"dept_id":'
                     || nvl(
                to_char(r.dept_id),
                'null'
            )
                     || ',"group_name":'
                     || f_json_quote(r.group_name)
                     || ',"scheme_name":'
                     || f_json_quote(r.scheme_name)
                     || ',"dept_name":'
                     || f_json_quote(r.dept_name_en)
--                     || ',"records":'
--                     || nvl(
--                to_char(r.records_count),
--                '0'
--            )
                    || ',"valid_records":'
                    || nvl(to_char(r.valid_records),'0')
                    || ',"invalid_records":'
                    || nvl(to_char(r.invalid_records),'0')
                   || ',"valid_rows":'
                    || COALESCE(l_valid_rows, TO_CLOB('[]'))
                    || ',"invalid_rows":'
                    || COALESCE(l_invalid_rows, TO_CLOB('[]'))
                     || ',"Last_Upload_date":'
                     || f_json_quote(to_char(r.created_date, 'YYYY-MM-DD HH24:MI:SS'))
                     || ',"upload_mode":'
                     || f_json_quote(r.upload_mode)
                     || ',"process_status":'
                     || f_json_quote(r.process_status)
                     || ',"processed_flag":'
                     || f_json_quote(r.processed_flag)
                     || ',"active_flag":'
                     || f_json_quote(r.active_flag)
                     || ',"mapping_version_snapshot":'
                     || nvl(
                to_char(r.mapping_version_snapshot),
                'null'
            )
                     || ',"upload_hash":'
                     || f_json_quote(r.upload_hash)
                     || ',"validation_attempt_count":'
                     || nvl(
                to_char(r.validation_attempt_count),
                '0'
            )
                     || ',"latest_validation_run_no":'
                     || nvl(
                to_char(r.latest_validation_run_no),
                '0'
            )
             || ',"DOCS_NAME":'
                     ||f_json_quote(r.DOCS_NAME)
                     || '}';

            l_first := FALSE;
        END LOOP;

        l_arr := l_arr || ']';
   --------Added by pravesh & Vivek 29062026------------------------
   ELSIF l_type = 2 THEN

    l_arr := '[';
    l_first := TRUE;
      FOR r IN (
             SELECT distinct---pravesh
                g.group_id,
                g.scheme_id,
                g.group_name,
                m.scheme_name,
                g.created_date,
                g.upload_mode,
                g.process_status,
                g.processed_flag,
                g.active_flag 
            FROM
                mst_beneficiary_group     g
              inner join stg_mst_beneficiary s
              on g.group_id=s.group_id
              inner join mst_payee p
              on s.payee_id=p.payee_id
              inner join mst_scheme m
              on g.scheme_id=m.scheme_id
              where g.PROCESS_STATUS='SUBMITTED'
            ORDER BY
                g.created_date DESC
            OFFSET l_offset ROWS FETCH NEXT l_page_size ROWS ONLY
        ) LOOP
              IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;
            l_arr := l_arr
                     || '{'
                     || '"group_id":'
                     || nvl(
                to_char(r.group_id),
                'null'
            )     
                     || ',"group_name":'
                     || package_bnf_pns.f_json_quote(r.group_name)
                     || ',"scheme_id":'
                     || package_bnf_pns.f_json_quote(r.scheme_id)
                     || ',"scheme_name":'
                     || package_bnf_pns.f_json_quote(r.scheme_name)
                     || ',"upload_mode":'
                     || package_bnf_pns.f_json_quote(r.upload_mode)
                     || ',"process_status":'
                     || package_bnf_pns.f_json_quote(r.process_status)
                     || ',"processed_flag":'
                     || package_bnf_pns.f_json_quote(r.processed_flag)
                     || ',"active_flag":'
                     || package_bnf_pns.f_json_quote(r.active_flag)     
                     || '}';

            l_first := FALSE;
        END LOOP;

        l_arr := l_arr || ']';
        
END IF;
 --------Ended by pravesh & Vivek 29062026------------------------
    -----------------------------------------------------------------
    -- Step 5: Final Response
    -----------------------------------------------------------------

        IF l_type = 1 THEN

                        p_set_success(
                            '{'
                            || '"summary":'
                            || l_arr1
                            || ',"groups":'---beneficiaries
                            || l_arr
                            || '}',
                            p_resp,
                            p_status,
                            p_err_msg,
                            p_err_code
                        );
                    
                    ELSIF l_type = 2 THEN      
                    
                        p_set_success(
                            '{"groups":'---groups
                            || l_arr
                            || '}',
                            p_resp,
                            p_status,
                            p_err_msg,
                            p_err_code
                        );
                    
                    END IF;

    EXCEPTION
        WHEN OTHERS THEN
            p_err_msg := sqlerrm
                         || chr(10)
                         || 'BACKTRACE: '
                         || dbms_utility.format_error_backtrace
                         || chr(10)
                         || 'CALL STACK: '
                         || dbms_utility.format_call_stack;

            p_set_error(p_err_msg,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

-----------------------------------------------End Pravesh,Jabir,Vivek----------------------
    --------------------------------------------------------------------------
    -- PROCEDURE: pr_get_groups
    -- Business purpose:
    --   Alias for PR_GET_BENEFICIARY_GROUPS to match simplified API naming.
    --------------------------------------------------------------------------
    PROCEDURE pr_get_groups (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS
    BEGIN
        pr_get_beneficiary_groups(p_req, p_resp, p_status, p_err_msg, p_err_code);
    END pr_get_groups;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_search_payees
    -- Business purpose:
    --   Search existing payees so UI can add payees to a group.
    --------------------------------------------------------------------------
--    PROCEDURE pr_search_payees (
--        p_req      IN CLOB,
--        p_resp     OUT CLOB,
--        p_status   OUT VARCHAR2,
--        p_err_msg  OUT VARCHAR2,
--        p_err_code OUT VARCHAR2
--    ) IS
--        l_search VARCHAR2(200);
--        l_arr    CLOB := '[';
--        l_first  BOOLEAN := TRUE;
--    BEGIN
--        -- Step 1: Read search text.
--        l_search := upper(trim(f_json_varchar(p_req, '$.search_text')));
--
--        -- Step 2: Search by name, account, mobile, Aadhaar ref or Jan Aadhaar.
--        FOR r IN (
--            SELECT
--                payee_id,
--                beneficiary_name,
--                account_no,
--                ifsc_code,
--                mobile_no,
--                aadhaar_ref_no,
--                jan_aadhar_id
--            FROM
--                mst_payee
--            WHERE
--                    active_flag = 'Y'
--                AND ( l_search IS NULL
--                      OR upper(beneficiary_name) LIKE '%'
--                      || l_search
--                      || '%'
--                         OR upper(account_no) LIKE '%'
--                      || l_search
--                      || '%'
--                         OR upper(mobile_no) LIKE '%'
--                      || l_search
--                      || '%'
--                         OR upper(aadhaar_ref_no) LIKE '%'
--                      || l_search
--                      || '%'
--                         OR upper(jan_aadhar_id) LIKE '%'
--                                                      || l_search
--                                                      || '%' )
--            ORDER BY
--                beneficiary_name
--            FETCH FIRST 50 ROWS ONLY
--        ) LOOP
--            IF NOT l_first THEN
--                l_arr := l_arr || ',';
--            END IF;
--            l_arr := l_arr
--                     || '{"payee_id":'
--                     || r.payee_id
--                     || ',"beneficiary_name":'
--                     || f_json_quote(r.beneficiary_name)
--                     || ',"account_no":'
--                     || f_json_quote(r.account_no)
--                     || ',"ifsc_code":'
--                     || f_json_quote(r.ifsc_code)
--                     || ',"mobile_no":'
--                     || f_json_quote(r.mobile_no)
--                     || ',"aadhaar_ref_masked":'
--                     || f_json_quote(f_mask_value(r.aadhaar_ref_no))
--                     || ',"jan_aadhar_masked":'
--                     || f_json_quote(f_mask_value(r.jan_aadhar_id))
--                     || '}';
--
--            l_first := FALSE;
--        END LOOP;
--
--        -- Step 3: Return payee matches.
--        p_set_success('{"payees":'
--                      || l_arr
--                      || ']}', p_resp, p_status, p_err_msg, p_err_code);
--
--    EXCEPTION
--        WHEN OTHERS THEN
--            p_set_error(sqlerrm,
--                        to_char(sqlcode),
--                        p_resp,
--                        p_status,
--                        p_err_msg,
--                        p_err_code);
--    END;

------Added pravesh & Vivek 24062026-------------------------

PROCEDURE pr_search_payees (
    p_req      IN CLOB,
    p_resp     OUT CLOB,
    p_status   OUT VARCHAR2,
    p_err_msg  OUT VARCHAR2,
    p_err_code OUT VARCHAR2
) IS
    l_search            VARCHAR2(200);
    l_page_no           NUMBER := 1;
    l_page_size         NUMBER := 10;
    l_offset            NUMBER := 0;
    l_arr               CLOB := '[';
    l_first             BOOLEAN := TRUE;
    l_total_valid_count NUMBER := 0;
    l_source_type       VARCHAR2(20);
BEGIN

    l_search := TRIM(f_json_varchar(p_req, '$.search_text'));
    l_source_type := UPPER(TRIM(f_json_varchar(p_req, '$.source_type')));

    l_page_no := NVL(f_json_number(p_req, '$.pageNo'),1);
    IF l_page_no <= 0 THEN
        l_page_no := 1;
    END IF;

    l_page_size := NVL(f_json_number(p_req, '$.pageSize'),10);
    IF l_page_size <= 0 THEN
        l_page_size := 10;
    END IF;

    l_offset := (l_page_no-1) * l_page_size;

    ------------------------------------------------------------------
    -- SINGLE PAYEE
    ------------------------------------------------------------------
    IF l_source_type = 'SINGLE' THEN

        SELECT COUNT(*)
        INTO l_total_valid_count
        FROM mst_payee p
        WHERE p.active_flag='Y'
          AND p.source_type='SINGLE'
          AND (
                l_search IS NULL
                OR UPPER(TRIM(p.beneficiary_name)) = UPPER(TRIM(l_search))
                OR TO_CHAR(p.account_no)=TRIM(l_search)
                OR TO_CHAR(p.mobile_no)=TRIM(l_search)
                OR TO_CHAR(p.jan_aadhar_id)=TRIM(l_search)
                OR TO_CHAR(p.payee_id)=TRIM(l_search)
              );

        FOR r IN
        (
            SELECT
                p.payee_id,
                p.beneficiary_name,
                p.office_id,
                p.account_no,
                p.ifsc_code,
                p.mobile_no,
                p.jan_aadhar_id
            FROM mst_payee p
            WHERE p.active_flag='Y'
              AND p.source_type='SINGLE'
              AND (
                    l_search IS NULL
                    OR UPPER(TRIM(p.beneficiary_name)) = UPPER(TRIM(l_search))
                    OR TO_CHAR(p.account_no)=TRIM(l_search)
                    OR TO_CHAR(p.mobile_no)=TRIM(l_search)
                    OR TO_CHAR(p.jan_aadhar_id)=TRIM(l_search)
                    OR TO_CHAR(p.payee_id)=TRIM(l_search)
                  )
            ORDER BY p.beneficiary_name
            OFFSET l_offset ROWS
            FETCH NEXT l_page_size ROWS ONLY
        )
        LOOP

            IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;

            l_arr := l_arr ||
            '{'||
            '"payee_id":'||r.payee_id||
            ',"beneficiary_name":'||f_json_quote(r.beneficiary_name)||
            ',"office_id":'||NVL(TO_CHAR(r.office_id),'null')||
            ',"account_no":'||f_json_quote(r.account_no)||
            ',"ifsc_code":'||f_json_quote(r.ifsc_code)||
            ',"mobile_no":'||f_json_quote(r.mobile_no)||
            ',"jan_aadhar_id":'||f_json_quote(r.jan_aadhar_id)||
            '}';

            l_first := FALSE;

        END LOOP;

    ------------------------------------------------------------------
    -- GROUP PAYEE
    ------------------------------------------------------------------
    ELSif l_source_type = 'BULK' THEN

        SELECT COUNT(DISTINCT p.payee_id)
        INTO l_total_valid_count
        FROM mst_payee p
        JOIN stg_mst_beneficiary a
          ON a.payee_id=p.payee_id
        WHERE p.active_flag='Y'
          AND a.validation_status='VALID'
          AND (
                l_search IS NULL
                OR UPPER(TRIM(p.beneficiary_name)) = UPPER(TRIM(l_search))
                OR TO_CHAR(p.account_no)=TRIM(l_search)
                OR TO_CHAR(p.mobile_no)=TRIM(l_search)
                OR TO_CHAR(p.jan_aadhar_id)=TRIM(l_search)
                OR TO_CHAR(p.payee_id)=TRIM(l_search)
              );

        FOR r IN
        (
            SELECT
                p.payee_id,
                p.beneficiary_name,
                p.office_id,
                p.account_no,
                p.ifsc_code,
                p.mobile_no,
                p.jan_aadhar_id,
                a.amount,
                a.stage_row_id,
                a.installment_no,
                a.row_no,
                a.validation_status,
                a.row_status
            FROM mst_payee p
            JOIN stg_mst_beneficiary a
              ON a.payee_id=p.payee_id
            WHERE p.active_flag='Y'
              AND a.validation_status='VALID'
              AND (
                    l_search IS NULL
                    OR UPPER(TRIM(p.beneficiary_name)) = UPPER(TRIM(l_search))
                    OR TO_CHAR(p.account_no)=TRIM(l_search)
                    OR TO_CHAR(p.mobile_no)=TRIM(l_search)
                    OR TO_CHAR(p.jan_aadhar_id)=TRIM(l_search)
                    OR TO_CHAR(p.payee_id)=TRIM(l_search)
                  )
            ORDER BY p.beneficiary_name
            OFFSET l_offset ROWS
            FETCH NEXT l_page_size ROWS ONLY
        )
        LOOP

            IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;

            l_arr := l_arr ||
            '{'||
            '"payee_id":'||r.payee_id||
            ',"beneficiary_name":'||f_json_quote(r.beneficiary_name)||
            ',"office_id":'||NVL(TO_CHAR(r.office_id),'null')||
            ',"account_no":'||f_json_quote(r.account_no)||
            ',"ifsc_code":'||f_json_quote(r.ifsc_code)||
            ',"mobile_no":'||f_json_quote(r.mobile_no)||
            ',"jan_aadhar_id":'||f_json_quote(r.jan_aadhar_id)||
            ',"amount":'||NVL(TO_CHAR(r.amount),'null')||
            ',"stage_row_id":'||NVL(TO_CHAR(r.stage_row_id),'null')||
            ',"installment_no":'||NVL(TO_CHAR(r.installment_no),'null')||
            ',"row_no":'||NVL(TO_CHAR(r.row_no),'null')||
            ',"validation_status":'||f_json_quote(r.validation_status)||
            ',"row_status":'||f_json_quote(r.row_status)||
            '}';

            l_first := FALSE;

        END LOOP;

    END IF;

    l_arr := l_arr || ']';

    p_set_success(
        '{"total_valid_count":'||l_total_valid_count||
        ',"payees":'||l_arr||'}',
        p_resp,
        p_status,
        p_err_msg,
        p_err_code
    );

EXCEPTION
    WHEN OTHERS THEN
        p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
END pr_search_payees;

------Ended pravesh & Vivek 24062026-------------------------
    --------------------------------------------------------------------------
    -- PROCEDURE: pr_get_group_beneficiaries
    -- Business purpose:
    --   Return editable group members from staging for UI correction/removal/move.
    --------------------------------------------------------------------------

    
--PROCEDURE pr_get_group_beneficiaries (
--        p_req      IN CLOB,
--        p_resp     OUT CLOB,
--        p_status   OUT VARCHAR2,
--        p_err_msg  OUT VARCHAR2,
--        p_err_code OUT VARCHAR2
--    ) IS
--        l_type     NUMBER;  ---2306026 Jabir----
--        l_group_id NUMBER;
--        l_arr      CLOB := '[';
--        l_first    BOOLEAN := TRUE;
--        
--    BEGIN
--    -----------------------------2306026 Jabir start -------------------------------
--    
--        l_type := NVL(f_json_number(p_req, '$.type'), 1);   
--        
--            IF l_type = 2 THEN
--
--        pr_get_individual_beneficiaries(
--            p_req      => p_req,
--            p_resp     => p_resp,
--            p_status   => p_status,
--            p_err_msg  => p_err_msg,
--            p_err_code => p_err_code
--        );
--
--        RETURN;
--        
--  elsif l_type = 1 THEN 
--  
--    --------------------------------2306026 Jabir end ---------------------------------------------
--        -- Step 1: Read and validate group.
--        l_group_id := f_json_number(p_req, '$.group_id');
--        p_assert_group_exists(l_group_id);
--
--        -- Step 2: Return stage rows.
--        FOR r IN (
--            SELECT
--                stage_row_id,
--                row_no,
--                row_status,
--                validation_status,
--                beneficiary_name,
--                account_no,
--                ifsc_code,
--                mobile_no,
--                aadhaar_ref_no,
--                jan_aadhar_id,
--                amount,
--                installment_no,
--				payee_id
--            FROM
--                stg_mst_beneficiary
--            WHERE
--                group_id = l_group_id
--				----AND PAYEE_ID IS NOT NULL
--            ORDER BY
--                row_no
--        ) LOOP
--            IF NOT l_first THEN
--                l_arr := l_arr || ',';
--            END IF;
--            l_arr := l_arr
--                     || '{"stage_row_id":'
--                     || r.stage_row_id
--                     || ',"row_no":'
--                     || r.row_no
--                     || ',"row_status":'
--                     || f_json_quote(r.row_status)
--                     || ',"validation_status":'
--                     || f_json_quote(r.validation_status)
--                     || ',"beneficiary_name":'
--                     || f_json_quote(r.beneficiary_name)
--                     || ',"account_no":'
--                     || f_json_quote(r.account_no)
--                     || ',"ifsc_code":'
--                     || f_json_quote(r.ifsc_code)
--                     || ',"mobile_no":'
--                     || f_json_quote(r.mobile_no)
----                     || ',"aadhaar_ref_masked":'  --------------25052026 remove mask
----                     || f_json_quote(f_mask_value(r.aadhaar_ref_no))
----                     || ',"jan_aadhar_masked":'
----                     || f_json_quote(f_mask_value(r.jan_aadhar_id))
--                     || ',"aadhaar_ref_no":'
--                     || f_json_quote(r.aadhaar_ref_no)
--                     || ',"jan_aadhar_id":'
--                     || f_json_quote(r.jan_aadhar_id)
--                     || ',"amount":'
--                     || nvl(
--                to_char(r.amount),
--                'null'
--            )
--             || ',"installment_no":'
--                     || to_char(nvl(r.installment_no,0))
--			 || ',"payee_id":'
--                     || to_char(nvl(r.payee_id,0))
--                     || '}';
--
--            l_first := FALSE;
--        END LOOP;
--
--        -- Step 3: Return group members.
--        p_set_success('{"group_id":'
--                      || l_group_id
--                      || ',"beneficiaries":'
--                      || l_arr
--                      || ']}', p_resp, p_status, p_err_msg, p_err_code);
--                      
--          END IF;
--
--    EXCEPTION
--        WHEN OTHERS THEN
--            p_set_error(sqlerrm,
--                        to_char(sqlcode),
--                        p_resp,
--                        p_status,
--                        p_err_msg,
--                        p_err_code);
--                        
--    END pr_get_group_beneficiaries;



PROCEDURE pr_get_group_beneficiaries (
    p_req      IN CLOB,
    p_resp     OUT CLOB,
    p_status   OUT VARCHAR2,
    p_err_msg  OUT VARCHAR2,
    p_err_code OUT VARCHAR2
) IS
    l_type     NUMBER;
    l_group_id NUMBER;
    l_count    NUMBER;
    l_arr      CLOB := '[';
    l_first    BOOLEAN := TRUE;
BEGIN

    l_type := NVL(f_json_number(p_req, '$.type'), 1);

    l_group_id := f_json_number(p_req, '$.group_id');
    --p_assert_group_exists(l_group_id);---------------Commented by pravesh and Jabir for single benefeciary view screen

    ------------------------------------------------------------------
    -- TYPE = 2 (Only VALID beneficiaries with PAYEE_ID)
    ------------------------------------------------------------------
      IF l_type = 2  THEN

        pr_get_individual_beneficiaries(
            p_req      => p_req,
            p_resp     => p_resp,
            p_status   => p_status,
            p_err_msg  => p_err_msg,
            p_err_code => p_err_code
        );

        RETURN;
    
    ------------------------------------------------------------------
    -- TYPE = 3 (New Logic) Added by pravesh 23062026
    ------------------------------------------------------------------

     ELSIF l_type = 3 THEN
         p_assert_group_exists(l_group_id);
                    SELECT COUNT(*)
                INTO l_count
                FROM stg_mst_beneficiary a
                INNER JOIN mst_payee b
                ON a.payee_id = b.payee_id
                WHERE a.group_id = l_group_id;
                
                IF l_count = 0 THEN
                    p_set_error(
                        'No beneficiaries found for this group.',
                        'NO_DATA_FOUND',
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code
                    );
                    RETURN;
                END IF;
   
 
        FOR r IN (
            SELECT
                                a.stage_row_id,
                                a.row_no,
                                a.row_status,
                                a.validation_status,
                                a.beneficiary_name,
                                a.account_no,
                                a.ifsc_code,
                                a.mobile_no,
                                --a.aadhaar_ref_no,
                                a.jan_aadhar_id,
                                a.amount,
                                a.installment_no,
                                b.payee_id,
                                b.office_id
                            FROM stg_mst_beneficiary a
                            INNER JOIN mst_payee b
--                                ON a.account_no = b.account_no
--                               AND a.ifsc_code = b.ifsc_code
                               on a.payee_id=b.payee_id
                            WHERE a.group_id = l_group_id
                            ORDER BY a.row_no
        ) LOOP

            IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;

            l_arr := l_arr
                     || '{"stage_row_id":'
                     || r.stage_row_id
                     || ',"row_no":'
                     || r.row_no
                     || ',"row_status":'
                     || f_json_quote(r.row_status)
                     || ',"validation_status":'
                     || f_json_quote(r.validation_status)
                     || ',"beneficiary_name":'
                     || f_json_quote(r.beneficiary_name)
                     || ',"account_no":'
                     || f_json_quote(r.account_no)
                     || ',"ifsc_code":'
                     || f_json_quote(r.ifsc_code)
                     || ',"mobile_no":'
                     || f_json_quote(r.mobile_no)
--                     || ',"aadhaar_ref_no":'
--                     || f_json_quote(r.aadhaar_ref_no)
                     || ',"jan_aadhar_id":'
                     || f_json_quote(r.jan_aadhar_id)
                     || ',"amount":'
                     || NVL(TO_CHAR(r.amount), 'null')
                     || ',"installment_no":'
                     || TO_CHAR(NVL(r.installment_no, 0))
                     || ',"payee_id":'
                     || TO_CHAR(r.payee_id)
                      || ',"office_id":'
                     || TO_CHAR(r.office_id)
                     || '}';

            l_first := FALSE;

        END LOOP;

        p_set_success(
            '{"group_id":'
            || l_group_id
            || ',"beneficiaries":'
            || l_arr
            || ']}',
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );

------------------------------------------------------------------
    -- TYPE = 3 (New Logic) Added by pravesh 23062026
    ------------------------------------------------------------------
    
    ------------------------------------------------------------------
    -- TYPE = 1 (Existing Logic)
    ------------------------------------------------------------------
    
     ELSIF l_type = 1 THEN
     p_assert_group_exists(l_group_id);
                SELECT COUNT(*)
            INTO l_count
            FROM stg_mst_beneficiary
            WHERE group_id = l_group_id;
            
            IF l_count = 0 THEN
                p_set_error(
                    'No beneficiaries found for this group.',
                    'NO_DATA_FOUND',
                    p_resp,
                    p_status,
                    p_err_msg,
                    p_err_code
                );
                RETURN;
            END IF;
   
        l_arr := '[';
        l_first := TRUE;

       FOR r IN (
            SELECT
                stage_row_id,
                row_no,
                row_status,
                validation_status,
                beneficiary_name,
                account_no,
                ifsc_code,
                mobile_no,
                aadhaar_ref_no,
                jan_aadhar_id,
                amount,
                installment_no,
				payee_id
            FROM
                stg_mst_beneficiary
            WHERE
                group_id = l_group_id
				----AND PAYEE_ID IS NOT NULL
            ORDER BY
                row_no
        ) LOOP
            IF NOT l_first THEN
                l_arr := l_arr || ',';
            END IF;
            l_arr := l_arr
                     || '{"stage_row_id":'
                     || r.stage_row_id
                     || ',"row_no":'
                     || r.row_no
                     || ',"row_status":'
                     || f_json_quote(r.row_status)
                     || ',"validation_status":'
                     || f_json_quote(r.validation_status)
                     || ',"beneficiary_name":'
                     || f_json_quote(r.beneficiary_name)
                     || ',"account_no":'
                     || f_json_quote(r.account_no)
                     || ',"ifsc_code":'
                     || f_json_quote(r.ifsc_code)
                     || ',"mobile_no":'
                     || f_json_quote(r.mobile_no)
--                     || ',"aadhaar_ref_masked":'  --------------25052026 remove mask
--                     || f_json_quote(f_mask_value(r.aadhaar_ref_no))
--                     || ',"jan_aadhar_masked":'
--                     || f_json_quote(f_mask_value(r.jan_aadhar_id))
                     || ',"aadhaar_ref_no":'
                     || f_json_quote(r.aadhaar_ref_no)
                     || ',"jan_aadhar_id":'
                     || f_json_quote(r.jan_aadhar_id)
                     || ',"amount":'
                     || nvl(
                to_char(r.amount),
                'null'
            )
             || ',"installment_no":'
                     || to_char(nvl(r.installment_no,0))
			 || ',"payee_id":'
                     || to_char(nvl(r.payee_id,0))
                     || '}';

            l_first := FALSE;
        END LOOP;


        p_set_success(
            '{"group_id":'
            || l_group_id
            || ',"beneficiaries":'
            || l_arr
            || ']}',
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );

    END IF;

EXCEPTION
    WHEN OTHERS THEN
        p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
END pr_get_group_beneficiaries;
    
    --------------------------------------------------------------------------
    -- PROCEDURE: pr_add_payees_to_group
    -- Business purpose:
    --   Add already saved payees to an editable group.
    --------------------------------------------------------------------------
    PROCEDURE pr_add_payees_to_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_group_id      NUMBER;
        l_user          VARCHAR2(100);
        l_base_row_no   NUMBER;
        l_count         NUMBER := 0;
        l_exists        NUMBER := 0;
        l_skipped_count NUMBER := 0;
    BEGIN 
-----------------------------------------------------------------
-- Step 1: Read group and verify editability.
------------------------------------------------------------------
        l_group_id := f_json_number(p_req, '$.group_id');
        l_user := nvl(
            f_json_varchar(p_req, '$.created_by'),
            user
        );
        p_assert_group_exists(l_group_id);
        p_assert_group_editable(l_group_id);
------------------------------------------------------------------
-- Step 2: Determine next row number.
------------------------------------------------------------------
        SELECT
            nvl(
                max(row_no),
                0
            )
        INTO l_base_row_no
        FROM
            stg_mst_beneficiary
        WHERE
            group_id = l_group_id;
------------------------------------------------------------------
  -- Step 3: Insert one stage row per selected payee.
------------------------------------------------------------------
        FOR r IN (
            SELECT
                p.payee_id,
                p.beneficiary_name,
                p.aadhaar_ref_no,
                p.jan_aadhar_id,
                p.mobile_no,
                p.state_name,
                p.district_name,
                p.ifsc_code,
                p.account_no
            FROM
                         JSON_TABLE ( p_req, '$.payees[*]'
                        COLUMNS (
                            payee_id NUMBER PATH '$.payee_id'
                        )
                    )
                jt
                JOIN mst_payee p ON p.payee_id = jt.payee_id
        ) LOOP 
  ------------------------------------------------------------------
  -- NEW VALIDATION:DO NOT ALLOW SAME PAYEE IN SAME GROUP  ----2505026 jabir
  ------------------------------------------------------------------
            SELECT
                COUNT(*)
            INTO l_exists
            FROM
                stg_mst_beneficiary
            WHERE
                    group_id = l_group_id
                AND payee_id = r.payee_id
                AND row_status = 'ACTIVE';
------------------------------------------------------------------
  -- IF PAYEE ALREADY EXISTS THEN SKIP
  ------------------------------------------------------------------
            IF l_exists > 0 THEN
                l_skipped_count := l_skipped_count + 1;
                CONTINUE;
            END IF;
------------------------------------------------------------------
-- INSERT NEW PAYEE
------------------------------------------------------------------
            l_base_row_no := l_base_row_no + 1;
            INSERT INTO stg_mst_beneficiary (
                group_id,
                row_no,
                row_status,
                validation_status,
                payee_id,
                beneficiary_name,
                aadhaar_ref_no,
                jan_aadhar_id,
                mobile_no,
                state_name,
                district_name,
                ifsc_code,
                account_no,
                created_by
            ) VALUES ( l_group_id,
                       l_base_row_no,
                       'ACTIVE',
                       'PENDING',
                       r.payee_id,
                       r.beneficiary_name,
                       r.aadhaar_ref_no,
                       r.jan_aadhar_id,
                       r.mobile_no,
                       r.state_name,
                       r.district_name,
                       r.ifsc_code,
                       r.account_no,
                       l_user );

            l_count := l_count + 1;
        END LOOP;
------------------------------------------------------------------
-- Step 4: Mark group as staged and audit.
------------------------------------------------------------------
        UPDATE mst_beneficiary_group
        SET
            process_status = 'STAGED',
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
            group_id = l_group_id;

        p_insert_group_run_detail(l_group_id, 'ADD_PAYEES', 'STAGED', l_user, 'Existing payees added to group');
        p_audit_membership(NULL, NULL, l_group_id, 'ADD_PAYEES', NULL,
                           p_req, 'Existing payees added', l_user);

        COMMIT;
------------------------------------------------------------------
  -- SUCCESS RESPONSE
------------------------------------------------------------------
        p_set_success('{"group_id":'
                      || l_group_id
                      || ',"added_rows":'
                      || l_count
                      || ',"skipped_rows":'
                      || l_skipped_count
                      || '}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_add_group_to_group
    -- Business purpose:
    -- Copy beneficiaries from one editable group into another editable group.
    --------------------------------------------------------------------------
    PROCEDURE pr_add_group_to_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_source_group_id NUMBER;
        l_target_group_id NUMBER;
        l_user            VARCHAR2(100);
        l_base_row_no     NUMBER;
        l_count           NUMBER := 0;
        l_exists          NUMBER := 0;
    BEGIN 
------------------------------------------------------------------
-- Step 1: Read source/target groups and ensure both are editable.
------------------------------------------------------------------
        l_source_group_id := f_json_number(p_req, '$.source_group_id');
        l_target_group_id := f_json_number(p_req, '$.target_group_id');
        l_user := nvl(
            f_json_varchar(p_req, '$.created_by'),
            user
        );
        p_assert_group_exists(l_source_group_id);
        p_assert_group_exists(l_target_group_id);
        p_assert_group_editable(l_source_group_id);
        p_assert_group_editable(l_target_group_id);
------------------------------------------------------------------
-- Step 2: Determine next row number in target group.
------------------------------------------------------------------
        SELECT
            nvl(
                max(row_no),
                0
            )
        INTO l_base_row_no
        FROM
            stg_mst_beneficiary
        WHERE
            group_id = l_target_group_id;
------------------------------------------------------------------
  -- Step 3: Copy active source rows to target group.
  ------------------------------------------------------------------
        FOR r IN (
            SELECT
                *
            FROM
                stg_mst_beneficiary
            WHERE
                    group_id = l_source_group_id
                AND row_status = 'ACTIVE'
            ORDER BY
                row_no
        ) LOOP 
  --------------------------------------------------------------
  -- DUPLICATE VALIDATION
  -- SAME PAYEE SHOULD NOT EXIST IN TARGET GROUP
  --------------------------------------------------------------
            SELECT
                COUNT(*)
            INTO l_exists
            FROM
                stg_mst_beneficiary t
            WHERE
                    t.group_id = l_target_group_id
                AND t.row_status = 'ACTIVE'
                AND (
    -- SAME PAYEE ID
                 ( t.payee_id = r.payee_id )
                      OR -- SAME ACCOUNT + IFSC
                       ( t.account_no = r.account_no
                           AND t.ifsc_code = r.ifsc_code )
                      OR -- SAME AADHAAR
                       ( r.aadhaar_ref_no IS NOT NULL
                           AND t.aadhaar_ref_no = r.aadhaar_ref_no ) );
--------------------------------------------------------------
  -- SKIP DUPLICATE   ---2505026  jabir
--------------------------------------------------------------
            IF l_exists > 0 THEN
                CONTINUE;
            END IF;
--------------------------------------------------------------
-- INSERT NEW RECORD
--------------------------------------------------------------
            l_base_row_no := l_base_row_no + 1;
            INSERT INTO stg_mst_beneficiary (
                group_id,
                row_no,
                row_status,
                validation_status,
                payee_id,
                beneficiary_name,
                aadhaar_ref_no,
                jan_aadhar_id,
                mobile_no,
                state_name,
                district_name,
                ifsc_code,
                account_no,
                amount,
                attr1_val,
                attr2_val,
                attr3_val,
                attr4_val,
                attr5_val,
                attr6_val,
                attr7_val,
                attr8_val,
                attr9_val,
                attr10_val,
                attr11_val,
                attr12_val,
                attr13_val,
                attr14_val,
                attr15_val,
                attr16_val,
                attr17_val,
                attr18_val,
                attr19_val,
                attr20_val,
                source_stage_row_id,
                created_by
            ) VALUES ( l_target_group_id,
                       l_base_row_no,
                       'ACTIVE',
                       'PENDING',
                       r.payee_id,
                       r.beneficiary_name,
                       r.aadhaar_ref_no,
                       r.jan_aadhar_id,
                       r.mobile_no,
                       r.state_name,
                       r.district_name,
                       r.ifsc_code,
                       r.account_no,
                       r.amount,
                       r.attr1_val,
                       r.attr2_val,
                       r.attr3_val,
                       r.attr4_val,
                       r.attr5_val,
                       r.attr6_val,
                       r.attr7_val,
                       r.attr8_val,
                       r.attr9_val,
                       r.attr10_val,
                       r.attr11_val,
                       r.attr12_val,
                       r.attr13_val,
                       r.attr14_val,
                       r.attr15_val,
                       r.attr16_val,
                       r.attr17_val,
                       r.attr18_val,
                       r.attr19_val,
                       r.attr20_val,
                       r.stage_row_id,
                       l_user );

            l_count := l_count + 1;
        END LOOP;
------------------------------------------------------------------
-- Step 4: Mark target group as staged and audit.
------------------------------------------------------------------
        UPDATE mst_beneficiary_group
        SET
            process_status = 'STAGED',
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
            group_id = l_target_group_id;

        p_insert_group_run_detail(l_target_group_id, 'COPY_FROM_GROUP', 'STAGED', l_user, 'Rows copied from another group');
        p_audit_membership(NULL, l_source_group_id, l_target_group_id, 'COPY_GROUP', NULL,
                           p_req, 'Group rows copied', l_user);

        COMMIT;
------------------------------------------------------------------
  -- SUCCESS RESPONSE
------------------------------------------------------------------
        p_set_success('{"target_group_id":'
                      || l_target_group_id
                      || ',"copied_rows":'
                      || l_count
                      || '}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_set_error(sqlerrm
                        || chr(10)
                        || dbms_utility.format_error_backtrace,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);

    END;
   
    --------------------------------------------------------------------------
    -- PROCEDURE: pr_import_group_beneficiaries
    -- Business purpose:
    --   Import active/valid/selected rows from one editable group into another.
    --------------------------------------------------------------------------

PROCEDURE pr_import_group_beneficiaries (
    p_req      IN CLOB,
    p_resp     OUT CLOB,
    p_status   OUT VARCHAR2,
    p_err_msg  OUT VARCHAR2,
    p_err_code OUT VARCHAR2
) IS

    l_source_group_id NUMBER;
    l_target_group_id NUMBER;

    l_mode            VARCHAR2(30);

    l_user            VARCHAR2(100);

    l_base_row_no     NUMBER;

    l_count           NUMBER := 0;

BEGIN

    ----------------------------------------------------------------------
    -- STEP 1 : READ INPUT
    ----------------------------------------------------------------------

    l_source_group_id := f_json_number(
        p_req,
        '$.source_group_id'
    );

    l_target_group_id := NVL(f_json_number(p_req,'$.target_group_id'),
        f_json_number( p_req,'$.group_id'));

    l_mode := NVL(UPPER(TRIM(f_json_varchar(p_req,'$.mode'))),'COPY_ALL_ACTIVE_ROWS');

    l_user := NVL(f_json_varchar(p_req,'$.created_by'),
                NVL(f_json_varchar(p_req,'$.modified_by' ),USER)
    );

    ----------------------------------------------------------------------
    -- STEP 2 : VALIDATIONS
    ----------------------------------------------------------------------

    p_assert_group_exists(l_source_group_id);

    p_assert_group_exists(l_target_group_id);

    p_assert_group_editable(l_source_group_id);

    p_assert_group_editable(l_target_group_id);

    ----------------------------------------------------------------------
    -- SOURCE/TARGET SAME CHECK
    ----------------------------------------------------------------------

    IF l_source_group_id = l_target_group_id THEN

        RAISE_APPLICATION_ERROR(
            -20052,
            'Source and target group cannot be same.'
        );

    END IF;

    ----------------------------------------------------------------------
    -- MODE VALIDATION
    ----------------------------------------------------------------------

    IF l_mode NOT IN (
        'COPY_ALL_ACTIVE_ROWS',
        'COPY_VALID_ACTIVE_ROWS',
        'COPY_SELECTED_ROW_NOS'
    ) THEN

        RAISE_APPLICATION_ERROR(-20053,'Invalid import mode.');

    END IF;

    ----------------------------------------------------------------------
    -- STEP 3 : FIND LAST ROW NUMBER OF TARGET GROUP
    ----------------------------------------------------------------------

    SELECT NVL(MAX(row_no), 0)
    INTO l_base_row_no
    FROM stg_mst_beneficiary
    WHERE group_id = l_target_group_id;

    ----------------------------------------------------------------------
    -- STEP 4 : FETCH SOURCE ROWS
    ----------------------------------------------------------------------

    FOR r IN (

        SELECT
            s.*
        FROM stg_mst_beneficiary s

        WHERE s.group_id = l_source_group_id

        AND s.row_status = 'ACTIVE'

        AND (

            l_mode = 'COPY_ALL_ACTIVE_ROWS'

            OR (

                l_mode = 'COPY_VALID_ACTIVE_ROWS'
                AND s.validation_status = 'VALID'

            )

            OR (

                l_mode = 'COPY_SELECTED_ROW_NOS'

                AND EXISTS (

                    SELECT 1
                    FROM JSON_TABLE (
                        p_req,
                        '$.row_nos[*]'
                        COLUMNS (
                            row_no NUMBER PATH '$'
                        )
                    ) jt
                    WHERE jt.row_no = s.row_no

                )

            )

        )

        ORDER BY s.row_no

    ) LOOP

        ------------------------------------------------------------------
        -- STEP 5 : DUPLICATE PAYEE VALIDATION   -----2505026 JABIR
        -- DO NOT INSERT SAME PAYEE AGAIN IN TARGET GROUP
        ------------------------------------------------------------------

        DECLARE

            l_exists NUMBER := 0;

        BEGIN

            SELECT COUNT(*)
            INTO l_exists
            FROM stg_mst_beneficiary t
            WHERE t.group_id = l_target_group_id
            AND t.payee_id = r.payee_id
            AND t.row_status = 'ACTIVE';

            ----------------------------------------------------------------
            -- INSERT ONLY IF PAYEE NOT EXISTS
            ----------------------------------------------------------------

            IF l_exists = 0 THEN

                l_base_row_no := l_base_row_no + 1;

                INSERT INTO stg_mst_beneficiary (

                    group_id,
                    row_no,
                    row_status,
                    validation_status,

                    payee_id,

                    beneficiary_name,
                    aadhaar_ref_no,
                    jan_aadhar_id,
                    mobile_no,

                    state_name,
                    district_name,

                    ifsc_code,
                    account_no,

                    amount,

                    attr1_val,
                    attr2_val,
                    attr3_val,
                    attr4_val,
                    attr5_val,
                    attr6_val,
                    attr7_val,
                    attr8_val,
                    attr9_val,
                    attr10_val,
                    attr11_val,
                    attr12_val,
                    attr13_val,
                    attr14_val,
                    attr15_val,
                    attr16_val,
                    attr17_val,
                    attr18_val,
                    attr19_val,
                    attr20_val,

                    source_stage_row_id,

                    created_by

                ) VALUES (

                    l_target_group_id,
                    l_base_row_no,

                    'ACTIVE',
                    'PENDING',

                    r.payee_id,

                    r.beneficiary_name,
                    r.aadhaar_ref_no,
                    r.jan_aadhar_id,
                    r.mobile_no,

                    r.state_name,
                    r.district_name,

                    r.ifsc_code,
                    r.account_no,

                    r.amount,

                    r.attr1_val,
                    r.attr2_val,
                    r.attr3_val,
                    r.attr4_val,
                    r.attr5_val,
                    r.attr6_val,
                    r.attr7_val,
                    r.attr8_val,
                    r.attr9_val,
                    r.attr10_val,
                    r.attr11_val,
                    r.attr12_val,
                    r.attr13_val,
                    r.attr14_val,
                    r.attr15_val,
                    r.attr16_val,
                    r.attr17_val,
                    r.attr18_val,
                    r.attr19_val,
                    r.attr20_val,

                    r.stage_row_id,

                    l_user

                );

                l_count := l_count + 1;

            END IF;

        END;

    END LOOP;

    ----------------------------------------------------------------------
    -- STEP 6 : NO ROW IMPORTED VALIDATION
    ----------------------------------------------------------------------

    IF l_count = 0 THEN

        RAISE_APPLICATION_ERROR(
            -20054,
            'No rows imported. All payees already exist in target group.'
        );

    END IF;

    ----------------------------------------------------------------------
    -- STEP 7 : UPDATE TARGET GROUP STATUS
    ----------------------------------------------------------------------

    UPDATE mst_beneficiary_group
    SET
        process_status = 'STAGED',
        modified_by    = l_user,
        modified_date  = SYSTIMESTAMP
    WHERE group_id = l_target_group_id;

    ----------------------------------------------------------------------
    -- STEP 8 : UPDATE GROUP EXTENSION TABLE
    ----------------------------------------------------------------------

    MERGE INTO mst_beneficiary_group_ext t

    USING (

        SELECT
            l_target_group_id AS group_id,
            l_source_group_id AS imported_from_group_id,
            l_user            AS modified_by
        FROM dual

    ) s

    ON (
        t.group_id = s.group_id
    )

    WHEN MATCHED THEN

        UPDATE SET

            t.imported_from_group_id = s.imported_from_group_id,
            t.modified_by            = s.modified_by,
            t.modified_date          = SYSTIMESTAMP

    WHEN NOT MATCHED THEN

        INSERT (

            group_id,
            mapping_version_snapshot,
            validation_attempt_count,
            latest_validation_run_no,
            imported_from_group_id,
            created_by

        )

        VALUES (

            s.group_id,
            1,
            0,
            0,
            s.imported_from_group_id,
            s.modified_by

        );

    ----------------------------------------------------------------------
    -- STEP 9 : AUDIT + RUN DETAILS
    ----------------------------------------------------------------------

    p_insert_group_run_detail(

        l_target_group_id,
        'IMPORT_GROUP_ROWS',
        'STAGED',
        l_user,

        'Rows imported from group '
        || l_source_group_id
        || ' using mode '
        || l_mode

    );

    p_audit_membership(

        NULL,
        l_source_group_id,
        l_target_group_id,

        'IMPORT_GROUP',

        NULL,

        p_req,

        'Group rows imported',

        l_user

    );

    COMMIT;

    ----------------------------------------------------------------------
    -- STEP 11 : SUCCESS RESPONSE
    ----------------------------------------------------------------------

    p_set_success(

        '{"target_group_id":'
        || l_target_group_id
        || ',"source_group_id":'
        || l_source_group_id
        || ',"import_mode":'
        || f_json_quote(l_mode)
        || ',"imported_rows":'
        || l_count
        || '}',

        p_resp,
        p_status,
        p_err_msg,
        p_err_code

    );

EXCEPTION

    WHEN OTHERS THEN

        ROLLBACK;

        p_err_msg :=
              SQLERRM
           || CHR(10)
           || 'BACKTRACE: '
           || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
           || CHR(10)
           || 'CALL STACK: '
           || DBMS_UTILITY.FORMAT_CALL_STACK;

        p_set_error(

            p_err_msg,
            TO_CHAR(SQLCODE),

            p_resp,
            p_status,
            p_err_msg,
            p_err_code

        );

END;
    --------------------------------------------------------------------------
    -- PROCEDURE: pr_stage_beneficiaries
    -- Business purpose:
    --   Stage JSON rows for manual/small bulk upload. Java should map UI field
    --   codes to physical columns before calling this procedure.
    --------------------------------------------------------------------------
    PROCEDURE pr_stage_beneficiaries (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS
        l_group_id    NUMBER;
        l_user        VARCHAR2(100);
        l_base_row_no NUMBER;
        l_count       NUMBER := 0;
        l_docs_name VARCHAR2(255);
    BEGIN
        -- Step 1: Read group and check editability.
        l_group_id := f_json_number(p_req, '$.group_id');
        l_user := nvl(
            f_json_varchar(p_req, '$.created_by'),
            user
        );
        l_docs_name := f_json_varchar(p_req, '$.fileName');
    
--        p_assert_group_exists(l_group_id);
--        p_assert_group_editable(l_group_id);


        -- Step 2: Find the next row number for append behavior.
        SELECT
            nvl(
                max(row_no),
                0
            )
        INTO l_base_row_no
        FROM
            stg_mst_beneficiary
        WHERE
            group_id = l_group_id;

        -- Step 3: Insert each JSON row into staging.
        FOR r IN (
            SELECT
                *
            FROM
                JSON_TABLE ( p_req, '$.rows[*]'
                    COLUMNS (
                        row_no NUMBER PATH '$.row_no',
                        beneficiary_name VARCHAR2 ( 300 ) PATH '$.beneficiary_name',
                        aadhaar_ref_no VARCHAR2 ( 200 ) PATH '$.aadhaar_ref_no',
                        jan_aadhar_id VARCHAR2 ( 100 ) PATH '$.jan_aadhar_id',
                        mobile_no VARCHAR2 ( 20 ) PATH '$.mobile_no',
                        state_name VARCHAR2 ( 200 ) PATH '$.state_name',
                        district_name VARCHAR2 ( 200 ) PATH '$.district_name',
                        ifsc_code VARCHAR2 ( 11 ) PATH '$.ifsc_code',
                        account_no VARCHAR2 ( 100 ) PATH '$.account_no',
                        amount VARCHAR2 ( 100 ) PATH '$.amount',
                        installment_no NUMBER  PATH '$.installment_no',
                        DOCS_NAME VARCHAR2 ( 100 ) PATH '$.fileName',
                        ------Pravesh & vivek 23062026------------------
                        PAN_NO  VARCHAR2 ( 50 ) PATH '$.firmPanNo',
                        BANK_BRANCH_ID  VARCHAR2 ( 50 ) PATH '$.bankBranchId',
                        BRANCH_NAME  VARCHAR2 ( 50 ) PATH '$.branchName',
                        BANK_NAME  VARCHAR2 ( 50 ) PATH '$.bankName',
                        ------Pravesh & vivek 23062026------------------
                        attr1_val VARCHAR2 ( 200 ) PATH '$.attr1_val',
                        attr2_val VARCHAR2 ( 200 ) PATH '$.attr2_val',
                        attr3_val VARCHAR2 ( 200 ) PATH '$.attr3_val',
                        attr4_val VARCHAR2 ( 200 ) PATH '$.attr4_val',
                        attr5_val VARCHAR2 ( 200 ) PATH '$.attr5_val',
                        attr6_val VARCHAR2 ( 2000 ) PATH '$.attr6_val',
                        attr7_val VARCHAR2 ( 2000 ) PATH '$.attr7_val',
                        attr8_val VARCHAR2 ( 2000 ) PATH '$.attr8_val',
                        attr9_val VARCHAR2 ( 2000 ) PATH '$.attr9_val',
                        attr10_val VARCHAR2 ( 2000 ) PATH '$.attr10_val'
                    )
                )
        ) LOOP
            INSERT INTO stg_mst_beneficiary (
                group_id,
                row_no,
                beneficiary_name,
                aadhaar_ref_no,
                jan_aadhar_id,
                mobile_no,
                state_name,
                district_name,
                ifsc_code,
                account_no,
                amount,
                installment_no,
                DOCS_NAME,
                ------Pravesh & vivek 23062026------------------
                PAN_NO,
                BANK_BRANCH_ID,
                BRANCH_NAME,
                BANK_NAME,
                ------Pravesh & vivek 23062026------------------
                attr1_val,
                attr2_val,
                attr3_val,
                attr4_val,
                attr5_val,
                attr6_val,
                attr7_val,
                attr8_val,
                attr9_val,
                attr10_val,
                created_by
            ) VALUES ( l_group_id,
                       l_base_row_no + nvl(r.row_no, l_count + 1),
                       r.beneficiary_name,
                       r.aadhaar_ref_no,
                       r.jan_aadhar_id,
                       r.mobile_no,
                       r.state_name,
                       r.district_name,
                       upper(r.ifsc_code),
                       r.account_no,
                       f_to_number_or_null(r.amount),
                       f_to_number_or_null(r.installment_no),
                       r.DOCS_NAME,
                    ------Pravesh & vivek 23062026------------------
                        r.PAN_NO,
                        r.BANK_BRANCH_ID,
                        r.BRANCH_NAME,
                        r.BANK_NAME,
                    ------Pravesh & vivek 23062026------------------
                       r.attr1_val,
                       r.attr2_val,
                       r.attr3_val,
                       r.attr4_val,
                       r.attr5_val,
                       r.attr6_val,
                       r.attr7_val,
                       r.attr8_val,
                       r.attr9_val,
                       r.attr10_val,
                       l_user );

            l_count := l_count + 1;
        END LOOP;

        -- Step 4: Mark group as staged and audit.
        UPDATE mst_beneficiary_group
        SET
            process_status = 'STAGED',
            modified_by = l_user,
            DOCS_NAME      = l_docs_name,
            modified_date = systimestamp
        WHERE
            group_id = l_group_id;

        p_insert_group_run_detail(l_group_id, 'STAGE_JSON', 'STAGED', l_user, 'Rows staged from JSON');
        p_audit_membership(NULL, NULL, l_group_id, 'STAGE_JSON', NULL,
                           p_req, 'Rows staged from JSON', l_user);

        COMMIT;
        p_set_success('{"group_id":'
                      || l_group_id
                      || ',"staged_rows":'
                      || l_count
                      || '}', p_resp, p_status, p_err_msg, p_err_code);

 --------------------------------------------05062026---------------------------------  
EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
           package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_stage_beneficiaries',
                p_type        => 1,
                p_ref_no      => l_group_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM || CHR(10) ||
                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY   => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
 END;    
--------------------------------------------05062026---------------------------------  

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_stage_beneficiaries_bulk
    -- Business purpose:
    --   High-performance Java path for Excel uploads. Java passes Oracle array
    --   TAB_BENEFICIARY_STAGE_IN in chunks, for example 1000 to 5000 rows.
    --------------------------------------------------------------------------
    PROCEDURE pr_stage_beneficiaries_bulk (
        p_group_id   IN NUMBER,
        p_created_by IN VARCHAR2,
        p_rows       IN tab_beneficiary_stage_in,
        p_resp       OUT CLOB,
        p_status     OUT VARCHAR2,
        p_err_msg    OUT VARCHAR2,
        p_err_code   OUT VARCHAR2
    ) IS
        l_user  VARCHAR2(100) := nvl(p_created_by, user);
        l_count NUMBER := 0;
    BEGIN
        -- Step 1: Validate group and input array.
       -- p_assert_group_exists(p_group_id);
        p_assert_group_editable(p_group_id);
        IF p_rows IS NULL
           OR p_rows.count = 0 THEN
            raise_application_error(-20020, 'Bulk input collection is empty.');
        END IF;

        -- Step 2: Insert collection rows directly into staging.
        INSERT INTO stg_mst_beneficiary (
            group_id,
            row_no,
            beneficiary_name,
            --aadhaar_ref_no,---0506026 jabir
            jan_aadhar_id,
            mobile_no,
            state_name,
            district_name,
            ifsc_code,
            account_no,
            amount,
            attr1_val,
            attr2_val,
            attr3_val,
            attr4_val,
            attr5_val,
            attr6_val,
            attr7_val,
            attr8_val,
            attr9_val,
            attr10_val,
            attr11_val,
            attr12_val,
            attr13_val,
            attr14_val,
            attr15_val,
            attr16_val,
            attr17_val,
            attr18_val,
            attr19_val,
            attr20_val,
            created_by,
            INSTALLMENT_NO
        )
            SELECT
                p_group_id,
                t.row_no,
                t.beneficiary_name,
                --t.aadhaar_ref_no, --0506026 jabir
                t.jan_aadhar_id,
                t.mobile_no,
                t.state_name,
                t.district_name,
                upper(t.ifsc_code),
                t.account_no,
                t.amount,
                t.attr1_val,
                t.attr2_val,
                t.attr3_val,
                t.attr4_val,
                t.attr5_val,
                t.attr6_val,
                t.attr7_val,
                t.attr8_val,
                t.attr9_val,
                t.attr10_val,
                t.attr11_val,
                t.attr12_val,
                t.attr13_val,
                t.attr14_val,
                t.attr15_val,
                t.attr16_val,
                t.attr17_val,
                t.attr18_val,
                t.attr19_val,
                t.attr20_val,
                l_user,
                t.INSTALLMENT_NO
            FROM
                TABLE ( p_rows ) t;

        l_count := SQL%rowcount;

        -- Step 3: Mark group as staged and audit.
        UPDATE mst_beneficiary_group
        SET
            process_status = 'STAGED',
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
            group_id = p_group_id;

        p_insert_group_run_detail(p_group_id, 'STAGE_BULK', 'STAGED', l_user, 'Rows staged from bulk input');
        p_audit_membership(NULL, NULL, p_group_id, 'STAGE_BULK', NULL,
                           'Bulk array input', 'Rows staged from bulk input', l_user);

        COMMIT;
        p_set_success('{"group_id":'
                      || p_group_id
                      || ',"staged_rows":'
                      || l_count
                      || '}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_update_stage_rows
    -- Business purpose:
    --   Correct invalid staged rows. Missing JSON fields are ignored for simplicity.
    --------------------------------------------------------------------------
    PROCEDURE pr_update_stage_rows (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS
        l_group_id NUMBER;
        l_user     VARCHAR2(100);
        l_count    NUMBER := 0;
    BEGIN
        -- Step 1: Validate group.
        l_group_id := f_json_number(p_req, '$.group_id');
        l_user := nvl(
            f_json_varchar(p_req, '$.modified_by'),
            user
        );
        p_assert_group_exists(l_group_id);
        p_assert_group_editable(l_group_id);

        -- Step 2: Update rows. NVL keeps existing value when JSON field is absent or null.
--        FOR r IN (
--            SELECT
--                *
--            FROM
--                JSON_TABLE ( p_req, '$.rows[*]'
--                    COLUMNS (
--                        stage_row_id NUMBER PATH '$.stage_row_id',
--                        beneficiary_name VARCHAR2 ( 300 ) PATH '$.beneficiary_name',
--                        mobile_no VARCHAR2 ( 20 ) PATH '$.mobile_no',
--                        ifsc_code VARCHAR2 ( 11 ) PATH '$.ifsc_code',
--                        account_no VARCHAR2 ( 100 ) PATH '$.account_no',
--                        amount VARCHAR2 ( 100 ) PATH '$.amount',
--                        aadhaar_ref_no VARCHAR2 ( 100 ) PATH '$.aadhaar_ref_no',
--                         jan_aadhar_id VARCHAR2 ( 100 ) PATH '$.jan_aadhar_id'
--                    )
--                )
--        ) LOOP
--            UPDATE stg_mst_beneficiary
--            SET
--                beneficiary_name = nvl(r.beneficiary_name, beneficiary_name),
--                mobile_no = nvl(r.mobile_no, mobile_no),
--                ifsc_code = nvl(upper(r.ifsc_code),ifsc_code),
--                account_no = nvl(r.account_no, account_no),
--                amount = nvl(f_to_number_or_null(r.amount),amount),
--                AADHAAR_REF_NO = nvl(r.aadhaar_ref_no, aadhaar_ref_no),
--                JAN_AADHAR_ID = nvl(r.jan_aadhar_id, aadhaar_ref_no),
--                validation_status = 'PENDING',
--                error_count = 0,
--                error_json = NULL,
--                modified_by = l_user,
--                modified_date = systimestamp
--            WHERE
--                    stage_row_id = r.stage_row_id
--                AND group_id = l_group_id
--                AND row_status = 'ACTIVE';
--
--            l_count := l_count + SQL%rowcount;
--        END LOOP;

       MERGE INTO stg_mst_beneficiary t
                                USING (
                                    SELECT *
                                    FROM JSON_TABLE(
                                        p_req,
                                        '$.rows[*]'
                                        COLUMNS (
                                            stage_row_id      NUMBER PATH '$.stage_row_id',
                                            beneficiary_name  VARCHAR2(300) PATH '$.beneficiary_name',
                                            mobile_no         VARCHAR2(20) PATH '$.mobile_no',
                                            ifsc_code         VARCHAR2(11) PATH '$.ifsc_code',
                                            account_no        VARCHAR2(100) PATH '$.account_no',
                                            amount            VARCHAR2(100) PATH '$.amount',
                                           -- aadhaar_ref_no    VARCHAR2(100) PATH '$.aadhaar_ref_no',---05062026
                                            jan_aadhar_id     VARCHAR2(100) PATH '$.jan_aadhar_id'
                                        )
                                    )
                                ) s
                                ON (
                                       t.stage_row_id = s.stage_row_id
                                   AND t.group_id = l_group_id
                                   AND t.row_status = 'ACTIVE'
                                )
                                WHEN MATCHED THEN
                                UPDATE SET
                                    t.beneficiary_name = NVL(s.beneficiary_name,t.beneficiary_name),
                                    t.mobile_no = NVL(s.mobile_no,t.mobile_no),
                                    t.ifsc_code = NVL(UPPER(s.ifsc_code),t.ifsc_code),
                                    t.account_no = NVL(s.account_no,t.account_no),
                                    t.amount = NVL(f_to_number_or_null(s.amount),t.amount),
                                   -- t.aadhaar_ref_no = NVL(s.aadhaar_ref_no,t.aadhaar_ref_no),--05062026
                                    t.jan_aadhar_id = NVL(s.jan_aadhar_id,t.jan_aadhar_id),
                                    t.validation_status = 'PENDING',
                                    t.error_count = 0,
                                    t.error_json = NULL,
                                    t.modified_by = l_user,
                                    t.modified_date = SYSTIMESTAMP; 
                                    --l_count := l_count + SQL%rowcount;------04-06-26
        -- Step 3: Mark group as staged and audit.
        UPDATE mst_beneficiary_group
        SET
            process_status = 'STAGED',
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
            group_id = l_group_id;

        p_insert_group_run_detail(l_group_id, 'UPDATE_STAGE_ROWS', 'STAGED', l_user, 'Rows corrected');
        p_audit_membership(NULL, l_group_id, l_group_id, 'UPDATE_ROWS', NULL,
                           p_req, 'Stage rows corrected', l_user);

        COMMIT;
        p_set_success('{"group_id":'
                      || l_group_id
                      || ',"updated_rows":'
                      || l_count
                      || '}', p_resp, p_status, p_err_msg, p_err_code);

 			
--------------------------------------------05062026---------------------------------  
EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
           package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_update_stage_rows',
                p_type        => 1,
                p_ref_no      => l_group_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM || CHR(10) ||
                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY   => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
 END;    
    --------------------------------------------------------------------------
    -- PROCEDURE: pr_remove_stage_rows
    -- Business purpose:
    --   Soft remove staged beneficiaries from an editable group.
    --------------------------------------------------------------------------
PROCEDURE pr_remove_stage_rows (
    p_req      IN CLOB,
    p_resp     OUT CLOB,
    p_status   OUT VARCHAR2,
    p_err_msg  OUT VARCHAR2,
    p_err_code OUT VARCHAR2
) IS

    l_group_id NUMBER;
    l_user     VARCHAR2(100);
    l_count    NUMBER := 0;
    l_removed_count NUMBER := 0;
    l_group_resp CLOB;
    l_status2    VARCHAR2(10);
    l_err_msg2   VARCHAR2(4000);
    l_err_code2  VARCHAR2(100);

BEGIN

    l_group_id := f_json_number(p_req, '$.group_id');
    l_user     := NVL(f_json_varchar(p_req, '$.modified_by'), USER);

    ------------------------------------------------------------------
    -- Validations
    ------------------------------------------------------------------
    p_assert_group_exists(l_group_id);
    p_assert_group_editable(l_group_id);

    ------------------------------------------------------------------
    -- Count rows to delete
    ------------------------------------------------------------------
    SELECT COUNT(*)
    INTO l_count
    FROM stg_mst_beneficiary s
    WHERE s.group_id = l_group_id
      AND s.row_status = 'ACTIVE'
      AND EXISTS (
            SELECT 1
            FROM JSON_TABLE(
                p_req,
                '$.rows[*]'
                COLUMNS (
                    stage_row_id NUMBER PATH '$.stage_row_id'
                )
            ) jt
            WHERE jt.stage_row_id = s.stage_row_id
      );

    ------------------------------------------------------------------
    -- Audit + Delete
    ------------------------------------------------------------------
    FOR r IN (
        SELECT s.stage_row_id
        FROM stg_mst_beneficiary s
        WHERE s.group_id = l_group_id
          AND s.row_status = 'ACTIVE'
          AND EXISTS (
                SELECT 1
                FROM JSON_TABLE(
                    p_req,
                    '$.rows[*]'
                    COLUMNS (
                        stage_row_id NUMBER PATH '$.stage_row_id'
                    )
                ) jt
                WHERE jt.stage_row_id = s.stage_row_id
          )
    )
    LOOP

        ------------------------------------------------------------------
        -- Audit
        ------------------------------------------------------------------
        p_audit_membership(
            r.stage_row_id,
            l_group_id,
            NULL,
            'REMOVE_STAGE_ROW',
            NULL,
            p_req,
            'Deleted via UI',
            l_user
        );

        ------------------------------------------------------------------
        -- Delete Master
        ------------------------------------------------------------------
        DELETE FROM mst_beneficiary
        WHERE source_stage_row_id = r.stage_row_id;

        ------------------------------------------------------------------
        -- Delete Staging
        ------------------------------------------------------------------
--        DELETE FROM stg_mst_beneficiary
--        WHERE stage_row_id = r.stage_row_id
--          AND group_id = l_group_id;
          
          DELETE FROM stg_mst_beneficiary
                WHERE stage_row_id = r.stage_row_id
                  AND group_id = l_group_id;
                
                l_removed_count := l_removed_count + SQL%ROWCOUNT;
                
    END LOOP;

    ------------------------------------------------------------------
    -- Update Group Status
    ------------------------------------------------------------------
    UPDATE mst_beneficiary_group
       SET modified_by   = l_user,
           modified_date = SYSTIMESTAMP
     WHERE group_id = l_group_id;

 ------------------------------------------------------------------
-- UPDATE GROUP PROCESS STATUS
------------------------------------------------------------------
--        UPDATE mst_beneficiary_group g
--        SET process_status =
--            CASE
--                WHEN EXISTS (
--                    SELECT 1
--                    FROM stg_mst_beneficiary s
--                    WHERE s.group_id = g.group_id
--                      AND s.row_status = 'ACTIVE'
--                      AND s.validation_status = 'INVALID'
--                )
--                THEN 'VALIDATION_FAILED'
--                ELSE 'VALIDATION_SUCCESS'
--            END,
--            modified_by   = l_user,
--            modified_date = SYSTIMESTAMP
--        WHERE g.group_id = l_group_id;
-- 
              ------------------------------------------------------------------
            -- REVALIDATE GROUP AFTER DELETE
            ------------------------------------------------------------------

            package_bnf_pns.pr_validate_group_v1(
                p_req,
                l_group_resp,
                l_status2,
                l_err_msg2,
                l_err_code2
            );
------------------------------------------------------------------

    -- Run Detail Log
    ------------------------------------------------------------------
    p_insert_group_run_detail(
        l_group_id,
        'REMOVE_ROWS',
        'SUCCESS',
        l_user,
        l_count || ' rows deleted'
    );

    COMMIT;

    ------------------------------------------------------------------
    -- Success Response
    ------------------------------------------------------------------
    p_set_success(
        '{"group_id":' || l_group_id ||
         ',"removed_rows":' || l_removed_count || '}',
        p_resp,
        p_status,
        p_err_msg,
        p_err_code
    );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;

        p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
END;

-------------------------------20/06/2026--------------------------------
--PROCEDURE pr_remove_stage_rows (
--    p_req      IN CLOB,
--    p_resp     OUT CLOB,
--    p_status   OUT VARCHAR2,
--    p_err_msg  OUT VARCHAR2,
--    p_err_code OUT VARCHAR2
--) IS
--
--    l_group_id NUMBER;
--    l_user     VARCHAR2(100);
--    l_count    NUMBER := 0;
--
--BEGIN
--
--    l_group_id := f_json_number(p_req, '$.group_id');
--    l_user := NVL( f_json_varchar(p_req, '$.modified_by'), USER );
--
--    ------------------------------------------------------------------
--    -- Validations
--    ------------------------------------------------------------------
--    p_assert_group_exists(l_group_id);
--    p_assert_group_editable(l_group_id);
--    ------------------------------------------------------------------
--    -- Extract JSON once (DUAL KEY SUPPORT)
--    ------------------------------------------------------------------
--    WITH req_rows AS (
--        SELECT
----            jt.row_no,
--            jt.stage_row_id
--        FROM JSON_TABLE(
--            p_req,
--            '$.rows[*]'
--            COLUMNS (
----                row_no        NUMBER PATH '$.row_no'        NULL ON ERROR,
--                stage_row_id  NUMBER PATH '$.stage_row_id'  NULL ON ERROR
--            )
--        ) jt
--    )
--    SELECT COUNT(*)
--    INTO l_count
--    FROM stg_mst_beneficiary s
--    WHERE s.group_id = l_group_id
--      AND s.row_status = 'ACTIVE'
--      AND NOT EXISTS (
--            SELECT 1
--            FROM req_rows rr
--     WHERE
---- (rr.row_no IS NOT NULL AND rr.row_no = s.row_no) OR
--    (rr.stage_row_id IS NOT NULL AND rr.stage_row_id = s.stage_row_id)
--      );
--    ------------------------------------------------------------------
--    -- DELETE LOOP (SAFE + AUDIT)
--    ------------------------------------------------------------------
--    FOR r IN (
--        WITH req_rows AS (
--            SELECT
----                jt.row_no,
--                jt.stage_row_id
--            FROM JSON_TABLE(
--                p_req,
--                '$.rows[*]'
--                COLUMNS (
----                    row_no        NUMBER PATH '$.row_no'        NULL ON ERROR,
--                    stage_row_id  NUMBER PATH '$.stage_row_id'  NULL ON ERROR
--                )
--            ) jt
--        )
--        SELECT
--            s.stage_row_id
----            s.row_no
--        FROM stg_mst_beneficiary s
--        WHERE s.group_id = l_group_id
--          AND s.row_status = 'ACTIVE'
--          AND NOT EXISTS (
--                SELECT 1
--                FROM req_rows rr
--                WHERE 
----                (rr.row_no IS NOT NULL AND rr.row_no = s.row_no)  OR 
--            (rr.stage_row_id IS NOT NULL AND rr.stage_row_id = s.stage_row_id)
--          )
--    )
--    LOOP
--        ------------------------------------------------------------------
--        -- AUDIT LOG
--        ------------------------------------------------------------------
--        p_audit_membership(
--            r.stage_row_id,
--            l_group_id,
--            NULL,
--            'REMOVE_DUAL_KEY',
--            NULL,
--            p_req,
--            'Deleted via UI (row_no OR stage_row_id match)',
--            l_user
--        );
--  ------------------------------------------------------------------
--        -- DELETE MASTER TABLE
--------------------------------------------------------------------
--        DELETE FROM mst_beneficiary
--        WHERE source_stage_row_id = r.stage_row_id;
--        ------------------------------------------------------------------
--        -- DELETE STAGING TABLE
--        ------------------------------------------------------------------
--        DELETE FROM stg_mst_beneficiary
--        WHERE stage_row_id = r.stage_row_id
--          AND group_id = l_group_id;
--        l_count := l_count + 1;
--    END LOOP;
--    ------------------------------------------------------------------
--    -- UPDATE GROUP STATUS
--    ------------------------------------------------------------------
--    UPDATE mst_beneficiary_group
--       SET process_status = 'STAGED',
--           modified_by    = l_user,
--           modified_date  = SYSTIMESTAMP
--     WHERE group_id = l_group_id;
--    ------------------------------------------------------------------
--    -- RUN DETAIL LOG
--    ------------------------------------------------------------------
--    p_insert_group_run_detail(
--        l_group_id,
--        'REMOVE_ROWS',
--        'STAGED',
--        l_user,
--        'Rows deleted using dual-key logic'
--    );
--    COMMIT;
--    ------------------------------------------------------------------
--    -- SUCCESS RESPONSE
--    ------------------------------------------------------------------
--    p_set_success(
--        '{"group_id":' || l_group_id ||
--        ',"removed_rows":' || l_count ||
--        ',"mode":"DUAL_KEY_DELETE"}',
--        p_resp,
--        p_status,
--        p_err_msg,
--        p_err_code
--    );
--EXCEPTION
--    WHEN OTHERS THEN
--        ROLLBACK;
--
--        p_set_error(
--            SQLERRM,
--            TO_CHAR(SQLCODE),
--            p_resp,
--            p_status,
--            p_err_msg,
--            p_err_code
--        );
--END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_move_stage_rows
    -- Business purpose:
    --   Move staged beneficiaries from one group to another. Both groups must be
    --   editable, meaning PROCESSED_FLAG must be N.
    --------------------------------------------------------------------------
    PROCEDURE pr_move_stage_rows (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_from_group_id NUMBER;
        l_to_group_id   NUMBER;
        l_user          VARCHAR2(100);
        l_next_row      NUMBER;
        l_count         NUMBER := 0;
    BEGIN
        -- Step 1: Validate source and target groups.
        l_from_group_id := f_json_number(p_req, '$.from_group_id');
        l_to_group_id := f_json_number(p_req, '$.to_group_id');
        l_user := nvl(f_json_varchar(p_req, '$.modified_by'),user);
        p_assert_group_exists(l_from_group_id);
        p_assert_group_exists(l_to_group_id);
        p_assert_group_editable(l_from_group_id);
        p_assert_group_editable(l_to_group_id);

        -- Step 2: Determine next row number in target group.
        SELECT
            nvl(
                max(row_no),
                0
            )
        INTO l_next_row
        FROM
            stg_mst_beneficiary
        WHERE
            group_id = l_to_group_id;

        -- Step 3: Move each requested row.
        FOR r IN (
            SELECT
                stage_row_id
            FROM
                JSON_TABLE ( p_req, '$.rows[*]'
                    COLUMNS (
                        stage_row_id NUMBER PATH '$.stage_row_id'
                    )
                )
        ) LOOP
            l_next_row := l_next_row + 1;
            UPDATE stg_mst_beneficiary
            SET
                group_id = l_to_group_id,
                row_no = l_next_row,
                validation_status = 'PENDING',
                error_count = 0,
                error_json = NULL,
                modified_by = l_user,
                modified_date = systimestamp
            WHERE
                    stage_row_id = r.stage_row_id
                AND group_id = l_from_group_id
                AND row_status = 'ACTIVE';

            DELETE FROM mst_beneficiary
            WHERE
                source_stage_row_id = r.stage_row_id;

            l_count := l_count + 1;
            p_audit_membership(r.stage_row_id, l_from_group_id, l_to_group_id, 'MOVE', NULL,
                               p_req, 'Row moved', l_user);

        END LOOP;

        -- Step 4: Mark both groups as staged.
        UPDATE mst_beneficiary_group
        SET
            process_status = 'STAGED',
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
            group_id IN ( l_from_group_id, l_to_group_id );

        p_insert_group_run_detail(l_from_group_id, 'MOVE_OUT', 'STAGED', l_user, 'Rows moved out');
        p_insert_group_run_detail(l_to_group_id, 'MOVE_IN', 'STAGED', l_user, 'Rows moved in');
        COMMIT;
        p_set_success('{"from_group_id":'
                      || l_from_group_id
                      || ',"to_group_id":'
                      || l_to_group_id
                      || ',"moved_rows":'
                      || l_count
                      || '}', p_resp, p_status, p_err_msg, p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- Private validation helper: apply simple policy checks when policy exists.
    --------------------------------------------------------------------------
    PROCEDURE p_apply_policy_checks (
        p_group_id  IN NUMBER,
        p_scheme_id IN NUMBER,
        p_row       IN stg_mst_beneficiary%rowtype,
        p_errors    IN OUT NOCOPY CLOB,
        p_err_count IN OUT NOCOPY NUMBER
    ) IS

        l_policy_count NUMBER;
        l_allow_dup    CHAR(1);
        l_allow_multi  CHAR(1);
        l_allow_same   CHAR(1);
        l_allow_cross  CHAR(1);
        l_count        NUMBER;
    BEGIN
        -- Step 1: If no active policy row exists, do not apply policy checks.
        SELECT
            COUNT(*)
        INTO l_policy_count
        FROM
            mst_scheme_validation_policy
        WHERE
                scheme_id = p_scheme_id
            AND active_flag = 'Y';

        IF l_policy_count = 0 THEN
            RETURN;
        END IF;

        -- Step 2: Read policy flags.
        SELECT
            allow_duplicate_payment_flag,
            allow_multiple_accounts_per_identity_flag,
            allow_same_account_different_identity_flag,
            allow_cross_identifier_match_flag
        INTO
            l_allow_dup,
            l_allow_multi,
            l_allow_same,
            l_allow_cross
        FROM
            mst_scheme_validation_policy
        WHERE
                scheme_id = p_scheme_id
            AND active_flag = 'Y';

        -- Step 3: Block duplicate payment account within same group if configured.
        IF
            l_allow_dup = 'N'
            AND p_row.account_no IS NOT NULL
            AND p_row.ifsc_code IS NOT NULL
        THEN
            SELECT
                COUNT(*)
            INTO l_count
            FROM
                stg_mst_beneficiary
            WHERE
                    group_id = p_group_id
                AND row_status = 'ACTIVE'
                AND account_no = p_row.account_no
                AND ifsc_code = p_row.ifsc_code;

            IF l_count > 1 THEN
                p_append_error(p_errors, p_err_count, 'ACCOUNT_NO', 'ACCOUNT_NO', 'Account No',
                               'Duplicate payment account in group');
            END IF;

        END IF;

        -- Step 4: Block multiple accounts for the same Aadhaar/Jan Aadhaar if configured.
        IF
            l_allow_multi = 'N'
            AND ( p_row.aadhaar_ref_no IS NOT NULL
                  OR p_row.jan_aadhar_id IS NOT NULL )
        THEN
            SELECT
                COUNT(*)
            INTO l_count
            FROM
                mst_payee
            WHERE
                    active_flag = 'Y'
                AND ( aadhaar_ref_no = p_row.aadhaar_ref_no
                      OR jan_aadhar_id = p_row.jan_aadhar_id )
                AND nvl(account_no, '#') <> nvl(p_row.account_no, '#');

            IF l_count > 0 THEN
                p_append_error(p_errors, p_err_count, 'ACCOUNT_NO', 'ACCOUNT_NO', 'Account No',
                               'Multiple accounts for same identity not allowed');
            END IF;

        END IF;

        -- Step 5: Block same account with different identity if configured.
        IF
            l_allow_same = 'N'
            AND p_row.account_no IS NOT NULL
            AND p_row.ifsc_code IS NOT NULL
        THEN
            SELECT
                COUNT(*)
            INTO l_count
            FROM
                mst_payee
            WHERE
                    active_flag = 'Y'
                AND account_no = p_row.account_no
                AND ifsc_code = p_row.ifsc_code
                AND ( nvl(aadhaar_ref_no, '#') <> nvl(p_row.aadhaar_ref_no, '#')
                      OR nvl(jan_aadhar_id, '#') <> nvl(p_row.jan_aadhar_id, '#') );

            IF l_count > 0 THEN
                p_append_error(p_errors, p_err_count, 'ACCOUNT_NO', 'ACCOUNT_NO', 'Account No',
                               'Same account with different identity not allowed');
            END IF;

        END IF;

        -- Step 6: Block cross identifier mismatch if configured.
        IF
            l_allow_cross = 'N'
            AND p_row.account_no IS NOT NULL
            AND p_row.ifsc_code IS NOT NULL
        THEN
            SELECT
                COUNT(*)
            INTO l_count
            FROM
                mst_payee
            WHERE
                    active_flag = 'Y'
                AND account_no = p_row.account_no
                AND ifsc_code = p_row.ifsc_code
                AND ( ( p_row.aadhaar_ref_no IS NOT NULL
                        AND nvl(aadhaar_ref_no, '#') <> p_row.aadhaar_ref_no )
                      OR ( p_row.jan_aadhar_id IS NOT NULL
                           AND nvl(jan_aadhar_id, '#') <> p_row.jan_aadhar_id ) );

            IF l_count > 0 THEN
                p_append_error(p_errors, p_err_count, 'ACCOUNT_NO', 'ACCOUNT_NO', 'Account No',
                               'Cross identifier mismatch not allowed');
            END IF;

        END IF;

    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_validate_group
    -- Business purpose:
    --   Validate active staged rows. Field checks apply only when configured;
    --   scheme policy checks apply only when a policy row exists.
    --------------------------------------------------------------------------
    PROCEDURE pr_validate_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_group_id  NUMBER;
        l_scheme_id NUMBER;
        l_user      VARCHAR2(100);
        l_errors    CLOB;
        l_err_count NUMBER;
        l_value     VARCHAR2(4000);
        l_total     NUMBER;
        l_active    NUMBER;
        l_valid     NUMBER;
        l_invalid   NUMBER;
        l_removed   NUMBER;
        l_status    VARCHAR2(30);
        l_run_no    NUMBER;
    BEGIN
        -- Step 1: Read group, verify it is editable, and get scheme.
        l_group_id := f_json_number(p_req, '$.group_id');
        l_user := nvl(f_json_varchar(p_req, '$.validated_by'),user );
      --  p_assert_group_exists(l_group_id);
        p_assert_group_editable(l_group_id);
        SELECT
            scheme_id
        INTO l_scheme_id
        FROM
            mst_beneficiary_group
        WHERE
            group_id = l_group_id;

        -- Step 2: Validate each active staged row.
        FOR s IN (
            SELECT
                *
            FROM
                stg_mst_beneficiary
            WHERE
                    group_id = l_group_id
                AND row_status = 'ACTIVE'
            ORDER BY
                row_no
        ) LOOP
            l_errors := '[';
            l_err_count := 0;

            -- Step 2a: Apply field validation rows. If none exist, this loop is skipped.
            FOR v IN (
                SELECT
                    column_name,
                    field_code,
                    attr_label,
                    attr_type,
                    is_required
                FROM
                    mst_beneficiary_field_validation
                WHERE
                        active_flag = 'Y'
                    AND ( scheme_id = l_scheme_id
                          OR scheme_id IS NULL )
                ORDER BY
                    nvl(display_sequence, 999999),
                    column_name
            ) LOOP
                l_value := f_get_stage_value(s, v.column_name);
                IF
                    v.is_required = 'Y'
                    AND TRIM(l_value) IS NULL
                    AND UPPER(v.field_code) <> 'AADHAAR'------pravesh 05062026--
                THEN
                    p_append_error(l_errors, l_err_count, v.column_name, v.field_code, v.attr_label,
                                   'Mandatory field missing');

                ELSIF TRIM(l_value) IS NOT NULL THEN
                    IF
                        v.attr_type = 'MOBILE'
                        AND f_validate_mobile(l_value) = 'N'
                    THEN
                        p_append_error(l_errors, l_err_count, v.column_name, v.field_code, v.attr_label,
                                       'Mobile number invalid');

                    ELSIF
                        v.attr_type = 'IFSC'
                        AND f_validate_ifsc(l_value) = 'N'
                    THEN
                        p_append_error(l_errors, l_err_count, v.column_name, v.field_code, v.attr_label,
                                       'IFSC invalid');
                    ELSIF
                        v.attr_type = 'NUMBER'
                        AND f_validate_number(l_value) = 'N'
                    THEN
                        p_append_error(l_errors, l_err_count, v.column_name, v.field_code, v.attr_label,
                                       'Number invalid');
                    END IF;
                END IF;

            END LOOP;

            -- Step 2b: Apply scheme policy checks only if policy row exists.
            p_apply_policy_checks(l_group_id, l_scheme_id, s, l_errors, l_err_count);

            -- Step 2c: Store validation outcome row-wise.
            l_errors := l_errors || ']';
            UPDATE stg_mst_beneficiary
            SET
                validation_status =
                    CASE
                        WHEN l_err_count = 0 THEN
                            'VALID'
                        ELSE
                            'INVALID'
                    END,
                error_count = l_err_count,
                error_json =
                    CASE
                        WHEN l_err_count = 0 THEN
                            NULL
                        ELSE
                            l_errors
                    END,
                modified_by = l_user,
                modified_date = systimestamp
            WHERE
                stage_row_id = s.stage_row_id;

        END LOOP;

        -- Step 3: Summarize group validation result.
        SELECT
            COUNT(*),
            nvl(
                sum(
                    CASE
                        WHEN row_status = 'ACTIVE' THEN
                            1
                        ELSE 0
                    END
                ),
                0
            ),
            nvl(
                sum(
                    CASE
                        WHEN
                            row_status = 'ACTIVE'
                            AND validation_status = 'VALID'
                        THEN
                            1
                        ELSE 0
                    END
                ),
                0
            ),
            nvl(
                sum(
                    CASE
                        WHEN
                            validation_status = 'INVALID'
                            AND row_status = 'ACTIVE'
                        THEN
                            1
                        ELSE 0
                    END
                ),
                0
            ),
            nvl(
                sum(
                    CASE
                        WHEN row_status = 'REMOVED' THEN
                            1
                        ELSE 0
                    END
                ),
                0
            )
        INTO
            l_total,
            l_active,
            l_valid,
            l_invalid,
            l_removed
        FROM
            stg_mst_beneficiary
        WHERE
            group_id = l_group_id;

        l_status :=
            CASE
                WHEN l_invalid = 0 THEN
                    'VALIDATED'
                ELSE 'VALIDATION_FAILED'
            END;
        UPDATE mst_beneficiary_group
        SET
            process_status = l_status,
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
            group_id = l_group_id;

        SELECT
            nvl(
                max(validation_run_no),
                0
            ) + 1
        INTO l_run_no
        FROM
            mst_beneficiary_validation_run
        WHERE
            group_id = l_group_id;

        INSERT INTO mst_beneficiary_validation_run (
            group_id,
            validation_run_no,
            total_rows,
            active_rows,
            valid_rows,
            invalid_rows,
            removed_rows,
            process_status_after,
            created_by
        ) VALUES ( l_group_id,
                   l_run_no,
                   l_total,
                   l_active,
                   l_valid,
                   l_invalid,
                   l_removed,
                   l_status,
                   l_user );

        MERGE INTO mst_beneficiary_group_ext t
        USING (
            SELECT
                l_group_id group_id,
                l_run_no   run_no,
                l_user     user_name
            FROM
                dual
        ) s ON ( t.group_id = s.group_id )
        WHEN MATCHED THEN UPDATE
        SET validation_attempt_count = nvl(validation_attempt_count, 0) + 1,
            latest_validation_run_no = s.run_no,
            last_validated_date = systimestamp,
            modified_by = s.user_name,
            modified_date = systimestamp
        WHEN NOT MATCHED THEN
        INSERT (
            group_id,
            mapping_version_snapshot,
            validation_attempt_count,
            latest_validation_run_no,
            last_validated_date,
            created_by )
        VALUES
            ( s.group_id,
              1,
              1,
              s.run_no,
              systimestamp,
              s.user_name );

        -- Step 4: Insert run detail and return counts.
        p_insert_group_run_detail(l_group_id, 'VALIDATE', l_status, l_user, 'Group validation completed');
        COMMIT;
        p_set_success('{"group_id":'
                      || l_group_id
                      || ',"total_rows":'
                      || l_total
                      || ',"invalid_rows":'
                      || l_invalid
                      || ',"validation_run_no":'
                      || l_run_no
                      || ',"process_status":'
                      || f_json_quote(l_status)
                      || '}',
                      p_resp,
                      p_status,
                      p_err_msg,
                      p_err_code);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_set_error(sqlerrm,
                        to_char(sqlcode),
                        p_resp,
                        p_status,
                        p_err_msg,
                        p_err_code);
    END;

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_get_group_validation_result
    -- Business purpose:
    --   Return paged validation results for UI correction/removal.
    --------------------------------------------------------------------------
    PROCEDURE pr_get_group_validation_result (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_group_id      NUMBER;
        l_arr           CLOB := '[';
        l_arr1          CLOB := '[';
        l_invalid_first BOOLEAN := TRUE;
        l_valid_first   BOOLEAN := TRUE;
        l_runs          CLOB := '[';
        l_run_first     BOOLEAN := TRUE;
        l_group_summary CLOB;
    BEGIN
        -- Step 1: Read group id.
        l_group_id := f_json_number(p_req, '$.group_id');
     --   p_assert_group_exists(l_group_id);

        -- Step 2: Return inactive rows with current validation status.
        FOR r IN (
            SELECT
                stage_row_id,
                row_no,
                validation_status,
                error_json,
                beneficiary_name,
               -- aadhaar_ref_no,--05062026
                jan_aadhar_id,
                mobile_no,
                state_name,
                district_name,
                account_no,
                ifsc_code,
                amount,
                installment_no,
                attr1_val,
                attr2_val
            FROM
                stg_mst_beneficiary
            WHERE
                    group_id = l_group_id
                AND row_status = 'ACTIVE'
                AND validation_status = 'INVALID'
            ORDER BY
                row_no
        ) LOOP
            IF NOT l_invalid_first THEN
                l_arr := l_arr || ' , ';
            END IF;
            l_arr := l_arr
                     || '{"stage_row_id":'
                     || r.stage_row_id
                     || ',"row_no":'
                     || r.row_no
                     || ',"validation_status":'
                     || f_json_quote(r.validation_status)
                     || ',"beneficiary_name":'
                     || f_json_quote(r.beneficiary_name)
                    -- || ',"aadhaar_ref_no":'
                    -- || f_json_quote(r.aadhaar_ref_no)  ---------0506026 jabir
                     || ',"jan_aadhar_id":'
                     || f_json_quote(r.jan_aadhar_id)
                     || ',"mobile_no":'
                     || f_json_quote(r.mobile_no)
                     || ',"state_name":'
                     || f_json_quote(r.state_name)
                     || ',"district_name":'
                     || f_json_quote(r.district_name)
                     || ',"account_no":'
                     || f_json_quote(r.account_no)
                     || ',"ifsc_code":'
                     || f_json_quote(r.ifsc_code)
                     || ',"amount":'
                     || nvl(
                to_char(r.amount),
                'null'
            )
                     || ',"installment_no":'
                     || to_char(nvl(r.installment_no,0))
                     || ',"attr1_val":'
                     || f_json_quote(r.attr1_val)
                     || ',"attr2_val":'
                     || f_json_quote(r.attr2_val)
                     || ',"errors":'
                     || nvl(r.error_json, '[]')
                     || '}';

            l_invalid_first := FALSE;
        END LOOP;
     --    l_arr := l_arr || ']';


        -- Step 2.5: Return active rows with current validation status.
        FOR r IN (
            SELECT
                stage_row_id,
                row_no,
                validation_status,
                error_json,
                beneficiary_name,
                --aadhaar_ref_no,--05062026
                jan_aadhar_id,
                mobile_no,
                state_name,
                district_name,
                account_no,
                ifsc_code,
                amount,
                installment_no,
                attr1_val,
                attr2_val
            FROM
                stg_mst_beneficiary
            WHERE
                    group_id = l_group_id
                AND row_status = 'ACTIVE'
                AND validation_status = 'VALID'
            ORDER BY
                row_no
        ) LOOP
            IF NOT l_valid_first THEN
                l_arr1 := l_arr1 || ',  ';
            END IF;
            l_arr1 := l_arr1
                      || '{"stage_row_id":'
                      || r.stage_row_id
                      || ',"row_no":'
                      || r.row_no
                      || ',"validation_status":'
                      || f_json_quote(r.validation_status)
                      || ',"beneficiary_name":'
                      || f_json_quote(r.beneficiary_name)
--                      || ',"aadhaar_ref_no":'
--                      || f_json_quote(r.aadhaar_ref_no)  -----0506026 jabir
                      || ',"jan_aadhar_id":'
                      || f_json_quote(r.jan_aadhar_id)
                      || ',"mobile_no":'
                      || f_json_quote(r.mobile_no)
                      || ',"state_name":'
                      || f_json_quote(r.state_name)
                      || ',"district_name":'
                      || f_json_quote(r.district_name)
                      || ',"account_no":'
                      || f_json_quote(r.account_no)
                      || ',"ifsc_code":'
                      || f_json_quote(r.ifsc_code)
                      || ',"amount":'
                      || nvl(
                to_char(r.amount),
                'null'
            )
                       || ',"installment_no":'
                     || to_char(nvl(r.installment_no,0))
                      || ',"attr1_val":'
                      || f_json_quote(r.attr1_val)
                      || ',"attr2_val":'
                      || f_json_quote(r.attr2_val)
                      || ',"errors":'
                      || nvl(r.error_json, '[]')
                      || '}';

            l_valid_first := FALSE;
        END LOOP;
       --     l_arr1 := l_arr1 || ']';
        SELECT
            '{"process_status":'
            || f_json_quote(g.process_status)
            || ',"processed_flag":'
            || f_json_quote(g.processed_flag)
            || ',"mapping_version_snapshot":'
            || nvl(
                to_char(e.mapping_version_snapshot),
                'null'
            )
            || ',"validation_attempt_count":'
            || nvl(
                to_char(e.validation_attempt_count),
                '0'
            )
            || ',"latest_validation_run_no":'
            || nvl(
                to_char(e.latest_validation_run_no),
                '0'
            )
            || ',"last_validated_date":'
            || f_json_quote(to_char(e.last_validated_date, 'YYYY-MM-DD HH24:MI:SS'))
            || '}'
        INTO l_group_summary
        FROM
            mst_beneficiary_group     g
            LEFT JOIN mst_beneficiary_group_ext e ON e.group_id = g.group_id
        WHERE
            g.group_id = l_group_id;

        FOR vr IN (
            SELECT
                validation_run_no,
                total_rows,
                active_rows,
                valid_rows,
                invalid_rows,
                removed_rows,
                process_status_after,
                created_date
            FROM
                mst_beneficiary_validation_run
            WHERE
                    group_id = l_group_id
                AND validation_run_no = (
                    SELECT
                        MAX(validation_run_no)
                    FROM
                        mst_beneficiary_validation_run
                    WHERE
                        group_id = l_group_id
                )          ----------------------1505026
            ORDER BY
                validation_run_no DESC
        ) LOOP
            IF NOT l_run_first THEN
                l_runs := l_runs || ',';
            END IF;
            l_runs := l_runs
                      || '{"validation_run_no":'
                      || vr.validation_run_no
                      || ',"total_rows":'
                      || vr.total_rows
                      || ',"active_rows":'
                      || vr.active_rows
                      || ',"valid_rows":'
                      || vr.valid_rows
                      || ',"invalid_rows":'
                      || vr.invalid_rows
                      || ',"removed_rows":'
                      || vr.removed_rows
                      || ',"process_status_after":'
                      || f_json_quote(vr.process_status_after)
                      || ',"created_date":'
                      || f_json_quote(to_char(vr.created_date, 'YYYY-MM-DD HH24:MI:SS'))
                      || '}';

            l_run_first := FALSE;
        END LOOP;
        
--              IF l_invalid_first THEN
--                    l_arr := '[]';
--                ELSE
--                    l_arr := l_arr || ']';
--                END IF;
--            
--                IF l_valid_first THEN
--                    l_arr1 := '[]';
--                ELSE
--                    l_arr1 := l_arr1 || ']';
--                END IF;
--            
--                IF l_run_first THEN
--                    l_runs := '[]';
--                ELSE
--                    l_runs := l_runs || ']';
--                END IF;

   -- l_runs := l_runs || ']';
        -- Step 3: Return validation rows.
        p_set_success('{"group_id":'
                      || l_group_id
                      || ',"group_summary":'
                      || nvl(l_group_summary, '{}')
                      || ',"invalid_rows":'
                      || l_arr
                      || ']'
                      || ',"valid_rows":'
                      || l_arr1
                      || ']'
                      || ',"validation_runs":'
                      || l_runs
                      || ']}',
                      p_resp,
                      p_status,
                      p_err_msg,
                      p_err_code);

			
--------------------------------------------05062026---------------------------------  
EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
           package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_get_group_validation_result',
                p_type        => 1,
                p_ref_no      => l_group_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM || CHR(10) ||
                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY   => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
 END;    
    --------------------------------------------------------------------------
    -- PROCEDURE: pr_process_group
    -- Business purpose:
    --   Submit validated staged rows into MST_PAYEE and MST_BENEFICIARY.
    --   This procedure does NOT set PROCESSED_FLAG='Y'. That is downstream work.
    --------------------------------------------------------------------------
--    PROCEDURE pr_process_group (
--        p_req      IN CLOB,
--        p_resp     OUT CLOB,
--        p_status   OUT VARCHAR2,
--        p_err_msg  OUT VARCHAR2,
--        p_err_code OUT VARCHAR2
--    ) IS
--
--        l_group_id        NUMBER;
--        l_scheme_id       NUMBER;
--        l_user            VARCHAR2(100);
--        l_invalid         NUMBER;
--        l_payee_id        NUMBER;
--        l_beneficiary_id  NUMBER;
--        l_count           NUMBER := 0;
--        l_duplicate_count NUMBER;
--    BEGIN
--
--    -----------------------------------------------------------------
--    -- Step 1 : Read Input
--    -----------------------------------------------------------------
--
--        l_group_id := f_json_number(p_req, '$.group_id');
--        l_user := nvl(
--        f_json_varchar(p_req, '$.processed_by'),user );
--
--    -----------------------------------------------------------------
--    -- Step 2 : Validate Group
--    -----------------------------------------------------------------
--
--        p_assert_group_editable(l_group_id);
--        SELECT
--            scheme_id
--        INTO l_scheme_id
--        FROM
--            mst_beneficiary_group
--        WHERE
--            group_id = l_group_id;
--
--    -----------------------------------------------------------------
--    -- Step 3 : Check Invalid Rows
--    -----------------------------------------------------------------
--
--        SELECT
--            COUNT(*)
--        INTO l_invalid
--        FROM
--            stg_mst_beneficiary
--        WHERE
--                group_id = l_group_id
--            AND row_status = 'ACTIVE'
--            AND nvl(validation_status, 'PENDING') <> 'VALID';
--
--        IF l_invalid > 0 THEN
--            raise_application_error(-20030, 'Group contains invalid or pending rows. Please validate all rows before submit.');
--        END IF;
--
--    -----------------------------------------------------------------
--    -- Step 4 : Process Valid Rows
--    -----------------------------------------------------------------
--
--        FOR s IN (
--            SELECT
--                s.*
--            FROM
--                     stg_mst_beneficiary s
--                JOIN (
--                    SELECT
--                        group_id,
--                        MAX(run_no) AS run_no
--                    FROM
--                        mst_beneficiary_group_run_details
--                    GROUP BY
--                        group_id
--                ) g ON s.group_id = g.group_id
--            WHERE
--                    s.group_id = l_group_id
--                AND s.row_status = 'ACTIVE'
--                AND s.validation_status = 'VALID'
--            ORDER BY
--                s.row_no
--        ) LOOP
--
--        -----------------------------------------------------------------
--        -- Step 4.1 : Duplicate Check BEFORE Payee Insert
--        -----------------------------------------------------------------
--
--            SELECT
--                COUNT(*)
--            INTO l_duplicate_count
--            FROM
--                mst_beneficiary mb
--            WHERE
--                    mb.beneficiary_status = 'ACTIVE'
--                AND nvl(mb.group_id, 0) <> nvl(l_group_id, 0)
--                AND ( ( s.aadhaar_ref_no IS NOT NULL
--                        AND TRIM(mb.aadhaar_ref_no) = TRIM(s.aadhaar_ref_no) )
--                      OR ( s.jan_aadhar_id IS NOT NULL
--                           AND TRIM(mb.jan_aadhar_id) = TRIM(s.jan_aadhar_id) )
--                      OR ( s.account_no IS NOT NULL
--                           AND s.ifsc_code IS NOT NULL
--                           AND TRIM(mb.account_no) = TRIM(s.account_no)
--                           AND upper(trim(mb.ifsc_code)) = upper(trim(s.ifsc_code)) ) );
--
--        -----------------------------------------------------------------
--        -- Duplicate Found
--        -----------------------------------------------------------------
--
--            IF l_duplicate_count > 0 THEN
--                UPDATE stg_mst_beneficiary
--                SET
--                    validation_status = 'INVALID',
--                    error_json = 'Duplicate beneficiary already exists in master',
--                    modified_by = l_user,
--                    modified_date = systimestamp
--                WHERE
--                    stage_row_id = s.stage_row_id;
--
--                CONTINUE;
--            END IF;
--
--        -----------------------------------------------------------------
--        -- Step 4.2 : Insert / Update Payee
--        -----------------------------------------------------------------
--
--            p_upsert_payee(s.beneficiary_name,
--           -- s.aadhaar_ref_no, 
--            s.jan_aadhar_id,
--            s.mobile_no, 
--            s.state_name,
--         s.district_name, 
--         s.ifsc_code, 
--         s.account_no, 
--         l_user, 
--         l_payee_id);
--
--        -----------------------------------------------------------------
--        -- Update Payee ID in Stage Table
--        -----------------------------------------------------------------
--
--            UPDATE stg_mst_beneficiary
--            SET
--                payee_id = l_payee_id,
--                modified_by = l_user,
--                modified_date = systimestamp
--            WHERE
--                stage_row_id = s.stage_row_id;
--
--        -----------------------------------------------------------------
--        -- Step 4.3 : Insert / Update Beneficiary
--        -----------------------------------------------------------------
--
--            MERGE INTO mst_beneficiary b
--            USING (
--                SELECT
--                    s.stage_row_id AS source_stage_row_id
--                FROM
--                    dual
--            ) src ON ( b.source_stage_row_id = src.source_stage_row_id )
--            WHEN MATCHED THEN UPDATE
--            SET payee_id = l_payee_id,
--                beneficiary_name = s.beneficiary_name,
--                aadhaar_ref_no = s.aadhaar_ref_no,
--                jan_aadhar_id = s.jan_aadhar_id,
--                mobile_no = s.mobile_no,
--                state_name = s.state_name,
--                district_name = s.district_name,
--                ifsc_code = s.ifsc_code,
--                account_no = s.account_no,
--                amount = s.amount,
--                beneficiary_status = 'ACTIVE',
--                modified_by = l_user,
--                modified_date = systimestamp
--            WHEN NOT MATCHED THEN
--            INSERT (
--                group_id,
--                scheme_id,
--                payee_id,
--                source_stage_row_id,
--                source_row_no,
--                beneficiary_status,
--                beneficiary_name,
--                aadhaar_ref_no,
--                jan_aadhar_id,
--                mobile_no,
--                state_name,
--                district_name,
--                ifsc_code,
--                account_no,
--                amount,
--                attr1_val,
--                attr2_val,
--                attr3_val,
--                attr4_val,
--                attr5_val,
--                attr6_val,
--                attr7_val,
--                attr8_val,
--                attr9_val,
--                attr10_val,
--                attr11_val,
--                attr12_val,
--                attr13_val,
--                attr14_val,
--                attr15_val,
--                attr16_val,
--                attr17_val,
--                attr18_val,
--                attr19_val,
--                attr20_val,
--                created_by )
--            VALUES
--                ( l_group_id,
--                  l_scheme_id,
--                  l_payee_id,
--                  s.stage_row_id,
--                  s.row_no,
--                  'ACTIVE',
--                  s.beneficiary_name,
--                  s.aadhaar_ref_no,
--                  s.jan_aadhar_id,
--                  s.mobile_no,
--                  s.state_name,
--                  s.district_name,
--                  s.ifsc_code,
--                  s.account_no,
--                  s.amount,
--                  s.attr1_val,
--                  s.attr2_val,
--                  s.attr3_val,
--                  s.attr4_val,
--                  s.attr5_val,
--                  s.attr6_val,
--                  s.attr7_val,
--                  s.attr8_val,
--                  s.attr9_val,
--                  s.attr10_val,
--                  s.attr11_val,
--                  s.attr12_val,
--                  s.attr13_val,
--                  s.attr14_val,
--                  s.attr15_val,
--                  s.attr16_val,
--                  s.attr17_val,
--                  s.attr18_val,
--                  s.attr19_val,
--                  s.attr20_val,
--                  l_user );
--
--        -----------------------------------------------------------------
--        -- Success Count
--        -----------------------------------------------------------------
--
--            l_count := l_count + 1;
--        END LOOP;
--
--    -----------------------------------------------------------------
--    -- Step 5 : Update Group Status
--    -----------------------------------------------------------------
--
--        UPDATE mst_beneficiary_group
--        SET
--            process_status = 'SUBMITTED',
--            modified_by = l_user,
--            modified_date = systimestamp
--        WHERE
--            group_id = l_group_id;
--
--    -----------------------------------------------------------------
--    -- Step 6 : Audit + Run Detail
--    -----------------------------------------------------------------
--
--        p_insert_group_run_detail(l_group_id, 'SUBMIT_GROUP', 'SUBMITTED', l_user, 'Rows copied to master beneficiary');
--        p_audit_group(l_group_id, 'SUBMIT', NULL, p_req, 'Group submitted to beneficiary master',
--                      l_user);
--
--    -----------------------------------------------------------------
--    -- Commit
--    -----------------------------------------------------------------
--
--        COMMIT;
--
--    -----------------------------------------------------------------
--    -- Success Response
--    -----------------------------------------------------------------
--
--        p_set_success('{"group_id":'
--                      || l_group_id
--                      || ',"submitted_rows":'
--                      || l_count
--                      || ',"processed_flag":"N"}', p_resp, p_status, p_err_msg, p_err_code);
--
----------------------------------------------05062026---------------------------------  
--EXCEPTION
--    WHEN OTHERS THEN
--
--        ROLLBACK;
--
--        BEGIN
--           package_bnf_pns.ots_benf_error_log(
--                p_module_name => 'package_bnf_pns',
--                p_proc_name   => 'package_bnf_pns.pr_process_group',
--                p_type        => 1,
--                p_ref_no      => l_group_id,
--                p_err_code    => TO_CHAR(SQLCODE),
--                p_err_msg     => SQLERRM || CHR(10) ||
--                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
--                p_SEVERITY   => 'ERROR',
--                p_request     => p_req
--            );
--        EXCEPTION
--            WHEN OTHERS THEN
--                NULL;
--        END;
--
--        package_bnf_pns.p_set_error(
--            SQLERRM,
--            TO_CHAR(SQLCODE),
--            p_resp,
--            p_status,
--            p_err_msg,
--            p_err_code
--        );
-- END pr_process_group;  

 PROCEDURE pr_process_group (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_group_id        NUMBER;
        l_scheme_id       NUMBER;
        l_user            VARCHAR2(100);
        l_invalid         NUMBER;
        l_payee_id        NUMBER;
        l_beneficiary_id  NUMBER;
        l_count           NUMBER := 0;
        l_duplicate_count NUMBER;
		
l_assignment_id NUMBER;
l_ddo_code      NUMBER;
l_office_id     NUMBER;
l_treas_code    VARCHAR2(20);
l_source_type   VARCHAR2(20);
    BEGIN

    -----------------------------------------------------------------
    -- Step 1 : Read Input
    -----------------------------------------------------------------
         l_assignment_id := f_json_number(p_req, '$.assignment_id');
        l_group_id := f_json_number(p_req, '$.group_id');
        l_user := nvl(
        f_json_varchar(p_req, '$.processed_by'),user );

    -----------------------------------------------------------------
    -- Step 2 : Validate Group
    -----------------------------------------------------------------

        p_assert_group_editable(l_group_id);
		
		if l_assignment_id is not null then 
BEGIN
    SELECT
        TO_NUMBER(a.assignment_value),
        b.office_id,
        b.treas_code
    INTO
        l_ddo_code,
        l_office_id,
        l_treas_code
    FROM vu_sso_user_role a
         JOIN mdm.office_ddo_treasury_map b
           ON b.ddo_code = TO_NUMBER(a.assignment_value)
          AND b.is_active = 'Y'
    WHERE a.assignment_id = l_assignment_id;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(
            -20001,
            'DDO/Office/Treasury mapping not found for Assignment ID : '
            || l_assignment_id
        );
END;
end if;

--------------------------------------------------------------------
-- Get Scheme ID --- Jabir 3006026 --data not inserted into mst_payee
---------------------------------------------------------------------
SELECT scheme_id
INTO l_scheme_id
FROM mst_beneficiary_group
WHERE group_id = l_group_id;

--DBMS_OUTPUT.PUT_LINE('Group Id  : ' || l_group_id);
--DBMS_OUTPUT.PUT_LINE('Scheme Id : ' || l_scheme_id);
    -----------------------------------------------------------------
    -- Step 3 : Check Invalid Rows
    -----------------------------------------------------------------

        SELECT
            COUNT(*)
        INTO l_invalid
        FROM
            stg_mst_beneficiary
        WHERE
                group_id = l_group_id
            AND row_status = 'ACTIVE'
            AND nvl(validation_status, 'PENDING') <> 'VALID';

        IF l_invalid > 0 THEN
            raise_application_error(-20030, 'Group contains invalid or pending rows. Please validate all rows before submit.');
        END IF;

    -----------------------------------------------------------------
    -- Step 4 : Process Valid Rows
    -----------------------------------------------------------------

        FOR s IN (
            SELECT
                s.*
            FROM
                     stg_mst_beneficiary s
                JOIN (
                    SELECT
                        group_id,
                        MAX(run_no) AS run_no
                    FROM
                        mst_beneficiary_group_run_details
                    GROUP BY
                        group_id
                ) g ON s.group_id = g.group_id
            WHERE
                    s.group_id = l_group_id
                AND s.row_status = 'ACTIVE'
                AND s.validation_status = 'VALID'
            ORDER BY
                s.row_no
        ) LOOP

        -----------------------------------------------------------------
        -- Step 4.1 : Duplicate Check BEFORE Payee Insert
        -----------------------------------------------------------------

            SELECT
                COUNT(*)
            INTO l_duplicate_count
            FROM
                mst_beneficiary mb
            WHERE
                    mb.beneficiary_status = 'ACTIVE'
                AND nvl(mb.group_id, 0) <> nvl(l_group_id, 0)
                AND ( ( s.aadhaar_ref_no IS NOT NULL
                        AND TRIM(mb.aadhaar_ref_no) = TRIM(s.aadhaar_ref_no) )
                      OR ( s.jan_aadhar_id IS NOT NULL
                           AND TRIM(mb.jan_aadhar_id) = TRIM(s.jan_aadhar_id) )
                      OR ( s.account_no IS NOT NULL
                           AND s.ifsc_code IS NOT NULL
                           AND TRIM(mb.account_no) = TRIM(s.account_no)
                           AND upper(trim(mb.ifsc_code)) = upper(trim(s.ifsc_code)) ) );

        -----------------------------------------------------------------
        -- Duplicate Found
        -----------------------------------------------------------------

            IF l_duplicate_count > 0 THEN
                UPDATE stg_mst_beneficiary
                SET
                    validation_status = 'INVALID',
                    error_json = 'Duplicate beneficiary already exists in master',
                    modified_by = l_user,
                    modified_date = systimestamp
                WHERE
                    stage_row_id = s.stage_row_id;

                CONTINUE;
            END IF;

        -----------------------------------------------------------------
        -- Step 4.2 : Insert / Update Payee
  -----------------------------------------------------------------
  --------------2006026 Jabir-----------------------------
p_upsert_payee(
    s.beneficiary_name,
    s.jan_aadhar_id,
    s.mobile_no,
    s.state_name,
    s.district_name,
    s.ifsc_code,
    s.account_no,
    l_user,
    l_ddo_code,
    l_office_id,
    l_treas_code,
    l_source_type,
    l_payee_id
);
----------------------------------------------2006026 Jabir ---------------------------
        -----------------------------------------------------------------
        -- Update Payee ID in Stage Table
        -----------------------------------------------------------------

            UPDATE stg_mst_beneficiary
            SET
                payee_id = l_payee_id,
                modified_by = l_user,
                modified_date = systimestamp
            WHERE
                stage_row_id = s.stage_row_id;

        -----------------------------------------------------------------
        -- Step 4.3 : Insert / Update Beneficiary
        -----------------------------------------------------------------

            MERGE INTO mst_beneficiary b
            USING (
                SELECT
                    s.stage_row_id AS source_stage_row_id
                FROM
                    dual
            ) src ON ( b.source_stage_row_id = src.source_stage_row_id )
            WHEN MATCHED THEN UPDATE
            SET payee_id = l_payee_id,
                beneficiary_name = s.beneficiary_name,
                aadhaar_ref_no = s.aadhaar_ref_no,
                jan_aadhar_id = s.jan_aadhar_id,
                mobile_no = s.mobile_no,
                state_name = s.state_name,
                district_name = s.district_name,
                ifsc_code = s.ifsc_code,
                account_no = s.account_no,
                amount = s.amount,
                beneficiary_status = 'ACTIVE',
                modified_by = l_user,
                modified_date = systimestamp
            WHEN NOT MATCHED THEN
            INSERT (
                group_id,
                scheme_id,
                payee_id,
                source_stage_row_id,
                source_row_no,
                beneficiary_status,
                beneficiary_name,
                aadhaar_ref_no,
                jan_aadhar_id,
                mobile_no,
                state_name,
                district_name,
                ifsc_code,
                account_no,
                amount,
                attr1_val,
                attr2_val,
                attr3_val,
                attr4_val,
                attr5_val,
                attr6_val,
                attr7_val,
                attr8_val,
                attr9_val,
                attr10_val,
                attr11_val,
                attr12_val,
                attr13_val,
                attr14_val,
                attr15_val,
                attr16_val,
                attr17_val,
                attr18_val,
                attr19_val,
                attr20_val,
                created_by )
            VALUES
                ( l_group_id,
                  l_scheme_id,
                  l_payee_id,
                  s.stage_row_id,
                  s.row_no,
                  'ACTIVE',
                  s.beneficiary_name,
                  s.aadhaar_ref_no,
                  s.jan_aadhar_id,
                  s.mobile_no,
                  s.state_name,
                  s.district_name,
                  s.ifsc_code,
                  s.account_no,
                  s.amount,
                  s.attr1_val,
                  s.attr2_val,
                  s.attr3_val,
                  s.attr4_val,
                  s.attr5_val,
                  s.attr6_val,
                  s.attr7_val,
                  s.attr8_val,
                  s.attr9_val,
                  s.attr10_val,
                  s.attr11_val,
                  s.attr12_val,
                  s.attr13_val,
                  s.attr14_val,
                  s.attr15_val,
                  s.attr16_val,
                  s.attr17_val,
                  s.attr18_val,
                  s.attr19_val,
                  s.attr20_val,
                  l_user );

        -----------------------------------------------------------------
        -- Success Count
        -----------------------------------------------------------------

            l_count := l_count + 1;
        END LOOP;

    -----------------------------------------------------------------
    -- Step 5 : Update Group Status
    -----------------------------------------------------------------

        UPDATE mst_beneficiary_group
        SET
            process_status = 'SUBMITTED',
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
            group_id = l_group_id;

    -----------------------------------------------------------------
    -- Step 6 : Audit + Run Detail
    -----------------------------------------------------------------

        p_insert_group_run_detail(l_group_id, 'SUBMIT_GROUP', 'SUBMITTED', l_user, 'Rows copied to master beneficiary');
        p_audit_group(l_group_id, 'SUBMIT', NULL, p_req, 'Group submitted to beneficiary master',
                      l_user);

        COMMIT;
 ------------------------------------2406026 Jabir-----------------------------------------------------------       
        p_set_success('{"group_id":'
                      || l_group_id
                      || ',"submitted_rows":'
                      || l_count
                      || ',"processed_flag":"N"}', p_resp, p_status, p_err_msg, p_err_code);




--------------------------------------2406026-----------------------------------------------------
EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
           package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_process_group',
                p_type        => 1,
                p_ref_no      => l_group_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM || CHR(10) ||
                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY   => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
 END pr_process_group;

--------------------------------------------05062026---------------------------------  

    --------------------------------------------------------------------------
    -- PROCEDURE: pr_save_individual_beneficiary
    -- Business purpose:
    --   Save individual beneficiary directly to MST_PAYEE without scheme/group.
    --   Dedupe uses Aadhaar Ref, Jan Aadhaar, Account+IFSC, then Mobile+Name.
    --------------------------------------------------------------------------

 PROCEDURE pr_save_individual_beneficiary (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_payee_id NUMBER;
        l_user     VARCHAR2(100);
        l_name     VARCHAR2(300);
    ---l_aadhaar  VARCHAR2(200);
        l_jan      VARCHAR2(100);
        l_mobile   VARCHAR2(20);
        l_state    VARCHAR2(200);
        l_district VARCHAR2(200);
        l_ifsc     VARCHAR2(11);
        l_account  VARCHAR2(100);
        --l_amount   NUMBER;
       --------------------------2006026 Jabir-------------
       l_assignment_id NUMBER;
       l_ddo_code      NUMBER;
       l_office_id     NUMBER;
       l_treas_code    VARCHAR2(4);
       l_source_type   VARCHAR2(20);
       l_existing_payee_id NUMBER;-----22062026---------------
        -----------------------------------------------------
    BEGIN
        -- Step 1: Read individual screen fields.
        l_assignment_id := f_json_number(p_req, '$.assignment_id');------ 2006026 Jabir
        l_user := nvl( f_json_varchar(p_req, '$.created_by'),user );
        l_name := f_json_varchar(p_req, '$.rows[0].beneficiary_name');
      --  l_aadhaar := f_json_varchar(p_req, '$.rows[0].aadhaar_ref_no');
        l_jan := f_json_varchar(p_req, '$.rows[0].jan_aadhar_id');
        l_mobile := f_json_varchar(p_req, '$.rows[0].mobile_no');
        l_state := f_json_varchar(p_req, '$.rows[0].state_name');
        l_district := f_json_varchar(p_req, '$.rows[0].district_name');
        l_ifsc := upper(f_json_varchar(p_req, '$.rows[0].ifsc_code'));
        l_account := f_json_varchar(p_req, '$.rows[0].account_no');
        l_source_type:= f_json_varchar(p_req, '$.source_type');------prav
        --l_amount := f_json_number(p_req, '$.rows[0].amount');
        
        -- Step 2: Apply minimal direct validations.
		
        ---------------------2006026 Jabir Start--------------------------
		
       IF l_assignment_id IS NOT NULL THEN
   BEGIN
       SELECT
           TO_NUMBER(a.assignment_value),
           b.office_id,
           b.treas_code
       INTO
           l_ddo_code,
           l_office_id,
           l_treas_code
       FROM vu_sso_user_role a
            JOIN mdm.office_ddo_treasury_map b
              ON b.ddo_code = TO_NUMBER(a.assignment_value)
             AND b.is_active='Y'
       WHERE a.assignment_id=l_assignment_id;

   EXCEPTION
       WHEN NO_DATA_FOUND THEN
           l_ddo_code:=NULL;
           l_office_id:=NULL;
           l_treas_code:=NULL;
       END;
   END IF;
    -----------------------------------------------
        IF l_name IS NULL THEN
            raise_application_error(-20040, 'Beneficiary name is required.');
        END IF;
        
--                            -- Aadhaar Validation
--                    IF l_aadhaar IS NOT NULL
--                       AND f_validate_aadhaar(l_aadhaar) = 'N'
--                    THEN
--                        raise_application_error(
--                            -20043,
--                            'Aadhaar number is invalid.'
--                        );
--                    END IF;
                    
                    -- Jan Aadhaar Validation
                    IF l_jan IS NOT NULL
                       AND f_validate_number1(l_jan) = 'N'
                    THEN
                        raise_application_error(
                            -20044,
                            'Jan Aadhaar number is invalid.'
                        );
                    END IF;
                    
                    IF
            l_mobile IS NOT NULL
            AND f_validate_mobile(l_mobile) = 'N'
        THEN
            raise_application_error(-20042, 'Mobile number is invalid.');
        END IF;
        
        IF
            l_ifsc IS NOT NULL
             AND f_validate_ifsc(UPPER(TRIM(l_ifsc))) = 'N'-----Pravesh & Jabir -----1106
        THEN
            raise_application_error(-20041, 'IFSC code is invalid.');
        END IF;

     IF l_account IS NOT NULL
           AND f_validate_account_no(l_account) = 'N'
        THEN
            raise_application_error(
                -20045,
                'Account number is invalid.'
            );
        END IF;
        
        -- Duplicate Beneficiary Check
-----------------------------------22062026-----------------------
                    p_find_payee(
                        p_jan_aadhar_id => l_jan,
                        p_account_no    => l_account,
                        p_ifsc_code     => l_ifsc,
                        p_mobile_no     => NULL,
                        p_name          => NULL,
                        p_payee_id      => l_existing_payee_id
                    );
                    
                    IF l_existing_payee_id IS NOT NULL THEN
                        raise_application_error(
                            -20047,
                            'Beneficiary already exists with Payee ID '
                            || l_existing_payee_id
                        );
                    END IF;
      -----------------------------------22062026-----------------------  
--                IF l_amount IS NOT NULL OR l_amount <= 0 THEN
--            raise_application_error(
--                -20046,
--                'Amount must be greater than zero.'
--            );
--        END IF;

        -- Step 3: Create or update MST_PAYEE using simplified dedupe.
		
-------------------------1906026  Jabir--------------------
         
p_upsert_payee(
   l_name,
   l_jan,
   l_mobile,
   l_state,
   l_district,
   l_ifsc,
   l_account,
   l_user,
   l_ddo_code,
   l_office_id,
   l_treas_code,
   l_source_type,
   l_payee_id
);
-------------------------1906026  end--------------------
        COMMIT;

        -- Step 4: Return masked identifiers to UI.

--    p_set_success('{"message":"Beneficiary submitted successfully."'
--              || ',"payee_id":'
--              || l_payee_id
------                      || ',"aadhaar_ref_masked":'
------                      || f_json_quote(f_mask_value(l_aadhaar))
------                      || ',"jan_aadhar_masked":'
------                      || f_json_quote(f_mask_value(l_jan))
--              || ',"jan_aadhar_masked":'
--              || f_json_quote(l_jan)-------25052026 remove mask
--              || '}',
--              p_resp,
--              p_status,
--              p_err_msg,
--              p_err_code);

p_set_success(
    '{"message":"Beneficiary submitted successfully. Generated Payee ID: '
    || l_payee_id
    || '"'
    || ',"payee_id":'
    || l_payee_id
    || ',"jan_aadhar_masked":'
    || f_json_quote(l_jan)
    || '}',
    p_resp,
    p_status,
    p_err_msg,
    p_err_code
);

			
--------------------------------------------05062026---------------------------------  
EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
           package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_save_individual_beneficiary',
                p_type        => 1,
                p_ref_no      => l_payee_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM || CHR(10) ||
                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY   => 'ERROR',
                p_request     => p_req
            );
			
-------------------2006026 Jabir Start---------------------
        -- EXCEPTION
            -- WHEN OTHERS THEN
                -- NULL;
        -- END;
		
		EXCEPTION
    WHEN NO_DATA_FOUND THEN
        l_ddo_code   := NULL;
        l_office_id  := NULL;
        l_treas_code := NULL;

    WHEN TOO_MANY_ROWS THEN
        raise_application_error(
            -20060,
            'Multiple DDO mappings found for Assignment ID.'
        );
END;
-----------------------------------------------------
        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
 END pr_save_individual_beneficiary; 
 

--------------------------------------------------------------------------
----------2206026 Jabir  created ------------
-- PROCEDURE: pr_get_individual_beneficiaries
-- Business purpose:
--   Fetch list of individual beneficiaries based on office_id for UI display
--   Supports pagination and search filters
-----------------------------------------------------------------------

PROCEDURE pr_get_individual_beneficiaries (
    p_req      IN CLOB,
    p_resp     OUT CLOB,
    p_status   OUT VARCHAR2,
    p_err_msg  OUT VARCHAR2,
    p_err_code OUT VARCHAR2
) IS


----------------------------------
	l_assignment_id NUMBER;
	l_office_id     NUMBER;
	l_ddo_code      NUMBER;
	l_treas_code    VARCHAR2(20);
  --------------------------------------------
    l_search_text   VARCHAR2(200);
    l_page_no       NUMBER := 1;
    l_page_size     NUMBER := 10;
    l_offset        NUMBER := 0;
    l_total_records NUMBER := 0;
    l_total_pages   NUMBER := 0;
    l_arr           CLOB := '[';
    l_first         BOOLEAN := TRUE;
    l_user          VARCHAR2(100);
	
    
BEGIN

    ------------------------------------------------------------------
    -- Step 1: Read Input Parameters
    ------------------------------------------------------------------
	
    l_assignment_id := f_json_number(p_req, '$.assignment_id');
	
	
    l_search_text := upper(trim(f_json_varchar(p_req, '$.search_text')));
    l_user := nvl(f_json_varchar(p_req, '$.user_id'), user);
	
	BEGIN
    SELECT
           TO_NUMBER(a.assignment_value),
           b.office_id,
           b.treas_code
    INTO
           l_ddo_code,
           l_office_id,
           l_treas_code
    FROM vu_sso_user_role a
         JOIN mdm.office_ddo_treasury_map b
           ON b.ddo_code = TO_NUMBER(a.assignment_value)
          AND b.is_active = 'Y'
    WHERE a.assignment_id = l_assignment_id;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(
            -20060,
            'No Office mapped with Assignment Id : ' || l_assignment_id
        );
END;
    
    -- Validate office_id is required
    -- IF l_office_id IS NULL THEN
        -- raise_application_error(-20060, 'office_id is required.');
    -- END IF;
IF l_assignment_id IS NULL THEN
    raise_application_error(-20060, 'assignment_id is required.');
END IF;
    ------------------------------------------------------------------
    -- Step 2: Pagination Inputs
    ------------------------------------------------------------------
    l_page_no := nvl(f_json_number(p_req, '$.pageNo'), 1);------pravesh & vivek 24062026
    IF l_page_no <= 0 THEN
        l_page_no := 1;
    END IF;

    l_page_size := nvl(f_json_number(p_req, '$.pageSize'), 10);
    IF l_page_size <= 0 THEN
        l_page_size := 10;
    END IF;

    l_offset := (l_page_no - 1) * l_page_size;

    ------------------------------------------------------------------
    -- Step 3: Get Total Records Count
    ------------------------------------------------------------------
    SELECT COUNT(*)
    INTO l_total_records
    FROM mst_payee p
    WHERE p.active_flag = 'Y'
      AND p.office_id = l_office_id
      AND (l_search_text IS NULL
           OR upper(p.beneficiary_name) LIKE '%' || l_search_text || '%'
           OR upper(p.account_no) LIKE '%' || l_search_text || '%'
           OR upper(p.mobile_no) LIKE '%' || l_search_text || '%'
           OR upper(p.jan_aadhar_id) LIKE '%' || l_search_text || '%');

    l_total_pages := ceil(l_total_records / l_page_size);

    ------------------------------------------------------------------
    -- Step 4: Fetch Paginated Beneficiary List
    ------------------------------------------------------------------
    FOR r IN (
        SELECT 
            p.payee_id,
            p.beneficiary_name,
            p.jan_aadhar_id,
            p.mobile_no,
            p.state_name,
            p.district_name,
            p.ifsc_code,
            p.account_no,
            p.ddo_code,
            p.office_id,
            p.treas_code,
            p.created_date,
            p.modified_date,
            p.created_by,
            p.modified_by
        FROM mst_payee p
        WHERE p.active_flag = 'Y'
          AND p.office_id = l_office_id
          AND (l_search_text IS NULL
               OR upper(p.beneficiary_name) LIKE '%' || l_search_text || '%'
               OR upper(p.account_no) LIKE '%' || l_search_text || '%'
               OR upper(p.mobile_no) LIKE '%' || l_search_text || '%'
               OR upper(p.jan_aadhar_id) LIKE '%' || l_search_text || '%')
        ORDER BY p.created_date DESC
        OFFSET l_offset ROWS FETCH NEXT l_page_size ROWS ONLY
    ) LOOP
        
        IF NOT l_first THEN
            l_arr := l_arr || ',';
        END IF;
        
        l_arr := l_arr
                 || '{'
                 || '"payee_id":' || r.payee_id
                 || ',"beneficiary_name":' || f_json_quote(r.beneficiary_name)
                 || ',"jan_aadhar_id":' || f_json_quote(r.jan_aadhar_id)
                 || ',"mobile_no":' || f_json_quote(r.mobile_no)
                 || ',"state_name":' || f_json_quote(r.state_name)
                 || ',"district_name":' || f_json_quote(r.district_name)
                 || ',"ifsc_code":' || f_json_quote(r.ifsc_code)
                 || ',"account_no":' || f_json_quote(r.account_no)
                 || ',"ddo_code":' || nvl(to_char(r.ddo_code), 'null')
                 || ',"office_id":' || nvl(to_char(r.office_id), 'null')
                 || ',"treas_code":' || f_json_quote(r.treas_code)
                 || ',"created_date":' || f_json_quote(to_char(r.created_date, 'YYYY-MM-DD HH24:MI:SS'))
                 || ',"modified_date":' || f_json_quote(to_char(r.modified_date, 'YYYY-MM-DD HH24:MI:SS'))
                 || ',"created_by":' || f_json_quote(r.created_by)
                 || ',"modified_by":' || f_json_quote(r.modified_by)
                 || '}';
        
        l_first := FALSE;
    END LOOP;

    l_arr := l_arr || ']';

    ------------------------------------------------------------------
    -- Step 5: Build Summary Response
    ------------------------------------------------------------------
    p_set_success(
        '{'
        || '"summary":{'
        || '"total_records":' || l_total_records
        || ',"pageNo":' || l_page_no------------pravesh & vivek 24062026
        || ',"pageSize":' || l_page_size
        || ',"totalPages":' || l_total_pages
        || ',"office_id":' || l_office_id
        || '}'
        || ',"beneficiaries":' || l_arr
        || '}',
        p_resp,
        p_status,
        p_err_msg,
        p_err_code
    );

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        
        BEGIN
            package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'pr_get_individual_beneficiaries',
                p_type        => 1,
                p_ref_no      => l_office_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY    => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
END pr_get_individual_beneficiaries;
 
 
------------------------------------------------------------------------------------
-----Procedure :   pr_stage_beneficiaries_bulk_from_json
------------------------------------------------------------------- 
    PROCEDURE pr_stage_beneficiaries_bulk_from_json (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS
        l_group_id NUMBER;
        l_user     VARCHAR2(100);
        l_rows     tab_beneficiary_stage_in := tab_beneficiary_stage_in();
    BEGIN
        l_group_id := package_bnf_pns.f_json_number(p_req, '$.group_id');
        l_user := nvl(
            package_bnf_pns.f_json_varchar(p_req, '$.created_by'),
            user
        );
        FOR r IN (
            SELECT
                *
            FROM
                JSON_TABLE ( p_req, '$.rows[*]'
                    COLUMNS (
                        row_no NUMBER PATH '$.row_no',
                        beneficiary_name VARCHAR2 ( 300 ) PATH '$.beneficiary_name',
                        --aadhaar_ref_no VARCHAR2 ( 200 ) PATH '$.aadhaar_ref_no',
                        jan_aadhar_id VARCHAR2 ( 100 ) PATH '$.jan_aadhar_id',
                        mobile_no VARCHAR2 ( 20 ) PATH '$.mobile_no',
                        state_name VARCHAR2 ( 200 ) PATH '$.state_name',
                        district_name VARCHAR2 ( 200 ) PATH '$.district_name',
                        ifsc_code VARCHAR2 ( 11 ) PATH '$.ifsc_code',
                        account_no VARCHAR2 ( 100 ) PATH '$.account_no',
                        amount NUMBER PATH '$.amount',
                        attr1_val VARCHAR2 ( 200 ) PATH '$.attr1_val',
                        attr2_val VARCHAR2 ( 200 ) PATH '$.attr2_val',
                        attr3_val VARCHAR2 ( 200 ) PATH '$.attr3_val',
                        attr4_val VARCHAR2 ( 200 ) PATH '$.attr4_val',
                        attr5_val VARCHAR2 ( 200 ) PATH '$.attr5_val',
                        attr6_val VARCHAR2 ( 2000 ) PATH '$.attr6_val',
                        attr7_val VARCHAR2 ( 2000 ) PATH '$.attr7_val',
                        attr8_val VARCHAR2 ( 2000 ) PATH '$.attr8_val',
                        attr9_val VARCHAR2 ( 2000 ) PATH '$.attr9_val',
                        attr10_val VARCHAR2 ( 2000 ) PATH '$.attr10_val',
                        INSTALLMENT_NO NUMBER PATH '$.INSTALLMENT_NO'
                    )
                )
        ) LOOP
            l_rows.extend;
            l_rows(l_rows.last) := obj_beneficiary_stage_in(r.row_no,
                                                            r.beneficiary_name,
                                                            --r.aadhaar_ref_no,----0506026 jabir
                                                            r.jan_aadhar_id,
                                                            r.mobile_no,
                                                            r.state_name,
                                                            r.district_name,
                                                            upper(r.ifsc_code),
                                                            r.account_no,
                                                            r.amount,
                                                            r.attr1_val,
                                                            r.attr2_val,
                                                            r.attr3_val,
                                                            r.attr4_val,
                                                            r.attr5_val,
                                                            r.attr6_val,
                                                            r.attr7_val,
                                                            r.attr8_val,
                                                            r.attr9_val,
                                                            r.attr10_val,
                                                            r.INSTALLMENT_NO,
                                                            NULL,
                                                            NULL,
                                                            NULL,
                                                            NULL,
                                                            NULL,  -- attr11..15
                                                            NULL,
                                                            NULL,
                                                            NULL,              -- attr16..18 (DATE)
                                                            NULL,
                                                            NULL                     -- attr19..20 (CLOB)
                                                            );

        END LOOP;

        package_bnf_pns.pr_stage_beneficiaries_bulk(
            p_group_id   => l_group_id,
            p_created_by => l_user,
            p_rows       => l_rows,
            p_resp       => p_resp,
            p_status     => p_status,
            p_err_msg    => p_err_msg,
            p_err_code   => p_err_code
        );

--------------------------------------------05062026---------------------------------  
EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
           package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_stage_beneficiaries_bulk_from_json',
                p_type        => 1,
                p_ref_no      => l_group_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM || CHR(10) ||
                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY   => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
 END;    
----------------------------------------------------------------- 
---New pr_validate_group_v1---03-06-2026--------------------
-----------------------------------------------------------------
PROCEDURE pr_validate_group_v1 (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
        
    ) IS

        l_group_id  NUMBER;
        l_scheme_id NUMBER;
        l_user      VARCHAR2(100);
        l_errors    CLOB;
        l_err_count NUMBER;
        l_value     VARCHAR2(4000);
        l_total     NUMBER;
        l_active    NUMBER;
        l_valid     NUMBER;
        l_invalid   NUMBER;
        l_removed   NUMBER;
        l_status    VARCHAR2(30);
        l_run_no    NUMBER;
        v_count   NUMBER;
      --  l_stage_row_id    NUMBER;
		
			TYPE t_validation_rec IS RECORD (
			column_name VARCHAR2(100),
			field_code  VARCHAR2(100),
			attr_label  VARCHAR2(200),
			attr_type   VARCHAR2(50),
			is_required VARCHAR2(1)
		);

		TYPE t_validation_tab IS TABLE OF t_validation_rec;
		l_validations t_validation_tab;

		TYPE t_dup_map IS TABLE OF VARCHAR2(20)
		INDEX BY PLS_INTEGER;

		l_dup_type        t_dup_map;
		l_duplicate_type  VARCHAR2(20);
    BEGIN
        l_group_id := package_bnf_pns.f_json_number(p_req, '$.group_id');
        l_user := nvl(
            package_bnf_pns.f_json_varchar(p_req, '$.validated_by'),
            user
        );
      --  p_assert_group_exists(l_group_id);
        package_bnf_pns.p_assert_group_editable(l_group_id);
        SELECT
            scheme_id
        INTO l_scheme_id
        FROM
            mst_beneficiary_group
        WHERE
            group_id = l_group_id;
            
     -------------------------  vivek 8-6-26 ---------------------------------    
select count(*) into v_count 
  FROM
            mst_beneficiary_group
        WHERE
            group_id = l_group_id;

if v_count >0 then  

 SELECT
            scheme_id
        INTO l_scheme_id
        FROM
            mst_beneficiary_group
        WHERE
            group_id = l_group_id;
            
            SELECT column_name,
                           field_code,
                           attr_label,
                           attr_type,
                           is_required
                BULK COLLECT INTO l_validations
                FROM mst_beneficiary_field_validation
                WHERE active_flag = 'Y'
                AND
                         scheme_id = l_scheme_id
                
                ORDER BY NVL(display_sequence,999999),
                                 column_name;
else 

            SELECT column_name,
                           field_code,
                           attr_label,
                           attr_type,
                           is_required
                BULK COLLECT INTO l_validations
                FROM mst_beneficiary_field_validation
                WHERE active_flag = 'Y'
                AND
                         scheme_id is null 
                
                ORDER BY NVL(display_sequence,999999),
                                 column_name;
        END IF;

-------------------------  vivek 8-6-26 ---------------------------------  

			FOR r IN (
				SELECT stage_row_id,
					   CASE
						 --WHEN aadhaar_cnt > 1 THEN 'AADHAAR'
						 WHEN jan_cnt > 1 THEN 'JAN_AADHAAR'
						 WHEN mobile_cnt > 1 THEN 'MOBILE'
                        -- WHEN ifsc_cnt > 1 THEN 'IFSC'---02072026
						 WHEN account_cnt > 1 THEN 'ACCOUNT'
                         WHEN installment_cnt >1 THEN 'INSTALLMENT_NO'
						 ELSE 'N'
					   END dup_type
				FROM (
					SELECT stage_row_id,
                     
--						   COUNT(
--                                            CASE
--                                                WHEN TRIM(aadhaar_ref_no) IS NOT NULL THEN 1
--                                            END
--                                        ) OVER (
--                                            PARTITION BY INSTALLMENT_NO,
--                                                         REPLACE(TRIM(aadhaar_ref_no),'-','')
--                                        ) aadhaar_cnt,
                                        
                                                                   COUNT(
                                            CASE
                                                WHEN TRIM(jan_aadhar_id) IS NOT NULL THEN 1
                                            END
                                        ) OVER (
                                            PARTITION BY INSTALLMENT_NO,
                                                         REPLACE(TRIM(jan_aadhar_id),'-','')
                                        ) jan_cnt,
                                        
                                                                  COUNT(
                                            CASE
                                                WHEN TRIM(mobile_no) IS NOT NULL THEN 1
                                            END
                                        ) OVER (
                                            PARTITION BY INSTALLMENT_NO,
                                                         TRIM(mobile_no)
                                        ) mobile_cnt,
                                                                   
--                                                                   COUNT(
--                                            CASE
--                                                WHEN TRIM(ifsc_code) IS NOT NULL THEN 1
--                                            END
--                                        ) OVER (
--                                            PARTITION BY INSTALLMENT_NO,
--                                                         UPPER(TRIM(ifsc_code))
--                                        ) ifsc_cnt,
                                        
                                                                  COUNT(
                                            CASE
                                                WHEN TRIM(account_no) IS NOT NULL THEN 1
                                            END
                                        ) OVER (
                                            PARTITION BY INSTALLMENT_NO,
                                                         TRIM(account_no),
                                                         UPPER(TRIM(ifsc_code))
                                        ) account_cnt,

                                            
                           
                           COUNT(*) OVER(
							   PARTITION BY INSTALLMENT_NO,
											TRIM(INSTALLMENT_NO)
						   ) installment_cnt
                           
					FROM stg_mst_beneficiary
					WHERE group_id = l_group_id
					AND
                   
                    row_status = 'ACTIVE'
				)

			) LOOP
				l_dup_type(r.stage_row_id) := r.dup_type;
			END LOOP;		
    -------27052026-------------------
    
     FOR s IN (
            SELECT
                *
            FROM
                stg_mst_beneficiary
            WHERE
                   group_id = l_group_id
                  -- AND  
--                   stage_row_id  = l_stage_row_id -----03-6-26 V
--                   AND VALIDATION_STATUS = 'INVALID'
                    
                AND row_status = 'ACTIVE'
                 
            ORDER BY
                row_no
        ) LOOP
           l_errors := '[';
            l_err_count := 0;

    ------------------------------------------------------------------
    -- Mandatory Beneficiary Name Validation  ---0207026 JABIR
    ------------------------------------------------------------------
    IF TRIM(s.beneficiary_name) IS NULL THEN
    
        package_bnf_pns.p_append_error(
            l_errors,
            l_err_count,
            'BENEFICIARY_NAME',
            'BENEFICIARY_NAME',
            'Beneficiary Name',
            'Beneficiary Name is mandatory'
        );

END IF;
--------------------------------------------------------------------
              l_duplicate_type :=
									NVL(
										l_dup_type(s.stage_row_id),
										'N'
									);

								FOR i IN 1 .. l_validations.COUNT LOOP

									l_value :=
										package_bnf_pns.f_get_stage_value(
											s,
											l_validations(i).column_name
										);

									IF l_validations(i).is_required = 'Y'
									   AND TRIM(l_value) IS NULL
                                     AND UPPER(l_validations(i).column_name) <> 'AADHAAR_REF_NO'
									THEN

										package_bnf_pns.p_append_error(
											l_errors,
											l_err_count,
											l_validations(i).column_name,
											l_validations(i).field_code,
											l_validations(i).attr_label,
											l_validations(i).column_name || ' Mandatory field missing'
										);

									ELSIF TRIM(l_value) IS NOT NULL THEN

										IF l_validations(i).attr_type = 'MOBILE'
										   AND (
												package_bnf_pns.f_validate_mobile(l_value) = 'N'
												OR l_duplicate_type = 'MOBILE'
										   )
										THEN

											package_bnf_pns.p_append_error(
												l_errors,
												l_err_count,
												l_validations(i).column_name,
												l_validations(i).field_code,
												l_validations(i).attr_label,
												'Mobile number invalid/Exists'
											);

										ELSIF l_validations(i).attr_type = 'IFSC'
											  AND package_bnf_pns.f_validate_ifsc(l_value) = 'N'
										THEN

											package_bnf_pns.p_append_error(
												l_errors,
												l_err_count,
												'IFSC_CODE',
												'IFSC_CODE',
												'IFSC Code',
												'IFSC invalid'
											);
                                    
-----------------------------------05062026--------------------------------------
--										ELSIF l_validations(i).attr_type = 'AADHAAR'
--											  AND (
--													package_bnf_pns.f_validate_aadhaar(l_value) = 'N'
--													OR l_duplicate_type = 'AADHAAR'
--												  )
--										THEN
--
--											package_bnf_pns.p_append_error(
--												l_errors,
--												l_err_count,
--												l_validations(i).column_name,
--												l_validations(i).field_code,
--												l_validations(i).attr_label,
--												'Adhar No invalid/exists with same installment_no'
--											);
--------------------------------05062026--------------------------------------

--										ELSIF l_validations(i).attr_type = 'ACCOUNT'
--											  AND (
--													f_validate_account_no(s.account_no) = 'N'
--													OR l_duplicate_type = 'ACCOUNT'
--												  )
--										THEN
-------------------------------Added validation pravesh & vivek 3006206----------------------------
                                        ELSIF l_validations(i).attr_type = 'ACCOUNT'
                                           AND (
                                            f_validate_account_no(s.account_no) = 'N'
                                         OR l_duplicate_type = 'ACCOUNT'
                                            )
                                            THEN

											package_bnf_pns.p_append_error(
												l_errors,
												l_err_count,
												'ACCOUNT_NO',
												'ACCOUNT_NO',
												'Account Number',
												'Account number invalid/exists with same installment_no'
											);
                                            
-------------------------------ended validation pravesh & vivek 3006206----------------------------
										ELSIF l_validations(i).attr_type = 'JAN_AADHAR'
											  AND (
													f_validate_number1(s.jan_aadhar_id) = 'N'
													OR l_duplicate_type = 'JAN_AADHAAR'
												  )
										THEN

											package_bnf_pns.p_append_error(
												l_errors,
												l_err_count,
												'JAN_AADHAR_ID',
												'JAN_AADHAR_ID',
												'JAN_AADHAR_ID',
												'JAN_AADHAR_ID invalid/exists with same installment_no'
											);

										END IF;

									END IF;
                   END LOOP;  
							
                l_errors := l_errors || ']';
                                    UPDATE stg_mst_beneficiary
                                    SET
                                        validation_status =
                                            CASE
                                                WHEN l_err_count = 0 THEN
                                                    'VALID'
                                                ELSE
                                                    'INVALID'
                                            END,
                                        error_count = l_err_count,
                                        error_json =
                                            CASE
                                                WHEN l_err_count = 0 THEN
                                                    NULL
                                                ELSE
                                                    l_errors
                                            END,
                                        modified_by = l_user,
                                        modified_date = systimestamp
                                    WHERE
                                        stage_row_id = s.stage_row_id; 
                                        
              END LOOP;
    
        SELECT
            COUNT(*),
            nvl(
                sum(
                    CASE
                        WHEN row_status = 'ACTIVE' THEN
                            1
                        ELSE 0
                    END
                ),
                0
            ),
            nvl(
                sum(
                    CASE
                        WHEN
                            row_status = 'ACTIVE'
                            AND validation_status = 'VALID'
                        THEN
                            1
                        ELSE 0
                    END
                ),
                0
            ),
            nvl(
                sum(
                    CASE
                        WHEN
                            row_status = 'ACTIVE'
                            AND validation_status = 'INVALID'
                        THEN
                            1
                        ELSE 0
                    END
                ),
                0
            ),
            nvl(
                sum(
                    CASE
                        WHEN row_status = 'REMOVED' THEN
                            1
                        ELSE 0
                    END
                ),
                0
            )
        INTO
            l_total,
            l_active,
            l_valid,
            l_invalid,
            l_removed
        FROM
            stg_mst_beneficiary
        WHERE
            group_id = l_group_id;

    ------------------------------------------------
    -- STEP 4 : GROUP STATUS
    ------------------------------------------------
        l_status :=
            CASE
                WHEN l_invalid = 0 THEN
                    'VALIDATED'
                ELSE 'VALIDATION_FAILED'
            END;
        UPDATE mst_beneficiary_group
        SET
            process_status = l_status,
            modified_by = l_user,
            modified_date = systimestamp
        WHERE
            group_id = l_group_id;

    ------------------------------------------------
    -- STEP 5 : VALIDATION RUN ENTRY
    ------------------------------------------------
        SELECT
            nvl(
                max(validation_run_no),
                0
            ) + 1
        INTO l_run_no
        FROM
            mst_beneficiary_validation_run
        WHERE
            group_id = l_group_id;

        INSERT INTO mst_beneficiary_validation_run (
            group_id,
            validation_run_no,
            total_rows,
            active_rows,
            valid_rows,
            invalid_rows,
            removed_rows,
            process_status_after,
            created_by
        ) VALUES ( l_group_id,
                   l_run_no,
                   l_total,
                   l_active,
                   l_valid,
                   l_invalid,
                   l_removed,
                   l_status,
                   l_user );

        MERGE INTO mst_beneficiary_group_ext t
        USING (
            SELECT
                l_group_id group_id,
                l_run_no   run_no,
                l_user     user_name
            FROM
                dual
        ) s ON ( t.group_id = s.group_id )
        WHEN MATCHED THEN UPDATE
        SET validation_attempt_count = nvl(validation_attempt_count, 0) + 1,
            latest_validation_run_no = s.run_no,
            last_validated_date = systimestamp,
            modified_by = s.user_name,
            modified_date = systimestamp
        WHEN NOT MATCHED THEN
        INSERT (
            group_id,
            mapping_version_snapshot,
            validation_attempt_count,
            latest_validation_run_no,
            last_validated_date,
            created_by )
        VALUES
            ( s.group_id,
              1,
              1,
              s.run_no,
              systimestamp,
              s.user_name );

        package_bnf_pns.p_insert_group_run_detail(l_group_id, 'VALIDATE', l_status, l_user, 'Group validation completed');
        COMMIT;
        package_bnf_pns.p_set_success('{"group_id":'
                      || l_group_id
                      || ',"total_rows":'
                      || l_total
                      || ',"invalid_rows":'
                      || l_invalid
                      || ',"validation_run_no":'
                      || l_run_no
                      || ',"process_status":'
                      || package_bnf_pns.f_json_quote(l_status)
                      || '}',
                      p_resp,
                      p_status,
                      p_err_msg,
                      p_err_code);

--------------------------------------------05062026---------------------------------  
EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
           package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_pns',
                p_proc_name   => 'package_bnf_pns.pr_validate_group_v1',
                p_type        => 1,
                p_ref_no      => l_group_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM || CHR(10) ||
                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY   => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_pns.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
 END pr_validate_group_v1;
----------------------------------------------------------------------------      

-----------------------------------------------------------------------------
--PROCEDURE: pr_onboard_full_flow
-----------------------------------------------------------------------------
    PROCEDURE pr_onboard_full_flow (
        p_req      IN CLOB,
        p_resp     OUT CLOB,
        p_status   OUT VARCHAR2,
        p_err_msg  OUT VARCHAR2,
        p_err_code OUT VARCHAR2
    ) IS

        l_type             VARCHAR2(50);
        l_scheme_resp      CLOB;
        l_group_resp       CLOB;
        l_status           VARCHAR2(10);
        l_err_msg          VARCHAR2(4000);
        l_err_code         VARCHAR2(100);
        l_scheme_id        NUMBER;
        l_group_id         NUMBER;
        e_group_id         NUMBER;
        e_scheme_id        NUMBER;
        l_user             VARCHAR2(100);
        l_req              CLOB;
        l_processed_status VARCHAR2(100);
        l_assignment_id NUMBER;----0906026 jabir
        e_exception     EXCEPTION;----0906026 jabir
    BEGIN
   --------------------------------------------------------------0906026 jabir
    l_assignment_id := f_json_number( p_req,'$.assignment_id'); 
                   
IF check_user_access(l_assignment_id, 29) = 'S' THEN
    NULL; -- continue processing
ELSE
    p_err_msg := 'User is not authorized.';
    RAISE e_exception;
END IF;
-------------------------------------------------------------------------------
        l_type := upper(trim(JSON_VALUE(p_req, '$.type' RETURNING VARCHAR2)));
        l_user := nvl(package_bnf_pns.f_json_varchar(p_req, '$.created_by'),user);
        e_group_id := package_bnf_pns.f_json_number(p_req, '$.group_id');
        e_scheme_id := package_bnf_pns.f_json_number(p_req, '$.scheme_id');

    ------------------------------------------------------------------
    -- INDIVIDUAL BENEFICIARY FLOW
    ------------------------------------------------------------------
        IF (e_group_id IS NULL AND e_scheme_id IS NULL) THEN
            package_bnf_pns.pr_save_individual_beneficiary(p_req, p_resp, p_status, p_err_msg, p_err_code);
            dbms_output.put_line('Individual beneficiary saved');

    ------------------------------------------------------------------
    -- NEW GROUP ONBOARDING FLOW
    ------------------------------------------------------------------

        ELSIF ( e_group_id IS NULL AND e_scheme_id IS NOT NULL ) THEN
            package_bnf_pns.pr_save_scheme(p_req, l_scheme_resp, l_status, l_err_msg, l_err_code);
            dbms_output.put_line('scheme successfully dumped');
            l_scheme_id := package_bnf_managament.f_json_number(l_scheme_resp, '$.scheme_id');
            package_bnf_managament.pr_save_scheme_field_mapping(p_req, l_scheme_resp, l_status, l_err_msg, l_err_code);
            dbms_output.put_line('field successfully dumped');
            package_bnf_managament.pr_create_beneficiary_group(p_req, l_group_resp, l_status, l_err_msg, l_err_code);
            l_group_id := package_bnf_managament.f_json_number(l_group_resp, '$.data.group_id');
            --dbms_output.put_line('l_group_id=' || l_group_id);---03-6-26
            l_req := regexp_replace(p_req, '"group_id"\s*:\s*null', '"group_id":' || l_group_id);
          --  dbms_output.put_line('l_req=' || l_req);
           package_bnf_managament.pr_stage_beneficiaries(l_req, l_group_resp, l_status, l_err_msg, l_err_code); ----0806022
           --package_bnf_managament.pr_stage_beneficiaries_bulk_from_json(l_req, l_group_resp, l_status, l_err_msg, l_err_code);-------08062022
            dbms_output.put_line('beneficiary staged');
            package_bnf_managament.pr_validate_group_v1(l_req, l_group_resp, l_status, l_err_msg, l_err_code);
            dbms_output.put_line('validation success');
            
            dbms_output.put_line('master data success');
            package_bnf_managament.pr_get_group_validation_result(l_req, p_resp, p_status, p_err_msg, p_err_code);
            l_processed_status := package_bnf_managament.f_json_varchar(p_resp, '$.data.group_summary.process_status');
            --dbms_output.put_line('l_processed_status:  ' || l_processed_status);
            IF l_processed_status = 'VALIDATED' THEN
                package_bnf_managament.pr_process_group(l_req, l_group_resp, l_status, l_err_msg, l_err_code);
        
                    END IF;

    ------------------------------------------------------------------
    -- EXISTING GROUP UPDATE FLOW
    ------------------------------------------------------------------

        ELSE
                
            package_bnf_managament.pr_update_stage_rows(p_req, p_resp, p_status, p_err_msg, p_err_code);
            package_bnf_managament.pr_validate_group_v1(p_req, l_group_resp, l_status, l_err_msg, l_err_code);
            package_bnf_managament.pr_get_group_validation_result(p_req, p_resp, p_status, p_err_msg, p_err_code);
           l_processed_status := package_bnf_managament.f_json_varchar(p_resp, '$.data.group_summary.process_status');
            IF l_processed_status = 'VALIDATED' THEN
                package_bnf_managament.pr_process_group(p_req, l_group_resp, l_status, l_err_msg, l_err_code);
                
            END IF;
 
        END IF;
   
   
   
 --------------------------0906026  jabir----------------------------------  
--    EXCEPTION
--        WHEN OTHERS THEN
--            p_status := 'E';
--            ROLLBACK;
--            raise_application_error(-20006, 'failed: ' || sqlerrm);
--    END;
EXCEPTION

    WHEN e_exception THEN

        ROLLBACK;

        p_status   := 'W';
        p_err_code := 'ffm-COR-OTS-BENF-ERR-01';
        p_resp     := '{"status":"FAILURE"}';

        BEGIN
            package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_managament',
                p_proc_name   => 'package_bnf_managament.pr_save_scheme',
                p_type        => 1,
                p_ref_no      => l_scheme_id,
                p_err_code    => p_err_code,
                p_err_msg     => p_err_msg,
                p_SEVERITY    => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

    WHEN OTHERS THEN

        ROLLBACK;

        BEGIN
            package_bnf_pns.ots_benf_error_log(
                p_module_name => 'package_bnf_managament',
                p_proc_name   => 'package_bnf_managament.pr_save_scheme',
                p_type        => 1,
                p_ref_no      => l_scheme_id,
                p_err_code    => TO_CHAR(SQLCODE),
                p_err_msg     => SQLERRM
                                 || CHR(10)
                                 || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                p_SEVERITY    => 'ERROR',
                p_request     => p_req
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        package_bnf_managament.p_set_error(
            SQLERRM,
            TO_CHAR(SQLCODE),
            p_resp,
            p_status,
            p_err_msg,
            p_err_code
        );
   
END;

END package_bnf_managament;
