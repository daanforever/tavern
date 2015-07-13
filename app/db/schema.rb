# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150510123243) do

  create_table "components", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "disabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  add_index "components", ["project_id"], name: "index_components_on_project_id"

  create_table "components_releases", force: :cascade do |t|
    t.integer "component_id"
    t.integer "release_id"
  end

  add_index "components_releases", ["component_id"], name: "index_components_releases_on_component_id"
  add_index "components_releases", ["release_id"], name: "index_components_releases_on_release_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "environments", force: :cascade do |t|
    t.string   "name"
    t.integer  "project_id"
    t.integer  "release_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "environments", ["project_id"], name: "index_environments_on_project_id"
  add_index "environments", ["release_id"], name: "index_environments_on_release_id"

  create_table "hosts", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.boolean  "disabled"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "environment_id"
  end

  add_index "hosts", ["environment_id"], name: "index_hosts_on_environment_id"

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.boolean  "disabled"
    t.integer  "project_id"
    t.integer  "release_id"
    t.integer  "component_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "docker_id"
  end

  add_index "images", ["component_id"], name: "index_images_on_component_id"
  add_index "images", ["project_id"], name: "index_images_on_project_id"
  add_index "images", ["release_id"], name: "index_images_on_release_id"

  create_table "images_registries", force: :cascade do |t|
    t.integer "registry_id"
    t.integer "image_id"
  end

  add_index "images_registries", ["image_id"], name: "index_images_registries_on_image_id"
  add_index "images_registries", ["registry_id"], name: "index_images_registries_on_registry_id"

  create_table "instances", force: :cascade do |t|
    t.string   "name"
    t.boolean  "disabled"
    t.string   "container"
    t.text     "properties"
    t.integer  "image_id"
    t.integer  "component_id"
    t.integer  "host_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state"
    t.integer  "environment_id"
    t.text     "options"
  end

  add_index "instances", ["component_id"], name: "index_instances_on_component_id"
  add_index "instances", ["environment_id"], name: "index_instances_on_environment_id"
  add_index "instances", ["host_id"], name: "index_instances_on_host_id"
  add_index "instances", ["image_id"], name: "index_instances_on_image_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "label"
    t.boolean  "visible"
    t.boolean  "disabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "releases_count",     default: 0, null: false
    t.integer  "environments_count", default: 0, null: false
  end

  create_table "projects_registries", force: :cascade do |t|
    t.integer "project_id"
    t.integer "registry_id"
  end

  add_index "projects_registries", ["project_id"], name: "index_projects_registries_on_project_id"
  add_index "projects_registries", ["registry_id"], name: "index_projects_registries_on_registry_id"

  create_table "registries", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.boolean  "disabled"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "releases", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "state"
  end

  add_index "releases", ["project_id"], name: "index_releases_on_project_id"

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
