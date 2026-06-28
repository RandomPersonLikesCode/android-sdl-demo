/* SPDX-License-Identifier: MIT */

package com.rplc.sdl_demo;

import android.util.Log;

import org.libsdl.app.SDLActivity;

public class MainActivity extends SDLActivity {
  private static final String TAG_NAME = "SDL_DEMO";

  @Override
  protected String[] getLibraries() {
    Log.i(TAG_NAME, "Get SDL libraries");
    return new String[] {
      "SDL3",
      "main"
    };
  }
}
