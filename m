Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EBE3E3668
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Aug 2021 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhHGRCG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Aug 2021 13:02:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58504 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230096AbhHGRBy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Aug 2021 13:01:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 177GtwwF022786;
        Sat, 7 Aug 2021 17:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=y5zFWVf+TNTh7gPNnhz2Esh0uP9/orOfFEtNw5tk6sg=;
 b=Rsfz4ztR51C5wuWj1g4n8bvn91PBG3i/GlbKSDmp4PKPjGt38qhOU796EmFjVBzpdzRS
 59F7YYJKkTkJthFgB9H1LqLyB+ZdDZCAastgqjGinIAyN2IkwURUMvtFq7gjzxqTacLD
 oGJYWRu0zXkZvTkIhlvDf22EN7okLMcoEurmHOFXYMBlrOGV0Z+sAiylBE42tzFV1EWU
 1PhWh1v+uTP31Ky5MQiWFc8YP+EsOhMgVflKqdQ58iPCv1lMeDL7I3vCOuiX/8aGhPQs
 sLxGpjJuzPP6tW0aws3oSmm6hzra2iXbS056LO5FcxvWYbDIhJlLExddV9ACjKmp1Dzr Cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=y5zFWVf+TNTh7gPNnhz2Esh0uP9/orOfFEtNw5tk6sg=;
 b=MN1+OD/mv0V3cCiVgMstSVOxxJCK0lWU/hHQ++heE+hfMozejqg8rtauzr88U7OwmADa
 SyUgZLTrJZ+u40z2DmDJl6zQ1K2PvzmFIyFVm0ABL8fuT7ZIo7BcwRxIWFJN8aIfcP0r
 yxbl95jLYKWHFsE09Jy6TiXO6a+93rKeYrVeLqO9DB6LO/qeNZfi194XlRuZcM+FBLB+
 5MW+rYbHREGd15EqGBMo93Z9pRgZbBkmZrZxsJSmBtnI+NM2xUTcxKvxVXlv2GMRDSR0
 Kesp9/AK8Vf1KsQ78fmhKylYvsHz9ZdYuiPxf9DyNVxJ5oBrv97E50mrIHpogZiilzvF pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9hssgp7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Aug 2021 17:00:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 177Gts9j164605;
        Sat, 7 Aug 2021 17:00:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3a9f9snsp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Aug 2021 17:00:54 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 177H0sfA172148;
        Sat, 7 Aug 2021 17:00:54 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 3a9f9snsny-1;
        Sat, 07 Aug 2021 17:00:53 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] Fix DoS vulnerability  in libtirpc
Date:   Sat,  7 Aug 2021 13:00:47 -0400
Message-Id: <20210807170047.68720-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Sk6ALlSdpKXLjz01EMvoxa_ZBRhNI5_i
X-Proofpoint-ORIG-GUID: Sk6ALlSdpKXLjz01EMvoxa_ZBRhNI5_i
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently svc_run does not handle poll time and rendezvous_request
does not handle EMFILE error returned from accept(2 as it used to.
These two missing functionality were removed by commit b2c9430f46c4.

The effect of not handling poll timeout allows idle TCP conections
to remain ESTABLISHED indefinitely. When the number of connections
reaches the limit of the open file descriptors (ulimit -n) then
accept(2) fails with EMFILE. Since there is no handling of EMFILE
error this causes svc_run() to get in a tight loop calling accept(2).
This resulting in the RPC service of svc_run is being down, it's
no longer able to service any requests.

The below script, td.sh, with nc (nmap-ncat-7.80-3) can be used
to take down the RPC service:

if [ $# -ne 3 ]; then
        echo "$0: server dst_port conn_cnt"
        exit
fi
server=$1
dport=$2
conn_cnt=$3
echo "dport[$dport] server[$server] conn_cnt[$conn_cnt]"

pcnt=0
while [ $pcnt -lt $conn_cnt ]
do
        nc -v --recv-only $server $dport &
        pcnt=`expr $pcnt + 1`
done

Fix by restoring code in svc_run to cleanup idle conncetions when
poll(2) returns 0 (timeout) and in rendezvous_request to handle
EMFILE error returned from accept(2).

Fixes: b2c9430f46c4 Use poll() instead of select() in svc_run()
Signed-off-by: dai.ngo@oracle.com
---
 src/libtirpc.map |  2 +-
 src/rpc_com.h    |  2 ++
 src/svc.c        |  2 +-
 src/svc_run.c    |  2 ++
 src/svc_vc.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/src/libtirpc.map b/src/libtirpc.map
index 21d60651ff57..b754110faadb 100644
--- a/src/libtirpc.map
+++ b/src/libtirpc.map
@@ -331,5 +331,5 @@ TIRPC_PRIVATE {
   global:
     __libc_clntudp_bufcreate;
   # private, but used by rpcbind:
-    __svc_clean_idle; svc_auth_none; libtirpc_set_debug;
+    __svc_destroy_idle; __svc_clean_idle; svc_auth_none; libtirpc_set_debug;
 };
diff --git a/src/rpc_com.h b/src/rpc_com.h
index 76badefcfe90..ede6ec8b1d4e 100644
--- a/src/rpc_com.h
+++ b/src/rpc_com.h
@@ -55,6 +55,7 @@ struct netbuf *__rpcb_findaddr_timed(rpcprog_t, rpcvers_t,
 bool_t __rpc_control(int,void *);
 
 bool_t __svc_clean_idle(fd_set *, int, bool_t);
+void __svc_destroy_idle(int, bool_t);
 bool_t __xdrrec_setnonblock(XDR *, int);
 bool_t __xdrrec_getrec(XDR *, enum xprt_stat *, bool_t);
 void __xprt_unregister_unlocked(SVCXPRT *);
@@ -62,6 +63,7 @@ void __xprt_set_raddr(SVCXPRT *, const struct sockaddr_storage *);
 
 
 extern int __svc_maxrec;
+extern SVCXPRT **__svc_xports;
 
 #ifdef __cplusplus
 }
diff --git a/src/svc.c b/src/svc.c
index 6db164bbd76b..aa0c92591914 100644
--- a/src/svc.c
+++ b/src/svc.c
@@ -57,7 +57,7 @@
 
 #define max(a, b) (a > b ? a : b)
 
-static SVCXPRT **__svc_xports;
+SVCXPRT **__svc_xports;
 int __svc_maxrec;
 
 /*
diff --git a/src/svc_run.c b/src/svc_run.c
index f40314b9948e..4eba36174524 100644
--- a/src/svc_run.c
+++ b/src/svc_run.c
@@ -44,6 +44,7 @@
 #include "rpc_com.h"
 #include <sys/select.h>
 
+
 void
 svc_run()
 {
@@ -86,6 +87,7 @@ svc_run()
           warn ("svc_run: - poll failed");
           break;
         case 0:
+          __svc_destroy_idle(30, FALSE);
           continue;
         default:
           svc_getreq_poll (my_pollfd, i);
diff --git a/src/svc_vc.c b/src/svc_vc.c
index f1d9f001fcdc..4880ab5dbc26 100644
--- a/src/svc_vc.c
+++ b/src/svc_vc.c
@@ -58,6 +58,7 @@
 
 #include <rpc/rpc.h>
 
+#include "debug.h"
 #include "rpc_com.h"
 
 #include <getpeereid.h>
@@ -337,6 +338,10 @@ again:
 	if (sock < 0) {
 		if (errno == EINTR)
 			goto again;
+		if (errno == EMFILE || errno == ENFILE) {
+			/* remove least active fd */
+			__svc_destroy_idle(0, FALSE);
+		}
 		return (FALSE);
 	}
 	/*
@@ -820,3 +825,46 @@ __svc_clean_idle(fd_set *fds, int timeout, bool_t cleanblock)
 {
 	return FALSE;
 }
+
+void
+__svc_destroy_idle(int timeout, bool_t cleanblock)
+{
+	int i;
+	SVCXPRT *xprt, *least_active;
+	struct timeval tv, tdiff, tmax;
+	struct cf_conn *cd;
+
+	gettimeofday(&tv, NULL);
+	tmax.tv_sec = tmax.tv_usec = 0;
+	least_active = NULL;
+	rwlock_wrlock(&svc_fd_lock);
+
+	for (i = 0; i <= svc_max_pollfd; i++) {
+		if (svc_pollfd[i].fd == -1)
+			continue;
+		xprt = __svc_xports[i];
+		if (xprt == NULL || xprt->xp_ops == NULL ||
+			xprt->xp_ops->xp_recv != svc_vc_recv)
+			continue;
+		cd = (struct cf_conn *)xprt->xp_p1;
+		if (!cleanblock && !cd->nonblock)
+			continue;
+		if (timeout == 0) {
+			timersub(&tv, &cd->last_recv_time, &tdiff);
+			if (timercmp(&tdiff, &tmax, >)) {
+				tmax = tdiff;
+				least_active = xprt;
+			}
+			continue;
+		}
+		if (tv.tv_sec - cd->last_recv_time.tv_sec > timeout) {
+			__xprt_unregister_unlocked(xprt);
+			__svc_vc_dodestroy(xprt);
+		}
+	}
+	if (timeout == 0 && least_active != NULL) {
+		__xprt_unregister_unlocked(least_active);
+		__svc_vc_dodestroy(least_active);
+	}
+	rwlock_unlock(&svc_fd_lock);
+}
-- 
2.26.2

