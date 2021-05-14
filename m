Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2FD380B47
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhENOOt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhENOOs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:14:48 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFEBC061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:36 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n10so28199856ion.8
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dI5JmqOCH3zdvyNCM0nA9u52lgtFDyX2MgVbj/R1zLM=;
        b=pjGeN7kVtEfX3nbUc3JKjYgFFUwS8zAD7WB1a+P8XJlqdDdJ8y4Qcrdb7oPE/xLUNP
         lLVeBmhynNDgSIw63iHDcDprIftbObUPpfkev2fbqt7oTvDLe6nG9Y/YbatW6qAvRxd7
         0oWUC7SwYIv/Mmk/lWUNClfTXwkq3vUesc9kOqy0ZqJYyIEUbNMcCGup8xo0eRjSykg4
         kP0cQR24wcduefaI1SdxqKODJwJeVVKTWqZBHFAjqP/5FC+sQb1By0pyKwoXtv5tARQL
         C+PqzbXCLvT6ISlzMJnUYGSbQqdvEv9YRjxDjNTAhgQ5tKVlEjcxZfTAZyYYYrTvmpBj
         bc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dI5JmqOCH3zdvyNCM0nA9u52lgtFDyX2MgVbj/R1zLM=;
        b=OpaycNk3At8BcZYLLql+jtCu0kX17fJDpsnMGZDEmhyAemnw/hIeHt0lQi06StzLIv
         bZNyJX9UKy/uouaXm32JuF1+1qDlWiCaqMDpGRT7rzwKDDSv0+S2fHx2/q/2dt8MK57R
         8rIepvrB7Ms1LwGtG6Qdy2Ne3lJ5TdG1/6cV6hn7a9s0yAWV2wIKHM/UP11g6PEiNdtL
         CP1zs1LNNCgUFac3f4t/S2uFavhVcUDbn1nqwYg+RZt/FEz/npnTa5ck/3X3Q/dx8AE3
         08AAXR9A81ft5TPgPdfeyZjWpUlaCF1RyBdWwZZaL1raVPOEGz86fMmYI5fdAql9lY9l
         ZkdQ==
X-Gm-Message-State: AOAM5317LWgeBnyCdSrjRUa7y6Ex0LRt/1oPVcUkqPeT68lIcVbTUjiS
        iFwH18F125l7I5Zcee3Q6b2xMFkLzVS1fg==
X-Google-Smtp-Source: ABdhPJwsAK/VhKFlxypoqwEZ6jExQV+OHZNhayDOP1jmTsnztgNgn/4Qh7ksKg1DVwySxPbligdZpg==
X-Received: by 2002:a5e:c202:: with SMTP id v2mr12934361iop.89.1621001616263;
        Fri, 14 May 2021 07:13:36 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4f7:32c8:9c05:11a7])
        by smtp.gmail.com with ESMTPSA id b189sm2639263iof.48.2021.05.14.07.13.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 07:13:35 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 10/12] sunrpc: add dst_attr attributes to the sysfs xprt directory
Date:   Fri, 14 May 2021 10:13:21 -0400
Message-Id: <20210514141323.67922-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/xprt.c           |   2 +-
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 823663c6380a..579c42901fc8 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -412,6 +412,7 @@ void			xprt_conditional_disconnect(struct rpc_xprt *xprt, unsigned int cookie);
 
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
index fd58a3a16add..b9beb7fc453d 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -442,7 +442,7 @@ void xprt_release_xprt_cong(struct rpc_xprt *xprt, struct rpc_task *task)
 }
 EXPORT_SYMBOL_GPL(xprt_release_xprt_cong);
 
-static inline void xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *task)
+void xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *task)
 {
 	if (xprt->snd_task != task)
 		return;
-- 
2.27.0

