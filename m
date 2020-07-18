Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D5224A37
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGRJY7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:24:59 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:39403 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgGRJY4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:56 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0000SO-Ee
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2evkaif8ftnj6zcV44zkFu1pv+/30twOeh//mCmXqG4=; b=knctxZZFEr2KOHG/flXLC5Rj3o
        gpfOXqqGE/KmAjnc7VbipllTclNlOxYT/st2KR3M4lJ2Hh1KopDEJV82VPAoN66hUJJQrsxGrybKd
        kpUJOHOmdb8a8rUE5glM7sHbBWCATAzbJ+23tyOxqJNw71igulGbkbkzDAg6LS8FVftO+XglH8K84
        2a2RVYd/3S62waSoZvw8XuxZ6Xjn/ZfTTHUT5bKRLtN2CwYivvc1qNgDTgMIijLJdHIA26DPK8dC1
        uVaupwVAziymlD2Wh4occp4k7h6/QRz4Tapts4awNSIxXz6/sgIm57ICVCs6D2JoM17VsdLXEmrv7
        W7cCCLZQ==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5O-0001He-8N
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:50 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/11] svcgssd: Convert to using libevent
Date:   Sat, 18 Jul 2020 05:24:18 -0400
Message-Id: <20200718092421.31691-9-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000621683892355)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVBhdVvatOQL85
 W8QN1VviSkTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJNr/iRojbelwSN6M+UT4TnTjSBu0xXNTKZ+UZE2i7xNXXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhz+UjdAvdDKZ5U5spZO6hon9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVNO0eLTyIuJf+IqbzABHTTf5J09OpIztnwXJmc43Cm+HZjEa/sNl+vcoDGoY
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
 utils/gssd/Makefile.am         |  2 +-
 utils/gssd/svcgssd.c           | 72 ++++++++++++++++++++++++--
 utils/gssd/svcgssd.h           |  3 +-
 utils/gssd/svcgssd_main_loop.c | 94 ----------------------------------
 utils/gssd/svcgssd_proc.c      | 15 +-----
 5 files changed, 70 insertions(+), 116 deletions(-)
 delete mode 100644 utils/gssd/svcgssd_main_loop.c

diff --git a/utils/gssd/Makefile.am b/utils/gssd/Makefile.am
index 321046b9..21d3bb88 100644
--- a/utils/gssd/Makefile.am
+++ b/utils/gssd/Makefile.am
@@ -67,7 +67,6 @@ gssd_CFLAGS = \
 svcgssd_SOURCES = \
 	$(COMMON_SRCS) \
 	svcgssd.c \
-	svcgssd_main_loop.c \
 	svcgssd_mech2file.c \
 	svcgssd_proc.c \
 	svcgssd_krb5.c \
@@ -78,6 +77,7 @@ svcgssd_SOURCES = \
 svcgssd_LDADD = \
 	../../support/nfs/libnfs.la \
 	../../support/nfsidmap/libnfsidmap.la \
+	$(LIBEVENT) \
 	$(RPCSECGSS_LIBS) \
 	$(KRBLIBS) $(GSSAPI_LIBS) $(LIBTIRPC)
 
diff --git a/utils/gssd/svcgssd.c b/utils/gssd/svcgssd.c
index ec49b616..f538fd2a 100644
--- a/utils/gssd/svcgssd.c
+++ b/utils/gssd/svcgssd.c
@@ -57,20 +57,30 @@
 #include <string.h>
 #include <signal.h>
 #include <nfsidmap.h>
+#include <event2/event.h>
+
 #include "nfslib.h"
 #include "svcgssd.h"
 #include "gss_util.h"
 #include "err_util.h"
 #include "conffile.h"
+#include "misc.h"
 
 struct state_paths etab;
+static bool signal_received = false;
+static struct event_base *evbase = NULL;
 
 static void
 sig_die(int signal)
 {
-	/* destroy krb5 machine creds */
+	if (signal_received) {
+		/* destroy krb5 machine creds */
+		printerr(1, "forced exiting on signal %d\n", signal);
+		exit(0);
+	}
+	signal_received = true;
 	printerr(1, "exiting on signal %d\n", signal);
-	exit(0);
+	event_base_loopexit(evbase, NULL);
 }
 
 static void
@@ -89,6 +99,24 @@ usage(char *progname)
 	exit(1);
 }
 
+static void
+svcgssd_nullrpc_cb(int fd, short UNUSED(which), void *UNUSED(data))
+{
+	char	lbuf[RPC_CHAN_BUF_SIZE];
+	int	lbuflen = 0;
+
+	printerr(1, "reading null request\n");
+
+	lbuflen = read(fd, lbuf, sizeof(lbuf));
+	if (lbuflen <= 0 || lbuf[lbuflen-1] != '\n') {
+		printerr(0, "WARNING: handle_nullreq: failed reading request\n");
+		return;
+	}
+	lbuf[lbuflen-1] = 0;
+
+	handle_nullreq(lbuf);
+}
+
 int
 main(int argc, char *argv[])
 {
@@ -102,6 +130,9 @@ main(int argc, char *argv[])
 	char *progname;
 	char *principal = NULL;
 	char *s;
+	int rc;
+	int nullrpc_fd = -1;
+	struct event *nullrpc_event = NULL;
 
 	conf_init_file(NFS_CONFFILE);
 
@@ -182,6 +213,12 @@ main(int argc, char *argv[])
 
 	daemon_init(fg);
 
+	evbase = event_base_new();
+	if (!evbase) {
+		printerr(0, "ERROR: failed to create event base: %s\n", strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
 	signal(SIGINT, sig_die);
 	signal(SIGTERM, sig_die);
 	signal(SIGHUP, sig_hup);
@@ -209,10 +246,35 @@ main(int argc, char *argv[])
 		}
 	}
 
+#define NULLRPC_FILE "/proc/net/rpc/auth.rpcsec.init/channel"
+
+	nullrpc_fd = open(NULLRPC_FILE, O_RDWR);
+	if (nullrpc_fd < 0) {
+		printerr(0, "failed to open %s: %s\n",
+			 NULLRPC_FILE, strerror(errno));
+		exit(1);
+	}
+	nullrpc_event = event_new(evbase, nullrpc_fd, EV_READ | EV_PERSIST,
+				  svcgssd_nullrpc_cb, NULL);
+	if (!nullrpc_event) {
+		printerr(0, "failed to create event for %s: %s\n",
+			 NULLRPC_FILE, strerror(errno));
+		exit(1);
+	}
+	event_add(nullrpc_event, NULL);
+
 	daemon_ready();
 
 	nfs4_init_name_mapping(NULL); /* XXX: should only do this once */
-	gssd_run();
-	printerr(0, "gssd_run returned!\n");
-	abort();
+
+	rc = event_base_dispatch(evbase);
+	if (rc < 0)
+		printerr(0, "event_base_dispatch() returned %i!\n", rc);
+
+	event_free(nullrpc_event);
+	close(nullrpc_fd);
+
+	event_base_free(evbase);
+
+	return EXIT_SUCCESS;
 }
diff --git a/utils/gssd/svcgssd.h b/utils/gssd/svcgssd.h
index 02b5c7ae..e229b989 100644
--- a/utils/gssd/svcgssd.h
+++ b/utils/gssd/svcgssd.h
@@ -35,8 +35,7 @@
 #include <sys/queue.h>
 #include <gssapi/gssapi.h>
 
-void handle_nullreq(int f);
-void gssd_run(void);
+void handle_nullreq(char *cp);
 
 #define GSSD_SERVICE_NAME	"nfs"
 
diff --git a/utils/gssd/svcgssd_main_loop.c b/utils/gssd/svcgssd_main_loop.c
deleted file mode 100644
index 920520d0..00000000
--- a/utils/gssd/svcgssd_main_loop.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
-  Copyright (c) 2004 The Regents of the University of Michigan.
-  All rights reserved.
-
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-  1. Redistributions of source code must retain the above copyright
-     notice, this list of conditions and the following disclaimer.
-  2. Redistributions in binary form must reproduce the above copyright
-     notice, this list of conditions and the following disclaimer in the
-     documentation and/or other materials provided with the distribution.
-  3. Neither the name of the University nor the names of its
-     contributors may be used to endorse or promote products derived
-     from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
-  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
-  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-  DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
-  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
-  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
-  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
-  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif	/* HAVE_CONFIG_H */
-
-#include <sys/param.h>
-#include <sys/socket.h>
-#include <poll.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <netinet/in.h>
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <memory.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <unistd.h>
-
-#include "svcgssd.h"
-#include "err_util.h"
-
-void
-gssd_run()
-{
-	int			ret;
-	int			f;
-	struct pollfd		pollfd;
-
-#define NULLRPC_FILE "/proc/net/rpc/auth.rpcsec.init/channel"
-
-	f = open(NULLRPC_FILE, O_RDWR);
-	if (f < 0) {
-		printerr(0, "failed to open %s: %s\n",
-			 NULLRPC_FILE, strerror(errno));
-		exit(1);
-	}
-	pollfd.fd = f;
-	pollfd.events = POLLIN;
-	while (1) {
-		int save_err;
-
-		pollfd.revents = 0;
-		printerr(1, "entering poll\n");
-		ret = poll(&pollfd, 1, -1);
-		save_err = errno;
-		printerr(1, "leaving poll\n");
-		if (ret < 0) {
-			if (save_err != EINTR)
-				printerr(0, "error return from poll: %s\n",
-					 strerror(save_err));
-		} else if (ret == 0) {
-			/* timeout; shouldn't happen. */
-		} else {
-			if (ret != 1) {
-				printerr(0, "bug: unexpected poll return %d\n",
-						ret);
-				exit(1);
-			}
-			if (pollfd.revents & POLLIN)
-				handle_nullreq(f);
-		}
-	}
-}
diff --git a/utils/gssd/svcgssd_proc.c b/utils/gssd/svcgssd_proc.c
index 72ec2540..b4031432 100644
--- a/utils/gssd/svcgssd_proc.c
+++ b/utils/gssd/svcgssd_proc.c
@@ -318,7 +318,7 @@ print_hexl(const char *description, unsigned char *cp, int length)
 #endif
 
 void
-handle_nullreq(int f) {
+handle_nullreq(char *cp) {
 	/* XXX initialize to a random integer to reduce chances of unnecessary
 	 * invalidation of existing ctx's on restarting svcgssd. */
 	static u_int32_t	handle_seq = 0;
@@ -340,24 +340,11 @@ handle_nullreq(int f) {
 	u_int32_t		maj_stat = GSS_S_FAILURE, min_stat = 0;
 	u_int32_t		ignore_min_stat;
 	struct svc_cred		cred;
-	char			lbuf[RPC_CHAN_BUF_SIZE];
-	int			lbuflen = 0;
-	char			*cp;
 	int32_t			ctx_endtime;
 	char			*hostbased_name = NULL;
 
 	printerr(1, "handling null request\n");
 
-	lbuflen = read(f, lbuf, sizeof(lbuf));
-	if (lbuflen <= 0 || lbuf[lbuflen-1] != '\n') {
-		printerr(0, "WARNING: handle_nullreq: "
-			    "failed reading request\n");
-		return;
-	}
-	lbuf[lbuflen-1] = 0;
-
-	cp = lbuf;
-
 	in_handle.length = (size_t) qword_get(&cp, in_handle.value,
 					      sizeof(in_handle_buf));
 #ifdef DEBUG
-- 
2.26.2

