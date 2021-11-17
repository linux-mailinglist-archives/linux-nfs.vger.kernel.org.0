Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6258453D4A
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 01:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhKQAu3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 19:50:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37098 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhKQAu3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 19:50:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC7F12177B;
        Wed, 17 Nov 2021 00:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637110050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADeM54StGRViqZXCy0BUQ2qVn2W/LxalQ4iSpCSBAmY=;
        b=jsQ/gCg/sTv92Bm+Z+Sh6aUH+pDZf2cJxCT715vwRi4MjZDFQ1oRPZgrWSbd9qQ1vWixeV
        T0EsmBpm5cpM7o5IRpcuLQ7nG5EnDdhltAvowrn2HstB3mwAxV0TWVVTrUGEMNSXn1xvRF
        GiyS1nS0dDGt8OD7i0obIjCyNdsUn6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637110050;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADeM54StGRViqZXCy0BUQ2qVn2W/LxalQ4iSpCSBAmY=;
        b=tiM/ToNmq/0A5G/N6EIJBbfpyPrBsAnppYitSVq/5wLE1+JWl6u1cTIp1r67u2wwnu7uFE
        Ev419qM8AQxyA7Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD8FD13BC1;
        Wed, 17 Nov 2021 00:47:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0nDiHiFRlGFKWgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Nov 2021 00:47:29 +0000
Subject: [PATCH 04/14] SUNRPC: use sv_lock to protect updates to sv_nrthreads.
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 17 Nov 2021 11:46:50 +1100
Message-ID: <163711001002.5485.7415582365549720137.stgit@noble.brown>
In-Reply-To: <163710954700.5485.5622638225352156964.stgit@noble.brown>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Using sv_lock means we don't need to hold the service mutex over these
updates.

In particular,  svc_exit_thread() no longer requires synchronisation, so
threads can exit asynchronously.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c |    9 ++++-----
 net/sunrpc/svc.c |    9 +++++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 9e517ddd8d4e..27a735a4df29 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -55,9 +55,8 @@ static __be32			nfsd_init_request(struct svc_rqst *,
 						struct svc_process_info *);
 
 /*
- * nfsd_mutex protects nn->nfsd_serv -- both the pointer itself and the members
- * of the svc_serv struct. In particular, ->sv_nrthreads but also to some
- * extent ->sv_temp_socks and ->sv_permsocks.
+ * nfsd_mutex protects nn->nfsd_serv -- both the pointer itself and some members
+ * of the svc_serv struct such as ->sv_temp_socks and ->sv_permsocks.
  *
  * If (out side the lock) nn->nfsd_serv is non-NULL, then it must point to a
  * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0 (unless
@@ -983,7 +982,6 @@ nfsd(void *vrqstp)
 	atomic_dec(&nfsdstats.th_cnt);
 
 out:
-	mutex_lock(&nfsd_mutex);
 	/* Take an extra ref so that the svc_put in svc_exit_thread()
 	 * doesn't call svc_destroy()
 	 */
@@ -993,10 +991,11 @@ nfsd(void *vrqstp)
 	svc_exit_thread(rqstp);
 
 	/* Now if needed we call svc_destroy in appropriate context */
+	mutex_lock(&nfsd_mutex);
 	nfsd_put(net);
+	mutex_unlock(&nfsd_mutex);
 
 	/* Release module */
-	mutex_unlock(&nfsd_mutex);
 	module_put_and_exit(0);
 	return 0;
 }
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index bd610709e88c..a099d0145d89 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -523,7 +523,7 @@ EXPORT_SYMBOL_GPL(svc_shutdown_net);
 
 /*
  * Destroy an RPC service. Should be called with appropriate locking to
- * protect the sv_nrthreads, sv_permsocks and sv_tempsocks.
+ * protect sv_permsocks and sv_tempsocks.
  */
 void
 svc_destroy(struct kref *ref)
@@ -641,7 +641,10 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 		return ERR_PTR(-ENOMEM);
 
 	svc_get(serv);
-	serv->sv_nrthreads++;
+	spin_lock_bh(&serv->sv_lock);
+	serv->sv_nrthreads += 1;
+	spin_unlock_bh(&serv->sv_lock);
+
 	spin_lock_bh(&pool->sp_lock);
 	pool->sp_nrthreads++;
 	list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
@@ -882,7 +885,9 @@ svc_exit_thread(struct svc_rqst *rqstp)
 		list_del_rcu(&rqstp->rq_all);
 	spin_unlock_bh(&pool->sp_lock);
 
+	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads -= 1;
+	spin_unlock_bh(&serv->sv_lock);
 	svc_sock_update_bufs(serv);
 
 	svc_rqst_free(rqstp);


