Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370CE229026
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGVFyC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:54:02 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:56273 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728049AbgGVFyC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:54:02 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7hX-0005jD-9j
        for linux-nfs@vger.kernel.org; Wed, 22 Jul 2020 00:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZSLYvDl3fNRMFOFsmIDVyF2oJswC1I2Oe5ryDsrp0e0=; b=hILljz4wFsTtQPeuPJhaD0DIT2
        kBzZPrHAaLB3cpjprKBFA3/2uyLN4SlzHcsSXXrRkTj0wygdHA1ZJqkyAYFTVlZWAlsAclZl5QtBI
        j/YT1PDGCMuvoEfsoEEUjKF/qKKKRZ5Q5ZemetpnVSq/ZMEuBrTdSa2m4VyvuhNVpLiB8bVdzv0hG
        7buuYKfZ/HhTUpyDRr1xBC/B2z2ASmbRGkAlVtEEi2GshA/M8smLgJ307b8sVryLHyXRN0wsdG0/y
        m3XvLWEU0JffuQFNWnuW3EJBnehhVumEWGN0B+3B0boomv4WZFxl0O2FSTcGaGHg9k8qFF1si54Kx
        ZXA2yxUw==;
Received: from [174.119.114.224] (port=44746 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7hX-00076P-2A
        for linux-nfs@vger.kernel.org; Wed, 22 Jul 2020 01:53:59 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] idmapd: Add graceful exit and resource cleanup
Date:   Wed, 22 Jul 2020 01:53:52 -0400
Message-Id: <20200722055354.28132-3-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722055354.28132-1-nazard@nazar.ca>
References: <20200722055354.28132-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00205176709524)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhV/e5CEO0SdfVZ
 hVlfeF0Qa0TNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dIZ/i9WJ7Rd8vON0CYo5woe67XI8zywfJdunGXHrZypA3XpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhQxBPrHBvirMJF75yK8lKDH9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVGLbUlq9gkfmitP94LxRBZZAHxBcLZkzNcDAgKPeBx3AZjEa/sNl+vcoDGoY
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
 utils/idmapd/idmapd.c | 75 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index 491ef54c..dae5e567 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -155,6 +155,7 @@ static void idtonameres(struct idmap_msg *);
 static void nametoidres(struct idmap_msg *);
 
 static int nfsdopen(void);
+static void nfsdclose(void);
 static int nfsdopenone(struct idmap_client *);
 static void nfsdreopen_one(struct idmap_client *);
 static void nfsdreopen(void);
@@ -167,6 +168,20 @@ static char *nobodyuser, *nobodygroup;
 static uid_t nobodyuid;
 static gid_t nobodygid;
 static struct event_base *evbase = NULL;
+static bool signal_received = false;
+
+static void
+sig_die(int signal)
+{
+	if (signal_received) {
+		xlog_warn("forced exiting on signal %d\n", signal);
+		exit(0);
+	}
+
+	signal_received = true;
+	xlog_warn("exiting on signal %d\n", signal);
+	event_base_loopexit(evbase, NULL);
+}
 
 static int
 flush_nfsd_cache(char *path, time_t now)
@@ -210,14 +225,15 @@ main(int argc, char **argv)
 {
 	int wd = -1, opt, fg = 0, nfsdret = -1;
 	struct idmap_clientq icq;
-	struct event *rootdirev, *clntdirev, *svrdirev, *inotifyev;
-	struct event *initialize;
+	struct event *rootdirev = NULL, *clntdirev = NULL,
+		     *svrdirev = NULL, *inotifyev = NULL;
+	struct event *initialize = NULL;
 	struct passwd *pw;
 	struct group *gr;
 	struct stat sb;
 	char *xpipefsdir = NULL;
 	int serverstart = 1, clientstart = 1;
-	int inotify_fd;
+	int inotify_fd = -1;
 	int ret;
 	char *progname;
 	char *conf_path = NULL;
@@ -290,6 +306,9 @@ main(int argc, char **argv)
 			serverstart = 0;
 	}
 
+	/* Not needed anymore */
+	conf_cleanup();
+
 	while ((opt = getopt(argc, argv, GETOPTSTR)) != -1)
 		switch (opt) {
 		case 'v':
@@ -398,6 +417,9 @@ main(int argc, char **argv)
 
 		TAILQ_INIT(&icq);
 
+		signal(SIGINT, sig_die);
+		signal(SIGTERM, sig_die);
+
 		/* These events are persistent */
 		rootdirev = evsignal_new(evbase, SIGUSR1, dirscancb, &icq);
 		if (rootdirev == NULL)
@@ -435,7 +457,25 @@ main(int argc, char **argv)
 	if (event_base_dispatch(evbase) < 0)
 		xlog_err("main: event_dispatch returns errno %d (%s)",
 			    errno, strerror(errno));
-	/* NOTREACHED */
+
+	nfs4_term_name_mapping();
+	nfsdclose();
+
+	if (inotifyev)
+		event_free(inotifyev);
+	if (inotify_fd != -1)
+		close(inotify_fd);
+
+	if (initialize)
+		event_free(initialize);
+	if (rootdirev)
+		event_free(rootdirev);
+	if (clntdirev)
+		event_free(clntdirev);
+	if (svrdirev)
+		event_free(svrdirev);
+	event_base_free(evbase);
+
 	return 1;
 }
 
@@ -760,6 +800,19 @@ out:
 	event_add(ic->ic_event, NULL);
 }
 
+static void
+nfsdclose_one(struct idmap_client *ic)
+{
+	if (ic->ic_event) {
+		event_free(ic->ic_event);
+		ic->ic_event = NULL;
+	}
+	if (ic->ic_fd != -1) {
+		close(ic->ic_fd);
+		ic->ic_fd = -1;
+	}
+}
+
 static void
 nfsdreopen_one(struct idmap_client *ic)
 {
@@ -769,12 +822,7 @@ nfsdreopen_one(struct idmap_client *ic)
 		xlog_warn("ReOpening %s", ic->ic_path);
 
 	if ((fd = open(ic->ic_path, O_RDWR, 0)) != -1) {
-		if (ic->ic_event && event_initialized(ic->ic_event)) {
-			event_del(ic->ic_event);
-			event_free(ic->ic_event);
-		}
-		if (ic->ic_fd != -1)
-			close(ic->ic_fd);
+		nfsdclose_one(ic);
 
 		ic->ic_fd = fd;
 		ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfsdcb, ic);
@@ -807,6 +855,13 @@ nfsdopen(void)
 		    nfsdopenone(&nfsd_ic[IC_IDNAME]) == 0) ? 0 : -1);
 }
 
+static void
+nfsdclose(void)
+{
+	nfsdclose_one(&nfsd_ic[IC_NAMEID]);
+	nfsdclose_one(&nfsd_ic[IC_IDNAME]);
+}
+
 static int
 nfsdopenone(struct idmap_client *ic)
 {
-- 
2.26.2

