import SideBar from '@/components/SideBar';
import TopBar from '@/components/TopBar';

const Layout = ({ children }) => (
  <div className='relative w-screen h-screen bg-white overflow-x-hidden'>
    <TopBar />
    <div className='relative lg:flex w-screen h-screen pt-16'>
      <SideBar />
      <div className='w-full overflow-x-hidden'>{children}</div>
    </div>
  </div>
);

export default Layout;
