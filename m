Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1C4599C8
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhKWBfO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:35:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37156 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBfN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:35:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54AE71FD39;
        Tue, 23 Nov 2021 01:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksD387RvbGGdsJFIycbu4bFM8cYLiuD6K1tfwfwYy6I=;
        b=bv/gm5u5JXxB77g1NpnjfEWiPFJSRc0lZPhhSaXw7prVctCqoEKIRx4Nwdm+zQPGw40lYp
        fMaPnx18uPp3aYTM0fXBsOOSOtS6eHwye+nUiyP9QVzQMjP90rhIoQ/lm0uFsmlhJ0Nbbp
        5fi1mlT7/jWVRZhlvSq2ALQX8XYU+hQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631125;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksD387RvbGGdsJFIycbu4bFM8cYLiuD6K1tfwfwYy6I=;
        b=26yYGND/GKnHEEdidBfkpYwd84n8KWsWAX8j4qnXVjvbcb7mlV/qGyyT++YjqvyOo0shMg
        G/fujogjcbOnZCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 387CD13BD4;
        Tue, 23 Nov 2021 01:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5i8uOZNEnGEEdAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:32:03 +0000
Subject: [PATCH 12/19] lockd: move lockd_start_svc() call into
 lockd_create_svc()
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097548.7284.17750816308590904344.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

lockd_start_svc() only needs to be called once, just after the svc is
created.  If the start fails, the svc is discarded too.

It thus makes sense to call lockd_start_svc() from lockd_create_svc().
This allows us to remove the test against nlmsvc_rqst at the start of
lockd_start_svc() - it must always be NULL.

lockd_up() only held an extra reference on the svc until a thread was
created - then it dropped it.  The thread - and thus the extra reference
- will remain until kthread_stop() is called.
Now that the thread is created in lockd_create_svc(), the extra
reference can be dropped there.  So the 'serv' variable is no longer
needed in lockd_up().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 20cebb191350..91e7c839841e 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -359,9 +359,6 @@ static int lockd_start_svc(struct svc_serv *serv)
 {
 	int error;
 
-	if (nlmsvc_rqst)
-		return 0;
-
 	/*
 	 * Create the kernel thread and wait for it to start.
 	 */
@@ -406,6 +403,7 @@ static const struct svc_serv_ops lockd_sv_ops = {
 static int lockd_create_svc(void)
 {
 	struct svc_serv *serv;
+	int error;
 
 	/*
 	 * Check whether we're already up and running.
@@ -432,6 +430,13 @@ static int lockd_create_svc(void)
 		printk(KERN_WARNING "lockd_up: create service failed\n");
 		return -ENOMEM;
 	}
+
+	error = lockd_start_svc(serv);
+	/* The thread now holds the only reference */
+	svc_put(serv);
+	if (error < 0)
+		return error;
+
 	nlmsvc_serv = serv;
 	register_inetaddr_notifier(&lockd_inetaddr_notifier);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -446,7 +451,6 @@ static int lockd_create_svc(void)
  */
 int lockd_up(struct net *net, const struct cred *cred)
 {
-	struct svc_serv *serv;
 	int error;
 
 	mutex_lock(&nlmsvc_mutex);
@@ -454,25 +458,19 @@ int lockd_up(struct net *net, const struct cred *cred)
 	error = lockd_create_svc();
 	if (error)
 		goto err_create;
-	serv = nlmsvc_serv;
 
-	error = lockd_up_net(serv, net, cred);
+	error = lockd_up_net(nlmsvc_serv, net, cred);
 	if (error < 0) {
 		goto err_put;
 	}
 
-	error = lockd_start_svc(serv);
-	if (error < 0) {
-		lockd_down_net(serv, net);
-		goto err_put;
-	}
 	nlmsvc_users++;
 err_put:
 	if (nlmsvc_users == 0) {
 		lockd_unregister_notifiers();
+		kthread_stop(nlmsvc_task);
 		nlmsvc_serv = NULL;
 	}
-	svc_put(serv);
 err_create:
 	mutex_unlock(&nlmsvc_mutex);
 	return error;


