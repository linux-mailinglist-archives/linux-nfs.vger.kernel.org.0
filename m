Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379B53768AF
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhEGQ0x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238120AbhEGQ0h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:37 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ADCC06138B
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:31 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h6so8133041ila.7
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKYLS33mtmiZ4uB3Jw+Cjsvv5friV9+9CrD6SJSul48=;
        b=kM0HpLP0utpTXEedqmQdJCBzMjCuGupEWGYU9f6GpFq8InZ9bi34pv0SVtZVBcrcj9
         P5OWRRli1VwbSAiO3qly/Om27tHDf7zYg6vRUmT7SG1Vgy2Am1B0oQ0f0S0BPcqJLoqP
         OPxemDvJJX0qFB0sqtS7YWp1LGwupMb2sHHUzysY2dY4s3Nf/dL1d5if1Iv2Tnf6IpdQ
         ZA24G7LR6fAwLsUBgM+lsE5uryfxmgDdE5ExQL/xMwh4LvtlZImFA0J0eNjWZKH4FrF1
         GgSGjJBrsVaZmXT/AgRf3ZLsjwH8Xo5KxMNNyd288Jzf1izKiYgF5IZXMGqkb9ZMLIMY
         po7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKYLS33mtmiZ4uB3Jw+Cjsvv5friV9+9CrD6SJSul48=;
        b=jl1tZ1AHrRs3MuXCs1sWaIRZyu4sAgaHifQm2aMrADIOF16dGGWqbnzyTED9bLw6k2
         hu/GdcflwYmwG/Jgy8YRJ+yvMQKUjGznHTbfGsaizp9o7tQKIHK98Y1TG+oIPTEq0V3J
         5v6kWbuayAYitkAHNX1kUFQlaIwbp7y3xuTFfF3g6YdxuicM9xPC93O7MKi9yD5vp4nd
         z6ksi/OBS5J0+2cQMgVL8jul3nlMo/m55crB2JpJIBbivhZGGsxuY+Fx1sJpVatGOnSj
         yWDbjcnrOI9jySiMfHNKR9QGoZeW0HkU52/tbfgZ0heF0t4Z3D7br0vXxzYyPRBAGrma
         KcwQ==
X-Gm-Message-State: AOAM531DfzJ/oAx9npPzyvrt5hviGNAsTltoPzAjT6rqlJhhZ+bEgvYZ
        nGTe1g/EN4gF/VOWPsA/y9GyhpH3uM3Dng==
X-Google-Smtp-Source: ABdhPJzukpLEyyLCJUGuDE4fsnJsTKDgo210KOkgTnFsyO3NkEsD3X2x8X0Kdzi7NUudRI7VP9WK5g==
X-Received: by 2002:a92:603:: with SMTP id x3mr10005744ilg.215.1620404730862;
        Fri, 07 May 2021 09:25:30 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:30 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 10/12] sunrpc: add dst_attr attributes to the sysfs xprt directory
Date:   Fri,  7 May 2021 12:25:16 -0400
Message-Id: <20210507162518.51520-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
References: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
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
index 78c0ff879424..a622a97c602d 100644
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

