Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41B27D1BB
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgI2OrU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbgI2OrU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:47:20 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB78C061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:47:20 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z5so5145880ilq.5
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=f30nHMA3w/sN/K/tv3bwN6Sls99xxxWJ44QUijQjEHs=;
        b=bxLNVJPsS1bhxtyv7vSVmnI/WwgzKg5nFIgv68hQiUivq4fCVUaC8DHX8oSFJO9NW2
         ZdEJa2Ws2nCHDEni6eJdcceTv7bNYa/eiDTWQ58uSSfyeYJY402mJj1PALSEwYPdTBjj
         q54mKALUm+pz1cgo4HrsyA5gNG4zsnFcZXezKdlKPccqZDtIiqbH1bcOCjG5sRH2HabB
         0qtBt/EY++XG4tH4kLh7/byLVEHiG9sScMecnBtg4FRifigUqBAqsQ3RKe+E/3VC0hy4
         lrvSrGoeYQ+L5xS1haazPmVVQ2qbVRLcPR6BJLE/JD21mKqk8GMzi0gr1WIgo+KMIaeT
         4KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=f30nHMA3w/sN/K/tv3bwN6Sls99xxxWJ44QUijQjEHs=;
        b=E/90nk+4HGUAcm5JZsun9tEabYfoXhFxPnbtYShSywfMQbMr0R2vww60rz/DK2cCr6
         f9zg37md8g7NLL9Q8Pt9eMLojeEYr3gPFru+UgAugoURRIKICm6qWJX6t3twHP/kQhoe
         r7jFOuSgfNsqQg5Vy77tlxEaIoczIe4tLcJZn7vsLQtT2oCjA1G041AYrQyspj+O+oPi
         Xo2CaVtfhrkxYjExk4DKidyIrBjERxBFmhHmSdqK8P5aX1IwZwh4QYlkuCMOSiNEzrMG
         hTRw0uQvlpdlvyVWoGmRHggw//1iMHmUDn029d1P9fBDCvz/qV7G+SKbPp5ktIz3Qe/2
         2a7g==
X-Gm-Message-State: AOAM533joOI977bQiJeYprhqB7RBiheXALTfRxJvk2TCB24b2FluMxsZ
        zSaYHf02KUv59eHmqvpzYZZxM5Q+yxcvFw==
X-Google-Smtp-Source: ABdhPJzJcKBck/vAKHVXXCAILIXSinnoyR7isE8IU5Cc3lFUkr7oU2Qv30q2fANCyJKrTVVNfoMENw==
X-Received: by 2002:a92:9a13:: with SMTP id t19mr430185ili.269.1601390838503;
        Tue, 29 Sep 2020 07:47:18 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c2sm883728iot.52.2020.09.29.07.47.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:47:17 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TElGQB026499
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 14:47:16 GMT
Subject: [PATCH RFC] lockd: Replace some dprintk() callsites with tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:47:16 -0400
Message-ID: <160139069000.1267.9327919889389631563.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace dprintk() infrastructure with tracepoints that collect
much deeper per-RPC information. Some examples:

lockd-1016  [000]   254.812542: lockd_proc_test: \
	xid=0xa7290991 caller=manet.1015granger.net \
	fh_hash=0x16fbb5ab range=[2147483647,-1] status=GRANTED

lockd-1016  [000]   254.827767: lockd_proc_lock: \
	xid=0xa8290991 caller=manet.1015granger.net \
	fh_hash=0x1e6450d5 range=[0,-1] status=GRANTED

lockd-1016  [000]   254.831879: lockd_proc_unlock: \
	xid=0xa9290991 caller=manet.1015granger.net \
	fh_hash=0x1e6450d5 range=[0,-1] status=GRANTED

Each of these tracepoints also stores but does not display IP
address information:

  netns_ino=4026532000
  server=192.168.2.55:34723
  client=192.168.2.51:993

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
Hello-

Here's another alternative for introducing operational tracepoints
on the NFS server. Here, for each procedure, the Call arguments and
the returned status code are recorded, as well as the server's
network namespace and IP address and the client's IP address.

Comments welcome.


 fs/lockd/Makefile   |    2 
 fs/lockd/svc.c      |    3 -
 fs/lockd/svc4proc.c |  177 ++++++++++++++++++++++++++--------------
 fs/lockd/svcproc.c  |  186 ++++++++++++++++++++++++++++--------------
 fs/lockd/trace.c    |   19 ++++
 fs/lockd/trace.h    |  228 +++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 490 insertions(+), 125 deletions(-)
 create mode 100644 fs/lockd/trace.c
 create mode 100644 fs/lockd/trace.h

diff --git a/fs/lockd/Makefile b/fs/lockd/Makefile
index 6d5e83ed4476..865324d97db5 100644
--- a/fs/lockd/Makefile
+++ b/fs/lockd/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_LOCKD) += lockd.o
 
 lockd-objs-y := clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
-	        svcshare.o svcproc.o svcsubs.o mon.o xdr.o
+	        svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o
 lockd-objs-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o
 lockd-objs-$(CONFIG_PROC_FS) += procfs.o
 lockd-objs		      := $(lockd-objs-y)
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 1a639e34847d..7b598e52014a 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -153,7 +153,6 @@ lockd(void *vrqstp)
 	 */
 	while (!kthread_should_stop()) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
-		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
 
 		/* update sv_maxconn if it has changed */
 		rqstp->rq_server->sv_maxconn = nlm_max_connections;
@@ -173,8 +172,6 @@ lockd(void *vrqstp)
 		err = svc_recv(rqstp, timeout);
 		if (err == -EAGAIN || err == -EINTR)
 			continue;
-		dprintk("lockd: request from %s\n",
-				svc_print_addr(rqstp, buf, sizeof(buf)));
 
 		svc_process(rqstp);
 	}
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 9913b823a5e7..a522ff2a8d8a 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -14,7 +14,7 @@
 #include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
-#define NLMDBG_FACILITY		NLMDBG_CLIENT
+#include "trace.h"
 
 /*
  * Obtain client and file from arguments
@@ -71,7 +71,7 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 static __be32
 nlm4svc_proc_null(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: NULL          called\n");
+	trace_lockd_proc_null(rqstp);
 	return rpc_success;
 }
 
@@ -86,7 +86,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_file	*file;
 	__be32 rc = rpc_success;
 
-	dprintk("lockd: TEST4        called\n");
 	resp->cookie = argp->cookie;
 
 	/* Obtain client and file */
@@ -97,8 +96,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie);
 	if (resp->status == nlm_drop_reply)
 		rc = rpc_drop_reply;
-	else
-		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
 
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
@@ -109,7 +106,13 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 static __be32
 nlm4svc_proc_test(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_test(rqstp, rqstp->rq_resp);
+	struct nlm_args *argp = rqstp->rq_argp;
+	__be32 rc;
+
+	rc = __nlm4svc_proc_test(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_test(rqstp, &argp->lock);
+	return rc;
 }
 
 static __be32
@@ -120,8 +123,6 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_file	*file;
 	__be32 rc = rpc_success;
 
-	dprintk("lockd: LOCK          called\n");
-
 	resp->cookie = argp->cookie;
 
 	/* Obtain client and file */
@@ -146,8 +147,6 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 					argp->reclaim);
 	if (resp->status == nlm_drop_reply)
 		rc = rpc_drop_reply;
-	else
-		dprintk("lockd: LOCK         status %d\n", ntohl(resp->status));
 
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
@@ -158,7 +157,13 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 static __be32
 nlm4svc_proc_lock(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_lock(rqstp, rqstp->rq_resp);
+	struct nlm_args *argp = rqstp->rq_argp;
+	__be32 rc;
+
+	rc = __nlm4svc_proc_lock(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_lock(rqstp, &argp->lock);
+	return rc;
 }
 
 static __be32
@@ -168,8 +173,6 @@ __nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
-	dprintk("lockd: CANCEL        called\n");
-
 	resp->cookie = argp->cookie;
 
 	/* Don't accept requests during grace period */
@@ -185,7 +188,6 @@ __nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 	/* Try to cancel request. */
 	resp->status = nlmsvc_cancel_blocked(SVC_NET(rqstp), file, &argp->lock);
 
-	dprintk("lockd: CANCEL        status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
@@ -195,7 +197,13 @@ __nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 static __be32
 nlm4svc_proc_cancel(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_cancel(rqstp, rqstp->rq_resp);
+	struct nlm_args *argp = rqstp->rq_argp;
+	__be32 rc;
+
+	rc = __nlm4svc_proc_cancel(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_cancel(rqstp, &argp->lock);
+	return rc;
 }
 
 /*
@@ -208,8 +216,6 @@ __nlm4svc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
-	dprintk("lockd: UNLOCK        called\n");
-
 	resp->cookie = argp->cookie;
 
 	/* Don't accept new lock requests during grace period */
@@ -225,7 +231,6 @@ __nlm4svc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	/* Now try to remove the lock */
 	resp->status = nlmsvc_unlock(SVC_NET(rqstp), file, &argp->lock);
 
-	dprintk("lockd: UNLOCK        status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
@@ -235,7 +240,13 @@ __nlm4svc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 static __be32
 nlm4svc_proc_unlock(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_unlock(rqstp, rqstp->rq_resp);
+	struct nlm_args *argp = rqstp->rq_argp;
+	__be32 rc;
+
+	rc = __nlm4svc_proc_unlock(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_lock(rqstp, &argp->lock);
+	return rc;
 }
 
 /*
@@ -249,16 +260,16 @@ __nlm4svc_proc_granted(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	resp->cookie = argp->cookie;
 
-	dprintk("lockd: GRANTED       called\n");
 	resp->status = nlmclnt_grant(svc_addr(rqstp), &argp->lock);
-	dprintk("lockd: GRANTED       status %d\n", ntohl(resp->status));
 	return rpc_success;
 }
 
 static __be32
 nlm4svc_proc_granted(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_granted(rqstp, rqstp->rq_resp);
+	__nlm4svc_proc_granted(rqstp, rqstp->rq_resp);
+	trace_lockd_proc_granted(rqstp);
+	return rpc_success;
 }
 
 /*
@@ -266,8 +277,6 @@ nlm4svc_proc_granted(struct svc_rqst *rqstp)
  */
 static void nlm4svc_callback_exit(struct rpc_task *task, void *data)
 {
-	dprintk("lockd: %5u callback returned %d\n", task->tk_pid,
-			-task->tk_status);
 }
 
 static void nlm4svc_callback_release(void *data)
@@ -318,32 +327,52 @@ static __be32 nlm4svc_callback(struct svc_rqst *rqstp, u32 proc,
 
 static __be32 nlm4svc_proc_test_msg(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: TEST_MSG      called\n");
-	return nlm4svc_callback(rqstp, NLMPROC_TEST_RES, __nlm4svc_proc_test);
+	__be32 rc;
+
+	rc = nlm4svc_callback(rqstp, NLMPROC_TEST_RES, __nlm4svc_proc_test);
+	if (rc == rpc_success)
+		trace_lockd_proc_test_msg(rqstp);
+	return rc;
 }
 
 static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: LOCK_MSG      called\n");
-	return nlm4svc_callback(rqstp, NLMPROC_LOCK_RES, __nlm4svc_proc_lock);
+	__be32 rc;
+
+	rc = nlm4svc_callback(rqstp, NLMPROC_LOCK_RES, __nlm4svc_proc_lock);
+	if (rc == rpc_success)
+		trace_lockd_proc_lock_msg(rqstp);
+	return rc;
 }
 
 static __be32 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: CANCEL_MSG    called\n");
-	return nlm4svc_callback(rqstp, NLMPROC_CANCEL_RES, __nlm4svc_proc_cancel);
+	__be32 rc;
+
+	rc = nlm4svc_callback(rqstp, NLMPROC_CANCEL_RES, __nlm4svc_proc_cancel);
+	if (rc == rpc_success)
+		trace_lockd_proc_cancel_msg(rqstp);
+	return rc;
 }
 
 static __be32 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: UNLOCK_MSG    called\n");
-	return nlm4svc_callback(rqstp, NLMPROC_UNLOCK_RES, __nlm4svc_proc_unlock);
+	__be32 rc;
+
+	rc = nlm4svc_callback(rqstp, NLMPROC_UNLOCK_RES, __nlm4svc_proc_unlock);
+	if (rc == rpc_success)
+		trace_lockd_proc_unlock_msg(rqstp);
+	return rc;
 }
 
 static __be32 nlm4svc_proc_granted_msg(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: GRANTED_MSG   called\n");
-	return nlm4svc_callback(rqstp, NLMPROC_GRANTED_RES, __nlm4svc_proc_granted);
+	__be32 rc;
+
+	rc = nlm4svc_callback(rqstp, NLMPROC_GRANTED_RES, __nlm4svc_proc_granted);
+	if (rc == rpc_success)
+		trace_lockd_proc_granted_msg(rqstp);
+	return rc;
 }
 
 /*
@@ -357,8 +386,6 @@ nlm4svc_proc_share(struct svc_rqst *rqstp)
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
-	dprintk("lockd: SHARE         called\n");
-
 	resp->cookie = argp->cookie;
 
 	/* Don't accept new lock requests during grace period */
@@ -374,7 +401,7 @@ nlm4svc_proc_share(struct svc_rqst *rqstp)
 	/* Now try to create the share */
 	resp->status = nlmsvc_share_file(host, file, argp);
 
-	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
+	trace_lockd_proc_share(rqstp, &argp->lock);
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
@@ -392,8 +419,6 @@ nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
-	dprintk("lockd: UNSHARE       called\n");
-
 	resp->cookie = argp->cookie;
 
 	/* Don't accept requests during grace period */
@@ -409,8 +434,9 @@ nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 	/* Now try to lock the file */
 	resp->status = nlmsvc_unshare_file(host, file, argp);
 
-	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(&argp->lock);
+
+	trace_lockd_proc_unshare(rqstp, &argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
@@ -423,11 +449,13 @@ static __be32
 nlm4svc_proc_nm_lock(struct svc_rqst *rqstp)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
-
-	dprintk("lockd: NM_LOCK       called\n");
+	__be32 rc;
 
 	argp->monitor = 0;		/* just clean the monitor flag */
-	return nlm4svc_proc_lock(rqstp);
+	rc = __nlm4svc_proc_lock(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_nm_lock(rqstp, &argp->lock);
+	return rc;
 }
 
 /*
@@ -444,6 +472,8 @@ nlm4svc_proc_free_all(struct svc_rqst *rqstp)
 		return rpc_success;
 
 	nlmsvc_free_host_resources(host);
+
+	trace_lockd_proc_free_all(rqstp, &argp->lock);
 	nlmsvc_release_host(host);
 	return rpc_success;
 }
@@ -456,16 +486,11 @@ nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
 {
 	struct nlm_reboot *argp = rqstp->rq_argp;
 
-	dprintk("lockd: SM_NOTIFY     called\n");
-
-	if (!nlm_privileged_requester(rqstp)) {
-		char buf[RPC_MAX_ADDRBUFLEN];
-		printk(KERN_WARNING "lockd: rejected NSM callback from %s\n",
-				svc_print_addr(rqstp, buf, sizeof(buf)));
+	if (!nlm_privileged_requester(rqstp))
 		return rpc_system_err;
-	}
 
 	nlm_host_rebooted(SVC_NET(rqstp), argp);
+	trace_lockd_proc_sm_notify(rqstp);
 	return rpc_success;
 }
 
@@ -480,9 +505,43 @@ nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
         if (!nlmsvc_ops)
                 return rpc_success;
 
-        dprintk("lockd: GRANTED_RES   called\n");
-
         nlmsvc_grant_reply(&argp->cookie, argp->status);
+	trace_lockd_proc_granted_res(rqstp);
+        return rpc_success;
+}
+
+static __be32
+nlm4svc_proc_test_res(struct svc_rqst *rqstp)
+{
+	trace_lockd_proc_test_res(rqstp);
+        return rpc_success;
+}
+
+static __be32
+nlm4svc_proc_lock_res(struct svc_rqst *rqstp)
+{
+	trace_lockd_proc_lock_res(rqstp);
+        return rpc_success;
+}
+
+static __be32
+nlm4svc_proc_cancel_res(struct svc_rqst *rqstp)
+{
+	trace_lockd_proc_cancel_res(rqstp);
+        return rpc_success;
+}
+
+static __be32
+nlm4svc_proc_unlock_res(struct svc_rqst *rqstp)
+{
+	trace_lockd_proc_unlock_res(rqstp);
+        return rpc_success;
+}
+
+static __be32
+nlm4svc_proc_unused(struct svc_rqst *rqstp)
+{
+	trace_lockd_proc_unused(rqstp);
         return rpc_success;
 }
 
@@ -588,7 +647,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize = St,
 	},
 	[NLMPROC_TEST_RES] = {
-		.pc_func = nlm4svc_proc_null,
+		.pc_func = nlm4svc_proc_test_res,
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
@@ -596,7 +655,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize = St,
 	},
 	[NLMPROC_LOCK_RES] = {
-		.pc_func = nlm4svc_proc_null,
+		.pc_func = nlm4svc_proc_lock_res,
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
@@ -604,7 +663,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize = St,
 	},
 	[NLMPROC_CANCEL_RES] = {
-		.pc_func = nlm4svc_proc_null,
+		.pc_func = nlm4svc_proc_cancel_res,
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
@@ -612,7 +671,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize = St,
 	},
 	[NLMPROC_UNLOCK_RES] = {
-		.pc_func = nlm4svc_proc_null,
+		.pc_func = nlm4svc_proc_unlock_res,
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
@@ -636,7 +695,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize = St,
 	},
 	[17] = { /* unused procedure */
-		.pc_func = nlm4svc_proc_null,
+		.pc_func = nlm4svc_proc_unused,
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
@@ -644,7 +703,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize = 0,
 	},
 	[18] = { /* unused procedure */
-		.pc_func = nlm4svc_proc_null,
+		.pc_func = nlm4svc_proc_unused,
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
@@ -652,7 +711,7 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize = 0,
 	},
 	[19] = { /* unused procedure */
-		.pc_func = nlm4svc_proc_null,
+		.pc_func = nlm4svc_proc_unused,
 		.pc_decode = nlm4svc_decode_void,
 		.pc_encode = nlm4svc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index dbcfa67a36b1..a9565a155f01 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -14,7 +14,7 @@
 #include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
-#define NLMDBG_FACILITY		NLMDBG_CLIENT
+#include "trace.h"
 
 #ifdef CONFIG_LOCKD_V4
 static __be32
@@ -101,7 +101,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 static __be32
 nlmsvc_proc_null(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: NULL          called\n");
+	trace_lockd_proc_null(rqstp);
 	return rpc_success;
 }
 
@@ -116,7 +116,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_file	*file;
 	__be32 rc = rpc_success;
 
-	dprintk("lockd: TEST          called\n");
 	resp->cookie = argp->cookie;
 
 	/* Obtain client and file */
@@ -127,9 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie));
 	if (resp->status == nlm_drop_reply)
 		rc = rpc_drop_reply;
-	else
-		dprintk("lockd: TEST          status %d vers %d\n",
-			ntohl(resp->status), rqstp->rq_vers);
 
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
@@ -140,7 +136,13 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 static __be32
 nlmsvc_proc_test(struct svc_rqst *rqstp)
 {
-	return __nlmsvc_proc_test(rqstp, rqstp->rq_resp);
+	struct nlm_args *argp = rqstp->rq_argp;
+	__be32 rc;
+
+	rc = __nlmsvc_proc_test(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_test(rqstp, &argp->lock);
+	return rc;
 }
 
 static __be32
@@ -151,8 +153,6 @@ __nlmsvc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_file	*file;
 	__be32 rc = rpc_success;
 
-	dprintk("lockd: LOCK          called\n");
-
 	resp->cookie = argp->cookie;
 
 	/* Obtain client and file */
@@ -177,8 +177,6 @@ __nlmsvc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 					       argp->reclaim));
 	if (resp->status == nlm_drop_reply)
 		rc = rpc_drop_reply;
-	else
-		dprintk("lockd: LOCK         status %d\n", ntohl(resp->status));
 
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
@@ -189,7 +187,13 @@ __nlmsvc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 static __be32
 nlmsvc_proc_lock(struct svc_rqst *rqstp)
 {
-	return __nlmsvc_proc_lock(rqstp, rqstp->rq_resp);
+	struct nlm_args *argp = rqstp->rq_argp;
+	__be32 rc;
+
+	rc = __nlmsvc_proc_lock(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_lock(rqstp, &argp->lock);
+	return rc;
 }
 
 static __be32
@@ -200,8 +204,6 @@ __nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_file	*file;
 	struct net *net = SVC_NET(rqstp);
 
-	dprintk("lockd: CANCEL        called\n");
-
 	resp->cookie = argp->cookie;
 
 	/* Don't accept requests during grace period */
@@ -217,7 +219,6 @@ __nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 	/* Try to cancel request. */
 	resp->status = cast_status(nlmsvc_cancel_blocked(net, file, &argp->lock));
 
-	dprintk("lockd: CANCEL        status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
@@ -227,7 +228,13 @@ __nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 static __be32
 nlmsvc_proc_cancel(struct svc_rqst *rqstp)
 {
-	return __nlmsvc_proc_cancel(rqstp, rqstp->rq_resp);
+	struct nlm_args *argp = rqstp->rq_argp;
+	__be32 rc;
+
+	rc = __nlmsvc_proc_cancel(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_cancel(rqstp, &argp->lock);
+	return rc;
 }
 
 /*
@@ -241,8 +248,6 @@ __nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_file	*file;
 	struct net *net = SVC_NET(rqstp);
 
-	dprintk("lockd: UNLOCK        called\n");
-
 	resp->cookie = argp->cookie;
 
 	/* Don't accept new lock requests during grace period */
@@ -258,7 +263,6 @@ __nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	/* Now try to remove the lock */
 	resp->status = cast_status(nlmsvc_unlock(net, file, &argp->lock));
 
-	dprintk("lockd: UNLOCK        status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
@@ -268,7 +272,13 @@ __nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 static __be32
 nlmsvc_proc_unlock(struct svc_rqst *rqstp)
 {
-	return __nlmsvc_proc_unlock(rqstp, rqstp->rq_resp);
+	struct nlm_args *argp = rqstp->rq_argp;
+	__be32 rc;
+
+	rc = __nlmsvc_proc_unlock(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_unlock(rqstp, &argp->lock);
+	return rc;
 }
 
 /*
@@ -282,16 +292,19 @@ __nlmsvc_proc_granted(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	resp->cookie = argp->cookie;
 
-	dprintk("lockd: GRANTED       called\n");
 	resp->status = nlmclnt_grant(svc_addr(rqstp), &argp->lock);
-	dprintk("lockd: GRANTED       status %d\n", ntohl(resp->status));
 	return rpc_success;
 }
 
 static __be32
 nlmsvc_proc_granted(struct svc_rqst *rqstp)
 {
-	return __nlmsvc_proc_granted(rqstp, rqstp->rq_resp);
+	__be32 rc;
+
+	rc = __nlmsvc_proc_granted(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_granted(rqstp);
+	return rc;
 }
 
 /*
@@ -299,8 +312,6 @@ nlmsvc_proc_granted(struct svc_rqst *rqstp)
  */
 static void nlmsvc_callback_exit(struct rpc_task *task, void *data)
 {
-	dprintk("lockd: %5u callback returned %d\n", task->tk_pid,
-			-task->tk_status);
 }
 
 void nlmsvc_release_call(struct nlm_rqst *call)
@@ -359,34 +370,53 @@ static __be32 nlmsvc_callback(struct svc_rqst *rqstp, u32 proc,
 
 static __be32 nlmsvc_proc_test_msg(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: TEST_MSG      called\n");
-	return nlmsvc_callback(rqstp, NLMPROC_TEST_RES, __nlmsvc_proc_test);
+	__be32 rc;
+
+	rc = nlmsvc_callback(rqstp, NLMPROC_TEST_RES, __nlmsvc_proc_test);
+	if (rc == rpc_success)
+		trace_lockd_proc_test_msg(rqstp);
+	return rc;
 }
 
 static __be32 nlmsvc_proc_lock_msg(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: LOCK_MSG      called\n");
-	return nlmsvc_callback(rqstp, NLMPROC_LOCK_RES, __nlmsvc_proc_lock);
+	__be32 rc;
+
+	rc = nlmsvc_callback(rqstp, NLMPROC_LOCK_RES, __nlmsvc_proc_lock);
+	if (rc == rpc_success)
+		trace_lockd_proc_lock_msg(rqstp);
+	return rc;
 }
 
 static __be32 nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: CANCEL_MSG    called\n");
-	return nlmsvc_callback(rqstp, NLMPROC_CANCEL_RES, __nlmsvc_proc_cancel);
+	__be32 rc;
+
+	rc = nlmsvc_callback(rqstp, NLMPROC_CANCEL_RES, __nlmsvc_proc_cancel);
+	if (rc == rpc_success)
+		trace_lockd_proc_cancel_msg(rqstp);
+	return rc;
 }
 
-static __be32
-nlmsvc_proc_unlock_msg(struct svc_rqst *rqstp)
+static __be32 nlmsvc_proc_unlock_msg(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: UNLOCK_MSG    called\n");
-	return nlmsvc_callback(rqstp, NLMPROC_UNLOCK_RES, __nlmsvc_proc_unlock);
+	__be32 rc;
+
+	rc = nlmsvc_callback(rqstp, NLMPROC_UNLOCK_RES, __nlmsvc_proc_unlock);
+	if (rc == rpc_success)
+		trace_lockd_proc_unlock_msg(rqstp);
+	return rc;
 }
 
 static __be32
 nlmsvc_proc_granted_msg(struct svc_rqst *rqstp)
 {
-	dprintk("lockd: GRANTED_MSG   called\n");
-	return nlmsvc_callback(rqstp, NLMPROC_GRANTED_RES, __nlmsvc_proc_granted);
+	__be32 rc;
+
+	rc = nlmsvc_callback(rqstp, NLMPROC_GRANTED_RES, __nlmsvc_proc_granted);
+	if (rc == rpc_success)
+		trace_lockd_proc_granted_msg(rqstp);
+	return rc;
 }
 
 /*
@@ -400,13 +430,12 @@ nlmsvc_proc_share(struct svc_rqst *rqstp)
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
-	dprintk("lockd: SHARE         called\n");
-
 	resp->cookie = argp->cookie;
 
 	/* Don't accept new lock requests during grace period */
 	if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim) {
 		resp->status = nlm_lck_denied_grace_period;
+		trace_lockd_proc_share(rqstp, &argp->lock);
 		return rpc_success;
 	}
 
@@ -417,7 +446,7 @@ nlmsvc_proc_share(struct svc_rqst *rqstp)
 	/* Now try to create the share */
 	resp->status = cast_status(nlmsvc_share_file(host, file, argp));
 
-	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
+	trace_lockd_proc_share(rqstp, &argp->lock);
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
@@ -435,13 +464,12 @@ nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
-	dprintk("lockd: UNSHARE       called\n");
-
 	resp->cookie = argp->cookie;
 
 	/* Don't accept requests during grace period */
 	if (locks_in_grace(SVC_NET(rqstp))) {
 		resp->status = nlm_lck_denied_grace_period;
+		trace_lockd_proc_unshare(rqstp, &argp->lock);
 		return rpc_success;
 	}
 
@@ -452,7 +480,7 @@ nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 	/* Now try to unshare the file */
 	resp->status = cast_status(nlmsvc_unshare_file(host, file, argp));
 
-	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
+	trace_lockd_proc_unshare(rqstp, &argp->lock);
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
@@ -466,11 +494,13 @@ static __be32
 nlmsvc_proc_nm_lock(struct svc_rqst *rqstp)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
-
-	dprintk("lockd: NM_LOCK       called\n");
+	__be32 rc;
 
 	argp->monitor = 0;		/* just clean the monitor flag */
-	return nlmsvc_proc_lock(rqstp);
+	rc = __nlmsvc_proc_lock(rqstp, rqstp->rq_resp);
+	if (rc == rpc_success)
+		trace_lockd_proc_nm_lock(rqstp, &argp->lock);
+	return rc;
 }
 
 /*
@@ -487,6 +517,8 @@ nlmsvc_proc_free_all(struct svc_rqst *rqstp)
 		return rpc_success;
 
 	nlmsvc_free_host_resources(host);
+
+	trace_lockd_proc_free_all(rqstp, &argp->lock);
 	nlmsvc_release_host(host);
 	return rpc_success;
 }
@@ -499,16 +531,11 @@ nlmsvc_proc_sm_notify(struct svc_rqst *rqstp)
 {
 	struct nlm_reboot *argp = rqstp->rq_argp;
 
-	dprintk("lockd: SM_NOTIFY     called\n");
-
-	if (!nlm_privileged_requester(rqstp)) {
-		char buf[RPC_MAX_ADDRBUFLEN];
-		printk(KERN_WARNING "lockd: rejected NSM callback from %s\n",
-				svc_print_addr(rqstp, buf, sizeof(buf)));
+	if (!nlm_privileged_requester(rqstp))
 		return rpc_system_err;
-	}
 
 	nlm_host_rebooted(SVC_NET(rqstp), argp);
+	trace_lockd_proc_sm_notify(rqstp);
 	return rpc_success;
 }
 
@@ -523,12 +550,47 @@ nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
 	if (!nlmsvc_ops)
 		return rpc_success;
 
-	dprintk("lockd: GRANTED_RES   called\n");
-
 	nlmsvc_grant_reply(&argp->cookie, argp->status);
+	trace_lockd_proc_granted_res(rqstp);
+	return rpc_success;
+}
+
+static __be32
+nlmsvc_proc_test_res(struct svc_rqst *rqstp)
+{
+	trace_lockd_proc_test_res(rqstp);
+	return rpc_success;
+}
+
+static __be32
+nlmsvc_proc_lock_res(struct svc_rqst *rqstp)
+{
+	trace_lockd_proc_lock_res(rqstp);
+	return rpc_success;
+}
+
+static __be32
+nlmsvc_proc_cancel_res(struct svc_rqst *rqstp)
+{
+	trace_lockd_proc_cancel_res(rqstp);
 	return rpc_success;
 }
 
+static __be32
+nlmsvc_proc_unlock_res(struct svc_rqst *rqstp)
+{
+	trace_lockd_proc_unlock_res(rqstp);
+	return rpc_success;
+}
+
+static __be32
+nlmsvc_proc_unused(struct svc_rqst *rqstp)
+{
+	trace_lockd_proc_unused(rqstp);
+        return rpc_success;
+}
+
+
 /*
  * NLM Server procedures.
  */
@@ -630,7 +692,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize = St,
 	},
 	[NLMPROC_TEST_RES] = {
-		.pc_func = nlmsvc_proc_null,
+		.pc_func = nlmsvc_proc_test_res,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
@@ -638,7 +700,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize = St,
 	},
 	[NLMPROC_LOCK_RES] = {
-		.pc_func = nlmsvc_proc_null,
+		.pc_func = nlmsvc_proc_lock_res,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
@@ -646,7 +708,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize = St,
 	},
 	[NLMPROC_CANCEL_RES] = {
-		.pc_func = nlmsvc_proc_null,
+		.pc_func = nlmsvc_proc_cancel_res,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
@@ -654,7 +716,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize = St,
 	},
 	[NLMPROC_UNLOCK_RES] = {
-		.pc_func = nlmsvc_proc_null,
+		.pc_func = nlmsvc_proc_unlock_res,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_res),
@@ -678,7 +740,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize = St,
 	},
 	[17] = { /* unused procedure */
-		.pc_func = nlmsvc_proc_null,
+		.pc_func = nlmsvc_proc_unused,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
@@ -686,7 +748,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize = St,
 	},
 	[18] = { /* unused procedure */
-		.pc_func = nlmsvc_proc_null,
+		.pc_func = nlmsvc_proc_unused,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
@@ -694,7 +756,7 @@ const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize = St,
 	},
 	[19] = { /* unused procedure */
-		.pc_func = nlmsvc_proc_null,
+		.pc_func = nlmsvc_proc_unused,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
 		.pc_argsize = sizeof(struct nlm_void),
diff --git a/fs/lockd/trace.c b/fs/lockd/trace.c
new file mode 100644
index 000000000000..3ce35d6546d5
--- /dev/null
+++ b/fs/lockd/trace.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/crc32.h>
+#include <linux/nfs.h>
+
+#ifdef CONFIG_CRC32
+static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
+{
+	return ~crc32_le(0xFFFFFFFF, &fh->data[0], fh->size);
+}
+#else
+static inline u32 nfs_fhandle_hash(const struct nfs_fh *fh)
+{
+	return 0;
+}
+#endif
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/fs/lockd/trace.h b/fs/lockd/trace.h
new file mode 100644
index 000000000000..70c36c64b370
--- /dev/null
+++ b/fs/lockd/trace.h
@@ -0,0 +1,228 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Tracepoints for lockd
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM lockd
+
+#if !defined(_LOCKD_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _LOCKD_TRACE_H
+
+#include <linux/tracepoint.h>
+
+#include <linux/lockd/nlm.h>
+#include <linux/lockd/xdr.h>
+#include <linux/sunrpc/svc.h>
+#include <linux/sunrpc/svc_xprt.h>
+#include <trace/events/nfs.h>
+
+TRACE_DEFINE_ENUM(NLM_LCK_GRANTED);
+TRACE_DEFINE_ENUM(NLM_LCK_DENIED);
+TRACE_DEFINE_ENUM(NLM_LCK_DENIED_NOLOCKS);
+TRACE_DEFINE_ENUM(NLM_LCK_BLOCKED);
+TRACE_DEFINE_ENUM(NLM_LCK_DENIED_GRACE_PERIOD);
+TRACE_DEFINE_ENUM(NLM_DEADLCK);
+TRACE_DEFINE_ENUM(NLM_ROFS);
+TRACE_DEFINE_ENUM(NLM_STALE_FH);
+TRACE_DEFINE_ENUM(NLM_FBIG);
+TRACE_DEFINE_ENUM(NLM_FAILED);
+
+#define show_nlm_status(x) \
+	__print_symbolic(x, \
+		{ NLM_LCK_GRANTED,		"GRANTED" }, \
+		{ NLM_LCK_DENIED,		"DENIED" }, \
+		{ NLM_LCK_DENIED_NOLOCKS,	"DENIED_NOLOCKS" }, \
+		{ NLM_LCK_BLOCKED,		"BLOCKED" }, \
+		{ NLM_LCK_DENIED_GRACE_PERIOD,	"DENIED_GRACE_PERIOD" }, \
+		{ NLM_DEADLCK,			"DEADLCK" }, \
+		{ NLM_ROFS,			"ROFS" }, \
+		{ NLM_STALE_FH,			"STALE_FH" }, \
+		{ NLM_FBIG,			"FBIG" }, \
+		{ NLM_FAILED,			"FAILED" })
+
+DECLARE_EVENT_CLASS(lockd_class,
+	TP_PROTO(
+		const struct svc_rqst *rqstp
+	),
+	TP_ARGS(rqstp),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(u32, xid)
+		__field(u32, version)
+		__array(unsigned char, server, sizeof(struct sockaddr_in6))
+		__array(unsigned char, client, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->version = rqstp->rq_vers;
+		memcpy(__entry->server, &rqstp->rq_xprt->xpt_local,
+		       rqstp->rq_xprt->xpt_locallen);
+		memcpy(__entry->client, &rqstp->rq_xprt->xpt_remote,
+		       rqstp->rq_xprt->xpt_remotelen);
+	),
+	TP_printk("xid=0x%08x",
+		__entry->xid
+	)
+);
+
+#define DEFINE_LOCKD_PROC_EVENT(name)			\
+DEFINE_EVENT(lockd_class, lockd_proc_##name,		\
+	TP_PROTO(					\
+		const struct svc_rqst *rqstp		\
+	),						\
+	TP_ARGS(rqstp))
+
+DECLARE_EVENT_CLASS(lockd_status_class,
+	TP_PROTO(
+		const struct svc_rqst *rqstp
+	),
+	TP_ARGS(rqstp),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(u32, xid)
+		__field(u32, version)
+		__field(unsigned long, nlm_status)
+		__array(unsigned char, server, sizeof(struct sockaddr_in6))
+		__array(unsigned char, client, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		const struct nlm_res *resp = rqstp->rq_resp;
+
+		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->version = rqstp->rq_vers;
+		__entry->nlm_status = be32_to_cpu(resp->status);
+		memcpy(__entry->server, &rqstp->rq_xprt->xpt_local,
+		       rqstp->rq_xprt->xpt_locallen);
+		memcpy(__entry->client, &rqstp->rq_xprt->xpt_remote,
+		       rqstp->rq_xprt->xpt_remotelen);
+	),
+	TP_printk("xid=0x%08x status=%s",
+		__entry->xid, show_nlm_status(__entry->nlm_status)
+	)
+);
+
+#define DEFINE_LOCKD_PROC_STATUS_EVENT(name)		\
+DEFINE_EVENT(lockd_status_class, lockd_proc_##name,	\
+	TP_PROTO(					\
+		const struct svc_rqst *rqstp		\
+	),						\
+	TP_ARGS(rqstp))
+
+DECLARE_EVENT_CLASS(lockd_args_class,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nlm_lock *lock
+	),
+	TP_ARGS(rqstp, lock),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(u32, xid)
+		__field(u32, version)
+		__field(u32, fh_hash)
+		__field(u64, start)
+		__field(u64, end)
+		__field(unsigned long, nlm_status)
+		__array(unsigned char, server, sizeof(struct sockaddr_in6))
+		__array(unsigned char, client, sizeof(struct sockaddr_in6))
+		__dynamic_array(unsigned char, caller, lock->len + 1)
+	),
+	TP_fast_assign(
+		const struct nlm_res *resp = rqstp->rq_resp;
+
+		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->version = rqstp->rq_vers;
+		__entry->fh_hash = nfs_fhandle_hash(&lock->fh);
+		__entry->start = lock->fl.fl_start == OFFSET_MAX ?
+					-1 : lock->fl.fl_start;
+		__entry->end = lock->fl.fl_end == OFFSET_MAX ?
+					-1 : lock->fl.fl_end;
+		__entry->nlm_status = be32_to_cpu(resp->status);
+		memcpy(__entry->server, &rqstp->rq_xprt->xpt_local,
+		       rqstp->rq_xprt->xpt_locallen);
+		memcpy(__entry->client, &rqstp->rq_xprt->xpt_remote,
+		       rqstp->rq_xprt->xpt_remotelen);
+		memcpy(__get_str(caller), lock->caller, lock->len);
+		__get_str(caller)[lock->len] = '\0';
+	),
+	TP_printk("xid=0x%08x caller=%s fh_hash=0x%08x range=[%lld,%lld] status=%s",
+		__entry->xid, __get_str(caller), __entry->fh_hash,
+		__entry->start, __entry->end,
+		show_nlm_status(__entry->nlm_status)
+	)
+);
+
+#define DEFINE_LOCKD_PROC_ARGS_EVENT(name)		\
+DEFINE_EVENT(lockd_args_class, lockd_proc_##name,	\
+	TP_PROTO(					\
+		const struct svc_rqst *rqstp,		\
+		const struct nlm_lock *lock		\
+	),						\
+	TP_ARGS(rqstp, lock))
+
+DEFINE_LOCKD_PROC_EVENT(null);
+DEFINE_LOCKD_PROC_ARGS_EVENT(test);
+DEFINE_LOCKD_PROC_ARGS_EVENT(lock);
+DEFINE_LOCKD_PROC_ARGS_EVENT(cancel);
+DEFINE_LOCKD_PROC_ARGS_EVENT(unlock);
+DEFINE_LOCKD_PROC_STATUS_EVENT(granted);
+DEFINE_LOCKD_PROC_EVENT(test_msg);
+DEFINE_LOCKD_PROC_EVENT(lock_msg);
+DEFINE_LOCKD_PROC_EVENT(cancel_msg);
+DEFINE_LOCKD_PROC_EVENT(unlock_msg);
+DEFINE_LOCKD_PROC_EVENT(granted_msg);
+DEFINE_LOCKD_PROC_EVENT(test_res);
+DEFINE_LOCKD_PROC_EVENT(lock_res);
+DEFINE_LOCKD_PROC_EVENT(cancel_res);
+DEFINE_LOCKD_PROC_EVENT(unlock_res);
+DEFINE_LOCKD_PROC_EVENT(granted_res);
+DEFINE_LOCKD_PROC_EVENT(sm_notify);
+DEFINE_LOCKD_PROC_EVENT(unused);
+DEFINE_LOCKD_PROC_ARGS_EVENT(share);
+DEFINE_LOCKD_PROC_ARGS_EVENT(unshare);
+DEFINE_LOCKD_PROC_ARGS_EVENT(nm_lock);
+
+TRACE_EVENT(lockd_proc_free_all,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nlm_lock *lock
+	),
+	TP_ARGS(rqstp, lock),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(u32, xid)
+		__field(u32, version)
+		__array(unsigned char, server, sizeof(struct sockaddr_in6))
+		__array(unsigned char, client, sizeof(struct sockaddr_in6))
+		__dynamic_array(unsigned char, caller, lock->len + 1)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->version = rqstp->rq_vers;
+		memcpy(__entry->server, &rqstp->rq_xprt->xpt_local,
+		       rqstp->rq_xprt->xpt_locallen);
+		memcpy(__entry->client, &rqstp->rq_xprt->xpt_remote,
+		       rqstp->rq_xprt->xpt_remotelen);
+		memcpy(__get_str(caller), lock->caller, lock->len);
+		__get_str(caller)[lock->len] = '\0';
+	),
+	TP_printk("xid=0x%08x caller=%s",
+		__entry->xid, __get_str(caller)
+	)
+);
+
+#endif /* _LOCKD_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../fs/lockd
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>


