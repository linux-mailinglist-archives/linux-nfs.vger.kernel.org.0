Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C79224A36
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgGRJY4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:24:56 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:51377 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726499AbgGRJYy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:54 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0000Qp-8x
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=svRA7aoHOMvVxIvs35zO4PcgOG2zRhRVK8CiwRc7iLw=; b=Z8I82+z/42DDhNK/UOOROHbIKm
        E6u0n1saO8SU2E2afpy3OLaHjg4k5GlxuRZlqH5clqi7HyS9t1byv+YXLYGoMNzk81rabJClVYPvm
        FxuSYzX0u0PbzZP1kehmAFg16UFt5342AXMa+GE9AF0FuwGppMJqot4I+iQR88wxMLHDlOwkIuYg7
        q94jjwPwHqf1ffcvlhyZUDdytb67hLsvHbSJUqtQtmTV0pkrVt+uxQ3te8wE3trzLQWk3qF+Wy9qH
        lpQv4dK0QdSrD5f3wXLH+eWmccFsaKzFNVPavYymbgydLecYN2Y8m1863UVCD/UdSHXsed9iil83C
        qE9zXViA==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0001He-3i
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:49 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/11] Add error handling to libevent allocations.
Date:   Sat, 18 Jul 2020 05:24:11 -0400
Message-Id: <20200718092421.31691-2-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00279471690026)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhV4nrcCLuIZDk+
 36DwAGCZnkTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dLX05wiIfJ4ndNwWne761Sox7kTeATwqXzUYlxYOl0P/HXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhcLHrhidnRCj/3YGmYs9moX9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVNfl/yowmv/m59rLSnpj2Nwi8SRcE85x96+mMa5iwb7SZjEa/sNl+vcoDGoY
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
 utils/gssd/gssd.c       | 37 +++++++++++++++++++++++++++----------
 utils/idmapd/idmapd.c   | 32 ++++++++++++++++++++++++++++++++
 utils/nfsdcld/nfsdcld.c | 18 +++++++++++++++++-
 3 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index 3c7c703a..85bc4b07 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -560,14 +560,9 @@ static int
 gssd_scan_clnt(struct clnt_info *clp)
 {
 	int clntfd;
-	bool gssd_was_closed;
-	bool krb5_was_closed;
 
 	printerr(3, "scanning client %s\n", clp->relpath);
 
-	gssd_was_closed = clp->gssd_fd < 0 ? true : false;
-	krb5_was_closed = clp->krb5_fd < 0 ? true : false;
-
 	clntfd = openat(pipefs_fd, clp->relpath, O_RDONLY);
 	if (clntfd < 0) {
 		if (errno != ENOENT)
@@ -582,16 +577,30 @@ gssd_scan_clnt(struct clnt_info *clp)
 	if (clp->gssd_fd == -1 && clp->krb5_fd == -1)
 		clp->krb5_fd = openat(clntfd, "krb5", O_RDWR | O_NONBLOCK);
 
-	if (gssd_was_closed && clp->gssd_fd >= 0) {
+	if (!clp->gssd_ev && clp->gssd_fd >= 0) {
 		clp->gssd_ev = event_new(evbase, clp->gssd_fd, EV_READ | EV_PERSIST,
 					 gssd_clnt_gssd_cb, clp);
-		event_add(clp->gssd_ev, NULL);
+		if (!clp->gssd_ev) {
+			printerr(0, "ERROR: %s: can't create gssd event for %s: %s\n",
+				 __FUNCTION__, clp->relpath, strerror(errno));
+			close(clp->gssd_fd);
+			clp->gssd_fd = -1;
+		} else {
+			event_add(clp->gssd_ev, NULL);
+		}
 	}
 
-	if (krb5_was_closed && clp->krb5_fd >= 0) {
+	if (!clp->krb5_ev && clp->krb5_fd >= 0) {
 		clp->krb5_ev = event_new(evbase, clp->krb5_fd, EV_READ | EV_PERSIST,
 					 gssd_clnt_krb5_cb, clp);
-		event_add(clp->krb5_ev, NULL);
+		if (!clp->krb5_ev) {
+			printerr(0, "ERROR: %s: can't create krb5 event for %s: %s\n",
+				 __FUNCTION__, clp->relpath, strerror(errno));
+			close(clp->krb5_fd);
+			clp->krb5_fd = -1;
+		} else {
+			event_add(clp->krb5_ev, NULL);
+		}
 	}
 
 	if (clp->krb5_fd == -1 && clp->gssd_fd == -1)
@@ -1086,7 +1095,7 @@ main(int argc, char *argv[])
 
 	evbase = event_base_new();
 	if (!evbase) {
-		printerr(0, "ERROR: failed to create event base\n");
+		printerr(0, "ERROR: failed to create event base: %s\n", strerror(errno));
 		exit(EXIT_FAILURE);
 	}
 
@@ -1111,9 +1120,17 @@ main(int argc, char *argv[])
 	signal(SIGINT, sig_die);
 	signal(SIGTERM, sig_die);
 	sighup_ev = evsignal_new(evbase, SIGHUP, gssd_scan_cb, NULL);
+	if (!sighup_ev) {
+		printerr(0, "ERROR: failed to create SIGHUP event: %s\n", strerror(errno));
+		exit(EXIT_FAILURE);
+	}
 	evsignal_add(sighup_ev, NULL);
 	inotify_ev = event_new(evbase, inotify_fd, EV_READ | EV_PERSIST,
 			       gssd_inotify_cb, NULL);
+	if (!inotify_ev) {
+		printerr(0, "ERROR: failed to create inotify event: %s\n", strerror(errno));
+		exit(EXIT_FAILURE);
+	}
 	event_add(inotify_ev, NULL);
 
 	TAILQ_INIT(&topdir_list);
diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index 12648f67..491ef54c 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -400,13 +400,21 @@ main(int argc, char **argv)
 
 		/* These events are persistent */
 		rootdirev = evsignal_new(evbase, SIGUSR1, dirscancb, &icq);
+		if (rootdirev == NULL)
+			errx(1, "Failed to create SIGUSR1 event.");
 		evsignal_add(rootdirev, NULL);
 		clntdirev = evsignal_new(evbase, SIGUSR2, clntscancb, &icq);
+		if (clntdirev == NULL)
+			errx(1, "Failed to create SIGUSR2 event.");
 		evsignal_add(clntdirev, NULL);
 		svrdirev = evsignal_new(evbase, SIGHUP, svrreopen, NULL);
+		if (svrdirev == NULL)
+			errx(1, "Failed to create SIGHUP event.");
 		evsignal_add(svrdirev, NULL);
 		if ( wd >= 0) {
 			inotifyev = event_new(evbase, inotify_fd, EV_READ, dirscancb, &icq);
+			if (inotifyev == NULL)
+				errx(1, "Failed to create inotify read event.");
 			event_add(inotifyev, NULL);
 		}
 
@@ -414,6 +422,8 @@ main(int argc, char **argv)
 		/* (Delay till start of event_dispatch to avoid possibly losing
 		 * a SIGUSR1 between here and the call to event_dispatch().) */
 		initialize = evtimer_new(evbase, dirscancb, &icq);
+		if (initialize == NULL)
+			errx(1, "Failed to create initialize event.");
 		evtimer_add(initialize, &now);
 	}
 
@@ -768,6 +778,13 @@ nfsdreopen_one(struct idmap_client *ic)
 
 		ic->ic_fd = fd;
 		ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfsdcb, ic);
+		if (ic->ic_event == NULL) {
+			xlog_warn("nfsdreopen: Failed to create event for '%s'",
+				  ic->ic_path);
+			close(ic->ic_fd);
+			ic->ic_fd = -1;
+			return;
+		}
 		event_add(ic->ic_event, NULL);
 	} else {
 		xlog_warn("nfsdreopen: Opening '%s' failed: errno %d (%s)",
@@ -802,6 +819,14 @@ nfsdopenone(struct idmap_client *ic)
 	}
 
 	ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfsdcb, ic);
+	if (ic->ic_event == NULL) {
+		if (verbose > 0)
+			xlog_warn("nfsdopenone: Create event for %s failed",
+				  ic->ic_path);
+		close(ic->ic_fd);
+		ic->ic_fd = -1;
+		return (-1);
+	}
 	event_add(ic->ic_event, NULL);
 
 	if (verbose > 0)
@@ -826,6 +851,13 @@ nfsopen(struct idmap_client *ic)
 		}
 	} else {
 		ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfscb, ic);
+		if (ic->ic_event == NULL) {
+			xlog_warn("nfsdopenone: Create event for %s failed",
+				  ic->ic_path);
+			close(ic->ic_fd);
+			ic->ic_fd = -1;
+			return -1;
+		}
 		event_add(ic->ic_event, NULL);
 		fcntl(ic->ic_dirfd, F_NOTIFY, 0);
 		fcntl(ic->ic_dirfd, F_SETSIG, 0);
diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index 6cefcf24..5ad94ce2 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -142,6 +142,7 @@ static int
 cld_pipe_open(struct cld_client *clnt)
 {
 	int fd;
+	struct event *ev;
 
 	xlog(D_GENERAL, "%s: opening upcall pipe %s", __func__, pipepath);
 	fd = open(pipepath, O_RDWR, 0);
@@ -150,6 +151,13 @@ cld_pipe_open(struct cld_client *clnt)
 		return -errno;
 	}
 
+	ev = event_new(evbase, fd, EV_READ, cldcb, clnt);
+	if (ev == NULL) {
+		xlog(D_GENERAL, "%s: failed to create event for %s", __func__, pipepath);
+		close(fd);
+		return -ENOMEM;
+	}
+
 	if (clnt->cl_event && event_initialized(clnt->cl_event)) {
 		event_del(clnt->cl_event);
 		event_free(clnt->cl_event);
@@ -158,7 +166,7 @@ cld_pipe_open(struct cld_client *clnt)
 		close(clnt->cl_fd);
 
 	clnt->cl_fd = fd;
-	clnt->cl_event = event_new(evbase, clnt->cl_fd, EV_READ, cldcb, clnt);
+	clnt->cl_event = ev;
 	/* event_add is done by the caller */
 	return 0;
 }
@@ -304,6 +312,10 @@ cld_pipe_init(struct cld_client *clnt)
 
 	/* set event for inotify read */
 	pipedir_event = event_new(evbase, inotify_fd, EV_READ, cld_inotify_cb, clnt);
+	if (pipedir_event == NULL) {
+		close(inotify_fd);
+		return -ENOMEM;
+	}
 	event_add(pipedir_event, NULL);
 out:
 	return ret;
@@ -768,6 +780,10 @@ main(int argc, char **argv)
 	}
 
 	evbase = event_base_new();
+	if (evbase == NULL) {
+		fprintf(stderr, "%s: unable to allocate event base.\n", argv[0]);
+		return 1;
+	}
 	xlog_syslog(0);
 	xlog_stderr(1);
 
-- 
2.26.2

