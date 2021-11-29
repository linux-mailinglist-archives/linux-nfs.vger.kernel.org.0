Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AA460E33
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbhK2E7z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 23:59:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60230 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhK2E5y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:57:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6723221763;
        Mon, 29 Nov 2021 04:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mZ9QCJmmpOfHkIM+MgeCLE+cunQFH91V1AI+zif9pc=;
        b=M6sQyxF4VbmZ8verxGzO/FgVkqKXBp2K2OuRk+IJkmogke2B5lcUtxLLBGagnZlTDbHkwD
        hvSkO87wgejpebcZE4DW8RP4785mOCcUbZaGSY2G8k8FeBPcPGw8FZETqskKyXdfnj8FJ5
        JP1kLbBk3h1jwcGBZvrlRidDCi6HwRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mZ9QCJmmpOfHkIM+MgeCLE+cunQFH91V1AI+zif9pc=;
        b=mvTvzABQ5CXpTw3jcvdHJ5nCESpAaDkhsdtBq3MknJijAi3K9mPDbGqSghcGGEl5HMdpJg
        j0qEPgVbhYqVM6DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44936133FE;
        Mon, 29 Nov 2021 04:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8j0ZALhcpGERbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:53:12 +0000
Subject: [PATCH 08/20] NFSD: Make it possible to use svc_set_num_threads_sync
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816148557.32298.11233238491435215789.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd cannot currently use svc_set_num_threads_sync.  It instead
uses svc_set_num_threads which does *not* wait for threads to all
exit, and has a separate mechanism (nfsd_shutdown_complete) to wait
for completion.

The reason that nfsd is unlike other services is that nfsd threads can
exit separately from svc_set_num_threads being called - they die on
receipt of SIGKILL.  Also, when the last thread exits, the service must
be shut down (sockets closed).

For this, the nfsd_mutex needs to be taken, and as that mutex needs to
be held while svc_set_num_threads is called, the one cannot wait for
the other.

This patch changes the nfsd thread so that it can drop the ref on the
service without blocking on nfsd_mutex, so that svc_set_num_threads_sync
can be used:
 - if it can drop a non-last reference, it does that.  This does not
   trigger shutdown and does not require a mutex.  This will likely
   happen for all but the last thread signalled, and for all threads
   being shut down by nfsd_shutdown_threads()
 - if it can get the mutex without blocking (trylock), it does that
   and then drops the reference.  This will likely happen for the
   last thread killed by SIGKILL
 - Otherwise there might be an unrelated task holding the mutex,
   possibly in another network namespace, or nfsd_shutdown_threads()
   might be just about to get a reference on the service, after which
   we can drop ours safely.
   We cannot conveniently get wakeup notifications on these events,
   and we are unlikely to need to, so we sleep briefly and check again.

With this we can discard nfsd_shutdown_complete and
nfsd_complete_shutdown(), and switch to svc_set_num_threads_sync.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/netns.h            |    3 ---
 fs/nfsd/nfssvc.c           |   41 ++++++++++++++++++++---------------------
 include/linux/sunrpc/svc.h |   13 +++++++++++++
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 08bcd8f23b01..1fd59eb0730b 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -134,9 +134,6 @@ struct nfsd_net {
 	wait_queue_head_t ntf_wq;
 	atomic_t ntf_refcnt;
 
-	/* Allow umount to wait for nfsd state cleanup */
-	struct completion nfsd_shutdown_complete;
-
 	/*
 	 * clientid and stateid data for construction of net unique COPY
 	 * stateids.
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 097abd8b059c..d0d9107a1b93 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -593,20 +593,10 @@ static const struct svc_serv_ops nfsd_thread_sv_ops = {
 	.svo_shutdown		= nfsd_last_thread,
 	.svo_function		= nfsd,
 	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
-	.svo_setup		= svc_set_num_threads,
+	.svo_setup		= svc_set_num_threads_sync,
 	.svo_module		= THIS_MODULE,
 };
 
-static void nfsd_complete_shutdown(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	WARN_ON(!mutex_is_locked(&nfsd_mutex));
-
-	nn->nfsd_serv = NULL;
-	complete(&nn->nfsd_shutdown_complete);
-}
-
 void nfsd_shutdown_threads(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
@@ -624,8 +614,6 @@ void nfsd_shutdown_threads(struct net *net)
 	serv->sv_ops->svo_setup(serv, NULL, 0);
 	nfsd_put(net);
 	mutex_unlock(&nfsd_mutex);
-	/* Wait for shutdown of nfsd_serv to complete */
-	wait_for_completion(&nn->nfsd_shutdown_complete);
 }
 
 bool i_am_nfsd(void)
@@ -650,7 +638,6 @@ int nfsd_create_serv(struct net *net)
 						&nfsd_thread_sv_ops);
 	if (nn->nfsd_serv == NULL)
 		return -ENOMEM;
-	init_completion(&nn->nfsd_shutdown_complete);
 
 	nn->nfsd_serv->sv_maxconn = nn->max_connections;
 	error = svc_bind(nn->nfsd_serv, net);
@@ -659,7 +646,7 @@ int nfsd_create_serv(struct net *net)
 		 * been set up yet.
 		 */
 		svc_put(nn->nfsd_serv);
-		nfsd_complete_shutdown(net);
+		nn->nfsd_serv = NULL;
 		return error;
 	}
 
@@ -715,7 +702,7 @@ void nfsd_put(struct net *net)
 	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
 		svc_shutdown_net(nn->nfsd_serv, net);
 		svc_destroy(&nn->nfsd_serv->sv_refcnt);
-		nfsd_complete_shutdown(net);
+		nn->nfsd_serv = NULL;
 	}
 }
 
@@ -743,7 +730,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	if (tot > NFSD_MAXSERVS) {
 		/* total too large: scale down requested numbers */
 		for (i = 0; i < n && tot > 0; i++) {
-		    	int new = nthreads[i] * NFSD_MAXSERVS / tot;
+			int new = nthreads[i] * NFSD_MAXSERVS / tot;
 			tot -= (nthreads[i] - new);
 			nthreads[i] = new;
 		}
@@ -989,10 +976,22 @@ nfsd(void *vrqstp)
 	/* Release the thread */
 	svc_exit_thread(rqstp);
 
-	/* Now if needed we call svc_destroy in appropriate context */
-	mutex_lock(&nfsd_mutex);
-	nfsd_put(net);
-	mutex_unlock(&nfsd_mutex);
+	/* We need to drop a ref, but may not drop the last reference
+	 * without holding nfsd_mutex, and we cannot wait for nfsd_mutex as that
+	 * could deadlock with nfsd_shutdown_threads() waiting for us.
+	 * So three options are:
+	 * - drop a non-final reference,
+	 * - get the mutex without waiting
+	 * - sleep briefly andd try the above again
+	 */
+	while (!svc_put_not_last(nn->nfsd_serv)) {
+		if (mutex_trylock(&nfsd_mutex)) {
+			nfsd_put(net);
+			mutex_unlock(&nfsd_mutex);
+			break;
+		}
+		msleep(20);
+	}
 
 	/* Release module */
 	module_put_and_exit(0);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 3903b4ae8ac5..36bfc0281988 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -141,6 +141,19 @@ static inline void svc_put(struct svc_serv *serv)
 	kref_put(&serv->sv_refcnt, svc_destroy);
 }
 
+/**
+ * svc_put_not_last - decrement non-final reference count on SUNRPC serv
+ * @serv:  the svc_serv to have count decremented
+ *
+ * Returns: %true is refcount was decremented.
+ *
+ * If the refcount is 1, it is not decremented and instead failure is reported.
+ */
+static inline bool svc_put_not_last(struct svc_serv *serv)
+{
+	return refcount_dec_not_one(&serv->sv_refcnt.refcount);
+}
+
 /*
  * Maximum payload size supported by a kernel RPC server.
  * This is use to determine the max number of pages nfsd is


