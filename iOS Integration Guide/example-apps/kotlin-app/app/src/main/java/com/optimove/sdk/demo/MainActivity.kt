package com.optimove.sdk.demo

import android.os.Bundle
import android.widget.Toast

import com.optimove.sdk.optimove_sdk.main.Optimove
import com.optimove.sdk.optimove_sdk.main.OptimoveSuccessStateListener
import com.optimove.sdk.optimove_sdk.main.constants.SdkRequiredPermission

import androidx.appcompat.app.AppCompatActivity
import androidx.viewpager.widget.ViewPager

class MainActivity : AppCompatActivity(), OptimoveSuccessStateListener {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val viewPager = findViewById<ViewPager>(R.id.mainViewPager)
        val mainPagerAdapter = MainPagerAdapter(supportFragmentManager)
        viewPager.adapter = mainPagerAdapter
    }

    override fun onStart() {
        super.onStart()
        // Optimove will hold a strong reference to the listener, remember to unregister or else you'll get a memory leak!
        Optimove.registerSuccessStateListener(this)
    }

    override fun onStop() {
        super.onStop()
        // Release the strong reference that Optimove holds to this listener
        Optimove.unregisterSuccessStateListener(this)
    }

    override fun onConfigurationSucceed(vararg missingPermissions: SdkRequiredPermission) {
        // The Optimove SDK is now initialized and ready to start receiving calls
        Optimove.getInstance().startTestMode { success -> Toast.makeText(this, "Test Mode Started", Toast.LENGTH_SHORT).show() }
    }
}
