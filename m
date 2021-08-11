Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD1D3E8709
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 02:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhHKAJI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 20:09:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40314 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235537AbhHKAJH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 20:09:07 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B031Aa011311;
        Wed, 11 Aug 2021 00:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=aeWfq+2pOift8ub1A24aOiCfO66JNQ2InGPla+7RxcU=;
 b=P+ltAJGEfs2PtXMBlzJzk/vu0Io9/AhwPhJZVO0DVsSCwTtVKMpva+Gux5iDnESAAUiK
 NA2KvGW7ycYlt/qYSEAsgXob3Q3uZ5OYaXfrw2q0ZTndxiCuU5eAf1qobfyZ+QmYQuyG
 ScXFv1ljVJ5T3yV/EUxOfps4YtrYTW7tDpl90PF48QPtIWCsbf8B/rTvGwTJ9WMz9jbx
 gT0CRVF9Vg5Lj4lsmBH+I6T8WGGSbwYXRc5Brq7di5YpcqtOIvhWZqygUgdziVd4g5c2
 v2ZHzFmUu0JSKr3A0wVZP5Vs6gwkmXJosL6uqtSVBg3xNHiirgS/UW8vDbhJ6pu8PQx5 Xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=aeWfq+2pOift8ub1A24aOiCfO66JNQ2InGPla+7RxcU=;
 b=ZOmOIo4HVxt+hbQedqFmT588VJlnV+e1+6sLYFz/aH1pRuMtdmR6fO9YyGYhjBlGZ0S0
 Oy7E7uw4tBJ82VdrcVtdR1ZDKPttU8cFN2TP5q/SvsElUHZZzNg2eO6CpwjSj/fio9JO
 7MY2LKHCJ4rU5lAYT1xCM3ZqfaNCRags+q1LYsbJB4TQgMOlkbH3+HO3uZMusxnlvFFh
 EBah9M8j00VYfQuLoS1V+y6el/Gh3SslwcmRh7PFphJubOBY4JMHeGApw97Ee+m+IPvd
 IarZtGG/VRfY1rVH99+en+PsmqethvzPguwPE4/LJ3OikWvRVSt+XU2YfJYGXzeauBE7 yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt449c8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 00:08:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17B00WoO053352;
        Wed, 11 Aug 2021 00:08:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3abx3uqcdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 00:08:27 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 17B08RRY076053;
        Wed, 11 Aug 2021 00:08:27 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 3abx3uqcbn-1;
        Wed, 11 Aug 2021 00:08:27 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org, steved@redhat.com, kukuk@thkukuk.de
Subject: [PATCH v2 1/1] Fix DoS vulnerability  in libtirpc
Date:   Tue, 10 Aug 2021 20:08:18 -0400
Message-Id: <20210811000818.95985-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aP0Vyx1vNu_xUscSWzt3pPg2iiMEzd6o
X-Proofpoint-GUID: aP0Vyx1vNu_xUscSWzt3pPg2iiMEzd6o
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently svc_run does not handle poll timeout and rendezvous_request
does not handle EMFILE error returned from accept(2 as it used to.
These two missing functionality were removed by commit b2c9430f46c4.

The effect of not handling poll timeout allows idle TCP conections
to remain ESTABLISHED indefinitely. When the number of connections
reaches the limit of the open file descriptors (ulimit -n) then
accept(2) fails with EMFILE. Since there is no handling of EMFILE
error this causes svc_run() to get in a tight loop calling accept(2).
This resulting in the RPC service of svc_run is being down, it's
no longer able to service any requests.

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

RPC service rpcbind, statd and mountd are effected by this
problem.

Fix by enhancing rendezvous_request to keep the number of
SVCXPRT conections to 4/5 of the size of the file descriptor
table. When this thresold is reached, it destroys the idle
TCP connections or destroys the least active connection if
no idle connnction was found.

Fixes: 44bf15b8 rpcbind: don't use obsolete svc_fdset interface of libtirpc
Signed-off-by: dai.ngo@oracle.com
---
 src/svc.c    | 17 +++++++++++++-
 src/svc_vc.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/src/svc.c b/src/svc.c
index 6db164bbd76b..3a8709fe375c 100644
--- a/src/svc.c
+++ b/src/svc.c
@@ -57,7 +57,7 @@
 
 #define max(a, b) (a > b ? a : b)
 
-static SVCXPRT **__svc_xports;
+SVCXPRT **__svc_xports;
 int __svc_maxrec;
 
 /*
@@ -194,6 +194,21 @@ __xprt_do_unregister (xprt, dolock)
     rwlock_unlock (&svc_fd_lock);
 }
 
+int
+svc_open_fds()
+{
+	int ix;
+	int nfds = 0;
+
+	rwlock_rdlock (&svc_fd_lock);
+	for (ix = 0; ix < svc_max_pollfd; ++ix) {
+		if (svc_pollfd[ix].fd != -1)
+			nfds++;
+	}
+	rwlock_unlock (&svc_fd_lock);
+	return (nfds);
+}
+
 /*
  * Add a service program to the callout list.
  * The dispatch routine will be called when a rpc request for this
diff --git a/src/svc_vc.c b/src/svc_vc.c
index f1d9f001fcdc..3dc8a75787e1 100644
--- a/src/svc_vc.c
+++ b/src/svc_vc.c
@@ -64,6 +64,8 @@
 
 
 extern rwlock_t svc_fd_lock;
+extern SVCXPRT **__svc_xports;
+extern int svc_open_fds();
 
 static SVCXPRT *makefd_xprt(int, u_int, u_int);
 static bool_t rendezvous_request(SVCXPRT *, struct rpc_msg *);
@@ -82,6 +84,7 @@ static void svc_vc_ops(SVCXPRT *);
 static bool_t svc_vc_control(SVCXPRT *xprt, const u_int rq, void *in);
 static bool_t svc_vc_rendezvous_control (SVCXPRT *xprt, const u_int rq,
 				   	     void *in);
+static int __svc_destroy_idle(int timeout);
 
 struct cf_rendezvous { /* kept in xprt->xp_p1 for rendezvouser */
 	u_int sendsize;
@@ -313,13 +316,14 @@ done:
 	return (xprt);
 }
 
+
 /*ARGSUSED*/
 static bool_t
 rendezvous_request(xprt, msg)
 	SVCXPRT *xprt;
 	struct rpc_msg *msg;
 {
-	int sock, flags;
+	int sock, flags, nfds, cnt;
 	struct cf_rendezvous *r;
 	struct cf_conn *cd;
 	struct sockaddr_storage addr;
@@ -379,6 +383,16 @@ again:
 
 	gettimeofday(&cd->last_recv_time, NULL);
 
+	nfds = svc_open_fds();
+	if (nfds >= (_rpc_dtablesize() / 5) * 4) {
+		/* destroy idle connections */
+		cnt = __svc_destroy_idle(15);
+		if (cnt == 0) {
+			/* destroy least active */
+			__svc_destroy_idle(0);
+		}
+	}
+
 	return (FALSE); /* there is never an rpc msg to be processed */
 }
 
@@ -820,3 +834,49 @@ __svc_clean_idle(fd_set *fds, int timeout, bool_t cleanblock)
 {
 	return FALSE;
 }
+
+static int
+__svc_destroy_idle(int timeout)
+{
+	int i, ncleaned = 0;
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
+		if (!cd->nonblock)
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
+			ncleaned++;
+		}
+	}
+	if (timeout == 0 && least_active != NULL) {
+		__xprt_unregister_unlocked(least_active);
+		__svc_vc_dodestroy(least_active);
+		ncleaned++;
+	}
+	rwlock_unlock(&svc_fd_lock);
+	return (ncleaned);
+}
-- 
2.26.2

