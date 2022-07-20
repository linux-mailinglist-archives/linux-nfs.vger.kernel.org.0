Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3C57BF86
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jul 2022 23:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiGTVWT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 20 Jul 2022 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiGTVWJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jul 2022 17:22:09 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jul 2022 14:22:07 PDT
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3B434D4FB
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 14:22:07 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-8OL41IKJM1il4X0fXXMPtw-1; Wed, 20 Jul 2022 17:20:59 -0400
X-MC-Unique: 8OL41IKJM1il4X0fXXMPtw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8E7585A586;
        Wed, 20 Jul 2022 21:20:58 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.8.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CA4D1415118;
        Wed, 20 Jul 2022 21:20:58 +0000 (UTC)
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] Eliminate deadlocks in connects with an MT environment
Date:   Wed, 20 Jul 2022 17:20:57 -0400
Message-Id: <20220720212057.43986-1-attila.kovacs@cfa.harvard.edu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=attila.kovacs@cfa.harvard.edu
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: cfa.harvard.edu
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_FAIL,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In cnlt_dg_freeres() and clnt_vc_freeres(), cond_signal() is called after
unlocking the mutex (clnt_fd_lock). The manual of pthread_cond_signal()
allows that, but mentions that for consistent scheduling, cond_signal()
should be called with the waiting mutex locked.

clnt_fd_lock is locked on L171, but then not released if jumping to the
err1 label on an error (L175 and L180). This means that those errors
will deadlock all further operations that require clnt_fd_lock access.

Same in clnt_vc.c in clnt_vc_create, on lines 215, 222, and 230 respectively.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
[Reposting Attila's patch with the proper Signed-off-by and format] 

 src/clnt_dg.c |  9 ++++++---
 src/clnt_vc.c | 12 ++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/src/clnt_dg.c b/src/clnt_dg.c
index b3d82e7..7c5d22e 100644
--- a/src/clnt_dg.c
+++ b/src/clnt_dg.c
@@ -101,9 +101,9 @@ extern mutex_t clnt_fd_lock;
 #define	release_fd_lock(fd_lock, mask) {	\
 	mutex_lock(&clnt_fd_lock);	\
 	fd_lock->active = FALSE;	\
-	mutex_unlock(&clnt_fd_lock);	\
 	thr_sigsetmask(SIG_SETMASK, &(mask), NULL); \
 	cond_signal(&fd_lock->cv);	\
+	mutex_unlock(&clnt_fd_lock);    \
 }
 
 static const char mem_err_clnt_dg[] = "clnt_dg_create: out of memory";
@@ -172,12 +172,15 @@ clnt_dg_create(fd, svcaddr, program, version, sendsz, recvsz)
 	if (dg_fd_locks == (fd_locks_t *) NULL) {
 		dg_fd_locks = fd_locks_init();
 		if (dg_fd_locks == (fd_locks_t *) NULL) {
+			mutex_unlock(&clnt_fd_lock);
 			goto err1;
 		}
 	}
 	fd_lock = fd_lock_create(fd, dg_fd_locks);
-	if (fd_lock == (fd_lock_t *) NULL)
+	if (fd_lock == (fd_lock_t *) NULL) {
+		mutex_unlock(&clnt_fd_lock);
 		goto err1;
+	}
 
 	mutex_unlock(&clnt_fd_lock);
 	thr_sigsetmask(SIG_SETMASK, &(mask), NULL);
@@ -573,9 +576,9 @@ clnt_dg_freeres(cl, xdr_res, res_ptr)
 	cu->cu_fd_lock->active = TRUE;
 	xdrs->x_op = XDR_FREE;
 	dummy = (*xdr_res)(xdrs, res_ptr);
-	mutex_unlock(&clnt_fd_lock);
 	thr_sigsetmask(SIG_SETMASK, &mask, NULL);
 	cond_signal(&cu->cu_fd_lock->cv);
+	mutex_unlock(&clnt_fd_lock);
 	return (dummy);
 }
 
diff --git a/src/clnt_vc.c b/src/clnt_vc.c
index a07e297..3c73e65 100644
--- a/src/clnt_vc.c
+++ b/src/clnt_vc.c
@@ -153,9 +153,9 @@ extern mutex_t  clnt_fd_lock;
 #define release_fd_lock(fd_lock, mask) {	\
 	mutex_lock(&clnt_fd_lock);	\
 	fd_lock->active = FALSE;	\
-	mutex_unlock(&clnt_fd_lock);	\
 	thr_sigsetmask(SIG_SETMASK, &(mask), (sigset_t *) NULL);	\
 	cond_signal(&fd_lock->cv);	\
+	mutex_unlock(&clnt_fd_lock);    \
 }
 
 static const char clnt_vc_errstr[] = "%s : %s";
@@ -216,7 +216,9 @@ clnt_vc_create(fd, raddr, prog, vers, sendsz, recvsz)
 	if (vc_fd_locks == (fd_locks_t *) NULL) {
 		vc_fd_locks = fd_locks_init();
 		if (vc_fd_locks == (fd_locks_t *) NULL) {
-			struct rpc_createerr *ce = &get_rpc_createerr();
+			struct rpc_createerr *ce;
+			mutex_unlock(&clnt_fd_lock);
+			ce = &get_rpc_createerr();
 			ce->cf_stat = RPC_SYSTEMERROR;
 			ce->cf_error.re_errno = errno;
 			goto err;
@@ -224,7 +226,9 @@ clnt_vc_create(fd, raddr, prog, vers, sendsz, recvsz)
 	}
 	fd_lock = fd_lock_create(fd, vc_fd_locks);
 	if (fd_lock == (fd_lock_t *) NULL) {
-		struct rpc_createerr *ce = &get_rpc_createerr();
+		struct rpc_createerr *ce;
+		mutex_unlock(&clnt_fd_lock);
+		ce = &get_rpc_createerr();
 		ce->cf_stat = RPC_SYSTEMERROR;
 		ce->cf_error.re_errno = errno;
 		goto err;
@@ -495,9 +499,9 @@ clnt_vc_freeres(cl, xdr_res, res_ptr)
 		cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
 	xdrs->x_op = XDR_FREE;
 	dummy = (*xdr_res)(xdrs, res_ptr);
-	mutex_unlock(&clnt_fd_lock);
 	thr_sigsetmask(SIG_SETMASK, &(mask), NULL);
 	cond_signal(&ct->ct_fd_lock->cv);
+	mutex_unlock(&clnt_fd_lock);
 
 	return dummy;
 }
-- 
2.36.1

