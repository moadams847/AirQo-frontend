import Layout from '@/components/Layout';
import Tabs from '@/components/Tabs';
import Tab from '@/components/Tabs/Tab';
import Password from './Tabs/Password';
import withAuth from '@/core/utils/protectedRoute';
import Team from './Tabs/Team';
import { useEffect, useState } from 'react';
import { getAssignedGroupMembers } from '@/core/apis/Account';

const Settings = () => {
  const [teamMembers, setTeamMembers] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    setLoading(true);
    getAssignedGroupMembers('64f54e357516f7001307a113')
      .then((response) => {
        setTeamMembers(response.group_members);
        setLoading(false);
      })
      .catch((error) => {
        console.error(`Error fetching user details: ${error}`);
        setLoading(false);
      });
  }, []);

  return (
    <Layout topbarTitle={'Settings'} noBorderBottom>
      <Tabs>
        <Tab label='Password'>
          <Password />
        </Tab>
        <Tab label='Team'>
          <Team users={teamMembers} loading={loading} />
        </Tab>
      </Tabs>
    </Layout>
  );
};

export default withAuth(Settings);
