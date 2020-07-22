Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B683229028
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jul 2020 07:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgGVFyE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jul 2020 01:54:04 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:34643 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728265AbgGVFyD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jul 2020 01:54:03 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7hX-0005jM-Ee
        for linux-nfs@vger.kernel.org; Wed, 22 Jul 2020 00:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AfQjnoYndr0FbHNzPPrXdSmZxDsl16Xc+E03p2trMHo=; b=ECHhgbsTRWUGWoKUY7qtq/7s3C
        M0nzsO67vn+6QvdE3kllNxAkcqDrC+33ekxzhdYDmkn7iplg4lCWE2ee/NYKQjHdBBTm9XCx+8wil
        ibyTIor57LLfJXhGvDXyy8alnzvZKJ6KJQaOdNEgtLxoF5mtBPw85cywctuJFnG0+5UilrFfVKpMl
        MfxYe9ncy6couF52eiWrkzL3RliulqXoygJ5whUZ+b8eFAAmQLsWMj1ji1BLS8mZuaX5H96e0oKEV
        S4meW/hZ+QrQBjc/YYiFbUUAKMgjwJCoTr10WobhfEv4X69Gbax65yraWuUkbhe4c+cXXVU8Y3tSx
        KlKX+wOw==;
Received: from [174.119.114.224] (port=44746 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jy7hX-00076P-8O
        for linux-nfs@vger.kernel.org; Wed, 22 Jul 2020 01:53:59 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] idmapd: Fix client mode support
Date:   Wed, 22 Jul 2020 01:53:53 -0400
Message-Id: <20200722055354.28132-4-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000127981598591)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhV+fuIcgrBGm1A
 upt4eOzOGUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJfR8RKi4KoC/Lsrey1CJXl03SG97xKUwUMBajc3faN73XpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhAY3Oy2XCfDUEDrfDzvsW5X9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVGLbUlq9gkfmitP94LxRBZbBO+ROmcYTan60saP6l/EFZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The inotify event was never rearmed, so we wouldn't get any notice
after the first event. Even if it had been re-added, we never read
the pending events so it would continously fire. Fix this by
moving to persistent events and reading any pending inotify events.
Effect was we'd leak any clients that existed after the first event.

Switch from dnotify to inotify on the client dir if the idmap file
isn't available yet.

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 utils/idmapd/idmapd.c | 138 +++++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 54 deletions(-)

diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index dae5e567..cb1478a2 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -169,6 +169,7 @@ static uid_t nobodyuid;
 static gid_t nobodygid;
 static struct event_base *evbase = NULL;
 static bool signal_received = false;
+static int inotify_fd = -1;
 
 static void
 sig_die(int signal)
@@ -233,7 +234,6 @@ main(int argc, char **argv)
 	struct stat sb;
 	char *xpipefsdir = NULL;
 	int serverstart = 1, clientstart = 1;
-	int inotify_fd = -1;
 	int ret;
 	char *progname;
 	char *conf_path = NULL;
@@ -410,7 +410,7 @@ main(int argc, char **argv)
 		if (inotify_fd == -1) {
 			xlog_err("Unable to initialise inotify_init1: %s\n", strerror(errno));
 		} else {
-			wd = inotify_add_watch(inotify_fd, pipefsdir, IN_CREATE | IN_DELETE | IN_MODIFY);
+			wd = inotify_add_watch(inotify_fd, pipefsdir, IN_CREATE | IN_DELETE);
 			if (wd < 0)
 				xlog_err("Unable to inotify_add_watch(%s): %s\n", pipefsdir, strerror(errno));
 		}
@@ -434,7 +434,8 @@ main(int argc, char **argv)
 			errx(1, "Failed to create SIGHUP event.");
 		evsignal_add(svrdirev, NULL);
 		if ( wd >= 0) {
-			inotifyev = event_new(evbase, inotify_fd, EV_READ, dirscancb, &icq);
+			inotifyev = event_new(evbase, inotify_fd,
+					      EV_READ | EV_PERSIST, dirscancb, &icq);
 			if (inotifyev == NULL)
 				errx(1, "Failed to create inotify read event.");
 			event_add(inotifyev, NULL);
@@ -480,7 +481,33 @@ main(int argc, char **argv)
 }
 
 static void
-dirscancb(int UNUSED(fd), short UNUSED(which), void *data)
+flush_inotify(int fd)
+{
+	while (true) {
+		char buf[4096] __attribute__ ((aligned(__alignof__(struct inotify_event))));
+		const struct inotify_event *ev;
+		ssize_t len;
+		char *ptr;
+
+		len = read(fd, buf, sizeof(buf));
+		if (len == -1 && errno == EINTR)
+			continue;
+
+		if (len <= 0)
+			break;
+
+		for (ptr = buf; ptr < buf + len;
+		     ptr += sizeof(struct inotify_event) + ev->len) {
+
+			ev = (const struct inotify_event *)ptr;
+			xlog_warn("pipefs inotify: wd=%i, mask=0x%08x, len=%i, name=%s",
+				  ev->wd, ev->mask, ev->len, ev->len ? ev->name : "");
+		}
+	}
+}
+
+static void
+dirscancb(int fd, short UNUSED(which), void *data)
 {
 	int nent, i;
 	struct dirent **ents;
@@ -488,6 +515,13 @@ dirscancb(int UNUSED(fd), short UNUSED(which), void *data)
 	char path[PATH_MAX+256]; /* + sizeof(d_name) */
 	struct idmap_clientq *icq = data;
 
+	if (fd != -1)
+		flush_inotify(fd);
+
+	TAILQ_FOREACH(ic, icq, ic_next) {
+		ic->ic_scanned = 0;
+	}
+
 	nent = scandir(pipefsdir, &ents, NULL, alphasort);
 	if (nent == -1) {
 		xlog_warn("dirscancb: scandir(%s): %s", pipefsdir, strerror(errno));
@@ -521,15 +555,15 @@ dirscancb(int UNUSED(fd), short UNUSED(which), void *data)
 			strlcat(path, "/idmap", sizeof(path));
 			strlcpy(ic->ic_path, path, sizeof(ic->ic_path));
 
-			if (verbose > 0)
-				xlog_warn("New client: %s", ic->ic_clid);
-
 			if (nfsopen(ic) == -1) {
 				close(ic->ic_dirfd);
 				free(ic);
 				goto out;
 			}
 
+			if (verbose > 0)
+				xlog_warn("New client: %s", ic->ic_clid);
+
 			ic->ic_id = "Client";
 
 			TAILQ_INSERT_TAIL(icq, ic, ic_next);
@@ -543,18 +577,19 @@ dirscancb(int UNUSED(fd), short UNUSED(which), void *data)
 	while(ic != NULL) {
 		nextic=TAILQ_NEXT(ic, ic_next);
 		if (!ic->ic_scanned) {
-			event_del(ic->ic_event);
-			event_free(ic->ic_event);
-			close(ic->ic_fd);
-			close(ic->ic_dirfd);
+			if (ic->ic_event)
+				event_free(ic->ic_event);
+			if (ic->ic_fd != -1)
+				close(ic->ic_fd);
+			if (ic->ic_dirfd != -1)
+				close(ic->ic_dirfd);
 			TAILQ_REMOVE(icq, ic, ic_next);
 			if (verbose > 0) {
 				xlog_warn("Stale client: %s", ic->ic_clid);
 				xlog_warn("\t-> closed %s", ic->ic_path);
 			}
 			free(ic);
-		} else
-			ic->ic_scanned = 0;
+		}
 		ic = nextic;
 	}
 
@@ -600,7 +635,7 @@ nfsdcb(int UNUSED(fd), short which, void *data)
 	unsigned long tmp;
 
 	if (which != EV_READ)
-		goto out;
+		return;
 
 	len = read(ic->ic_fd, buf, sizeof(buf));
 	if (len == 0)
@@ -623,11 +658,11 @@ nfsdcb(int UNUSED(fd), short which, void *data)
 	/* Authentication name -- ignored for now*/
 	if (getfield(&bp, authbuf, sizeof(authbuf)) == -1) {
 		xlog_warn("nfsdcb: bad authentication name in upcall\n");
-		goto out;
+		return;
 	}
 	if (getfield(&bp, typebuf, sizeof(typebuf)) == -1) {
 		xlog_warn("nfsdcb: bad type in upcall\n");
-		goto out;
+		return;
 	}
 	if (verbose > 0)
 		xlog_warn("nfsdcb: authbuf=%s authtype=%s",
@@ -641,26 +676,26 @@ nfsdcb(int UNUSED(fd), short which, void *data)
 		im.im_conv = IDMAP_CONV_NAMETOID;
 		if (getfield(&bp, im.im_name, sizeof(im.im_name)) == -1) {
 			xlog_warn("nfsdcb: bad name in upcall\n");
-			goto out;
+			return;
 		}
 		break;
 	case IC_IDNAME:
 		im.im_conv = IDMAP_CONV_IDTONAME;
 		if (getfield(&bp, buf1, sizeof(buf1)) == -1) {
 			xlog_warn("nfsdcb: bad id in upcall\n");
-			goto out;
+			return;
 		}
 		tmp = strtoul(buf1, (char **)NULL, 10);
 		im.im_id = (u_int32_t)tmp;
 		if ((tmp == ULONG_MAX && errno == ERANGE)
 				|| (unsigned long)im.im_id != tmp) {
 			xlog_warn("nfsdcb: id '%s' too big!\n", buf1);
-			goto out;
+			return;
 		}
 		break;
 	default:
 		xlog_warn("nfsdcb: Unknown which type %d", ic->ic_which);
-		goto out;
+		return;
 	}
 
 	imconv(ic, &im);
@@ -721,7 +756,7 @@ nfsdcb(int UNUSED(fd), short which, void *data)
 		break;
 	default:
 		xlog_warn("nfsdcb: Unknown which type %d", ic->ic_which);
-		goto out;
+		return;
 	}
 
 	bsiz = sizeof(buf) - bsiz;
@@ -729,9 +764,6 @@ nfsdcb(int UNUSED(fd), short which, void *data)
 	if (atomicio((void*)write, ic->ic_fd, buf, bsiz) != bsiz)
 		xlog_warn("nfsdcb: write(%s) failed: errno %d (%s)",
 			     ic->ic_path, errno, strerror(errno));
-
-out:
-	event_add(ic->ic_event, NULL);
 }
 
 static void
@@ -775,14 +807,12 @@ nfscb(int UNUSED(fd), short which, void *data)
 	struct idmap_msg im;
 
 	if (which != EV_READ)
-		goto out;
+		return;
 
 	if (atomicio(read, ic->ic_fd, &im, sizeof(im)) != sizeof(im)) {
 		if (verbose > 0)
 			xlog_warn("nfscb: read(%s): %s", ic->ic_path, strerror(errno));
-		if (errno == EPIPE)
-			return;
-		goto out;
+		return;
 	}
 
 	imconv(ic, &im);
@@ -796,8 +826,6 @@ nfscb(int UNUSED(fd), short which, void *data)
 
 	if (atomicio((void*)write, ic->ic_fd, &im, sizeof(im)) != sizeof(im))
 		xlog_warn("nfscb: write(%s): %s", ic->ic_path, strerror(errno));
-out:
-	event_add(ic->ic_event, NULL);
 }
 
 static void
@@ -825,7 +853,7 @@ nfsdreopen_one(struct idmap_client *ic)
 		nfsdclose_one(ic);
 
 		ic->ic_fd = fd;
-		ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfsdcb, ic);
+		ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ | EV_PERSIST, nfsdcb, ic);
 		if (ic->ic_event == NULL) {
 			xlog_warn("nfsdreopen: Failed to create event for '%s'",
 				  ic->ic_path);
@@ -873,7 +901,7 @@ nfsdopenone(struct idmap_client *ic)
 		return (-1);
 	}
 
-	ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfsdcb, ic);
+	ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ | EV_PERSIST, nfsdcb, ic);
 	if (ic->ic_event == NULL) {
 		if (verbose > 0)
 			xlog_warn("nfsdopenone: Create event for %s failed",
@@ -894,32 +922,34 @@ static int
 nfsopen(struct idmap_client *ic)
 {
 	if ((ic->ic_fd = open(ic->ic_path, O_RDWR, 0)) == -1) {
-		switch (errno) {
-		case ENOENT:
-			fcntl(ic->ic_dirfd, F_SETSIG, SIGUSR2);
-			fcntl(ic->ic_dirfd, F_NOTIFY,
-			    DN_CREATE | DN_DELETE | DN_MULTISHOT);
-			break;
-		default:
-			xlog_warn("nfsopen: open(%s): %s", ic->ic_path, strerror(errno));
-			return (-1);
-		}
-	} else {
-		ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ, nfscb, ic);
-		if (ic->ic_event == NULL) {
-			xlog_warn("nfsdopenone: Create event for %s failed",
-				  ic->ic_path);
-			close(ic->ic_fd);
-			ic->ic_fd = -1;
+		if (errno == ENOENT) {
+			char *slash;
+
+			slash = strrchr(ic->ic_path, '/');
+			if (!slash)
+				return -1;
+			*slash = 0;
+			inotify_add_watch(inotify_fd, ic->ic_path, IN_CREATE | IN_ONLYDIR | IN_ONESHOT);
+			*slash = '/';
+			xlog_warn("Path %s not available. waiting...", ic->ic_path);
 			return -1;
 		}
-		event_add(ic->ic_event, NULL);
-		fcntl(ic->ic_dirfd, F_NOTIFY, 0);
-		fcntl(ic->ic_dirfd, F_SETSIG, 0);
-		if (verbose > 0)
-			xlog_warn("Opened %s", ic->ic_path);
+
+		xlog_warn("nfsopen: open(%s): %s", ic->ic_path, strerror(errno));
+		return (-1);
 	}
 
+	ic->ic_event = event_new(evbase, ic->ic_fd, EV_READ | EV_PERSIST, nfscb, ic);
+	if (ic->ic_event == NULL) {
+		xlog_warn("nfsopen: Create event for %s failed", ic->ic_path);
+		close(ic->ic_fd);
+		ic->ic_fd = -1;
+		return -1;
+	}
+	event_add(ic->ic_event, NULL);
+	if (verbose > 0)
+		xlog_warn("Opened %s", ic->ic_path);
+
 	return (0);
 }
 
-- 
2.26.2

