USE ROLE ACCOUNTADMIN;
USE DATABASE SNOWFLAKE_LEARNING_DB;

CREATE NETWORK RULE IF NOT EXISTS SNOWFLAKE_LEARNING_DB.PUBLIC.PYPI_NETWORK_RULE
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('pypi.org', 'pypi.python.org', 'pythonhosted.org', 'files.pythonhosted.org');


CREATE NETWORK RULE IF NOT EXISTS SNOWFLAKE_LEARNING_DB.PUBLIC.PLANETARY_COMPUTER_NETWORK_RULE
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = (
    -- Primary API endpoints
    'planetarycomputer.microsoft.com',
    'api.planetarycomputer.microsoft.com',
    'planetarycomputer.microsoft.com:443',
    
    -- STAC specification endpoints
    'api.stacspec.org',
    'stacspec.org',
    
    -- Azure Blob Storage (needed for data access)
    'planetarycomputer.blob.core.windows.net',
    'cpdataeuwest.blob.core.windows.net',
    'ai4edataeuwest.blob.core.windows.net',
    'naipeuwest.blob.core.windows.net',
    
    -- Azure Data Lake Storage (for Zarr access)
    'planetarycomputer.dfs.core.windows.net',
    'cpdataeuwest.dfs.core.windows.net',
    
    -- SAS token and authentication endpoints
    '*.blob.core.windows.net',
    '*.dfs.core.windows.net',
    
    -- Microsoft authentication (if needed)
    'login.microsoftonline.com',
    'management.azure.com'
  );

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION DATA_CHALLENGE_EXTERNAL_ACCESS
  ALLOWED_NETWORK_RULES = (
    SNOWFLAKE_LEARNING_DB.PUBLIC.PYPI_NETWORK_RULE,
    SNOWFLAKE_LEARNING_DB.PUBLIC.PLANETARY_COMPUTER_NETWORK_RULE
  )
  ENABLED = TRUE;


-- Verify integration creation
DESCRIBE INTEGRATION DATA_CHALLENGE_EXTERNAL_ACCESS;


-- Create Github Integration

CREATE OR REPLACE API INTEGRATION GITHUB
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com')
  API_USER_AUTHENTICATION = (TYPE = SNOWFLAKE_GITHUB_APP)
  ENABLED = TRUE;

ALTER ACCOUNT SET USE_WORKSPACES_FOR_SQL = 'always';


select 'https://www.snowflake.com/en/developers/guides/ey-ai-and-data-challenge/#create-new-workspace-from-git-repo' 
        as "Next Step: Click link below to return to Developer Guide, for instructions to create a Workspace from Git repo";
/*

Next Step: Click link below to return to Developer Guide, 
           for instructions to create a Workspace from Git repo

*/