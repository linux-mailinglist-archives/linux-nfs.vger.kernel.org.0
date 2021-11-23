Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766644599CA
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhKWBf1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:35:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57932 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhKWBf1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:35:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 857A4218B0;
        Tue, 23 Nov 2021 01:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/3zS1w9XPAB0sKrywf5beu0ueeIr7R6pDKbEKsXTPc=;
        b=beNwV92Z7vpxYnolbpkMahjFsLukUlosgj+lCH/qLdZvuFJaajGtGZPjjBXM7G88z62xb5
        o7j/D1WvDlz7CZ8UBAmCLdPz41TURaQmATY6WoKsNfr/ePX+2F3SPmeT0WA1ONtuJqJbd2
        yFleOze1ueCFp3ylrfikMbAS1BGv6sE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631139;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/3zS1w9XPAB0sKrywf5beu0ueeIr7R6pDKbEKsXTPc=;
        b=KEOU1eO74MOkTelgioGA/zG1cfvgvc6blYXyOxdUw3JiGcGUYtvqYl0dRIhPHXEmnjDDI1
        6AQqxTwCVgOPbQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7193E13BD4;
        Tue, 23 Nov 2021 01:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Iuj3C6JEnGETdAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:32:18 +0000
Subject: [PATCH 14/19] lockd: introduce lockd_put()
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097549.7284.13864576118395419236.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is some cleanup that is duplicated in lockd_down() and the failure
path of lockd_up().
Factor these out into a new lockd_put() and call it from both places.

lockd_put() does *not* take the mutex - that must be held by the caller.
It decrements nlmsvc_users and if that reaches zero, it cleans up.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c |   64 ++++++++++++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 9aa499a76159..7f12c280fd30 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -351,14 +351,6 @@ static struct notifier_block lockd_inet6addr_notifier = {
 };
 #endif
 
-static void lockd_unregister_notifiers(void)
-{
-	unregister_inetaddr_notifier(&lockd_inetaddr_notifier);
-#if IS_ENABLED(CONFIG_IPV6)
-	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
-#endif
-}
-
 static int lockd_start_svc(struct svc_serv *serv)
 {
 	int error;
@@ -450,6 +442,27 @@ static int lockd_create_svc(void)
 	return 0;
 }
 
+static void lockd_put(void)
+{
+	if (WARN(nlmsvc_users <= 0, "lockd_down: no users!\n"))
+		return;
+	if (--nlmsvc_users)
+		return;
+
+	unregister_inetaddr_notifier(&lockd_inetaddr_notifier);
+#if IS_ENABLED(CONFIG_IPV6)
+	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
+#endif
+
+	if (nlmsvc_task) {
+		kthread_stop(nlmsvc_task);
+		dprintk("lockd_down: service stopped\n");
+		nlmsvc_task = NULL;
+	}
+	nlmsvc_serv = NULL;
+	dprintk("lockd_down: service destroyed\n");
+}
+
 /*
  * Bring up the lockd process if it's not already up.
  */
@@ -461,21 +474,16 @@ int lockd_up(struct net *net, const struct cred *cred)
 
 	error = lockd_create_svc();
 	if (error)
-		goto err_create;
+		goto err;
+	nlmsvc_users++;
 
 	error = lockd_up_net(nlmsvc_serv, net, cred);
 	if (error < 0) {
-		goto err_put;
+		lockd_put();
+		goto err;
 	}
 
-	nlmsvc_users++;
-err_put:
-	if (nlmsvc_users == 0) {
-		lockd_unregister_notifiers();
-		kthread_stop(nlmsvc_task);
-		nlmsvc_serv = NULL;
-	}
-err_create:
+err:
 	mutex_unlock(&nlmsvc_mutex);
 	return error;
 }
@@ -489,25 +497,7 @@ lockd_down(struct net *net)
 {
 	mutex_lock(&nlmsvc_mutex);
 	lockd_down_net(nlmsvc_serv, net);
-	if (nlmsvc_users) {
-		if (--nlmsvc_users)
-			goto out;
-	} else {
-		printk(KERN_ERR "lockd_down: no users! task=%p\n",
-			nlmsvc_task);
-		BUG();
-	}
-
-	if (!nlmsvc_task) {
-		printk(KERN_ERR "lockd_down: no lockd running.\n");
-		BUG();
-	}
-	lockd_unregister_notifiers();
-	kthread_stop(nlmsvc_task);
-	dprintk("lockd_down: service destroyed\n");
-	nlmsvc_serv = NULL;
-	nlmsvc_task = NULL;
-out:
+	lockd_put();
 	mutex_unlock(&nlmsvc_mutex);
 }
 EXPORT_SYMBOL_GPL(lockd_down);


