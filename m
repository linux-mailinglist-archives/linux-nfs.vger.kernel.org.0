Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2BF224A3A
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgGRJZA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:25:00 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:43237 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726569AbgGRJY4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:56 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0000T8-Tw
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DlbBM/7CxriTyYaHJXs30O9irNeb4V4wSk7udWrb2OU=; b=h9ql8fjhuL4T/9IAPXog11esNk
        BfUBPhyKchQUpjSXix0dlpwgp1hrF1jzlX27YDdDUztSv/45Actev0MQvp0Dmv+rHZ7nro7cquHni
        t21ZD6uDWujls9IjYMnJMOp5qmqOx5O/V5FvyUtAuL23kJfCIaIkczhh+zB2FM2XxwPJaEa4KST4e
        WcHEt5SJ/hv95aj/uEEwtnVaxyMk4tLwaodkHDbwAe+T+1G57WlM/m44c6TKsp9ZJzq2JNu/aFw8v
        lb1floDEelmeU6yS0vxytvyh6crPONq5rXEih/eLYwWpWQ8z2gxndTT670PYgJkZt/kXDsaFoyIAC
        1goL6hOQ==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0001He-OG
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:50 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 11/11] svcgssd: Wait for nullrpc channel if not available
Date:   Sat, 18 Jul 2020 05:24:21 -0400
Message-Id: <20200718092421.31691-12-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.005556668255)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVdFMz4/AGqGoc
 TGSu/yfNpUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJSBfK4zF/GhD7b9e8YsdXJuFStTh08T0oeZwtAZH96BnXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhP00mgL6b13u0FHEcP+Wyqn9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVNO0eLTyIuJf+IqbzABHTTdw+jnEV4SmuSHpVqLSULkNZjEa/sNl+vcoDGoY
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
 utils/gssd/svcgssd.c | 99 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 19 deletions(-)

diff --git a/utils/gssd/svcgssd.c b/utils/gssd/svcgssd.c
index 3155a2f9..3ab2100b 100644
--- a/utils/gssd/svcgssd.c
+++ b/utils/gssd/svcgssd.c
@@ -67,9 +67,14 @@
 #include "misc.h"
 #include "svcgssd_krb5.h"
 
-struct state_paths etab;
+struct state_paths etab; /* from cacheio.c */
 static bool signal_received = false;
 static struct event_base *evbase = NULL;
+static int nullrpc_fd = -1;
+static struct event *nullrpc_event = NULL;
+static struct event *wait_event = NULL;
+
+#define NULLRPC_FILE "/proc/net/rpc/auth.rpcsec.init/channel"
 
 static void
 sig_die(int signal)
@@ -118,6 +123,66 @@ svcgssd_nullrpc_cb(int fd, short UNUSED(which), void *UNUSED(data))
 	handle_nullreq(lbuf);
 }
 
+static void
+svcgssd_nullrpc_close(void)
+{
+	if (nullrpc_event) {
+		printerr(2, "closing nullrpc channel %s\n", NULLRPC_FILE);
+		event_free(nullrpc_event);
+		nullrpc_event = NULL;
+	}
+	if (nullrpc_fd != -1) {
+		close(nullrpc_fd);
+		nullrpc_fd = -1;
+	}
+}
+
+static void
+svcgssd_nullrpc_open(void)
+{
+	nullrpc_fd = open(NULLRPC_FILE, O_RDWR);
+	if (nullrpc_fd < 0) {
+		printerr(0, "failed to open %s: %s\n",
+			 NULLRPC_FILE, strerror(errno));
+		return;
+	}
+	nullrpc_event = event_new(evbase, nullrpc_fd, EV_READ | EV_PERSIST,
+				  svcgssd_nullrpc_cb, NULL);
+	if (!nullrpc_event) {
+		printerr(0, "failed to create event for %s: %s\n",
+			 NULLRPC_FILE, strerror(errno));
+		close(nullrpc_fd);
+		nullrpc_fd = -1;
+		return;
+	}
+	event_add(nullrpc_event, NULL);
+	printerr(2, "opened nullrpc channel %s\n", NULLRPC_FILE);
+}
+
+static void
+svcgssd_wait_cb(int UNUSED(fd), short UNUSED(which), void *UNUSED(data))
+{
+	static int times = 0;
+	int rc;
+
+	rc = access(NULLRPC_FILE, R_OK | W_OK);
+	if (rc != 0) {
+		struct timeval t = {times < 10 ? 1 : 10, 0};
+		times++;
+		if (times % 30 == 0)
+			printerr(2, "still waiting for nullrpc channel: %s\n",
+				NULLRPC_FILE);
+		evtimer_add(wait_event, &t);
+		return;
+	}
+
+	svcgssd_nullrpc_open();
+	event_free(wait_event);
+	wait_event = NULL;
+}
+
+
+
 int
 main(int argc, char *argv[])
 {
@@ -132,8 +197,6 @@ main(int argc, char *argv[])
 	char *principal = NULL;
 	char *s;
 	int rc;
-	int nullrpc_fd = -1;
-	struct event *nullrpc_event = NULL;
 
 	conf_init_file(NFS_CONFFILE);
 
@@ -250,22 +313,19 @@ main(int argc, char *argv[])
 		}
 	}
 
-#define NULLRPC_FILE "/proc/net/rpc/auth.rpcsec.init/channel"
-
-	nullrpc_fd = open(NULLRPC_FILE, O_RDWR);
-	if (nullrpc_fd < 0) {
-		printerr(0, "failed to open %s: %s\n",
-			 NULLRPC_FILE, strerror(errno));
-		exit(1);
-	}
-	nullrpc_event = event_new(evbase, nullrpc_fd, EV_READ | EV_PERSIST,
-				  svcgssd_nullrpc_cb, NULL);
+	svcgssd_nullrpc_open();
 	if (!nullrpc_event) {
-		printerr(0, "failed to create event for %s: %s\n",
-			 NULLRPC_FILE, strerror(errno));
-		exit(1);
+		struct timeval t = {1, 0};
+
+		printerr(2, "waiting for nullrpc channel to appear\n");
+		wait_event = evtimer_new(evbase, svcgssd_wait_cb, NULL);
+		if (!wait_event) {
+			printerr(0, "ERROR: failed to create wait event: %s\n",
+				 strerror(errno));
+			exit(EXIT_FAILURE);
+		}
+		evtimer_add(wait_event, &t);
 	}
-	event_add(nullrpc_event, NULL);
 
 	daemon_ready();
 
@@ -275,8 +335,9 @@ main(int argc, char *argv[])
 	if (rc < 0)
 		printerr(0, "event_base_dispatch() returned %i!\n", rc);
 
-	event_free(nullrpc_event);
-	close(nullrpc_fd);
+	svcgssd_nullrpc_close();
+	if (wait_event)
+		event_free(wait_event);
 
 	event_base_free(evbase);
 
-- 
2.26.2

