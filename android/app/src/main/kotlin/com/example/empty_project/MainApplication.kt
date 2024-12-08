package com.example.empty_project

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        // Устанавливаем язык и ключ API
        MapKitFactory.setLocale("ru_RU") // Предпочтительный язык
        MapKitFactory.setApiKey("91c078b4-4ede-42f0-bba4-5fcd7216c098") // Ваш API ключ
    }
}
