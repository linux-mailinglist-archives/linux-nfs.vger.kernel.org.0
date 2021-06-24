Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488E53B257A
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 05:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFXDbU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 23:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFXDbU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 23:31:20 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6E1C061756
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:29:01 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a6so6209460ioe.0
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaXOH9viw4AlOcNpHDVEcNVeb68SygmlHfuqV9aPO9I=;
        b=cohvp/bUsdBeM4aNzTbLJ9lFg1z+RNEFgzMUx1BMm7+xmg9OAVqXbv5g66rdrVnBrG
         1k4SusJN1Xq1Oish6Jj0vcoBnO0G9RyO0ofby3tqcOz/pnZFCjDhhrpY1TLDRHsdTY/X
         bADJs17R+8v+K8fyOgGJ2m2hUl9/WN5iOd7WzFRqXFJsCaik0ovwzsWjGxW4ryzTRCHj
         /4R3G90dQtT1VlVmq5QLT95UC1UENhyhZeUMZD8EAts+8XeQ2U/OU6ifLGGNjZQk7yXE
         8xQDLtF1lIhyRV3uWUORwcxFOfA/CmvZmABOW+Y6+IXo/3fZV8o2ms5qu7qGDXdtLtWS
         FOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaXOH9viw4AlOcNpHDVEcNVeb68SygmlHfuqV9aPO9I=;
        b=U36YwMLua+CRih1KNKh5rtwnLeTtj/YEjgYMHa9lTphn9De0RIgf2uCFFfzGh5oRTb
         mLU3ditNyoYzftyNFAtTxXZ1BoqAEH8ycTCrzSiIuhdRmntqTLBMIAFnovsFAL1fkEtO
         SRwsYTUL181Icrg9MyUqIfkPxLn19jkZeH2FewvNdqWtPrARf5MGkwcl0AjyZBB45bM/
         CBTL4JYukMbiC1vx5w2ryOi/Y6+/CGZaDOpcHD8WLae1gg78uAesihEHhVvRqi9H04pa
         8N1jhWDNcerysl+CPmmN+rNqckpj5Y+9MvZTRNv9UNDeU15oK/KI66R+fdlHTak5CwsT
         87gA==
X-Gm-Message-State: AOAM530p2g8lDqFS9OmgM5hZGSgEHzP3l5H2U+Q8t/uftsUM7aNufQN4
        wM39LXMXU/5UT9X90G9AHwE=
X-Google-Smtp-Source: ABdhPJyRQ2ozDl6FOB6dQXcEHRI4e89qvU4R3wUlJEz+M92byxE0eMXPB8GFruzy7ul3bCA642NOxA==
X-Received: by 2002:a6b:fe0e:: with SMTP id x14mr2300373ioh.79.1624505341306;
        Wed, 23 Jun 2021 20:29:01 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd18:15dc:e0e4:e39e])
        by smtp.gmail.com with ESMTPSA id g4sm1026780ilk.37.2021.06.23.20.29.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 20:29:00 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/8] SUNRPC: take a xprt offline using sysfs
Date:   Wed, 23 Jun 2021 23:28:50 -0400
Message-Id: <20210624032853.4776-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
References: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Using sysfs's xprt_state attribute, mark a particular transport offline.
It will not be picked during the round-robin selection. It's not allowed
to take the main (1st created transport associated with the rpc_client)
offline. Also bring a transport back online via sysfs by writing "online"
and that would allow for this transport to be picked during the round-
robin selection.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h |  1 +
 net/sunrpc/sysfs.c          | 66 ++++++++++++++++++++++++++++++++++---
 net/sunrpc/sysfs.h          |  1 +
 net/sunrpc/xprtmultipath.c  |  6 ++--
 4 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 692e5946c029..b8ed7fa1b4ca 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -427,6 +427,7 @@ void			xprt_release_write(struct rpc_xprt *, struct rpc_task *);
 #define XPRT_BOUND		(4)
 #define XPRT_BINDING		(5)
 #define XPRT_CLOSING		(6)
+#define XPRT_OFFLINE		(7)
 #define XPRT_CONGESTED		(9)
 #define XPRT_CWND_WAIT		(10)
 #define XPRT_WRITE_SPACE	(11)
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 816f543d4237..e66888cc4c14 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -68,6 +68,15 @@ rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
 	return xprt_get(x->xprt);
 }
 
+static inline struct rpc_xprt_switch *
+rpc_sysfs_xprt_kobj_get_xprt_switch(struct kobject *kobj)
+{
+	struct rpc_sysfs_xprt *x = container_of(kobj,
+		struct rpc_sysfs_xprt, kobject);
+
+	return xprt_switch_get(x->xprt_switch);
+}
+
 static inline struct rpc_xprt_switch *
 rpc_sysfs_xprt_switch_kobj_get_xprt(struct kobject *kobj)
 {
@@ -122,7 +131,7 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	ssize_t ret;
 	int locked, connected, connecting, close_wait, bound, binding,
-	    closing, congested, cwnd_wait, write_space;
+	    closing, congested, cwnd_wait, write_space, offline;
 
 	if (!xprt)
 		return 0;
@@ -140,8 +149,9 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 		congested = test_bit(XPRT_CONGESTED, &xprt->state);
 		cwnd_wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
 		write_space = test_bit(XPRT_WRITE_SPACE, &xprt->state);
+		offline = test_bit(XPRT_OFFLINE, &xprt->state);
 
-		ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s %s\n",
+		ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s %s %s\n",
 			      locked ? "LOCKED" : "",
 			      connected ? "CONNECTED" : "",
 			      connecting ? "CONNECTING" : "",
@@ -151,7 +161,8 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 			      closing ? "CLOSING" : "",
 			      congested ? "CONGESTED" : "",
 			      cwnd_wait ? "CWND_WAIT" : "",
-			      write_space ? "WRITE_SPACE" : "");
+			      write_space ? "WRITE_SPACE" : "",
+			      offline ? "OFFLINE" : "");
 	}
 
 	xprt_put(xprt);
@@ -235,6 +246,52 @@ static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
 	goto out;
 }
 
+static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	int offline = 0, online = 0;
+	struct rpc_xprt_switch *xps = rpc_sysfs_xprt_kobj_get_xprt_switch(kobj);
+
+	if (!xprt)
+		return 0;
+
+	if (!strncmp(buf, "offline", 7))
+		offline = 1;
+	else if (!strncmp(buf, "online", 6))
+		online = 1;
+	else
+		return -EINVAL;
+
+	if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE)) {
+		count = -EINTR;
+		goto out_put;
+	}
+	if (xprt->main) {
+		count = -EINVAL;
+		goto release_tasks;
+	}
+	if (offline) {
+		set_bit(XPRT_OFFLINE, &xprt->state);
+		spin_lock(&xps->xps_lock);
+		xps->xps_nactive--;
+		spin_unlock(&xps->xps_lock);
+	} else if (online) {
+		clear_bit(XPRT_OFFLINE, &xprt->state);
+		spin_lock(&xps->xps_lock);
+		xps->xps_nactive++;
+		spin_unlock(&xps->xps_lock);
+	}
+
+release_tasks:
+	xprt_release_write(xprt, NULL);
+out_put:
+	xprt_put(xprt);
+	xprt_switch_put(xps);
+	return count;
+}
+
 int rpc_sysfs_init(void)
 {
 	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
@@ -305,7 +362,7 @@ static struct kobj_attribute rpc_sysfs_xprt_info = __ATTR(xprt_info,
 	0444, rpc_sysfs_xprt_info_show, NULL);
 
 static struct kobj_attribute rpc_sysfs_xprt_change_state = __ATTR(xprt_state,
-	0644, rpc_sysfs_xprt_state_show, NULL);
+	0644, rpc_sysfs_xprt_state_show, rpc_sysfs_xprt_state_change);
 
 static struct attribute *rpc_sysfs_xprt_attrs[] = {
 	&rpc_sysfs_xprt_dstaddr.attr,
@@ -468,6 +525,7 @@ void rpc_sysfs_xprt_setup(struct rpc_xprt_switch *xprt_switch,
 	if (rpc_xprt) {
 		xprt->xprt_sysfs = rpc_xprt;
 		rpc_xprt->xprt = xprt;
+		rpc_xprt->xprt_switch = xprt_switch;
 		kobject_uevent(&rpc_xprt->kobject, KOBJ_ADD);
 	}
 }
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
index ff10451de6fa..6620cebd1037 100644
--- a/net/sunrpc/sysfs.h
+++ b/net/sunrpc/sysfs.h
@@ -22,6 +22,7 @@ struct rpc_sysfs_xprt_switch {
 struct rpc_sysfs_xprt {
 	struct kobject kobject;
 	struct rpc_xprt *xprt;
+	struct rpc_xprt_switch *xprt_switch;
 };
 
 int rpc_sysfs_init(void);
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 584349c8cad4..7d40cdf81274 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -65,7 +65,8 @@ static void xprt_switch_remove_xprt_locked(struct rpc_xprt_switch *xps,
 {
 	if (unlikely(xprt == NULL))
 		return;
-	xps->xps_nactive--;
+	if (!test_bit(XPRT_OFFLINE, &xprt->state))
+		xps->xps_nactive--;
 	xps->xps_nxprts--;
 	if (xps->xps_nxprts == 0)
 		xps->xps_net = NULL;
@@ -231,7 +232,8 @@ void xprt_iter_default_rewind(struct rpc_xprt_iter *xpi)
 static
 bool xprt_is_active(const struct rpc_xprt *xprt)
 {
-	return kref_read(&xprt->kref) != 0;
+	return (kref_read(&xprt->kref) != 0 &&
+		!test_bit(XPRT_OFFLINE, &xprt->state));
 }
 
 static
-- 
2.27.0

