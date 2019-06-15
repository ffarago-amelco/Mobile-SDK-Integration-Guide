package com.optimove.sdk.demo;

import android.os.Bundle;
import android.widget.Toast;

import com.optimove.sdk.optimove_sdk.main.Optimove;
import com.optimove.sdk.optimove_sdk.main.OptimoveSuccessStateListener;
import com.optimove.sdk.optimove_sdk.main.constants.SdkRequiredPermission;

import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager.widget.ViewPager;

public class MainActivity extends AppCompatActivity implements OptimoveSuccessStateListener {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    ViewPager viewPager = findViewById(R.id.mainViewPager);
    MainPagerAdapter mainPagerAdapter = new MainPagerAdapter(getSupportFragmentManager());
    viewPager.setAdapter(mainPagerAdapter);
  }

  @Override
  protected void onStart() {
    super.onStart();
    // Optimove will hold a strong reference to the listener, remember to unregister or else you'll get a memory leak!
    Optimove.registerSuccessStateListener(this);
  }

  @Override
  protected void onStop() {
    super.onStop();
    // Release the strong reference that Optimove holds to this listener
    Optimove.unregisterSuccessStateListener(this);
  }

  @Override
  public void onConfigurationSucceed(SdkRequiredPermission... missingPermissions) {
    // The Optimove SDK is now initialized and ready to start receiving calls
    Optimove.getInstance().startTestMode(success -> Toast.makeText(this, "Test Mode Started", Toast.LENGTH_SHORT).show());
  }
}
