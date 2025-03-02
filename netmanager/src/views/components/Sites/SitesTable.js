import React, { useState, useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { useHistory } from 'react-router-dom';
import LoadingOverlay from 'react-loading-overlay';
import { isEmpty } from 'underscore';
import Tooltip from '@material-ui/core/Tooltip';
import DeleteIcon from '@material-ui/icons/DeleteOutlineOutlined';
import { Parser } from 'json2csv';
import { loadSitesData, loadSitesSummary } from 'redux/SiteRegistry/operations';
import { useSitesSummaryData } from 'redux/SiteRegistry/selectors';
import CustomMaterialTable from '../Table/CustomMaterialTable';
import ConfirmDialog from '../../containers/ConfirmDialog';
import { deleteSiteApi } from 'views/apis/deviceRegistry';
import { updateMainAlert } from 'redux/MainAlert/operations';

// css
import 'assets/css/location-registry.css';
import { clearSiteDetails } from '../../../redux/SiteRegistry/operations';

// horizontal loader
import HorizontalLoader from 'views/components/HorizontalLoader/HorizontalLoader';

const BLANK_SPACE_HOLDER = '-';
const renderCell = (field) => (rowData) => <span>{rowData[field] || BLANK_SPACE_HOLDER}</span>;

const SitesTable = () => {
  const history = useHistory();
  const dispatch = useDispatch();
  const sites = useSitesSummaryData();
  const activeNetwork = JSON.parse(localStorage.getItem('activeNetwork'));
  const [loading, setLoading] = useState(true);
  const [isLoading, setIsLoading] = useState(false);
  const [delState, setDelState] = useState({ open: false, name: '', id: '' });

  useEffect(() => {
    if (isEmpty(sites)) {
      if (!isEmpty(activeNetwork)) {
        dispatch(loadSitesSummary(activeNetwork.net_name));
      }
    }
    setLoading(isEmpty(sites));
  }, [sites]);

  const handleDeleteSite = async () => {
    setDelState({ open: false, name: '', id: '' });
    setIsLoading(true);
    try {
      const resData = await deleteSiteApi(delState.id);
      if (!isEmpty(activeNetwork)) {
        dispatch(loadSitesData(activeNetwork.net_name));
      }
      dispatch(
        updateMainAlert({
          message: resData.message,
          show: true,
          severity: 'success'
        })
      );
    } catch (error) {
      dispatch(
        updateMainAlert({
          message:
            (error.response && error.response.data && error.response.data.message) ||
            'An error occurred',
          show: true,
          severity: 'error'
        })
      );
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <>
      <HorizontalLoader loading={isLoading} />
      <CustomMaterialTable
        pointerCursor
        userPreferencePaginationKey={'sites'}
        title={`Site Registry for ${activeNetwork.net_name}`}
        isLoading={loading}
        columns={[
          {
            title: 'Name',
            field: 'name',
            render: renderCell('name')
          },
          {
            title: 'Site ID',
            field: 'generated_name',
            render: renderCell('generated_name'),
            cellStyle: { fontFamily: 'Open Sans' }
          },
          {
            title: 'Description',
            field: 'description',
            render: renderCell('description'),
            cellStyle: { fontFamily: 'Open Sans' }
          },
          {
            title: 'Country',
            field: 'country',
            render: renderCell('country'),
            cellStyle: { fontFamily: 'Open Sans' }
          },
          {
            title: 'District',
            field: 'district',
            render: renderCell('district'),
            cellStyle: { fontFamily: 'Open Sans' }
          },
          {
            title: 'Region',
            field: 'region',
            render: renderCell('region'),
            cellStyle: { fontFamily: 'Open Sans' }
          },
          {
            title: 'Actions',
            render: (rowData) => (
              <div>
                <Tooltip title="Delete">
                  <DeleteIcon
                    // className={"hover-red"}
                    style={{
                      margin: '0 5px',
                      cursor: 'not-allowed',
                      color: 'grey'
                    }}
                    // disable deletion for now
                    // onClick={(event) => {
                    //   event.stopPropagation();
                    //   setDelState({
                    //     open: true,
                    //     name: rowData.name || rowData.description,
                    //     id: rowData._id,
                    //   });
                    // }}
                  />
                </Tooltip>
              </div>
            )
          }
        ]}
        onRowClick={(event, data) => {
          event.preventDefault();
          clearSiteDetails();
          history.push(`/sites/${data._id}`);
        }}
        data={sites}
        options={{
          search: true,
          exportButton: true,
          searchFieldAlignment: 'right',
          showTitle: true,
          searchFieldStyle: {
            fontFamily: 'Open Sans'
          },
          headerStyle: {
            fontFamily: 'Open Sans',
            fontSize: 16,
            fontWeight: 600
          },
          exportCsv: (columns, data) => {
            const fields = [
              'name',
              'description',
              'generated_name',
              'latitude',
              'longitude',
              'country',
              'region',
              'district',
              'city',
              'county',
              'sub_county',
              'parish',
              'street',
              'formatted_name',
              'altitude',
              'greenness',
              'landform_90',
              'landform_270',
              'aspect',
              'distance_to_nearest_road',
              'distance_to_nearest_primary_road',
              'distance_to_nearest_tertiary_road',
              'distance_to_nearest_unclassified_road',
              'distance_to_nearest_residential_road',
              'distance_to_nearest_secondary_road',
              'distance_to_capital_city_center',
              'bearing_to_capital_city_center'
            ];
            const json2csvParser = new Parser({ fields });
            const csv = json2csvParser.parse(data);
            let filename = `site-registry.csv`;
            const link = document.createElement('a');
            link.setAttribute(
              'href',
              'data:text/csv;charset=utf-8,%EF%BB%BF' + encodeURIComponent(csv)
            );
            link.setAttribute('download', filename);
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
          }
        }}
      />
      <ConfirmDialog
        open={delState.open}
        title={'Delete a site?'}
        message={`Are you sure you want to delete this ${delState.name} site`}
        close={() => setDelState({ open: false, name: '', id: '' })}
        confirm={handleDeleteSite}
        error
      />
    </>
  );
};

export default SitesTable;
