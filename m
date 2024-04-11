Return-Path: <linux-nfs+bounces-2761-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF98A1D18
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 20:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80001F221EE
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202B1C9EAC;
	Thu, 11 Apr 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6Oekipw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7694776A;
	Thu, 11 Apr 2024 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854075; cv=none; b=U99zKRhzBrZ5TE+QAR4nA++Y01WCB+6Vm338r+NAthyFawggoFKf3kBSpcTVMq+pQpgv5dfhTBeU2/RJkaMbqJgAzxcum+iLit8PczuXmXpsGw0qWPJ9A3QUMlV3C7vJl9TbHnJ6llI8EgYyZ57wC1IgEM1giBlC3v7uR34PTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854075; c=relaxed/simple;
	bh=maYb65/7SVX/4s9qjDYiJ8xqmtthQ1vPpO9pqDNHpts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7lt0cAot5nNNegDiD8HOeagZOojMrEykH/1mrDgU7fXDyuRW2rIeQ+6p5bcn9aNvBzZ/6wkz0isazAYAG94ZjN7IefwpzQvDDQS5QK+9Le+pUthvUiz7uUDbgJUsQab2mM0U8tnRRR5QTIBMD2GyZpVq64GidB4U72N9GfNoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6Oekipw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B05C072AA;
	Thu, 11 Apr 2024 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854074;
	bh=maYb65/7SVX/4s9qjDYiJ8xqmtthQ1vPpO9pqDNHpts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6OekipwGq/GLFxhCdJ2J2ogwQ2+c/iZ0wyNa3WGVNObEvlPTNIeUJ54xD4BRVoOb
	 NmLImo/xuKBmWb4zOwEj/kMG2uRfeAi3DqHzXkLtU/scB/uq0XmHQ6av8WqHA19X7J
	 j0uydGh+6ntBHJrwxKorq2LUzNB3VWDeElN/vGz3aBl1dhFAtUzM2KyY1N2+Z5qtBj
	 OmgbSuoOFRMhMXQs0ABijB8gVnf6oijT7lxjApERP31BXYeTKZZTWBHj/bZTR3M0Dr
	 nznpmdsQLGfq23k9uYjqvwBx59tty75Mt77GX8XCIegukBVIpTzT2er1bwf5M4MWwU
	 1ELyQ/qSgA/Kw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org
Subject: [PATCH v7 1/5] NFSD: convert write_threads to netlink command
Date: Thu, 11 Apr 2024 18:47:24 +0200
Message-ID: <d822328a8bdf7c796f6722139accba672466703a.1712853394.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712853393.git.lorenzo@kernel.org>
References: <cover.1712853393.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce write_threads netlink command similar to the one available
through the procfs.

Tested-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml | 23 ++++++++++
 fs/nfsd/netlink.c                     | 17 ++++++++
 fs/nfsd/netlink.h                     |  2 +
 fs/nfsd/nfsctl.c                      | 60 +++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  9 ++++
 5 files changed, 111 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 05acc73e2e33..c92e1425d316 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -62,6 +62,12 @@ attribute-sets:
         name: compound-ops
         type: u32
         multi-attr: true
+  -
+    name: server-worker
+    attributes:
+      -
+        name: threads
+        type: u32
 
 operations:
   list:
@@ -87,3 +93,20 @@ operations:
             - sport
             - dport
             - compound-ops
+    -
+      name: threads-set
+      doc: set the number of running threads
+      attribute-set: server-worker
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - threads
+    -
+      name: threads-get
+      doc: get the number of running threads
+      attribute-set: server-worker
+      do:
+        reply:
+          attributes:
+            - threads
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 0e1d635ec5f9..1a59a8e6c7e2 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -10,6 +10,11 @@
 
 #include <uapi/linux/nfsd_netlink.h>
 
+/* NFSD_CMD_THREADS_SET - do */
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_THREADS + 1] = {
+	[NFSD_A_SERVER_WORKER_THREADS] = { .type = NLA_U32, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -19,6 +24,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.done	= nfsd_nl_rpc_status_get_done,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NFSD_CMD_THREADS_SET,
+		.doit		= nfsd_nl_threads_set_doit,
+		.policy		= nfsd_threads_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_WORKER_THREADS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_THREADS_GET,
+		.doit	= nfsd_nl_threads_get_doit,
+		.flags	= GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index d83dd6bdee92..4137fac477e4 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -16,6 +16,8 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
 
 int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				  struct netlink_callback *cb);
+int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 93c87587e646..71608744e67f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1651,6 +1651,66 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
 	return 0;
 }
 
+/**
+ * nfsd_nl_threads_set_doit - set the number of running threads
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	u32 nthreads;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_WORKER_THREADS))
+		return -EINVAL;
+
+	nthreads = nla_get_u32(info->attrs[NFSD_A_SERVER_WORKER_THREADS]);
+	ret = nfsd_svc(nthreads,
+		       genl_info_net(info), get_current_cred());
+
+	return ret == nthreads ? 0 : -EINVAL;
+}
+
+/**
+ * nfsd_nl_threads_get_doit - get the number of running threads
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	void *hdr;
+	int err;
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(skb, info);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(skb, NFSD_A_SERVER_WORKER_THREADS,
+			nfsd_nrthreads(genl_info_net(info)))) {
+		err = -EINVAL;
+		goto err_free_msg;
+	}
+
+	genlmsg_end(skb, hdr);
+
+	return genlmsg_reply(skb, info);
+
+err_free_msg:
+	nlmsg_free(skb);
+
+	return err;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 3cd044edee5d..1b6fe1f9ed0e 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -29,8 +29,17 @@ enum {
 	NFSD_A_RPC_STATUS_MAX = (__NFSD_A_RPC_STATUS_MAX - 1)
 };
 
+enum {
+	NFSD_A_SERVER_WORKER_THREADS = 1,
+
+	__NFSD_A_SERVER_WORKER_MAX,
+	NFSD_A_SERVER_WORKER_MAX = (__NFSD_A_SERVER_WORKER_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
+	NFSD_CMD_THREADS_SET,
+	NFSD_CMD_THREADS_GET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
-- 
2.44.0


