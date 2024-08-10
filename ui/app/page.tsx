import BrandSlide from "@/components/home/BrandSlide";
import CTA from "@/components/home/CTA";
import Footer from "@/components/Footer";
import Header from "@/components/Header";
import Hero from "@/components/home/Hero";
import Pricing from "@/components/home/Pricing";
import ProductCard from "@/components/home/ProductCard";
import ProductShowcase from "@/components/home/ProductShowcase";
import Testimonials from "@/components/home/Testimonials";

export default function Home() {
  return (
    <div>
      <Header />
      <Hero/>
      <BrandSlide/>
      <ProductShowcase/>
      <ProductCard/>
      <Pricing/>
      <Testimonials/>
      <CTA/>
      <Footer/>
    </div>
  );
}
