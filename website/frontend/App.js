import React, { Suspense } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { Provider } from 'react-redux';

import Loadspinner from './src/components/LoadSpinner';

const HomePage = React.lazy(() => import('src/pages/HomePage'));
const Press = React.lazy(() => import('src/pages/Press/Press'));
const LegalPage = React.lazy(() => import('src/pages/Legal'));
const ResearchPage = React.lazy(() => import('src/pages/OurSolutions/ResearchPage'));
const CommunityPage = React.lazy(() => import('src/pages/OurSolutions/CommunityPage'));
const AfricanCitiesPage = React.lazy(() => import('src/pages/OurSolutions/AfricanCitiesPage'));
const AboutUsPage = React.lazy(() => import('src/pages/AboutUsPage'));
const ContactUsPage = React.lazy(() => import('src/pages/ContactUs/ContactUs'));
const ContactForm = React.lazy(() => import('src/pages/ContactUs/ContactForm'));
const Feedback = React.lazy(() => import('src/pages/ContactUs/Feedback'));
const ExploreData = React.lazy(() => import('src/pages/ExploreData'));
const CareerPage = React.lazy(() => import('src/pages/CareerPage'));
const CareerDetailPage = React.lazy(() => import('src/pages/CareerDetailPage'));
const PublicationsPage = React.lazy(() => import('src/pages/Publications/Publications'));
const EventsPage = React.lazy(() => import('src/pages/Events'));
const EventsDetailsPage = React.lazy(()=>import('src/pages/Events/Details'))

import { loadAirQloudSummaryData } from 'reduxStore/AirQlouds/operations';
import { ContentUganda, ContentKenya } from 'src/pages/OurSolutions/AfricanCitiesPage';
import store from './store';
import {
  ExploreGetStarted,
  ExploreUserCategory,
  ExploreUserProfessionType,
  ExploreOrganisationType,
  ExploreUserRegistry,
  ExploreRegistryConfirmation,
  ExploreApp,
  ExploreBusinessRegistry,
  ExploreOrganisationRegistry
} from './src/pages/ExploreData';
import PartnerDetailPage from './src/pages/Partners';
import Error404 from 'src/pages/ErrorPages/Error404';

store.dispatch(loadAirQloudSummaryData());

const App = () => {
  return (
    <Provider store={store}>
      <Router>
        <Suspense fallback={<Loadspinner />}>
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/solutions/research" element={<ResearchPage />} />
            <Route path="/solutions/communities" element={<CommunityPage />} />
            <Route path="/solutions/african-cities" element={<AfricanCitiesPage />}>
              <Route path="uganda" element={<ContentUganda />} />
              <Route path="kenya" element={<ContentKenya />} />
            </Route>
            <Route path="/careers" element={<CareerPage />} />
            <Route path="/careers/:uniqueTitle" element={<CareerDetailPage />} />
            <Route path="/about-us" element={<AboutUsPage />} />
            <Route path="/press" element={<Press />} />
            <Route path="/legal" element={<LegalPage />} />
            <Route path="/contact" element={<ContactUsPage />} />
            <Route path="/contact/form" element={<ContactForm />} />
            <Route path="/contact/sent" element={<Feedback />} />
            <Route path="/explore-data" element={<ExploreData />} />
            <Route path="/explore-data/download-apps" element={<ExploreApp />} />
            <Route path="/explore-data/get-started" element={<ExploreGetStarted />} />
            <Route path="/explore-data/get-started/user" element={<ExploreUserCategory />} />
            <Route
              path="/explore-data/get-started/user/individual"
              element={<ExploreUserProfessionType />}
            />
            <Route
              path="/explore-data/get-started/user/organisation"
              element={<ExploreOrganisationType />}
            />
            <Route
              path="/explore-data/get-started/user/register"
              element={<ExploreUserRegistry />}
            />
            <Route
              path="/explore-data/get-started/user/register/business"
              element={<ExploreBusinessRegistry />}
            />
            <Route
              path="/explore-data/get-started/user/register/organisation"
              element={<ExploreOrganisationRegistry />}
            />
            <Route
              path="/explore-data/get-started/user/check-mail"
              element={<ExploreRegistryConfirmation />}
            />
            <Route path="/partners/:uniqueTitle" element={<PartnerDetailPage />} />
            <Route path="/publications" element={<PublicationsPage />} />
            <Route path="/events" element={<EventsPage />} />
            <Route path="/events/details" element={<EventsDetailsPage/>}/>
            <Route path="*" element={<Error404 />} />
          </Routes>
        </Suspense>
      </Router>
    </Provider>
  );
};

export default App;
