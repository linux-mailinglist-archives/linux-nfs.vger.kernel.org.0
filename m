Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59B453D4D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 01:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhKQAus (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 19:50:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43436 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhKQAus (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 19:50:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF8B81FCA3;
        Wed, 17 Nov 2021 00:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637110069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeDiznDVv3CLcbTtcvLOqPO5YZ7qIY+CCuOmCnLva+k=;
        b=WwD7FOU+A/q0FCNSqHC0Nc69zENPfXKZlTlts7ZXNPLtwy1vytvLvIk9AxcyzIyhMMzhki
        TKzI770pyhp7yhZEuideAjnCx+i5Vp3xQkhSykMdFayGU4cyxqUNtJ+MHNgAnEdmd9c4Y5
        S3NCE9Y+a7I9/o8f3qM1cao2erwNNSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637110069;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeDiznDVv3CLcbTtcvLOqPO5YZ7qIY+CCuOmCnLva+k=;
        b=hmu0IFMakE6JTsTkxnEc4o4zWDf91WtPfHxq36ORtyguzs7iO44KrTt1Hnio3QA0XNlliA
        oLbTB7GaTQ7baTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C612613BC1;
        Wed, 17 Nov 2021 00:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZyRzLjNRlGFbWgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Nov 2021 00:47:47 +0000
Subject: [PATCH 07/14] NFSD: simplify locking for network notifier.
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 17 Nov 2021 11:46:50 +1100
Message-ID: <163711001004.5485.5399311117838750208.stgit@noble.brown>
In-Reply-To: <163710954700.5485.5622638225352156964.stgit@noble.brown>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd currently maintains an open-coded read/write semaphore (refcount
and wait queue) for each network namespace to ensure the nfs service
isn't shut down while the notifier is running.

This is excessive.  As there is unlikely to be contention between
notifiers and they run without sleeping, a single spinlock is sufficient
to avoid problems.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/netns.h  |    3 ---
 fs/nfsd/nfsctl.c |    2 --
 fs/nfsd/nfssvc.c |   38 ++++++++++++++++++++------------------
 3 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 1fd59eb0730b..021acdc0d03b 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -131,9 +131,6 @@ struct nfsd_net {
 	 */
 	int keep_active;
 
-	wait_queue_head_t ntf_wq;
-	atomic_t ntf_refcnt;
-
 	/*
 	 * clientid and stateid data for construction of net unique COPY
 	 * stateids.
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 22dbd638f6c8..28c26429988e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1482,8 +1482,6 @@ static __net_init int nfsd_init_net(struct net *net)
 	nn->clientid_counter = nn->clientid_base + 1;
 	nn->s2s_cp_cl_id = nn->clientid_counter++;
 
-	atomic_set(&nn->ntf_refcnt, 0);
-	init_waitqueue_head(&nn->ntf_wq);
 	seqlock_init(&nn->boot_lock);
 
 	return 0;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 37408b644607..e00dc1172786 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -434,6 +434,7 @@ static void nfsd_shutdown_net(struct net *net)
 	nfsd_shutdown_generic();
 }
 
+DEFINE_SPINLOCK(nfsd_notifier_lock);
 static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
 	void *ptr)
 {
@@ -443,18 +444,17 @@ static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct sockaddr_in sin;
 
-	if ((event != NETDEV_DOWN) ||
-	    !atomic_inc_not_zero(&nn->ntf_refcnt))
+	if (event != NETDEV_DOWN || !nn->nfsd_serv)
 		goto out;
 
+	spin_lock(&nfsd_notifier_lock);
 	if (nn->nfsd_serv) {
 		dprintk("nfsd_inetaddr_event: removed %pI4\n", &ifa->ifa_local);
 		sin.sin_family = AF_INET;
 		sin.sin_addr.s_addr = ifa->ifa_local;
 		svc_age_temp_xprts_now(nn->nfsd_serv, (struct sockaddr *)&sin);
 	}
-	atomic_dec(&nn->ntf_refcnt);
-	wake_up(&nn->ntf_wq);
+	spin_unlock(&nfsd_notifier_lock);
 
 out:
 	return NOTIFY_DONE;
@@ -474,10 +474,10 @@ static int nfsd_inet6addr_event(struct notifier_block *this,
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct sockaddr_in6 sin6;
 
-	if ((event != NETDEV_DOWN) ||
-	    !atomic_inc_not_zero(&nn->ntf_refcnt))
+	if (event != NETDEV_DOWN || !nn->nfsd_serv)
 		goto out;
 
+	spin_lock(&nfsd_notifier_lock);
 	if (nn->nfsd_serv) {
 		dprintk("nfsd_inet6addr_event: removed %pI6\n", &ifa->addr);
 		sin6.sin6_family = AF_INET6;
@@ -486,8 +486,8 @@ static int nfsd_inet6addr_event(struct notifier_block *this,
 			sin6.sin6_scope_id = ifa->idev->dev->ifindex;
 		svc_age_temp_xprts_now(nn->nfsd_serv, (struct sockaddr *)&sin6);
 	}
-	atomic_dec(&nn->ntf_refcnt);
-	wake_up(&nn->ntf_wq);
+	spin_unlock(&nfsd_notifier_lock);
+
 out:
 	return NOTIFY_DONE;
 }
@@ -504,7 +504,6 @@ static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	atomic_dec(&nn->ntf_refcnt);
 	/* check if the notifier still has clients */
 	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
 		unregister_inetaddr_notifier(&nfsd_inetaddr_notifier);
@@ -512,7 +511,6 @@ static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
 		unregister_inet6addr_notifier(&nfsd_inet6addr_notifier);
 #endif
 	}
-	wait_event(nn->ntf_wq, atomic_read(&nn->ntf_refcnt) == 0);
 
 	/*
 	 * write_ports can create the server without actually starting
@@ -624,6 +622,7 @@ int nfsd_create_serv(struct net *net)
 {
 	int error;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	WARN_ON(!mutex_is_locked(&nfsd_mutex));
 	if (nn->nfsd_serv) {
@@ -633,21 +632,23 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	nn->nfsd_serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize,
-						&nfsd_thread_sv_ops);
-	if (nn->nfsd_serv == NULL)
+	serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize,
+				 &nfsd_thread_sv_ops);
+	if (serv == NULL)
 		return -ENOMEM;
 
-	nn->nfsd_serv->sv_maxconn = nn->max_connections;
-	error = svc_bind(nn->nfsd_serv, net);
+	serv->sv_maxconn = nn->max_connections;
+	error = svc_bind(serv, net);
 	if (error < 0) {
 		/* NOT nfsd_put() as notifiers (see below) haven't
 		 * been set up yet.
 		 */
-		svc_put(nn->nfsd_serv);
-		nn->nfsd_serv = NULL;
+		svc_put(serv);
 		return error;
 	}
+	spin_lock(&nfsd_notifier_lock);
+	nn->nfsd_serv = serv;
+	spin_unlock(&nfsd_notifier_lock);
 
 	set_max_drc();
 	/* check if the notifier is already set */
@@ -657,7 +658,6 @@ int nfsd_create_serv(struct net *net)
 		register_inet6addr_notifier(&nfsd_inet6addr_notifier);
 #endif
 	}
-	atomic_inc(&nn->ntf_refcnt);
 	nfsd_reset_boot_verifier(nn);
 	svc_get(nn->nfsd_serv);
 	return 0;
@@ -702,7 +702,9 @@ void nfsd_put(struct net *net)
 	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
 		svc_shutdown_net(nn->nfsd_serv, net);
 		svc_destroy(&nn->nfsd_serv->sv_refcnt);
+		spin_lock(&nfsd_notifier_lock);
 		nn->nfsd_serv = NULL;
+		spin_unlock(&nfsd_notifier_lock);
 	}
 }
 


