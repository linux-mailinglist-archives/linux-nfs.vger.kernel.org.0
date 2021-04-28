Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3468136E0FF
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Apr 2021 23:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhD1VdI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Apr 2021 17:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhD1VdH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Apr 2021 17:33:07 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F4EC06138C
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:20 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id z2so28212133qkb.9
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLekTvxobSQ6+oTt34AkXgwZSXUp+mWS4nVt6ovQ0yI=;
        b=KQCZ+oGG4pOyXVB55zvlk9TIOWJvcHwdox1aCnhRLuPQqvVPI+L0GzORTGuzhPyqqX
         YBF9+Yv5fgIj63ZBJidah9YLXwqD0P4jtY8lZ3Ch4qkwm2Df+y1FPdQdO946RBfqcMFi
         srr1cPocMEDvbRVWCiEefxstm03Q5PXttJzM9XN3qvk6QNCXhtzOgHxw3ruc+lh+6Att
         1mTJfftmrfo1sxymLVqQxusBJ1VExf4txmmdq9M6/JMysRfpbmLyhU1pUPQdZjioIj1e
         AFNcv0GSqfI/uSCYduGlVa+JRIp/8vgh9d3pwSrpKvZ72xwE2GQu+OVjyKQwggQfFBe4
         inog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLekTvxobSQ6+oTt34AkXgwZSXUp+mWS4nVt6ovQ0yI=;
        b=P0X8OqVdjy0ooK4LuuJRWsONNVMxrFUJTbRpeD06nM30sixDh00MuIFLN5rzTQKG+L
         P479KPMc1t2bzh8LHjLja48FZ32KLsgR0ovZQdMBgpoOHnVWxtosn6nTlNvfqu3OFP8p
         JMYY63nmpwPXlmRGtnTutGIMPjTudRn+lwncbYEgGRKgfngZ2Mdk7PtUDCv1FSxTbqTS
         CW2LHUKrT2y1Zq50+yoEh/PNBLeQwTBPypGkzaDkOVH6VGYgVhgpis7YDWu2j2BW5EFf
         Avfj6Uu0xx3ye5ao1RiwqNFQx6TirWjLjYGt0VelJ/kpcMdTaEXSLeH3Lkosf2a8hERA
         h0QA==
X-Gm-Message-State: AOAM53189LhRz4R7moYbBsXr2gtL52/t6wXP0i/pRMGiEiLdtpOfpt8N
        /sewijF5tZKCuwkj7KZ901w=
X-Google-Smtp-Source: ABdhPJwjG6Y5Bybo3hJXK2pZNfCTpFv5g/5nQloJy9KAetWeglTissy2Y+45Mxa8A93joMjVTrU4OA==
X-Received: by 2002:a37:42c3:: with SMTP id p186mr31409504qka.352.1619645539937;
        Wed, 28 Apr 2021 14:32:19 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id v3sm710269qkb.124.2021.04.28.14.32.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:32:19 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 11/13] sunrpc: add dst_attr attributes to the sysfs xprt directory
Date:   Wed, 28 Apr 2021 17:32:01 -0400
Message-Id: <20210428213203.40059-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
References: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/sysfs.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 78c0ff879424..234e545a7a40 100644
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
 
@@ -43,6 +59,69 @@ static struct kobject *rpc_sysfs_object_alloc(const char *name,
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
+	wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE);
+	saddr = (struct sockaddr *)&xprt->addr;
+	port = rpc_get_port(saddr);
+
+	dst_addr = kstrndup(buf, count - 1, GFP_KERNEL);
+	saved_addr = kzalloc(sizeof(*saved_addr), GFP_KERNEL);
+	if (!saved_addr)
+		goto out;
+	saved_addr->addr = xprt->address_strings[RPC_DISPLAY_ADDR];
+	rcu_assign_pointer(xprt->address_strings[RPC_DISPLAY_ADDR], dst_addr);
+	call_rcu(&saved_addr->rcu, free_xprt_addr);
+	xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr,
+				 sizeof(*saddr));
+	rpc_set_port(saddr, port);
+
+	xprt->ops->connect(xprt, NULL);
+out:
+	clear_bit(XPRT_LOCKED, &xprt->state);
+	xprt_put(xprt);
+	return count;
+}
+
 int rpc_sysfs_init(void)
 {
 	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
@@ -106,6 +185,14 @@ static const void *rpc_sysfs_xprt_namespace(struct kobject *kobj)
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
@@ -120,6 +207,7 @@ static struct kobj_type rpc_sysfs_xprt_switch_type = {
 
 static struct kobj_type rpc_sysfs_xprt_type = {
 	.release = rpc_sysfs_xprt_release,
+	.default_attrs = rpc_sysfs_xprt_attrs,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = rpc_sysfs_xprt_namespace,
 };
-- 
2.27.0

