#!/usr/bin/env bash

DEV_FLOW_PROJECT_SCHEMA_VERSION="${DEV_FLOW_PROJECT_SCHEMA_VERSION:-6}"

dev_flow_valid_project_type() {
  case "${1:-}" in
    ui|agent|api|library|docs) return 0 ;;
    *) return 1 ;;
  esac
}

dev_flow_applicability_template_for_type() {
  case "${1:-ui}" in
    ui) echo "applicability-ui.env" ;;
    agent) echo "applicability-agent.env" ;;
    api|library|docs) echo "applicability-non-ui.env" ;;
    *) echo "" ;;
  esac
}
