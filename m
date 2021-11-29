Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB420460E2F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhK2E6v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 23:58:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42514 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbhK2E4v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:56:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C98CD1FD37;
        Mon, 29 Nov 2021 04:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SRODYG02CzjFzQL4XDmO8VeXkSyZ3ESGsTuHgv14Ty8=;
        b=QxA7JnSmuM2BorzvJ1VN94rP+o9dwAweNjVDkavmLJQVMf0vSj5LJgnc9fbbhBPT4Q9c+J
        i0pHGl/Puw7IjuDw1q4G5mk1cUb+SLtNGxud7DzbNosntH9pafyVEA++dMRUDPpGWdi9cE
        jhEev/KU3LeKgQnkJv5eSFGnSyGjiuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SRODYG02CzjFzQL4XDmO8VeXkSyZ3ESGsTuHgv14Ty8=;
        b=9ConAjxBB3pas1NDDiaAOI50x4SLnecjQv5uD9Ki+m1NtEfZIdMe9mXpwxLVrgmDqkv1VD
        4jH7ka7UyQdguRDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6C51133FE;
        Mon, 29 Nov 2021 04:53:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0r2/F8xcpGEnbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:53:32 +0000
Subject: [PATCH 12/20] lockd: simplify management of network status notifiers
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816148560.32298.7337359283781543353.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that the network status notifiers use nlmsvc_serv rather then
nlmsvc_rqst the management can be simplified.

Notifier unregistration synchronises with any pending notifications so
providing we unregister before nlm_serv is freed no further interlock
is required.

So we move the unregister call to just before the thread is killed
(which destroys the service) and just before the service is destroyed in
the failure-path of lockd_up().

Then nlm_ntf_refcnt and nlm_ntf_wq can be removed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c |   35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 83874878f41d..20cebb191350 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -59,9 +59,6 @@ static struct task_struct	*nlmsvc_task;
 static struct svc_rqst		*nlmsvc_rqst;
 unsigned long			nlmsvc_timeout;
 
-static atomic_t nlm_ntf_refcnt = ATOMIC_INIT(0);
-static DECLARE_WAIT_QUEUE_HEAD(nlm_ntf_wq);
-
 unsigned int lockd_net_id;
 
 /*
@@ -303,8 +300,7 @@ static int lockd_inetaddr_event(struct notifier_block *this,
 	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
 	struct sockaddr_in sin;
 
-	if ((event != NETDEV_DOWN) ||
-	    !atomic_inc_not_zero(&nlm_ntf_refcnt))
+	if (event != NETDEV_DOWN)
 		goto out;
 
 	if (nlmsvc_serv) {
@@ -314,8 +310,6 @@ static int lockd_inetaddr_event(struct notifier_block *this,
 		sin.sin_addr.s_addr = ifa->ifa_local;
 		svc_age_temp_xprts_now(nlmsvc_serv, (struct sockaddr *)&sin);
 	}
-	atomic_dec(&nlm_ntf_refcnt);
-	wake_up(&nlm_ntf_wq);
 
 out:
 	return NOTIFY_DONE;
@@ -332,8 +326,7 @@ static int lockd_inet6addr_event(struct notifier_block *this,
 	struct inet6_ifaddr *ifa = (struct inet6_ifaddr *)ptr;
 	struct sockaddr_in6 sin6;
 
-	if ((event != NETDEV_DOWN) ||
-	    !atomic_inc_not_zero(&nlm_ntf_refcnt))
+	if (event != NETDEV_DOWN)
 		goto out;
 
 	if (nlmsvc_serv) {
@@ -344,8 +337,6 @@ static int lockd_inet6addr_event(struct notifier_block *this,
 			sin6.sin6_scope_id = ifa->idev->dev->ifindex;
 		svc_age_temp_xprts_now(nlmsvc_serv, (struct sockaddr *)&sin6);
 	}
-	atomic_dec(&nlm_ntf_refcnt);
-	wake_up(&nlm_ntf_wq);
 
 out:
 	return NOTIFY_DONE;
@@ -362,14 +353,6 @@ static void lockd_unregister_notifiers(void)
 #if IS_ENABLED(CONFIG_IPV6)
 	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
 #endif
-	wait_event(nlm_ntf_wq, atomic_read(&nlm_ntf_refcnt) == 0);
-}
-
-static void lockd_svc_exit_thread(void)
-{
-	atomic_dec(&nlm_ntf_refcnt);
-	lockd_unregister_notifiers();
-	svc_exit_thread(nlmsvc_rqst);
 }
 
 static int lockd_start_svc(struct svc_serv *serv)
@@ -388,11 +371,9 @@ static int lockd_start_svc(struct svc_serv *serv)
 		printk(KERN_WARNING
 			"lockd_up: svc_rqst allocation failed, error=%d\n",
 			error);
-		lockd_unregister_notifiers();
 		goto out_rqst;
 	}
 
-	atomic_inc(&nlm_ntf_refcnt);
 	svc_sock_update_bufs(serv);
 	serv->sv_maxconn = nlm_max_connections;
 
@@ -410,7 +391,7 @@ static int lockd_start_svc(struct svc_serv *serv)
 	return 0;
 
 out_task:
-	lockd_svc_exit_thread();
+	svc_exit_thread(nlmsvc_rqst);
 	nlmsvc_task = NULL;
 out_rqst:
 	nlmsvc_rqst = NULL;
@@ -477,7 +458,6 @@ int lockd_up(struct net *net, const struct cred *cred)
 
 	error = lockd_up_net(serv, net, cred);
 	if (error < 0) {
-		lockd_unregister_notifiers();
 		goto err_put;
 	}
 
@@ -488,8 +468,10 @@ int lockd_up(struct net *net, const struct cred *cred)
 	}
 	nlmsvc_users++;
 err_put:
-	if (nlmsvc_users == 0)
+	if (nlmsvc_users == 0) {
+		lockd_unregister_notifiers();
 		nlmsvc_serv = NULL;
+	}
 	svc_put(serv);
 err_create:
 	mutex_unlock(&nlmsvc_mutex);
@@ -518,13 +500,14 @@ lockd_down(struct net *net)
 		printk(KERN_ERR "lockd_down: no lockd running.\n");
 		BUG();
 	}
+	lockd_unregister_notifiers();
 	kthread_stop(nlmsvc_task);
 	dprintk("lockd_down: service stopped\n");
-	lockd_svc_exit_thread();
+	svc_exit_thread(nlmsvc_rqst);
+	nlmsvc_rqst = NULL;
 	dprintk("lockd_down: service destroyed\n");
 	nlmsvc_serv = NULL;
 	nlmsvc_task = NULL;
-	nlmsvc_rqst = NULL;
 out:
 	mutex_unlock(&nlmsvc_mutex);
 }


