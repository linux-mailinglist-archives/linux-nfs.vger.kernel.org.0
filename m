Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59733E366A
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Aug 2021 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhHGRDa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Aug 2021 13:03:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbhHGRD3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Aug 2021 13:03:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 177GvFrI008553;
        Sat, 7 Aug 2021 17:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=A6FEIqM7J97QQkyLaLxYmM5ORC91GobGn7OQ0nWhlXo=;
 b=Xagd4qDsEoG66PGsMx/CyzX+S+eJcCQCx3Is5G90UyabEqXl07XtXe2GXTbX+iBxHCkc
 c3EEldye0DFm0AcpoAQrjsqu8ccxIjk8DG7+rxvbmMqDo8dxH3b1VIdOtJBLu+JdfEh2
 k3mpGZUk8t6TggItajH5uSH8HddSafT6Y6BNm75Vg7m+A7sh4NO1MZbI40MAk+A+wweT
 LPvzlf0CMwOczi78mNVTmkqMpHfBj5rLynKrDNqNRjNDlSWtwsY59JW6IdsXqzIvLtaq
 /ullIcZLax7iL3y9qs3IF5LOa+hyUbrz3upe31z7QEHBC6ReEfxkc9w0fG1s8yMNAWU+ 1w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=A6FEIqM7J97QQkyLaLxYmM5ORC91GobGn7OQ0nWhlXo=;
 b=bxBqtb5CUZ+oD1lfkRr7hNBk284zlcXULUai5pysjrhOIR5VQ00so0pQvGvm5uZ2kdLv
 7P3sOOWQ5iDl+Y4gPzMYd3k6nFMVSOB1TQjK4bUqi8q0irxIOMzvdYsC+pJoIe5pCM4i
 3weRk4qOy4dc1/OXkk+o5U7WYfDaJBrsP6ZpyX0xW+eeaVCRZENXSGHLJL/oDVARqK5C
 tc8X/z9gKdaap7QUyKmWVRrOIVk81T7k901HOP0S92jVVlPBP4JowPqE06czBqbiAjA3
 qwq6Oy8P2X0qPWuz9n346g0Vgl4a5rRoMNIvFOp7Yz9NHC0cCUiAP7lH+oAO3Fh5Vpa1 kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9gy1rqa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Aug 2021 17:02:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 177Gtrau164523;
        Sat, 7 Aug 2021 17:02:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3a9f9snv3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Aug 2021 17:02:58 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 177H2vUm175676;
        Sat, 7 Aug 2021 17:02:57 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 3a9f9snv2b-1;
        Sat, 07 Aug 2021 17:02:57 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     libtirpc-devel@lists.sourceforge.net
Subject: [PATCH 1/1] Fix DoS vulnerability in statd and mountd
Date:   Sat,  7 Aug 2021 13:02:48 -0400
Message-Id: <20210807170248.68817-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lvsLL4473X2AX77IJLvQMKe8xYijuDNz
X-Proofpoint-ORIG-GUID: lvsLL4473X2AX77IJLvQMKe8xYijuDNz
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently my_svc_run does not handle poll time allowing idle TCP
connections to remain ESTABLISHED indefinitely. When the number
of connections reaches the limit the open file descriptors
(ulimit -n) then accept(2) fails with EMFILE. Since libtirpc does
not handle EMFILE returned from accept(2) this get my_svc_run into
a tight loop calling accept(2) resulting in the RPC service being
down, it's no longer able to service any requests.

Fix by removing idle connections when select(2) times out in my_svc_run
and when open(2) returns EMFILE/ENFILE in auth_reload.

Signed-off-by: dai.ngo@oracle.com
---
 support/export/auth.c  | 12 ++++++++++--
 utils/mountd/svc_run.c | 10 ++++++++--
 utils/statd/svc_run.c  | 11 ++++++++---
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/support/export/auth.c b/support/export/auth.c
index 03ce4b8a0e1e..0bb189fb4037 100644
--- a/support/export/auth.c
+++ b/support/export/auth.c
@@ -81,6 +81,8 @@ check_useipaddr(void)
 		cache_flush();
 }
 
+extern void __svc_destroy_idle(int, bool_t);
+
 unsigned int
 auth_reload()
 {
@@ -91,8 +93,14 @@ auth_reload()
 	int			fd;
 
 	if ((fd = open(etab.statefn, O_RDONLY)) < 0) {
-		xlog(L_FATAL, "couldn't open %s", etab.statefn);
-	} else if (fstat(fd, &stb) < 0) {
+		if (errno != EMFILE && errno != ENFILE)
+			xlog(L_FATAL, "couldn't open %s", etab.statefn);
+		/* remove idle */
+		__svc_destroy_idle(5, FALSE);
+		if ((fd = open(etab.statefn, O_RDONLY)) < 0)
+			xlog(L_FATAL, "couldn't open %s", etab.statefn);
+	}
+	if (fstat(fd, &stb) < 0) {
 		xlog(L_FATAL, "couldn't stat %s", etab.statefn);
 		close(fd);
 	} else if (last_fd != -1 && stb.st_ino == last_inode) {
diff --git a/utils/mountd/svc_run.c b/utils/mountd/svc_run.c
index 167b9757bde2..ada8d0ac8844 100644
--- a/utils/mountd/svc_run.c
+++ b/utils/mountd/svc_run.c
@@ -59,6 +59,7 @@
 #include "export.h"
 
 void my_svc_run(void);
+extern void __svc_destroy_idle(int , bool_t);
 
 #if defined(__GLIBC__) && LONG_MAX != INT_MAX
 /* bug in glibc 2.3.6 and earlier, we need
@@ -95,6 +96,7 @@ my_svc_run(void)
 {
 	fd_set	readfds;
 	int	selret;
+	struct	timeval tv;
 
 	for (;;) {
 
@@ -102,8 +104,10 @@ my_svc_run(void)
 		cache_set_fds(&readfds);
 		v4clients_set_fds(&readfds);
 
+		tv.tv_sec = 30;
+		tv.tv_usec = 0;
 		selret = select(FD_SETSIZE, &readfds,
-				(void *) 0, (void *) 0, (struct timeval *) 0);
+				(void *) 0, (void *) 0, &tv);
 
 
 		switch (selret) {
@@ -113,7 +117,9 @@ my_svc_run(void)
 				continue;
 			xlog(L_ERROR, "my_svc_run() - select: %m");
 			return;
-
+		case 0:
+			__svc_destroy_idle(30, FALSE);
+			continue;
 		default:
 			selret -= cache_process_req(&readfds);
 			selret -= v4clients_process(&readfds);
diff --git a/utils/statd/svc_run.c b/utils/statd/svc_run.c
index e343c7689860..8888788c81d0 100644
--- a/utils/statd/svc_run.c
+++ b/utils/statd/svc_run.c
@@ -59,6 +59,7 @@
 
 void my_svc_exit(void);
 static int	svc_stop = 0;
+extern void __svc_destroy_idle(int , bool_t);
 
 /*
  * This is the global notify list onto which all SM_NOTIFY and CALLBACK
@@ -85,6 +86,7 @@ my_svc_run(int sockfd)
 	FD_SET_TYPE	readfds;
 	int             selret;
 	time_t		now;
+	struct timeval	tv;
 
 	svc_stop = 0;
 
@@ -101,7 +103,6 @@ my_svc_run(int sockfd)
 		/* Set notify sockfd for waiting for reply */
 		FD_SET(sockfd, &readfds);
 		if (notify) {
-			struct timeval	tv;
 
 			tv.tv_sec  = NL_WHEN(notify) - now;
 			tv.tv_usec = 0;
@@ -111,8 +112,10 @@ my_svc_run(int sockfd)
 				(void *) 0, (void *) 0, &tv);
 		} else {
 			xlog(D_GENERAL, "Waiting for client connections");
+			tv.tv_sec = 30;
+			tv.tv_usec = 0;
 			selret = select(FD_SETSIZE, &readfds,
-				(void *) 0, (void *) 0, (struct timeval *) 0);
+				(void *) 0, (void *) 0, &tv);
 		}
 
 		switch (selret) {
@@ -124,7 +127,9 @@ my_svc_run(int sockfd)
 			return;
 
 		case 0:
-			/* A notify/callback timed out. */
+			/* A notify/callback/wait for client timed out. */
+			if (!notify)
+				__svc_destroy_idle(30, FALSE);
 			continue;
 
 		default:
-- 
2.26.2

