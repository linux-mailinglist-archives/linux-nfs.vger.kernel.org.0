Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790DA3A04D7
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhFHUBd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhFHUBc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:01:32 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B216C061574
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 12:59:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id k11so19848019qkk.1
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M75J5gxIYaLCC3K7GTU61NltQHpX1UepCv+SiagOXio=;
        b=X/aZ5uVcuLG7++5Yt6o10Xb2AhBmduQO/0m6iDUZkzUAGt5lgmZtu7T8KK9ShYIIMz
         tTi1bh/D8OQGie1tKPoYcLBe4K6w1bNSUPDnxMOQAieO68rCLCYR8mlpiaxHX0uiuogx
         /XZNMklzajbdcwVypZ5tMh/3jY4L8K5q1MrAtZkP00gMx9c3k+uyeFUmmQAuB8GreWUN
         NqT9fURqmtSHAaGWiksI5bIghUewIWxnTq+9LMIl86tVwWrMKvSLwnjmwhUWMROQC8yz
         ZBwF63m1tNwne7fGQEgpKFe3XnGZ587SAQo717ck7CM3Z4ua7PrqSdznt3wDNPJfZZWv
         xtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M75J5gxIYaLCC3K7GTU61NltQHpX1UepCv+SiagOXio=;
        b=o+83YlgC35Qcu04WzbDaSAenvTMezWLU/oJ8khSKY/eI+MeFEA81/GQC+jQcySN10W
         br0sqMF9u4MZFTlzRowe1q+rzmly0ctxfMoQdVJAZtyXfe4jsFF33CpFjAO8DDxpCCkt
         B6tlCGBXl0s81Ta0ipCBDZQ1AuVHFHe6XElQ7mYEUiJ/P0fNYQ/lrX5NJr2Q0Ntfp42A
         Nt3W/xtASgmxp/jLAIa4ut2Ut/NHazOkxsU9PXO6r9tFp14VQ7ZWdgOGIDr5LKaM+LsQ
         7uF5PPmViBIy7KAzMAFbgj2Ld7wqDVBOyjTj1EyFBuZYSiVCIxiY8Yl7KPmLUIVFRvUj
         0lzQ==
X-Gm-Message-State: AOAM531tWUSoIAQ6ua3e/Ifz1HemZ/8TKC2m1iv6skIjvjQ+Hr0G1j6m
        J83RxEGa8oEnA7vh3RUuk/cjqI2qX9Q=
X-Google-Smtp-Source: ABdhPJxd8YjUkUnY8EMnBM7LXJ1PGjNG6Iis7ewlj3oaEYIg3bIHhqADByxRIll8b2MprxmirhvEAw==
X-Received: by 2002:a37:6c03:: with SMTP id h3mr23069361qkc.474.1623182378684;
        Tue, 08 Jun 2021 12:59:38 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:38 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 10/13] sunrpc: add dst_attr attributes to the sysfs xprt directory
Date:   Tue,  8 Jun 2021 15:59:19 -0400
Message-Id: <20210608195922.88655-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
References: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c          | 105 ++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprt.c           |   4 +-
 net/sunrpc/xprtmultipath.c  |   2 -
 4 files changed, 109 insertions(+), 3 deletions(-)

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
index 20f75708594f..402924bbd743 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -4,8 +4,23 @@
  */
 #include <linux/sunrpc/clnt.h>
 #include <linux/kobject.h>
+#include <linux/sunrpc/addr.h>
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
 
@@ -43,6 +58,87 @@ static struct kobject *rpc_sysfs_object_alloc(const char *name,
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
+	size_t buf_len;
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
+	/* buf_len is the len until the first occurence of either
+	 * '\n' or '\0'
+	 */
+	buf_len = strcspn(buf, "\n");
+
+	dst_addr = kstrndup(buf, buf_len, GFP_KERNEL);
+	if (!dst_addr)
+		goto out_err;
+	saved_addr = kzalloc(sizeof(*saved_addr), GFP_KERNEL);
+	if (!saved_addr)
+		goto out_err_free;
+	saved_addr->addr =
+		rcu_dereference_raw(xprt->address_strings[RPC_DISPLAY_ADDR]);
+	rcu_assign_pointer(xprt->address_strings[RPC_DISPLAY_ADDR], dst_addr);
+	call_rcu(&saved_addr->rcu, free_xprt_addr);
+	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, buf_len, saddr,
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
@@ -106,6 +202,14 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
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
@@ -120,6 +224,7 @@ static struct kobj_type rpc_sysfs_xprt_switch_type = {
 
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

