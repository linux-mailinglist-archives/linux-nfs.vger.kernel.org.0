Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC67460E39
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhK2FAK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 00:00:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42630 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhK2E6J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:58:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 189691FD39;
        Mon, 29 Nov 2021 04:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/DdyxV03d1CRB6Sivyn6NSZWUBIVAtjE4QQl7RMvgGI=;
        b=P1bsXjsp2se83YzmCQKqkvswfIcC7kFCoD1RufyLSNf8ikXKHOqRWyew3tJdWCDFmcQTgW
        FeJSYTHp8OOEORr/y7TjCmZBxvTSOBcwhADHYaid16bBq/iRbbAN4gf612iyRaNC9R+Vgh
        MdCREXCnbP2uPJbNHBEfHMrhWtfaL4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/DdyxV03d1CRB6Sivyn6NSZWUBIVAtjE4QQl7RMvgGI=;
        b=7cG7MwWyhC8SIkHPV99p8tC+TY0FhIP8MYFJ9CK1lMOs/UDk2gRnh+VKhS0TjAZfhrfxw1
        cZNPdqp2qs1sQSBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03BBA133FE;
        Mon, 29 Nov 2021 04:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oSy3LNdcpGE3bwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:53:43 +0000
Subject: [PATCH 14/20] lockd: move svc_exit_thread() into the thread
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816148561.32298.4688484272863440870.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The normal place to call svc_exit_thread() is from the thread itself
just before it exists.
Do this for lockd.

This means that nlmsvc_rqst is not used out side of lockd_start_svc(),
so it can be made local to that function, and renamed to 'rqst'.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 91e7c839841e..9aa499a76159 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -56,7 +56,6 @@ static DEFINE_MUTEX(nlmsvc_mutex);
 static unsigned int		nlmsvc_users;
 static struct svc_serv		*nlmsvc_serv;
 static struct task_struct	*nlmsvc_task;
-static struct svc_rqst		*nlmsvc_rqst;
 unsigned long			nlmsvc_timeout;
 
 unsigned int lockd_net_id;
@@ -182,6 +181,11 @@ lockd(void *vrqstp)
 	nlm_shutdown_hosts();
 	cancel_delayed_work_sync(&ln->grace_period_end);
 	locks_end_grace(&ln->lockd_manager);
+
+	dprintk("lockd_down: service stopped\n");
+
+	svc_exit_thread(rqstp);
+
 	return 0;
 }
 
@@ -358,13 +362,14 @@ static void lockd_unregister_notifiers(void)
 static int lockd_start_svc(struct svc_serv *serv)
 {
 	int error;
+	struct svc_rqst *rqst;
 
 	/*
 	 * Create the kernel thread and wait for it to start.
 	 */
-	nlmsvc_rqst = svc_prepare_thread(serv, &serv->sv_pools[0], NUMA_NO_NODE);
-	if (IS_ERR(nlmsvc_rqst)) {
-		error = PTR_ERR(nlmsvc_rqst);
+	rqst = svc_prepare_thread(serv, &serv->sv_pools[0], NUMA_NO_NODE);
+	if (IS_ERR(rqst)) {
+		error = PTR_ERR(rqst);
 		printk(KERN_WARNING
 			"lockd_up: svc_rqst allocation failed, error=%d\n",
 			error);
@@ -374,24 +379,23 @@ static int lockd_start_svc(struct svc_serv *serv)
 	svc_sock_update_bufs(serv);
 	serv->sv_maxconn = nlm_max_connections;
 
-	nlmsvc_task = kthread_create(lockd, nlmsvc_rqst, "%s", serv->sv_name);
+	nlmsvc_task = kthread_create(lockd, rqst, "%s", serv->sv_name);
 	if (IS_ERR(nlmsvc_task)) {
 		error = PTR_ERR(nlmsvc_task);
 		printk(KERN_WARNING
 			"lockd_up: kthread_run failed, error=%d\n", error);
 		goto out_task;
 	}
-	nlmsvc_rqst->rq_task = nlmsvc_task;
+	rqst->rq_task = nlmsvc_task;
 	wake_up_process(nlmsvc_task);
 
 	dprintk("lockd_up: service started\n");
 	return 0;
 
 out_task:
-	svc_exit_thread(nlmsvc_rqst);
+	svc_exit_thread(rqst);
 	nlmsvc_task = NULL;
 out_rqst:
-	nlmsvc_rqst = NULL;
 	return error;
 }
 
@@ -500,9 +504,6 @@ lockd_down(struct net *net)
 	}
 	lockd_unregister_notifiers();
 	kthread_stop(nlmsvc_task);
-	dprintk("lockd_down: service stopped\n");
-	svc_exit_thread(nlmsvc_rqst);
-	nlmsvc_rqst = NULL;
 	dprintk("lockd_down: service destroyed\n");
 	nlmsvc_serv = NULL;
 	nlmsvc_task = NULL;


