Return-Path: <linux-nfs+bounces-8987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C4A06740
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6BB3A61A5
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2972040B7;
	Wed,  8 Jan 2025 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAv9WFwA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B820408A
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372195; cv=none; b=NZgHhfFYGnPPuZ/K7nVO0DS6OMXJ1Q9w76y41Z7xlfcBAiYHrG3b9sxqt/xRq+Dre3cJcmhLzYzN6dvj62tsmY1kqRe2fgmYmVNeca7G3WvOobvYhjKIB9aWqjgHvg1xUOlRObqDW4KaL4RUMatjos6w73a8OV2z/biH/RMc7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372195; c=relaxed/simple;
	bh=MyXCNbnyTPJEVaJEYjeQQs5km6ICGwQITW6f87vuOeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liMa6YbsFQzwnPnCbJ0nt58RAbMOPmnzqf7CMkJuJAa4cCaLBkKw34Qr/kwdhED2SBhuuFb1HHOKHLQmHpr/0dcOflFfdFf+SIcNs+9f3m050ZWjq/ZVPp9KPr+jzs3ViKAgJuGOEGRiElMhfAxOj5hgaP7yCesJ2C8KClLaSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAv9WFwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02697C4CEE2;
	Wed,  8 Jan 2025 21:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372195;
	bh=MyXCNbnyTPJEVaJEYjeQQs5km6ICGwQITW6f87vuOeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uAv9WFwA3XJGbaVaUNNQAZN0NfBER+Z6Gst7AR9HmZO1W+qfDL6kkTS6cFrjlRCDx
	 rXYTi92XevJJnsSU2lo2MokXDFJOT614QvJJZnI+1V52kVsMmQS7zEiU4KCEkIRYaU
	 De5nHeXxCIVdgeaYICgX07eiA6rRAoVQnvha9TUrcZgrJMZXjhkYi96H6jscH8pTK3
	 zINDiLkFKXY3nBWvaAK7EWCtncXkutWhS9l1MrzILQW9NUb9KpGqG6rigvFEMgxroz
	 MA5i9IzfMc3EZWvPCjJ/pS7m8Wq3ldCd9VO2WYbXtzHkV076czGNKpBlVJJT5Kt1Sh
	 zI4ARY5M92XZw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 3/3] sunrpc: Add a sysfs file for adding a new xprt
Date: Wed,  8 Jan 2025 16:36:32 -0500
Message-ID: <20250108213632.260498-4-anna@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108213632.260498-1-anna@kernel.org>
References: <20250108213632.260498-1-anna@kernel.org>
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

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 include/linux/sunrpc/xprtmultipath.h |  1 +
 net/sunrpc/sysfs.c                   | 54 ++++++++++++++++++++++++++++
 net/sunrpc/xprtmultipath.c           | 21 +++++++++++
 3 files changed, 76 insertions(+)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index c0514c684b2c..c827c6ef0bc5 100644
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
index dc3b7cd70000..ce7dae140770 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -250,6 +250,55 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
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
@@ -451,8 +500,13 @@ ATTRIBUTE_GROUPS(rpc_sysfs_xprt);
 static struct kobj_attribute rpc_sysfs_xprt_switch_info =
 	__ATTR(xprt_switch_info, 0444, rpc_sysfs_xprt_switch_info_show, NULL);
 
+static struct kobj_attribute rpc_sysfs_xprt_switch_add_xprt =
+	__ATTR(xprt_switch_add_xprt, 0644, rpc_sysfs_xprt_switch_add_xprt_show,
+		rpc_sysfs_xprt_switch_add_xprt_store);
+
 static struct attribute *rpc_sysfs_xprt_switch_attrs[] = {
 	&rpc_sysfs_xprt_switch_info.attr,
+	&rpc_sysfs_xprt_switch_add_xprt.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(rpc_sysfs_xprt_switch);
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 720d3ba742ec..a07b81ce93c3 100644
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
+	xprt = xprt_iter_get_xprt(&xpi);
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
2.47.1


