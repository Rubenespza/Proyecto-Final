package com.example.appkotlin.ui.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.recyclerview.widget.RecyclerView
import com.example.appkotlin.model.Menu
import com.example.appkotlin.R
import com.example.appkotlin.util.Comunicacion
import com.example.appkotlin.util.Util

class MenuAdapter(
    private val context: Context?,
    private val menuList: List<Menu>,
    private val com: Comunicacion
) :
    RecyclerView.Adapter<MenuAdapter.MenuViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MenuViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.item_menu, parent, false)
        return MenuViewHolder(view)
    }

    override fun onBindViewHolder(holder: MenuViewHolder, position: Int) {
        val menu = menuList[position]
        holder.tvNombreMenu.text = menu.nombre
        Util.setImageFromBase64(holder.imgIconMenu, menu.foto)

        holder.ly.setOnClickListener {
            com.onClick(menu)
        }
    }

    override fun getItemCount(): Int {
        return menuList.size
    }

    fun getLista(): List<Menu> {
        return menuList
    }

    inner class MenuViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val imgIconMenu: ImageView = itemView.findViewById(R.id.imgMenu)
        val tvNombreMenu: TextView = itemView.findViewById(R.id.tvNombreMenu)
        val ly: ConstraintLayout = itemView.findViewById(R.id.ly)
    }
}