Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57F372406
	for <lists+linux-nfs@lfdr.de>; Tue,  4 May 2021 02:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhEDA6G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 3 May 2021 20:58:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhEDA6F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 20:58:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F014CB034;
        Tue,  4 May 2021 00:57:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH nfs-utils] Replace all /var/run with /run
Date:   Tue, 04 May 2021 10:57:06 +1000
Message-id: <162008982689.6582.6678647463188747222@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

FHS 3.0 deprecated /var/run in favour of /run.
FHS 3.0 was released over 5 years ago.
I think it is time for nfs-utils to catch up.
Note that some places, particularly systemd unit files, already use just
"/run".

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/nfs/getport.c            |  2 +-
 tests/test-lib.sh                |  2 +-
 utils/blkmapd/device-discovery.c |  2 +-
 utils/statd/sm-notify.c          |  4 ++--
 utils/statd/start-statd          | 10 +++++-----
 utils/statd/statd.c              |  2 +-
 utils/statd/statd.man            |  2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/support/nfs/getport.c b/support/nfs/getport.c
index e458d8fe95f8..813f7bf9e3ff 100644
--- a/support/nfs/getport.c
+++ b/support/nfs/getport.c
@@ -904,7 +904,7 @@ int nfs_getport_ping(struct sockaddr *sap, const socklen_t salen,
  * listen on AF_LOCAL.
  *
  * If that doesn't work (for example, if portmapper is running, or rpcbind
- * isn't listening on /var/run/rpcbind.sock), send a query via UDP to localhost
+ * isn't listening on /run/rpcbind.sock), send a query via UDP to localhost
  * (UDP doesn't leave a socket in TIME_WAIT, and the timeout is a relatively
  * short 3 seconds).
  */
diff --git a/tests/test-lib.sh b/tests/test-lib.sh
index 57af37b11126..e47ad13539ac 100644
--- a/tests/test-lib.sh
+++ b/tests/test-lib.sh
@@ -56,5 +56,5 @@ start_statd() {
 
 # shut down statd
 kill_statd() {
-	kill `cat /var/run/rpc.statd.pid`
+	kill `cat /run/rpc.statd.pid`
 }
diff --git a/utils/blkmapd/device-discovery.c b/utils/blkmapd/device-discovery.c
index f5f9b10b95f2..77ebe73670fa 100644
--- a/utils/blkmapd/device-discovery.c
+++ b/utils/blkmapd/device-discovery.c
@@ -64,7 +64,7 @@
 #define EVENT_BUFSIZE (1024 * EVENT_SIZE)
 
 #define RPCPIPE_DIR	"/var/lib/nfs/rpc_pipefs"
-#define PID_FILE	"/var/run/blkmapd.pid"
+#define PID_FILE	"/run/blkmapd.pid"
 
 #define CONF_SAVE(w, f) do {			\
 	char *p = f;				\
diff --git a/utils/statd/sm-notify.c b/utils/statd/sm-notify.c
index 606b912d3629..ed82b8f2533d 100644
--- a/utils/statd/sm-notify.c
+++ b/utils/statd/sm-notify.c
@@ -901,7 +901,7 @@ find_host(uint32_t xid)
 }
 
 /*
- * Record pid in /var/run/sm-notify.pid
+ * Record pid in /run/sm-notify.pid
  * This file should remain until a reboot, even if the
  * program exits.
  * If file already exists, fail.
@@ -913,7 +913,7 @@ static int record_pid(void)
 	int fd;
 
 	(void)snprintf(pid, sizeof(pid), "%d\n", (int)getpid());
-	fd = open("/var/run/sm-notify.pid", O_CREAT|O_EXCL|O_WRONLY, 0600);
+	fd = open("/run/sm-notify.pid", O_CREAT|O_EXCL|O_WRONLY, 0600);
 	if (fd < 0)
 		return 0;
 
diff --git a/utils/statd/start-statd b/utils/statd/start-statd
index 54ced822016a..2baf73c385cf 100755
--- a/utils/statd/start-statd
+++ b/utils/statd/start-statd
@@ -1,18 +1,18 @@
 #!/bin/sh
 # nfsmount calls this script when mounting a filesystem with locking
 # enabled, but when statd does not seem to be running (based on
-# /var/run/rpc.statd.pid).
+# /run/rpc.statd.pid).
 # It should run statd with whatever flags are apropriate for this
 # site.
 PATH="/sbin:/usr/sbin:/bin:/usr/bin"
 
 # Use flock to serialize the running of this script
-exec 9> /var/run/rpc.statd.lock
+exec 9> /run/rpc.statd.lock
 flock -e 9
 
-if [ -s /var/run/rpc.statd.pid ] &&
-       [ 1`cat /var/run/rpc.statd.pid` -gt 1 ] &&
-       kill -0 `cat /var/run/rpc.statd.pid` > /dev/null 2>&1
+if [ -s /run/rpc.statd.pid ] &&
+       [ 1`cat /run/rpc.statd.pid` -gt 1 ] &&
+       kill -0 `cat /run/rpc.statd.pid` > /dev/null 2>&1
 then
     # statd already running - must have been slow to respond.
     exit 0
diff --git a/utils/statd/statd.c b/utils/statd/statd.c
index 32169d47c66d..a469a67a91df 100644
--- a/utils/statd/statd.c
+++ b/utils/statd/statd.c
@@ -161,7 +161,7 @@ usage(void)
 	fprintf(stderr,"      -H                   Specify a high-availability callout program.\n");
 }
 
-static const char *pidfile = "/var/run/rpc.statd.pid";
+static const char *pidfile = "/run/rpc.statd.pid";
 
 int pidfd = -1;
 static void create_pidfile(void)
diff --git a/utils/statd/statd.man b/utils/statd/statd.man
index ecd3e889e831..7441ffde2687 100644
--- a/utils/statd/statd.man
+++ b/utils/statd/statd.man
@@ -440,7 +440,7 @@ directory containing notify list
 .I /var/lib/nfs/state
 NSM state number for this host
 .TP 2.5i
-.I /var/run/run.statd.pid
+.I /run/run.statd.pid
 pid file
 .TP 2.5i
 .I /etc/netconfig
-- 
2.30.1

