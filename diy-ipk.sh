#!/bin/bash
git clone  https://github.com/ITdesk01/jd_openwrt_script.git package/jd_openwrt_script

sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=@TARGET_armvirt_64/g' package/lean/luci-app-cpufreq/Makefile
cat package/lean/luci-app-cpufreq/Makefile
sed -i 's/entry({"admin", "services", "cpufreq"}, cbi("cpufreq"), _("CPU Freq"), 900).dependent = false/entry({"admin", "system", "cpufreq"}, cbi("cpufreq"), _("CPU Freq"), 9).dependent = false/g' package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua
cat package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua

./scripts/feeds update -a
./scripts/feeds install -a
