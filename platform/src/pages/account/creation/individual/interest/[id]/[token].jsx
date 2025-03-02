import React, { useState } from 'react';
import AccountPageLayout from '@/components/Account/Layout';
import RadioComponent from '@/components/Account/RadioComponent';
import { updateUserCreationDetails } from '@/core/apis/Account';
import { useRouter } from 'next/router';
import Toast from '@/components/Toast';

const IndividualAccountInterest = () => {
  const router = useRouter();
  const { id } = router.query;

  const radioButtonText = [
    'Education related',
    'Business related',
    'Personal related',
    'Non-profit related',
    'Government related',
    'Others',
  ];
  const [clickedButton, setClickedButton] = useState('');
  const [interest, setInterest] = useState(null);
  const [userData, setUserData] = useState({});
  const [updateError, setUpdateError] = useState({
    state: false,
    message: '',
  });

  const handleUpdate = async () => {
    setUpdateError({
      state: false,
      message: '',
    });
    setUserData({
      industry: clickedButton,
      interest,
    });
    try {
      await updateUserCreationDetails(userData, id);
      router.push('/analytics');
    } catch (error) {
      setUpdateError({
        state: true,
        message: error.response.data.message,
      });
      return error;
    }
  };

  return (
    <AccountPageLayout childrenHeight={'lg:h-[580]'}>
      {updateError.state && <Toast type={'error'} timeout={5000} message={updateError.message} />}
      <div className='w-full'>
        <h2 className='text-3xl text-black-700 font-medium'>
          What brings you to the AirQo Analytics Dashboard?
        </h2>
        <p className='text-xl text-black-700 font-normal mt-3'>
          We will help you get started based on your response
        </p>
        <div className='mt-6'>
          <div className='w-full grid grid-cols-1 md:grid-cols-2 gap-y-4 gap-x-4'>
            {clickedButton === ''
              ? radioButtonText.map((text, index) => (
                  <div key={index} className='w-full' onClick={() => setClickedButton(text)}>
                    <RadioComponent
                      text={text}
                      titleFont={'text-md font-normal'}
                      padding={'px-3 py-4'}
                      width={'w-full'}
                    />
                  </div>
                ))
              : radioButtonText
                  .filter((button) => button === clickedButton)
                  .map((text, index) => (
                    <div key={index} className='w-full col-span-2'>
                      <RadioComponent
                        text={text}
                        titleFont={'text-md font-normal'}
                        padding={'px-3 py-4'}
                        width={'w-full'}
                        checked={true}
                      />
                      <div className='mt-6'>
                        <div className='w-full'>
                          <div className='text-sm'>Give us more details about your interests?</div>
                          <div className='mt-2 w-10/12'>
                            <textarea
                              onChange={(e) => setInterest(e.target.value)}
                              rows='3'
                              className='textarea textarea-lg w-full bg-white rounded-lg border-input-light-outline focus:border-input-outline'
                              placeholder='Type here'></textarea>
                          </div>
                        </div>
                      </div>
                    </div>
                  ))}
          </div>
        </div>
        <div className='mt-10'>
          <div className='lg:w-1/3 mt-6 md:mt-0 md:w-full'>
            {clickedButton === '' && interest === null ? (
              <button
                className='w-full btn btn-disabled bg-white rounded-none text-sm outline-none border-none'>
                Continue
              </button>
            ) : (
              <button
                className='w-full btn bg-blue-900 rounded-none text-sm outline-none border-none hover:bg-blue-950'
                onClick={() => handleUpdate()}>
                Continue
              </button>
            )}
          </div>
        </div>
      </div>
    </AccountPageLayout>
  );
};

export default IndividualAccountInterest;
