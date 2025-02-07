Return-Path: <linux-nfs+bounces-9949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6353EA2CE61
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D933AB27C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 20:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0460F1B415B;
	Fri,  7 Feb 2025 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGuD23zX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AFA1B4153
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960948; cv=none; b=Wig+Ed7pqOKUIjm/2EP0Wcz2YhxvY9dltl8fFMlCg7jz4bwfn4mz2VD5dolzOn2WWFt6tGF5TNEtRs9nFazDwGkQ7UkFzSPbkLP0P+YVcelcUnG1EzNBlkb6VA6096HhzMHxuaIwomlrcxkeB3sNd6Xf1X01DXb3vBkbZ3srim4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960948; c=relaxed/simple;
	bh=LGgk1JfU8J24EXQpVbCW39Bcqm4RwkYaRXTfGP0n8/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mipfQeauDYbpyutuABa6iIrDs3uPl3My928x88BWKYYMLsNs/fRjGE/WizoJD7G5QmELFMuOrXgyxtiXfKHB5VinET0OXyg8Wwk+ut58tkAIeUYx6G9vyTY9MbNr3PzWTmQcAfryCaiSB+mmK8QnKOWipMxvgG0TyHu6XGo1Bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGuD23zX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FE3C4AF09;
	Fri,  7 Feb 2025 20:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738960948;
	bh=LGgk1JfU8J24EXQpVbCW39Bcqm4RwkYaRXTfGP0n8/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kGuD23zXnsWcCeejbIVmsdfkM0iJI7zQCcR5njGi7uoC+ACKYTk5z0MeCVliEpek7
	 aCrB4PcfeXUyX7vwM/tXd58xRMr/vwiw/xKjyA4cm9HJW28eHD2Vx0Jo+Ph6DT0ZMR
	 8HYNwjAI7flzkg4BjM7ThM2nC72co1pPcjpWzP/uS8Dhfnn6+QmTzRzTrCsXgUwIqM
	 nO6dODHaHwuGeZkCKtzunJkwQHuKfSrfQhvOZZ6PomMgkxoROoqKuDa7Ms9UeXaRLL
	 s6V1A+J3tVK8bQbiudnPqQqtTGGcAZnqohQPrZBeLatozEfFlPrPA6uGBlTvVxLxn+
	 4TVkuoHcRV6bg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v3 4/5] sunrpc: Add a sysfs file for adding a new xprt
Date: Fri,  7 Feb 2025 15:42:24 -0500
Message-ID: <20250207204225.594002-5-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207204225.594002-1-anna@kernel.org>
References: <20250207204225.594002-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Writing to this file will clone the 'main' xprt of an xprt_switch and
add it to be used as an additional connection.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
--
v3: Replace call to xprt_iter_get_xprt() with xprt_iter_get_next()
---
 include/linux/sunrpc/xprtmultipath.h |  1 +
 net/sunrpc/sysfs.c                   | 54 ++++++++++++++++++++++++++++
 net/sunrpc/xprtmultipath.c           | 21 +++++++++++
 3 files changed, 76 insertions(+)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index e411368cdacf..e4db5022fe92 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -56,6 +56,7 @@ extern void rpc_xprt_switch_add_xprt(struct rpc_xprt_switch *xps,
 		struct rpc_xprt *xprt);
 extern void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
 		struct rpc_xprt *xprt, bool offline);
+extern struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_switch *xps);
 
 extern void xprt_iter_init(struct rpc_xprt_iter *xpi,
 		struct rpc_xprt_switch *xps);
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index dcd579eab50a..8fd1975f2fe8 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -305,6 +305,55 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
 	return ret;
 }
 
+static ssize_t rpc_sysfs_xprt_switch_add_xprt_show(struct kobject *kobj,
+						   struct kobj_attribute *attr,
+						   char *buf)
+{
+	return sprintf(buf, "# add one xprt to this xprt_switch\n");
+}
+
+static ssize_t rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *kobj,
+						    struct kobj_attribute *attr,
+						    const char *buf, size_t count)
+{
+	struct rpc_xprt_switch *xprt_switch =
+		rpc_sysfs_xprt_switch_kobj_get_xprt(kobj);
+	struct xprt_create xprt_create_args;
+	struct rpc_xprt *xprt, *new;
+
+	if (!xprt_switch)
+		return 0;
+
+	xprt = rpc_xprt_switch_get_main_xprt(xprt_switch);
+	if (!xprt)
+		goto out;
+
+	xprt_create_args.ident = xprt->xprt_class->ident;
+	xprt_create_args.net = xprt->xprt_net;
+	xprt_create_args.dstaddr = (struct sockaddr *)&xprt->addr;
+	xprt_create_args.addrlen = xprt->addrlen;
+	xprt_create_args.servername = xprt->servername;
+	xprt_create_args.bc_xprt = xprt->bc_xprt;
+	xprt_create_args.xprtsec = xprt->xprtsec;
+	xprt_create_args.connect_timeout = xprt->connect_timeout;
+	xprt_create_args.reconnect_timeout = xprt->max_reconnect_timeout;
+
+	new = xprt_create_transport(&xprt_create_args);
+	if (IS_ERR_OR_NULL(new)) {
+		count = PTR_ERR(new);
+		goto out_put_xprt;
+	}
+
+	rpc_xprt_switch_add_xprt(xprt_switch, new);
+	xprt_put(new);
+
+out_put_xprt:
+	xprt_put(xprt);
+out:
+	xprt_switch_put(xprt_switch);
+	return count;
+}
+
 static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
 					    struct kobj_attribute *attr,
 					    const char *buf, size_t count)
@@ -523,8 +572,13 @@ ATTRIBUTE_GROUPS(rpc_sysfs_xprt);
 static struct kobj_attribute rpc_sysfs_xprt_switch_info =
 	__ATTR(xprt_switch_info, 0444, rpc_sysfs_xprt_switch_info_show, NULL);
 
+static struct kobj_attribute rpc_sysfs_xprt_switch_add_xprt =
+	__ATTR(add_xprt, 0644, rpc_sysfs_xprt_switch_add_xprt_show,
+		rpc_sysfs_xprt_switch_add_xprt_store);
+
 static struct attribute *rpc_sysfs_xprt_switch_attrs[] = {
 	&rpc_sysfs_xprt_switch_info.attr,
+	&rpc_sysfs_xprt_switch_add_xprt.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(rpc_sysfs_xprt_switch);
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 7e98d4dd9f10..4c5e08b0aa64 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -92,6 +92,27 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
 	xprt_put(xprt);
 }
 
+/**
+ * rpc_xprt_switch_get_main_xprt - Get the 'main' xprt for an xprt switch.
+ * @xps: pointer to struct rpc_xprt_switch.
+ */
+struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_switch *xps)
+{
+	struct rpc_xprt_iter xpi;
+	struct rpc_xprt *xprt;
+
+	xprt_iter_init_listall(&xpi, xps);
+
+	xprt = xprt_iter_get_next(&xpi);
+	while (xprt && !xprt->main) {
+		xprt_put(xprt);
+		xprt = xprt_iter_get_next(&xpi);
+	}
+
+	xprt_iter_destroy(&xpi);
+	return xprt;
+}
+
 static DEFINE_IDA(rpc_xprtswitch_ids);
 
 void xprt_multipath_cleanup_ids(void)
-- 
2.48.1


