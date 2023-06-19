import { useState } from 'react';

function Tabs({ children }) {
  const [activeTab, setActiveTab] = useState(0);

  return (
    <div className='mt-6'>
      <div className='mx-6 mb-4 border-b border-grey-200'>
        <ul className='flex flex-wrap text-sm font-medium text-center'>
          {children.map((child, index) => (
            <li
              key={index}
              role='presentation'
              className={`${
                activeTab === index
                  ? 'border-grey-400'
                  : 'border-transparent opacity-40 hover:text-grey hover:border-grey-200'
              } text-black-900 whitespace-nowrap py-2 px-4 border-b-2 rounded-tl-full rounded-tr-full font-medium text-sm focus:outline-none mr-2 cursor-pointer`}
              onClick={() => setActiveTab(index)}
            >
              {child.props.label}
            </li>
          ))}
        </ul>
      </div>
      <div>{children[activeTab]}</div>
    </div>
  );
}

export default Tabs;
