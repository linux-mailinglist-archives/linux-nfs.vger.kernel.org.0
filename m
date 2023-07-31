Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E983768C55
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGaGwE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjGaGvx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:51:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC4C10EF
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:51:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D2B6822431;
        Mon, 31 Jul 2023 06:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5k7osmNyqLkFeyRd3xv0Iv/wEZImUba5nBcluA0dsIs=;
        b=QDwVsXstJzTAA3QrhrSC4rVWlfDRvd7wHv7Kl1ZSTlG/a75XZ1eMpI6T0tKyOtFPLgHcJa
        vXYb4jRZVJpArVFrl4bmKVXxoeTjGg2mOMF6IA4gaa7VQ1OuIA6RBEygk63h1iT3/gEzPG
        1t3MOSnwQTJMcuQs5TNBB9UPnuOadiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786303;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5k7osmNyqLkFeyRd3xv0Iv/wEZImUba5nBcluA0dsIs=;
        b=a4ZLvBIe276xGBad3u30Bqwr3BEDfrxYy/iYRWGTHsdFAku0gBQ/mrBto/l7f3l7s8LedZ
        QILgK2YI/aEV2nAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91BE61322C;
        Mon, 31 Jul 2023 06:51:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fPIiEf5Zx2S/bwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:51:42 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/12] nfsd: separate nfsd_last_thread() from nfsd_put()
Date:   Mon, 31 Jul 2023 16:48:32 +1000
Message-Id: <20230731064839.7729-6-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731064839.7729-1-neilb@suse.de>
References: <20230731064839.7729-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that the last nfsd thread is stopped by an explicit act of calling
svc_set_num_threads() with a count of zero, we only have a limited
number of places that can happen, and don't need to call
nfsd_last_thread() in nfsd_put()

So separate that out and call it at the two places where the number of
threads is set to zero.

Move the clearing of ->nfsd_serv and the call to svc_xprt_destroy_all()
into nfsd_last_thread(), as they are really part of the same action.

nfsd_put() is now a thin wrapper around svc_put(), so make it a static inline.

nfsd_put() cannot be called after nfsd_last_thread(), so in a couple of
places we have to use svc_put() instead.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsd.h   |  7 ++++++-
 fs/nfsd/nfssvc.c | 52 ++++++++++++++++++------------------------------
 2 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index d88498f8b275..11c14faa6c67 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -96,7 +96,12 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-void		nfsd_put(struct net *net);
+static inline void nfsd_put(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	svc_put(nn->nfsd_serv);
+}
 
 bool		i_am_nfsd(void);
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 33a80725e14e..1582af33e204 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -542,9 +542,14 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 /* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
-static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
+static void nfsd_last_thread(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
+
+	spin_lock(&nfsd_notifier_lock);
+	nn->nfsd_serv = NULL;
+	spin_unlock(&nfsd_notifier_lock);
 
 	/* check if the notifier still has clients */
 	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
@@ -554,6 +559,8 @@ static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
 #endif
 	}
 
+	svc_xprt_destroy_all(serv, net);
+
 	/*
 	 * write_ports can create the server without actually starting
 	 * any threads--if we get shut down before any threads are
@@ -644,7 +651,8 @@ void nfsd_shutdown_threads(struct net *net)
 	svc_get(serv);
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
-	nfsd_put(net);
+	nfsd_last_thread(net);
+	svc_put(serv);
 	mutex_unlock(&nfsd_mutex);
 }
 
@@ -674,9 +682,6 @@ int nfsd_create_serv(struct net *net)
 	serv->sv_maxconn = nn->max_connections;
 	error = svc_bind(serv, net);
 	if (error < 0) {
-		/* NOT nfsd_put() as notifiers (see below) haven't
-		 * been set up yet.
-		 */
 		svc_put(serv);
 		return error;
 	}
@@ -719,29 +724,6 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 	return 0;
 }
 
-/* This is the callback for kref_put() below.
- * There is no code here as the first thing to be done is
- * call svc_shutdown_net(), but we cannot get the 'net' from
- * the kref.  So do all the work when kref_put returns true.
- */
-static void nfsd_noop(struct kref *ref)
-{
-}
-
-void nfsd_put(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
-		svc_xprt_destroy_all(nn->nfsd_serv, net);
-		nfsd_last_thread(nn->nfsd_serv, net);
-		svc_destroy(&nn->nfsd_serv->sv_refcnt);
-		spin_lock(&nfsd_notifier_lock);
-		nn->nfsd_serv = NULL;
-		spin_unlock(&nfsd_notifier_lock);
-	}
-}
-
 int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 {
 	int i = 0;
@@ -792,7 +774,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 		if (err)
 			break;
 	}
-	nfsd_put(net);
+	svc_put(nn->nfsd_serv);
 	return err;
 }
 
@@ -807,6 +789,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	int	error;
 	bool	nfsd_up_before;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	mutex_lock(&nfsd_mutex);
 	dprintk("nfsd: creating service\n");
@@ -826,22 +809,25 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 		goto out;
 
 	nfsd_up_before = nn->nfsd_net_up;
+	serv = nn->nfsd_serv;
 
 	error = nfsd_startup_net(net, cred);
 	if (error)
 		goto out_put;
-	error = svc_set_num_threads(nn->nfsd_serv, NULL, nrservs);
+	error = svc_set_num_threads(serv, NULL, nrservs);
 	if (error)
 		goto out_shutdown;
-	error = nn->nfsd_serv->sv_nrthreads;
+	error = serv->sv_nrthreads;
+	if (error == 0)
+		nfsd_last_thread(net);
 out_shutdown:
 	if (error < 0 && !nfsd_up_before)
 		nfsd_shutdown_net(net);
 out_put:
 	/* Threads now hold service active */
 	if (xchg(&nn->keep_active, 0))
-		nfsd_put(net);
-	nfsd_put(net);
+		svc_put(serv);
+	svc_put(serv);
 out:
 	mutex_unlock(&nfsd_mutex);
 	return error;
-- 
2.40.1

