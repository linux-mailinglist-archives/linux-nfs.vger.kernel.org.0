Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3F4599C6
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhKWBfE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:35:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37146 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBfD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:35:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C33151FD39;
        Tue, 23 Nov 2021 01:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtR+h2/SHobdjw6xJn7imJnV1Ye8cBQSZWUn0dvaWP0=;
        b=1wE+Hz64io3doMFsE20ksU8FEnbMPYk81v6fgkhfhbL6XZJrcW3WKYoqaYSpNzHEXIk4El
        kGpgp01bf6q6AZLsiY5xGPM6lIBX6FAnsZirJPYOYrHyyAidy8mDcu1lu6x1xKpOc+nMvd
        iEZNBEu8GSDuoumE1r2TnQ6UWC9fKWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtR+h2/SHobdjw6xJn7imJnV1Ye8cBQSZWUn0dvaWP0=;
        b=r2qHKE8SpiDY5C2MYeCXe+/v4tS2OjgpCTU9gYpDmJATWGAGVXwh9M9ITDkrG71wq99QHQ
        zb2ke9Rc6QclAoBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C85613BD4;
        Tue, 23 Nov 2021 01:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QrBzFYpEnGHwcwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:31:54 +0000
Subject: [PATCH 10/19] lockd: introduce nlmsvc_serv
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097547.7284.4982400127908906020.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

lockd has two globals - nlmsvc_task and nlmsvc_rqst - but mostly it
wants the 'struct svc_serv', and when it doesn't want it exactly it can
get to what it wants from the serv.

This patch is a first step to removing nlmsvc_task and nlmsvc_rqst.  It
introduces nlmsvc_serv to store the 'struct svc_serv*'.  This is set as
soon as the serv is created, and cleared only when it is destroyed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index a9669b106dbd..83874878f41d 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -54,6 +54,7 @@ EXPORT_SYMBOL_GPL(nlmsvc_ops);
 
 static DEFINE_MUTEX(nlmsvc_mutex);
 static unsigned int		nlmsvc_users;
+static struct svc_serv		*nlmsvc_serv;
 static struct task_struct	*nlmsvc_task;
 static struct svc_rqst		*nlmsvc_rqst;
 unsigned long			nlmsvc_timeout;
@@ -306,13 +307,12 @@ static int lockd_inetaddr_event(struct notifier_block *this,
 	    !atomic_inc_not_zero(&nlm_ntf_refcnt))
 		goto out;
 
-	if (nlmsvc_rqst) {
+	if (nlmsvc_serv) {
 		dprintk("lockd_inetaddr_event: removed %pI4\n",
 			&ifa->ifa_local);
 		sin.sin_family = AF_INET;
 		sin.sin_addr.s_addr = ifa->ifa_local;
-		svc_age_temp_xprts_now(nlmsvc_rqst->rq_server,
-			(struct sockaddr *)&sin);
+		svc_age_temp_xprts_now(nlmsvc_serv, (struct sockaddr *)&sin);
 	}
 	atomic_dec(&nlm_ntf_refcnt);
 	wake_up(&nlm_ntf_wq);
@@ -336,14 +336,13 @@ static int lockd_inet6addr_event(struct notifier_block *this,
 	    !atomic_inc_not_zero(&nlm_ntf_refcnt))
 		goto out;
 
-	if (nlmsvc_rqst) {
+	if (nlmsvc_serv) {
 		dprintk("lockd_inet6addr_event: removed %pI6\n", &ifa->addr);
 		sin6.sin6_family = AF_INET6;
 		sin6.sin6_addr = ifa->addr;
 		if (ipv6_addr_type(&sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL)
 			sin6.sin6_scope_id = ifa->idev->dev->ifindex;
-		svc_age_temp_xprts_now(nlmsvc_rqst->rq_server,
-			(struct sockaddr *)&sin6);
+		svc_age_temp_xprts_now(nlmsvc_serv, (struct sockaddr *)&sin6);
 	}
 	atomic_dec(&nlm_ntf_refcnt);
 	wake_up(&nlm_ntf_wq);
@@ -423,15 +422,17 @@ static const struct svc_serv_ops lockd_sv_ops = {
 	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
 };
 
-static struct svc_serv *lockd_create_svc(void)
+static int lockd_create_svc(void)
 {
 	struct svc_serv *serv;
 
 	/*
 	 * Check whether we're already up and running.
 	 */
-	if (nlmsvc_rqst)
-		return svc_get(nlmsvc_rqst->rq_server);
+	if (nlmsvc_serv) {
+		svc_get(nlmsvc_serv);
+		return 0;
+	}
 
 	/*
 	 * Sanity check: if there's no pid,
@@ -448,14 +449,15 @@ static struct svc_serv *lockd_create_svc(void)
 	serv = svc_create(&nlmsvc_program, LOCKD_BUFSIZE, &lockd_sv_ops);
 	if (!serv) {
 		printk(KERN_WARNING "lockd_up: create service failed\n");
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
+	nlmsvc_serv = serv;
 	register_inetaddr_notifier(&lockd_inetaddr_notifier);
 #if IS_ENABLED(CONFIG_IPV6)
 	register_inet6addr_notifier(&lockd_inet6addr_notifier);
 #endif
 	dprintk("lockd_up: service created\n");
-	return serv;
+	return 0;
 }
 
 /*
@@ -468,11 +470,10 @@ int lockd_up(struct net *net, const struct cred *cred)
 
 	mutex_lock(&nlmsvc_mutex);
 
-	serv = lockd_create_svc();
-	if (IS_ERR(serv)) {
-		error = PTR_ERR(serv);
+	error = lockd_create_svc();
+	if (error)
 		goto err_create;
-	}
+	serv = nlmsvc_serv;
 
 	error = lockd_up_net(serv, net, cred);
 	if (error < 0) {
@@ -487,6 +488,8 @@ int lockd_up(struct net *net, const struct cred *cred)
 	}
 	nlmsvc_users++;
 err_put:
+	if (nlmsvc_users == 0)
+		nlmsvc_serv = NULL;
 	svc_put(serv);
 err_create:
 	mutex_unlock(&nlmsvc_mutex);
@@ -501,7 +504,7 @@ void
 lockd_down(struct net *net)
 {
 	mutex_lock(&nlmsvc_mutex);
-	lockd_down_net(nlmsvc_rqst->rq_server, net);
+	lockd_down_net(nlmsvc_serv, net);
 	if (nlmsvc_users) {
 		if (--nlmsvc_users)
 			goto out;
@@ -519,6 +522,7 @@ lockd_down(struct net *net)
 	dprintk("lockd_down: service stopped\n");
 	lockd_svc_exit_thread();
 	dprintk("lockd_down: service destroyed\n");
+	nlmsvc_serv = NULL;
 	nlmsvc_task = NULL;
 	nlmsvc_rqst = NULL;
 out:


