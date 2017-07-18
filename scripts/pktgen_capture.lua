package.path = package.path ..";?.lua;test/?.lua;app/?.lua;"
pktgen.start(0);
--just to make sure that there are no rx-miss and tx-error in VPP
pktgen.delay(5000);
pktgen.clear("all");
pktgen.capture(1,"enable");
pktgen.delay(1000);
pktgen.stop(0);
pktgen.delay(3000);
pktgen.capture(1,"disable");
pktgen.delay(5000);
os.execute("sudo kill -9 $(pidof pktgen)");
