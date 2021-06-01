Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC29F397C43
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 00:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhFAWLb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 18:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbhFAWL3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 18:11:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F477C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  1 Jun 2021 15:09:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id u30so432047qke.7
        for <linux-nfs@vger.kernel.org>; Tue, 01 Jun 2021 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xD9h/pDNgtlnfY6yZc0kDjgxTQYtRgVOzX2sDLdN2M=;
        b=a4bkPaILa6wRiMmRndb4rGAIg6SBdN8ei8S3Or3veL01nCD5FyhG5YRg0of6dUgfeZ
         e9Mdj+WOcAXSCo8rs/MS7kx1IuIexehYLV8/HXZQst3yMkr2GfdTdJ9cdGYouu/n8dX8
         wkFJHJCpho8oT0XUvAt6+2vKWbxQ3gmkuiBBVgA/a1Hf6e4yGepjcr2zXmcJif+pzYSt
         icoojvqQc239eeUkhjFqluSz7yRAhl8kPflJ9albH8sfdczhBZ95cvkxTvOpsziIvhHH
         MUtOe1YuCMTpyWWTSXN+EzK8sIykh9wR5QYbo2Tsu794AdVe2vgiKvoxAwdqI9Csudff
         H6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xD9h/pDNgtlnfY6yZc0kDjgxTQYtRgVOzX2sDLdN2M=;
        b=tW2aaMX09aHvr1e+z7hOneOfLMgyBZ8wSgmR45DVVlG3va62wQ32dHT9EQr43gbDwv
         6IJx07kyAWGiW0EcdBSMyhrIosjve3bmDhwaMsdRh1oWT1aZ+zhHqs2sr5XiAr30UHI3
         M5Teu87q+8JGPPfTYMrvpClGtU+oUYrTIo8Fj2qqfy7Cp2b6rPkxIHX0bYXKZ+P/VmRb
         p0LlfYFebfBmlkPDQo6F0hhQr+fQDVZVJwRxFUBtUUdJ24lUcfYm34ReXwO5hvCMtYA8
         kQ8PT6VOUsjv1mMeJAzLQVsNQIxMhLDtLcVDo7VYocV9m4wbK4V4oJcwplOkUMskePNK
         DrtQ==
X-Gm-Message-State: AOAM532wNgQ4YJ7qo3ZlSQ8S3DaIt8u+d+eTaO2yEPnt8PpURz+fuH4V
        nQDxm6cD49z3FuILFdNU91SxTsDlOKY=
X-Google-Smtp-Source: ABdhPJw/ec8FtfxPml5nIVFi+DbojS3NwTOtVGWSgxsmZSJiNAhoLdk5+PXUcE4kIgS6iR2f35WcDQ==
X-Received: by 2002:a05:620a:248c:: with SMTP id i12mr24604354qkn.56.1622585386290;
        Tue, 01 Jun 2021 15:09:46 -0700 (PDT)
Received: from kolga-mac-1.lan (50-124-240-218.alma.mi.frontiernet.net. [50.124.240.218])
        by smtp.gmail.com with ESMTPSA id q13sm12419789qkn.10.2021.06.01.15.09.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 15:09:45 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 10/13] sunrpc: add dst_attr attributes to the sysfs xprt directory
Date:   Tue,  1 Jun 2021 18:09:12 -0400
Message-Id: <20210601220915.18975-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
References: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Allow to query and set the destination's address of a transport.
Setting of the destination address is allowed only for TCP or RDMA
based connections.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h |   1 +
 net/sunrpc/sysfs.c          | 100 ++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprt.c           |   4 +-
 net/sunrpc/xprtmultipath.c  |   2 -
 4 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 8360db664e5f..13a4eaf385cf 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -414,6 +414,7 @@ void			xprt_conditional_disconnect(struct rpc_xprt *xprt, unsigned int cookie);
 
 bool			xprt_lock_connect(struct rpc_xprt *, struct rpc_task *, void *);
 void			xprt_unlock_connect(struct rpc_xprt *, void *);
+void			xprt_release_write(struct rpc_xprt *, struct rpc_task *);
 
 /*
  * Reserved bit positions in xprt->state
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 20f75708594f..f330148433c8 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -4,8 +4,24 @@
  */
 #include <linux/sunrpc/clnt.h>
 #include <linux/kobject.h>
+#include <linux/sunrpc/addr.h>
+#include <linux/sunrpc/xprtsock.h>
+
 #include "sysfs.h"
 
+struct xprt_addr {
+	const char *addr;
+	struct rcu_head rcu;
+};
+
+static void free_xprt_addr(struct rcu_head *head)
+{
+	struct xprt_addr *addr = container_of(head, struct xprt_addr, rcu);
+
+	kfree(addr->addr);
+	kfree(addr);
+}
+
 static struct kset *rpc_sunrpc_kset;
 static struct kobject *rpc_sunrpc_client_kobj, *rpc_sunrpc_xprt_switch_kobj;
 
@@ -43,6 +59,81 @@ static struct kobject *rpc_sysfs_object_alloc(const char *name,
 	return NULL;
 }
 
+static inline struct rpc_xprt *
+rpc_sysfs_xprt_kobj_get_xprt(struct kobject *kobj)
+{
+	struct rpc_sysfs_xprt *x = container_of(kobj,
+		struct rpc_sysfs_xprt, kobject);
+
+	return xprt_get(x->xprt);
+}
+
+static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *buf)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	ssize_t ret;
+
+	if (!xprt)
+		return 0;
+	ret = sprintf(buf, "%s\n", xprt->address_strings[RPC_DISPLAY_ADDR]);
+	xprt_put(xprt);
+	return ret + 1;
+}
+
+static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	struct sockaddr *saddr;
+	char *dst_addr;
+	int port;
+	struct xprt_addr *saved_addr;
+
+	if (!xprt)
+		return 0;
+	if (!(xprt->xprt_class->ident == XPRT_TRANSPORT_TCP ||
+	      xprt->xprt_class->ident == XPRT_TRANSPORT_RDMA)) {
+		xprt_put(xprt);
+		return -EOPNOTSUPP;
+	}
+
+	if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE)) {
+		count = -EINTR;
+		goto out_put;
+	}
+	saddr = (struct sockaddr *)&xprt->addr;
+	port = rpc_get_port(saddr);
+
+	dst_addr = kstrndup(buf, count - 1, GFP_KERNEL);
+	if (!dst_addr)
+		goto out_err;
+	saved_addr = kzalloc(sizeof(*saved_addr), GFP_KERNEL);
+	if (!saved_addr)
+		goto out_err_free;
+	saved_addr->addr =
+		rcu_dereference_raw(xprt->address_strings[RPC_DISPLAY_ADDR]);
+	rcu_assign_pointer(xprt->address_strings[RPC_DISPLAY_ADDR], dst_addr);
+	call_rcu(&saved_addr->rcu, free_xprt_addr);
+	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr,
+				 sizeof(*saddr));
+	rpc_set_port(saddr, port);
+
+	xprt_force_disconnect(xprt);
+out:
+	xprt_release_write(xprt, NULL);
+out_put:
+	xprt_put(xprt);
+	return count;
+out_err_free:
+	kfree(dst_addr);
+out_err:
+	count = -ENOMEM;
+	goto out;
+}
+
 int rpc_sysfs_init(void)
 {
 	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
@@ -106,6 +197,14 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
 			    kobject)->xprt->xprt_net;
 }
 
+static struct kobj_attribute rpc_sysfs_xprt_dstaddr = __ATTR(dstaddr,
+	0644, rpc_sysfs_xprt_dstaddr_show, rpc_sysfs_xprt_dstaddr_store);
+
+static struct attribute *rpc_sysfs_xprt_attrs[] = {
+	&rpc_sysfs_xprt_dstaddr.attr,
+	NULL,
+};
+
 static struct kobj_type rpc_sysfs_client_type = {
 	.release = rpc_sysfs_client_release,
 	.sysfs_ops = &kobj_sysfs_ops,
@@ -120,6 +219,7 @@ static struct kobj_type rpc_sysfs_xprt_switch_type = {
 
 static struct kobj_type rpc_sysfs_xprt_type = {
 	.release = rpc_sysfs_xprt_release,
+	.default_attrs = rpc_sysfs_xprt_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_namespace,
 };
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 20b9bd705014..fb6db09725c7 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -55,6 +55,7 @@
 #include <trace/events/sunrpc.h>
 
 #include "sunrpc.h"
+#include "sysfs.h"
 
 /*
  * Local variables
@@ -443,7 +444,7 @@ void xprt_release_xprt_cong(struct rpc_xprt *xprt, struct rpc_task *task)
 }
 EXPORT_SYMBOL_GPL(xprt_release_xprt_cong);
 
-static inline void xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *task)
+void xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *task)
 {
 	if (xprt->snd_task != task)
 		return;
@@ -1812,6 +1813,7 @@ void xprt_free(struct rpc_xprt *xprt)
 	put_net(xprt->xprt_net);
 	xprt_free_all_slots(xprt);
 	xprt_free_id(xprt);
+	rpc_sysfs_xprt_destroy(xprt);
 	kfree_rcu(xprt, rcu);
 }
 EXPORT_SYMBOL_GPL(xprt_free);
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index e7973c1ff70c..07e76ae1028a 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -86,7 +86,6 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
 	spin_lock(&xps->xps_lock);
 	xprt_switch_remove_xprt_locked(xps, xprt);
 	spin_unlock(&xps->xps_lock);
-	rpc_sysfs_xprt_destroy(xprt);
 	xprt_put(xprt);
 }
 
@@ -155,7 +154,6 @@ static void xprt_switch_free_entries(struct rpc_xprt_switch *xps)
 				struct rpc_xprt, xprt_switch);
 		xprt_switch_remove_xprt_locked(xps, xprt);
 		spin_unlock(&xps->xps_lock);
-		rpc_sysfs_xprt_destroy(xprt);
 		xprt_put(xprt);
 		spin_lock(&xps->xps_lock);
 	}
-- 
2.27.0

