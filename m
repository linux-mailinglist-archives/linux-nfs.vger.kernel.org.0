Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4C460E2D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhK2E6W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 23:58:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42492 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhK2E4V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:56:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A57A1FD33;
        Mon, 29 Nov 2021 04:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L47S3sZjTXCU21ehsLsQq+BhRNyb14t/cYjD8QCxZVw=;
        b=so357D8LBHi3d5mQg2QSVDLmG0kWoSI2vczvbDIsgWhUyuDnqBdYMjQUjAACmzHNK9Pw8a
        XZIYZ2AyjZlVOnP+Ny8ZPWBCo/1I1Gkowm3FHRaxHqGOm8vV5Ztvif052zSlREuIRk9BrD
        aUgIdEwnXsGHd+Hd0nXcftdxdDUn1pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L47S3sZjTXCU21ehsLsQq+BhRNyb14t/cYjD8QCxZVw=;
        b=MueqyiryMgVPMDM3eJSdJgkSuVHRuuDZFLL3sW4Ff8lH+b0AJ/IDvrEmsn1dscTy/+kARZ
        /KbBfNOQIcHU+BBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28FD5133FE;
        Mon, 29 Nov 2021 04:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SOIwNq5cpGH/bgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:53:02 +0000
Subject: [PATCH 06/20] SUNRPC: use sv_lock to protect updates to sv_nrthreads.
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816148556.32298.17419698380488869158.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
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

Note that we could use an atomic_t, but as there are many more read
sites than writes, that would add unnecessary noise to the code.
Some reads are already racy, and there is no need for them to not be.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c |    5 ++---
 net/sunrpc/svc.c |    9 +++++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index fc5899502a83..e9c9fa820b17 100644
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
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index acddc6e12e9e..2b2042234e4b 100644
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
@@ -639,7 +639,10 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
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
@@ -880,7 +883,9 @@ svc_exit_thread(struct svc_rqst *rqstp)
 		list_del_rcu(&rqstp->rq_all);
 	spin_unlock_bh(&pool->sp_lock);
 
+	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads -= 1;
+	spin_unlock_bh(&serv->sv_lock);
 	svc_sock_update_bufs(serv);
 
 	svc_rqst_free(rqstp);


