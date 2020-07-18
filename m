Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E40224A3C
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgGRJZE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:25:04 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:60157 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbgGRJYz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:55 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0000S0-3d
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QLJP4wjy2I+rY2bEM/5jrwa5boYczV+uRgen2xQ7FEQ=; b=mjVdcvJfRpcqp3sOgf3mtmjL+o
        Vjy8rmoHz+B22u6Znw8EMsPWXkI4usniduixRPVrMhCyknHvOoFiWFMF/t3894ZIxHxMmoaUFujLM
        vJHc5cAbEjDPF7IjzvRTPDHOFhgAjBmRZGesvTh98knSqrsp4zaUAW/2Tpk4e0ir/fp7S4sYBmUfM
        /L1OrPGpd6S5CUg/kIOKWFRqSDGAQ+RMxxHceP2O4Lf32QdmRgJgb0T3o1F9eDxTF1w9a2EAErIhg
        ixifOImI71OGJwob24WQud1eNGiZE+Nov1wh7zxweOksD+gPZuD5rkzk8+Xzaf0wyYvhP+K8bXenx
        YPL9RtLA==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0001He-U2
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:49 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/11] nfsdcld: Add graceful exit handling and resource cleanup
Date:   Sat, 18 Jul 2020 05:24:16 -0400
Message-Id: <20200718092421.31691-7-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718092421.31691-1-nazard@nazar.ca>
References: <20200718092421.31691-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000371006276743)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVV/885Ry1PRqv
 uZDqEqk21kTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJlVzO70gsZqepgmXGYYD2+WQICwsOgO0ofQcBYkbX5WHXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhGFD//eip2BB74+LOn843PX9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVNO0eLTyIuJf+IqbzABHTTc/UT1bX+2Gm/PrYRC4E9iwZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/nfsdcld/nfsdcld.c | 32 ++++++++++++++++++++++++++++++--
 utils/nfsdcld/sqlite.c  | 15 +++++++++++++++
 utils/nfsdcld/sqlite.h  |  1 +
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index 5ad94ce2..636c3983 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -27,6 +27,7 @@
 #include <event2/event.h>
 #include <stdbool.h>
 #include <getopt.h>
+#include <signal.h>
 #include <string.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -69,6 +70,7 @@ static int 		inotify_fd = -1;
 static struct event	 *pipedir_event;
 static struct event_base *evbase;
 static bool old_kernel = false;
+static bool signal_received = false;
 
 uint64_t current_epoch;
 uint64_t recovery_epoch;
@@ -89,6 +91,19 @@ static struct option longopts[] =
 /* forward declarations */
 static void cldcb(int UNUSED(fd), short which, void *data);
 
+static void
+sig_die(int signal)
+{
+	if (signal_received) {
+		xlog(D_GENERAL, "forced exiting on signal %d\n", signal);
+		exit(0);
+	}
+
+	signal_received = true;
+	xlog(D_GENERAL, "exiting on signal %d\n", signal);
+	event_base_loopexit(evbase, NULL);
+}
+
 static void
 usage(char *progname)
 {
@@ -881,14 +896,27 @@ main(int argc, char **argv)
 	if (rc)
 		goto out;
 
+	signal(SIGINT, sig_die);
+	signal(SIGTERM, sig_die);
+
 	xlog(D_GENERAL, "%s: Starting event dispatch handler.", __func__);
 	rc = event_base_dispatch(evbase);
 	if (rc < 0)
 		xlog(L_ERROR, "%s: event_dispatch failed: %m", __func__);
 
-	close(clnt.cl_fd);
-	close(inotify_fd);
 out:
+	if (clnt.cl_event)
+		event_free(clnt.cl_event);
+	if (clnt.cl_fd != -1)
+		close(clnt.cl_fd);
+	if (pipedir_event)
+		event_free(pipedir_event);
+	if (inotify_fd != -1)
+		close(inotify_fd);
+
+	event_base_free(evbase);
+	sqlite_shutdown();
+
 	free(progname);
 	return rc;
 }
diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index e2586c39..8fd1d0c2 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -1404,3 +1404,18 @@ sqlite_first_time_done(void)
 	sqlite3_free(err);
 	return ret;
 }
+
+/*
+ * Closes all sqlite3 resources and shuts down the library.
+ *
+ */
+void
+sqlite_shutdown(void)
+{
+	if (dbh != NULL) {
+		sqlite3_close(dbh);
+		dbh = NULL;
+	}
+
+	sqlite3_shutdown();
+}
diff --git a/utils/nfsdcld/sqlite.h b/utils/nfsdcld/sqlite.h
index 0a26ad67..044236cf 100644
--- a/utils/nfsdcld/sqlite.h
+++ b/utils/nfsdcld/sqlite.h
@@ -34,4 +34,5 @@ int sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_clien
 int sqlite_delete_cltrack_records(void);
 int sqlite_first_time_done(void);
 
+void sqlite_shutdown(void);
 #endif /* _SQLITE_H */
-- 
2.26.2

