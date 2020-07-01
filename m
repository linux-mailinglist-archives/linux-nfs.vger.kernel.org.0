Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345B42112B0
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgGAS2N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:13 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:53505 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732888AbgGAS2M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:12 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSq-0007XA-Gv
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qrumFLOrdYY/i7jsTuvUztCbnclz9DfS5Gaeo1E9XtI=; b=XHtQlkdfbgoTzfs77Jfnvx5ulD
        SyX5ngYQ4iSkOmMo53G4e0QHRBxn6JeuOFHRMseh5IibFttqq1POIWjjqQ1fJTUZNdtJw3D/gJjMH
        5nqrhncPqUufSdbVqyAEO4gDfqq41LU4z7oEalJ60MjXJIGekAelQWb6HDonFZvxLswzQ6Y0QrV00
        1FuqmMcgZlGCkzl/cg2z5L3f09J3f3LLN9cTXDi/1Oj0Bh66+HrxKiOE5M/en6RmoeoSda9Mk68v7
        BIeJv0g1vUDtjrLFNPrhWwYdVWIhCqvJxNWPIAk1H7jWsxSC3bWguOYHwXD3h+vgRX+bkds9H77nv
        EvnrsVCw==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSq-0003Oc-BH
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:08 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/10] Update to libevent 2.x apis.
Date:   Wed,  1 Jul 2020 14:27:53 -0400
Message-Id: <20200701182803.14947-3-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701182803.14947-1-nazard@nazar.ca>
References: <20200701182803.14947-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (3.96447254494e-05)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVi9Vro23mOkSF
 NDP3JexQr0TNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dLI3afsvdG8Wac/RFakAoUjHgUgR/Xew92BCehPpO9Da3XpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhJNUw/rlW+CXUZOCdn1f+rH9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVGIDtlyyGhtxMdqa3CaFDS1t7wVO00SsQIONYgVSCyg/ZjEa/sNl+vcoDGoY
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
 aclocal/libevent.m4          |  6 ++--
 utils/gssd/gssd.c            | 58 +++++++++++++++++++++------------
 utils/gssd/gssd.h            |  4 +--
 utils/idmapd/idmapd.c        | 62 ++++++++++++++++++++----------------
 utils/nfsdcld/cld-internal.h |  2 +-
 utils/nfsdcld/nfsdcld.c      | 29 +++++++++--------
 utils/nfsdcld/sqlite.c       |  1 -
 utils/nfsdcltrack/sqlite.c   |  2 +-
 8 files changed, 94 insertions(+), 70 deletions(-)

diff --git a/aclocal/libevent.m4 b/aclocal/libevent.m4
index b5ac00ff..e0b820b2 100644
--- a/aclocal/libevent.m4
+++ b/aclocal/libevent.m4
@@ -1,12 +1,12 @@
 dnl Checks for libevent
 AC_DEFUN([AC_LIBEVENT], [
 
-  dnl Check for libevent, but do not add -levent to LIBS
-  AC_CHECK_LIB([event], [event_dispatch], [LIBEVENT=-levent],
+  dnl Check for libevent, but do not add -levent_core to LIBS
+  AC_CHECK_LIB([event_core], [event_base_dispatch], [LIBEVENT=-levent_core],
                [AC_MSG_ERROR([libevent not found.])])
   AC_SUBST(LIBEVENT)
 
-  AC_CHECK_HEADERS([event.h], ,
+  AC_CHECK_HEADERS([event2/event.h], ,
                    [AC_MSG_ERROR([libevent headers not found.])])
 
 ])dnl
diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index b40c3220..f8f21f74 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -64,7 +64,7 @@
 #include <fcntl.h>
 #include <dirent.h>
 #include <netdb.h>
-#include <event.h>
+#include <event2/event.h>
 
 #include "gssd.h"
 #include "err_util.h"
@@ -77,7 +77,7 @@ static char *pipefs_path = GSSD_PIPEFS_DIR;
 static DIR *pipefs_dir;
 static int pipefs_fd;
 static int inotify_fd;
-struct event inotify_ev;
+struct event *inotify_ev;
 
 char *keytabfile = GSSD_DEFAULT_KEYTAB_FILE;
 char **ccachesearch;
@@ -91,6 +91,7 @@ char *ccachedir = NULL;
 static bool avoid_dns = true;
 static bool use_gssproxy = false;
 pthread_mutex_t clp_lock = PTHREAD_MUTEX_INITIALIZER;
+static struct event_base *evbase = NULL;
 
 TAILQ_HEAD(topdir_list_head, topdir) topdir_list;
 
@@ -394,11 +395,17 @@ gssd_destroy_client(struct clnt_info *clp)
 {
 	printerr(3, "destroying client %s\n", clp->relpath);
 
-	if (clp->krb5_fd >= 0)
-		event_del(&clp->krb5_ev);
+	if (clp->krb5_ev) {
+		event_del(clp->krb5_ev);
+		event_free(clp->krb5_ev);
+		clp->krb5_ev = NULL;
+	}
 
-	if (clp->gssd_fd >= 0)
-		event_del(&clp->gssd_ev);
+	if (clp->gssd_ev) {
+		event_del(clp->gssd_ev);
+		event_free(clp->gssd_ev);
+		clp->gssd_ev = NULL;
+	}
 
 	inotify_rm_watch(inotify_fd, clp->wd);
 	gssd_free_client(clp);
@@ -571,15 +578,15 @@ gssd_scan_clnt(struct clnt_info *clp)
 		clp->krb5_fd = openat(clntfd, "krb5", O_RDWR | O_NONBLOCK);
 
 	if (gssd_was_closed && clp->gssd_fd >= 0) {
-		event_set(&clp->gssd_ev, clp->gssd_fd, EV_READ | EV_PERSIST,
-			  gssd_clnt_gssd_cb, clp);
-		event_add(&clp->gssd_ev, NULL);
+		clp->gssd_ev = event_new(evbase, clp->gssd_fd, EV_READ | EV_PERSIST,
+					 gssd_clnt_gssd_cb, clp);
+		event_add(clp->gssd_ev, NULL);
 	}
 
 	if (krb5_was_closed && clp->krb5_fd >= 0) {
-		event_set(&clp->krb5_ev, clp->krb5_fd, EV_READ | EV_PERSIST,
-			  gssd_clnt_krb5_cb, clp);
-		event_add(&clp->krb5_ev, NULL);
+		clp->krb5_ev = event_new(evbase, clp->krb5_fd, EV_READ | EV_PERSIST,
+					 gssd_clnt_krb5_cb, clp);
+		event_add(clp->krb5_ev, NULL);
 	}
 
 	if (clp->krb5_fd == -1 && clp->gssd_fd == -1)
@@ -783,12 +790,16 @@ gssd_inotify_clnt(struct topdir *tdi, struct clnt_info *clp, const struct inotif
 	} else if (ev->mask & IN_DELETE) {
 		if (!strcmp(ev->name, "gssd") && clp->gssd_fd >= 0) {
 			close(clp->gssd_fd);
-			event_del(&clp->gssd_ev);
+			event_del(clp->gssd_ev);
+			event_free(clp->gssd_ev);
+			clp->gssd_ev = NULL;
 			clp->gssd_fd = -1;
 
 		} else if (!strcmp(ev->name, "krb5") && clp->krb5_fd >= 0) {
 			close(clp->krb5_fd);
-			event_del(&clp->krb5_ev);
+			event_del(clp->krb5_ev);
+			event_free(clp->krb5_ev);
+			clp->krb5_ev = NULL;
 			clp->krb5_fd = -1;
 		}
 
@@ -923,7 +934,7 @@ main(int argc, char *argv[])
 	int i;
 	extern char *optarg;
 	char *progname;
-	struct event sighup_ev;
+	struct event *sighup_ev;
 
 	read_gss_conf();
 
@@ -1062,7 +1073,11 @@ main(int argc, char *argv[])
 	if (gssd_check_mechs() != 0)
 		errx(1, "Problem with gssapi library");
 
-	event_init();
+	evbase = event_base_new();
+	if (!evbase) {
+		printerr(0, "ERROR: failed to create event base\n");
+		exit(EXIT_FAILURE);
+	}
 
 	pipefs_dir = opendir(pipefs_path);
 	if (!pipefs_dir) {
@@ -1084,16 +1099,17 @@ main(int argc, char *argv[])
 
 	signal(SIGINT, sig_die);
 	signal(SIGTERM, sig_die);
-	signal_set(&sighup_ev, SIGHUP, gssd_scan_cb, NULL);
-	signal_add(&sighup_ev, NULL);
-	event_set(&inotify_ev, inotify_fd, EV_READ | EV_PERSIST, gssd_inotify_cb, NULL);
-	event_add(&inotify_ev, NULL);
+	sighup_ev = evsignal_new(evbase, SIGHUP, gssd_scan_cb, NULL);
+	evsignal_add(sighup_ev, NULL);
+	inotify_ev = event_new(evbase, inotify_fd, EV_READ | EV_PERSIST,
+			       gssd_inotify_cb, NULL);
+	event_add(inotify_ev, NULL);
 
 	TAILQ_INIT(&topdir_list);
 	gssd_scan();
 	daemon_ready();
 
-	event_dispatch();
+	event_base_dispatch(evbase);
 
 	printerr(0, "ERROR: event_dispatch() returned!\n");
 	return EXIT_FAILURE;
diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
index d33e4dff..ae0355bb 100644
--- a/utils/gssd/gssd.h
+++ b/utils/gssd/gssd.h
@@ -77,9 +77,9 @@ struct clnt_info {
 	int			vers;
 	char			*protocol;
 	int			krb5_fd;
-	struct event		krb5_ev;
+	struct event		*krb5_ev;
 	int			gssd_fd;
-	struct event		gssd_ev;
+	struct event		*gssd_ev;
 	struct			sockaddr_storage addr;
 };
 
diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index 893159f1..12648f67 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -49,7 +49,7 @@
 
 #include <err.h>
 #include <errno.h>
-#include <event.h>
+#include <event2/event.h>
 #include <fcntl.h>
 #include <dirent.h>
 #include <unistd.h>
@@ -115,7 +115,7 @@ struct idmap_client {
 	int                        ic_fd;
 	int                        ic_dirfd;
 	int                        ic_scanned;
-	struct event               ic_event;
+	struct event              *ic_event;
 	TAILQ_ENTRY(idmap_client)  ic_next;
 };
 static struct idmap_client nfsd_ic[2] = {
@@ -166,6 +166,7 @@ static char pipefsdir[PATH_MAX];
 static char *nobodyuser, *nobodygroup;
 static uid_t nobodyuid;
 static gid_t nobodygid;
+static struct event_base *evbase = NULL;
 
 static int
 flush_nfsd_cache(char *path, time_t now)
@@ -209,8 +210,8 @@ main(int argc, char **argv)
 {
 	int wd = -1, opt, fg = 0, nfsdret = -1;
 	struct idmap_clientq icq;
-	struct event rootdirev, clntdirev, svrdirev, inotifyev;
-	struct event initialize;
+	struct event *rootdirev, *clntdirev, *svrdirev, *inotifyev;
+	struct event *initialize;
 	struct passwd *pw;
 	struct group *gr;
 	struct stat sb;
@@ -341,7 +342,9 @@ main(int argc, char **argv)
 	if (nfs4_init_name_mapping(conf_path))
 		errx(1, "Unable to create name to user id mappings.");
 
-	event_init();
+	evbase = event_base_new();
+	if (evbase == NULL)
+		errx(1, "Failed to create event base.");
 
 	if (verbose > 0)
 		xlog_warn("Expiration time is %d seconds.",
@@ -396,22 +399,22 @@ main(int argc, char **argv)
 		TAILQ_INIT(&icq);
 
 		/* These events are persistent */
-		signal_set(&rootdirev, SIGUSR1, dirscancb, &icq);
-		signal_add(&rootdirev, NULL);
-		signal_set(&clntdirev, SIGUSR2, clntscancb, &icq);
-		signal_add(&clntdirev, NULL);
-		signal_set(&svrdirev, SIGHUP, svrreopen, NULL);
-		signal_add(&svrdirev, NULL);
+		rootdirev = evsignal_new(evbase, SIGUSR1, dirscancb, &icq);
+		evsignal_add(rootdirev, NULL);
+		clntdirev = evsignal_new(evbase, SIGUSR2, clntscancb, &icq);
+		evsignal_add(clntdirev, NULL);
+		svrdirev = evsignal_new(evbase, SIGHUP, svrreopen, NULL);
+		evsignal_add(svrdirev, NULL);
 		if ( wd >= 0) {
-			event_set(&inotifyev, inotify_fd, EV_READ, dirscancb, &icq);
-			event_add(&inotifyev, NULL);
+			inotifyev = event_new(evbase, inotify_fd, EV_READ, dirscancb, &icq);
+			event_add(inotifyev, NULL);
 		}
 
 		/* Fetch current state */
 		/* (Delay till start of event_dispatch to avoid possibly losing
 		 * a SIGUSR1 between here and the call to event_dispatch().) */
-		evtimer_set(&initialize, dirscancb, &icq);
-		evtimer_add(&initialize, &now);
+		initialize = evtimer_new(evbase, dirscancb, &icq);
+		evtimer_add(initialize, &now);
 	}
 
 	if (nfsdret != 0 && wd < 0)
@@ -419,7 +422,7 @@ main(int argc, char **argv)
 
 	daemon_ready();
 
-	if (event_dispatch() < 0)
+	if (event_base_dispatch(evbase) < 0)
 		xlog_err("main: event_dispatch returns errno %d (%s)",
 			    errno, strerror(errno));
 	/* NOTREACHED */
@@ -490,7 +493,8 @@ dirscancb(int UNUSED(fd), short UNUSED(which), void *data)
 	while(ic != NULL) {
 		nextic=TAILQ_NEXT(ic, ic_next);
 		if (!ic->ic_scanned) {
-			event_del(&ic->ic_event);
+			event_del(ic->ic_event);
+			event_free(ic->ic_event);
 			close(ic->ic_fd);
 			close(ic->ic_dirfd);
 			TAILQ_REMOVE(icq, ic, ic_next);
@@ -677,7 +681,7 @@ nfsdcb(int UNUSED(fd), short which, void *data)
 			     ic->ic_path, errno, strerror(errno));
 
 out:
-	event_add(&ic->ic_event, NULL);
+	event_add(ic->ic_event, NULL);
 }
 
 static void
@@ -743,7 +747,7 @@ nfscb(int UNUSED(fd), short which, void *data)
 	if (atomicio((void*)write, ic->ic_fd, &im, sizeof(im)) != sizeof(im))
 		xlog_warn("nfscb: write(%s): %s", ic->ic_path, strerror(errno));
 out:
-	event_add(&ic->ic_event, NULL);
+	event_add(ic->ic_event, NULL);
 }
 
 static void
@@ -755,14 +759,16 @@ nfsdreopen_one(struct idmap_client *ic)
 		xlog_warn("ReOpening %s", ic->ic_path);
 
 	if ((fd = open(ic->ic_path, O_RDWR, 0)) != -1) {
-		if ((event_initialized(&ic->ic_event)))
-			event_del(&ic->ic_event);
+		if (ic->ic_event && event_initialized(ic->ic_event)) {
+			event_del(ic->ic_event);
+			event_free(ic->ic_event);
+		}
 		if (ic->ic_fd != -1)
 			close(ic->ic_fd);
 
-		ic->ic_event.ev_fd = ic->ic_fd = fd;
-		event_set(&ic->ic_event, ic->ic_fd, EV_READ, nfsdcb, ic);
-		event_add(&ic->ic_event, NULL);
+		ic->ic_fd = fd;
+		ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfsdcb, ic);
+		event_add(ic->ic_event, NULL);
 	} else {
 		xlog_warn("nfsdreopen: Opening '%s' failed: errno %d (%s)",
 			ic->ic_path, errno, strerror(errno));
@@ -795,8 +801,8 @@ nfsdopenone(struct idmap_client *ic)
 		return (-1);
 	}
 
-	event_set(&ic->ic_event, ic->ic_fd, EV_READ, nfsdcb, ic);
-	event_add(&ic->ic_event, NULL);
+	ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfsdcb, ic);
+	event_add(ic->ic_event, NULL);
 
 	if (verbose > 0)
 		xlog_warn("Opened %s", ic->ic_path);
@@ -819,8 +825,8 @@ nfsopen(struct idmap_client *ic)
 			return (-1);
 		}
 	} else {
-		event_set(&ic->ic_event, ic->ic_fd, EV_READ, nfscb, ic);
-		event_add(&ic->ic_event, NULL);
+		ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfscb, ic);
+		event_add(ic->ic_event, NULL);
 		fcntl(ic->ic_dirfd, F_NOTIFY, 0);
 		fcntl(ic->ic_dirfd, F_SETSIG, 0);
 		if (verbose > 0)
diff --git a/utils/nfsdcld/cld-internal.h b/utils/nfsdcld/cld-internal.h
index cc283dae..35765157 100644
--- a/utils/nfsdcld/cld-internal.h
+++ b/utils/nfsdcld/cld-internal.h
@@ -26,7 +26,7 @@
 
 struct cld_client {
 	int			cl_fd;
-	struct event		cl_event;
+	struct event		*cl_event;
 	union {
 		struct cld_msg		cl_msg;
 #if UPCALL_VERSION >= 2
diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index be655626..d6e1dff9 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -24,7 +24,7 @@
 #endif /* HAVE_CONFIG_H */
 
 #include <errno.h>
-#include <event.h>
+#include <event2/event.h>
 #include <stdbool.h>
 #include <getopt.h>
 #include <string.h>
@@ -66,7 +66,8 @@
 static char pipefs_dir[PATH_MAX] = DEFAULT_PIPEFS_DIR;
 static char pipepath[PATH_MAX];
 static int 		inotify_fd = -1;
-static struct event	pipedir_event;
+static struct event	 *pipedir_event;
+static struct event_base *evbase;
 static bool old_kernel = false;
 
 uint64_t current_epoch;
@@ -149,13 +150,15 @@ cld_pipe_open(struct cld_client *clnt)
 		return -errno;
 	}
 
-	if (event_initialized(&clnt->cl_event))
-		event_del(&clnt->cl_event);
+	if (clnt->cl_event && event_initialized(clnt->cl_event)) {
+		event_del(clnt->cl_event);
+		event_free(clnt->cl_event);
+	}
 	if (clnt->cl_fd >= 0)
 		close(clnt->cl_fd);
 
 	clnt->cl_fd = fd;
-	event_set(&clnt->cl_event, clnt->cl_fd, EV_READ, cldcb, clnt);
+	clnt->cl_event = event_new(evbase, clnt->cl_fd, EV_READ, cldcb, clnt);
 	/* event_add is done by the caller */
 	return 0;
 }
@@ -208,7 +211,7 @@ cld_inotify_cb(int UNUSED(fd), short which, void *data)
 	switch (ret) {
 	case 0:
 		/* readd the event for the cl_event pipe */
-		event_add(&clnt->cl_event, NULL);
+		event_add(clnt->cl_event, NULL);
 		break;
 	case -ENOENT:
 		/* pipe must have disappeared, wait for it to come back */
@@ -221,7 +224,7 @@ cld_inotify_cb(int UNUSED(fd), short which, void *data)
 	}
 
 out:
-	event_add(&pipedir_event, NULL);
+	event_add(pipedir_event, NULL);
 	free(dirc);
 }
 
@@ -286,7 +289,7 @@ cld_pipe_init(struct cld_client *clnt)
 	switch (ret) {
 	case 0:
 		/* add the event and we're good to go */
-		event_add(&clnt->cl_event, NULL);
+		event_add(clnt->cl_event, NULL);
 		break;
 	case -ENOENT:
 		/* ignore this error -- cld_inotify_cb will handle it */
@@ -299,8 +302,8 @@ cld_pipe_init(struct cld_client *clnt)
 	}
 
 	/* set event for inotify read */
-	event_set(&pipedir_event, inotify_fd, EV_READ, cld_inotify_cb, clnt);
-	event_add(&pipedir_event, NULL);
+	pipedir_event = event_new(evbase, inotify_fd, EV_READ, cld_inotify_cb, clnt);
+	event_add(pipedir_event, NULL);
 out:
 	return ret;
 }
@@ -737,7 +740,7 @@ cldcb(int UNUSED(fd), short which, void *data)
 		cld_not_implemented(clnt);
 	}
 out:
-	event_add(&clnt->cl_event, NULL);
+	event_add(clnt->cl_event, NULL);
 }
 
 int
@@ -762,7 +765,7 @@ main(int argc, char **argv)
 		return 1;
 	}
 
-	event_init();
+	evbase = event_base_new();
 	xlog_syslog(0);
 	xlog_stderr(1);
 
@@ -860,7 +863,7 @@ main(int argc, char **argv)
 		goto out;
 
 	xlog(D_GENERAL, "%s: Starting event dispatch handler.", __func__);
-	rc = event_dispatch();
+	rc = event_base_dispatch(evbase);
 	if (rc < 0)
 		xlog(L_ERROR, "%s: event_dispatch failed: %m", __func__);
 
diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 6666c867..2ba3a5f6 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -48,7 +48,6 @@
 
 #include <dirent.h>
 #include <errno.h>
-#include <event.h>
 #include <stdbool.h>
 #include <string.h>
 #include <sys/stat.h>
diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
index 28012016..f79aebb3 100644
--- a/utils/nfsdcltrack/sqlite.c
+++ b/utils/nfsdcltrack/sqlite.c
@@ -40,7 +40,7 @@
 
 #include <dirent.h>
 #include <errno.h>
-#include <event.h>
+#include <stdio.h>
 #include <stdbool.h>
 #include <string.h>
 #include <sys/stat.h>
-- 
2.26.2

