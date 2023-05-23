import Box from '@/components/Collocation/Report/box';
import Button from '@/components/Button';
import ArrowDropDownIcon from '@/icons/arrow_drop_down';
import PollutantDropdown from '@/components/Collocation/Report/PollutantDropdown';
import CorrelationChart from '@/components/Collocation/Report/Charts/CorrelationLineChart';
import Spinner from '@/components/Spinner';
import { useEffect, useState } from 'react';
import moment from 'moment';
import { useDispatch, useSelector } from 'react-redux';
import {
  addActiveSelectedDeviceCollocationReportData,
  addActiveSelectedDeviceReport,
} from '@/lib/store/services/collocation/collocationDataSlice';
import { useRouter } from 'next/router';
import CustomLegend from './custom_legend';

const IntraCorrelationChart = ({
  intraCorrelationConcentration,
  toggleIntraCorrelationConcentrationChange,
  collocationResults,
  isLoading,
  deviceList,
  graphColors,
}) => {
  const router = useRouter();
  const { device, batchId } = router.query;
  const dispatch = useDispatch();
  const [isOpen, setIsOpen] = useState(false);

  const activeSelectedDeviceCollocationReportData = useSelector(
    (state) => state.collocationData.activeSelectedDeviceCollocationReportData,
  );
  const activeSelectedDeviceReport = useSelector(
    (state) => state.collocationData.activeSelectedDeviceReport,
  );

  useEffect(() => {
    dispatch(addActiveSelectedDeviceCollocationReportData(collocationResults));
  }, [activeSelectedDeviceCollocationReportData, collocationResults]);

  useEffect(() => {
    const getActiveSelectedDeviceReport = () => {
      if (!device || !batchId) return;
      dispatch(addActiveSelectedDeviceReport({ device, batchId }));
    };

    getActiveSelectedDeviceReport();
  }, [device, batchId]);

  const handleSelect = async (newDevice, newStartDate, newEndDate) => {
    // let startDate = moment(newStartDate).format('YYYY-MM-DD');
    // let endDate = moment(newEndDate).format('YYYY-MM-DD');
    // dispatch(addActiveSelectedDeviceReport({ device: newDevice, startDate, endDate }));

    // const response = await getCollocationResultsData({
    //   devices: newDevice,
    //   startDate,
    //   endDate,
    // });

    // if (!response.error) {
    //   const updatedQuery = {
    //     ...router.query,
    //     device: newDevice,
    //     startDate,
    //     endDate,
    //   };

    //   router.replace({
    //     pathname: `/collocation/reports/monitor_report/${newDevice}`,
    //     query: updatedQuery,
    //   });

    //   dispatch(addActiveSelectedDeviceCollocationReportData(response.data.data));
    // }
    setIsOpen(false);
  };

  return (
    <Box
      isBigTitle
      title='Intra Sensor Correlation'
      subtitle='Detailed comparison of data between two sensors that are located within the same device. By comparing data from sensors to create a more accurate and reliable reading.'
    >
      {isLoading ? (
        <div className='h-20' data-testid='correlation-data-loader'>
          <Spinner />
        </div>
      ) : (
        <div className='flex flex-col justify-start w-full'>
          <div className='relative'>
            <Button
              className='relative w-auto h-10 bg-purple-600 rounded-lg text-base font-semibold text-purple-700 ml-6'
              onClick={() => setIsOpen(!isOpen)}
            >
              <span className='uppercase'>
                {activeSelectedDeviceReport && activeSelectedDeviceReport.device}
              </span>
              <span className='ml-2 text-purple-700'>
                <ArrowDropDownIcon fillColor='#584CAB' />
              </span>
            </Button>
            {isOpen && (
              <ul className='absolute z-30 bg-white mt-1 ml-6 py-1 w-36 rounded border border-gray-200 max-h-60 overflow-y-auto text-sm'>
                {deviceList.map((device, index) => (
                  <>
                    {activeSelectedDeviceReport.device !== device.device_name && (
                      <li
                        key={index}
                        className='px-4 py-2 hover:bg-gray-200 cursor-pointer text-xs uppercase'
                        onClick={() =>
                          handleSelect(device.device_name, device.start_date, device.end_date)
                        }
                      >
                        {device.device_name}
                      </li>
                    )}
                  </>
                ))}
              </ul>
            )}
          </div>
          <PollutantDropdown
            pollutantValue={intraCorrelationConcentration}
            handlePollutantChange={toggleIntraCorrelationConcentrationChange}
            options={[
              { value: '2.5', label: 'pm2_5' },
              { value: '10', label: 'pm10' },
            ]}
          />
          {activeSelectedDeviceCollocationReportData ? (
            <CorrelationChart
              data={activeSelectedDeviceCollocationReportData}
              pmConcentration={intraCorrelationConcentration}
              isInterSensorCorrelation
              graphColors={graphColors}
            />
          ) : (
            <div className='text-center text-grey-300 text-sm'>No data found</div>
          )}
          {deviceList && graphColors && (
            <CustomLegend devices={deviceList} graphColors={graphColors} />
          )}
        </div>
      )}
    </Box>
  );
};

export default IntraCorrelationChart;
