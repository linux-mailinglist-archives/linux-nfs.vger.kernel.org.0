Return-Path: <linux-nfs+bounces-2826-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151738A5B8F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 21:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3869D1C22095
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF9A15CD5D;
	Mon, 15 Apr 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOQGybru"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ECF156997;
	Mon, 15 Apr 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210329; cv=none; b=apRYSgPvOQ9tPcMW3zswvA11+S3gJ2cCJQTfJg23dGeUu7KorHyZTeQL2q5bWAH1vajDmXfFn+4UW7ERImBS+h7XNEU3ldzDHuJOBuOTb/xlO0G5rT9/VagFHs0dgioFhK8SrXa+rYWL3PxcirdQvzgnjTh9vgx3JNIamgrTuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210329; c=relaxed/simple;
	bh=YzZyTZ6laH16VDOPaBXcnHJFtK1KqYmNpuOjW9U82po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JC/3fmfjnoy1gLKqBe0OZAaBG+EyFjnGNI6zINNFy25Z15+65K/B3cRl+8UmRccwzeCoX7zFPQrGTrQ5rTGpQtPOe/iYq5mwlIDbXlt2Qc1z+xHJcBcn+vWw471x7NVJd37f5CmwQ4lFa0DOIVWU1grZss3sUpFO4Jug45JxdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOQGybru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5685C113CC;
	Mon, 15 Apr 2024 19:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713210329;
	bh=YzZyTZ6laH16VDOPaBXcnHJFtK1KqYmNpuOjW9U82po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOQGybru9rotjWM5PJ0QeYy2p82Im0ZSvKUGBWwMP590fAy+E3CpN9LS7hGpTXecD
	 EyZr4+NCT39zfrJpn0sr3vpasWusXGa4Er0+y0Ai9V2seCHoVO1PrEhJw1t/ZP8J4m
	 3EwrpreUeWFR02mEJAIbBiwnE1nIN4L7VfPw8MEbVlq4s2UyYwtM0fc61CUXn//a9g
	 fO28v1UFl9aJSIT8UCQm1B8zYtJS8SgColoFLblAbcAEm2YP+P71FfYL+Km7qEKRAa
	 3+qRBbkOcYwb+YU4uCeU5y1nugZC8hL7sC8cIKlMc9Qfp8G4afv5TRJ12t2P3WMabw
	 BKXNnCw04VClA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v8 6/6] NFSD: add listener-{set,get} netlink command
Date: Mon, 15 Apr 2024 21:44:39 +0200
Message-ID: <a4a74f6dd08157f4c7e561cf8e316374b843b294.1713209938.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713209938.git.lorenzo@kernel.org>
References: <cover.1713209938.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce write_ports netlink command. For listener-set, userspace is
expected to provide a NFS listeners list it wants enabled. All other
sockets will be closed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Co-developed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  34 ++++
 fs/nfsd/netlink.c                     |  22 +++
 fs/nfsd/netlink.h                     |   3 +
 fs/nfsd/nfsctl.c                      | 220 ++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  17 ++
 5 files changed, 296 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 0396e8b3ea1f..e5c1f9186fe8 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -94,6 +94,23 @@ attribute-sets:
         type: nest
         nested-attributes: version
         multi-attr: true
+  -
+    name: sock
+    attributes:
+      -
+        name: addr
+        type: binary
+      -
+        name: transport-name
+        type: string
+  -
+    name: server-sock
+    attributes:
+      -
+        name: addr
+        type: nest
+        nested-attributes: sock
+        multi-attr: true
 
 operations:
   list:
@@ -157,3 +174,20 @@ operations:
         reply:
           attributes:
             - version
+    -
+      name: listener-set
+      doc: set nfs running sockets
+      attribute-set: server-sock
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - addr
+    -
+      name: listener-get
+      doc: get nfs running listeners
+      attribute-set: server-sock
+      do:
+        reply:
+          attributes:
+            - addr
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index bf5df9597288..9450d691dae8 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -11,6 +11,11 @@
 #include <uapi/linux/nfsd_netlink.h>
 
 /* Common nested types */
+const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1] = {
+	[NFSD_A_SOCK_ADDR] = { .type = NLA_BINARY, },
+	[NFSD_A_SOCK_TRANSPORT_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
 	[NFSD_A_VERSION_MAJOR] = { .type = NLA_U32, },
 	[NFSD_A_VERSION_MINOR] = { .type = NLA_U32, },
@@ -29,6 +34,11 @@ static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_PROTO_VE
 	[NFSD_A_SERVER_PROTO_VERSION] = NLA_POLICY_NESTED(nfsd_version_nl_policy),
 };
 
+/* NFSD_CMD_LISTENER_SET - do */
+static const struct nla_policy nfsd_listener_set_nl_policy[NFSD_A_SERVER_SOCK_ADDR + 1] = {
+	[NFSD_A_SERVER_SOCK_ADDR] = NLA_POLICY_NESTED(nfsd_sock_nl_policy),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -62,6 +72,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_version_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_LISTENER_SET,
+		.doit		= nfsd_nl_listener_set_doit,
+		.policy		= nfsd_listener_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_SOCK_ADDR,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_LISTENER_GET,
+		.doit	= nfsd_nl_listener_get_doit,
+		.flags	= GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index c7c0da275481..e3724637d64d 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -12,6 +12,7 @@
 #include <uapi/linux/nfsd_netlink.h>
 
 /* Common nested types */
+extern const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1];
 extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1];
 
 int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
@@ -23,6 +24,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2c8929ef79e9..2e8534113ce4 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1907,6 +1907,226 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/**
+ * nfsd_nl_listener_set_doit - set the nfs running sockets
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct svc_xprt *xprt, *tmp;
+	const struct nlattr *attr;
+	struct svc_serv *serv;
+	LIST_HEAD(permsocks);
+	struct nfsd_net *nn;
+	int err, rem;
+
+	mutex_lock(&nfsd_mutex);
+
+	err = nfsd_create_serv(net);
+	if (err) {
+		mutex_unlock(&nfsd_mutex);
+		return err;
+	}
+
+	nn = net_generic(net, nfsd_net_id);
+	serv = nn->nfsd_serv;
+
+	spin_lock_bh(&serv->sv_lock);
+
+	/* Move all of the old listener sockets to a temp list */
+	list_splice_init(&serv->sv_permsocks, &permsocks);
+
+	/*
+	 * Walk the list of server_socks from userland and move any that match
+	 * back to sv_permsocks
+	 */
+	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
+		const char *xcl_name;
+		struct sockaddr *sa;
+
+		if (nla_type(attr) != NFSD_A_SERVER_SOCK_ADDR)
+			continue;
+
+		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
+				     nfsd_sock_nl_policy, info->extack) < 0)
+			continue;
+
+		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
+			continue;
+
+		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(*sa))
+			continue;
+
+		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
+		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
+
+		/* Put back any matching sockets */
+		list_for_each_entry_safe(xprt, tmp, &permsocks, xpt_list) {
+			/* This shouldn't be possible */
+			if (WARN_ON_ONCE(xprt->xpt_net != net)) {
+				list_move(&xprt->xpt_list, &serv->sv_permsocks);
+				continue;
+			}
+
+			/* If everything matches, put it back */
+			if (!strcmp(xprt->xpt_class->xcl_name, xcl_name) &&
+			    rpc_cmp_addr_port(sa, (struct sockaddr *)&xprt->xpt_local)) {
+				list_move(&xprt->xpt_list, &serv->sv_permsocks);
+				break;
+			}
+		}
+	}
+
+	/* For now, no removing old sockets while server is running */
+	if (serv->sv_nrthreads && !list_empty(&permsocks)) {
+		list_splice_init(&permsocks, &serv->sv_permsocks);
+		spin_unlock_bh(&serv->sv_lock);
+		err = -EBUSY;
+		goto out_unlock_mtx;
+	}
+
+	/* Close the remaining sockets on the permsocks list */
+	while (!list_empty(&permsocks)) {
+		xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
+		list_move(&xprt->xpt_list, &serv->sv_permsocks);
+
+		/*
+		 * Newly-created sockets are born with the BUSY bit set. Clear
+		 * it if there are no threads, since nothing can pick it up
+		 * in that case.
+		 */
+		if (!serv->sv_nrthreads)
+			clear_bit(XPT_BUSY, &xprt->xpt_flags);
+
+		set_bit(XPT_CLOSE, &xprt->xpt_flags);
+		spin_unlock_bh(&serv->sv_lock);
+		svc_xprt_close(xprt);
+		spin_lock_bh(&serv->sv_lock);
+	}
+
+	spin_unlock_bh(&serv->sv_lock);
+
+	/* walk list of addrs again, open any that still don't exist */
+	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
+		const char *xcl_name;
+		struct sockaddr *sa;
+		int ret;
+
+		if (nla_type(attr) != NFSD_A_SERVER_SOCK_ADDR)
+			continue;
+
+		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
+				     nfsd_sock_nl_policy, info->extack) < 0)
+			continue;
+
+		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
+			continue;
+
+		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(*sa))
+			continue;
+
+		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
+		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
+
+		xprt = svc_find_listener(serv, xcl_name, net, sa);
+		if (xprt) {
+			svc_xprt_put(xprt);
+			continue;
+		}
+
+		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa,
+					      SVC_SOCK_ANONYMOUS,
+					      get_current_cred());
+		/* always save the latest error */
+		if (ret < 0)
+			err = ret;
+	}
+
+	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
+		nfsd_destroy_serv(net);
+
+out_unlock_mtx:
+	mutex_unlock(&nfsd_mutex);
+
+	return err;
+}
+
+/**
+ * nfsd_nl_listener_get_doit - get the nfs running listeners
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct svc_xprt *xprt;
+	struct svc_serv *serv;
+	struct nfsd_net *nn;
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
+	mutex_lock(&nfsd_mutex);
+	nn = net_generic(genl_info_net(info), nfsd_net_id);
+
+	/* no nfs server? Just send empty socket list */
+	if (!nn->nfsd_serv)
+		goto out_unlock_mtx;
+
+	serv = nn->nfsd_serv;
+	spin_lock_bh(&serv->sv_lock);
+	list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
+		struct nlattr *attr;
+
+		attr = nla_nest_start(skb, NFSD_A_SERVER_SOCK_ADDR);
+		if (!attr) {
+			err = -EINVAL;
+			goto err_serv_unlock;
+		}
+
+		if (nla_put_string(skb, NFSD_A_SOCK_TRANSPORT_NAME,
+				   xprt->xpt_class->xcl_name) ||
+		    nla_put(skb, NFSD_A_SOCK_ADDR,
+			    sizeof(struct sockaddr_storage),
+			    &xprt->xpt_local)) {
+			err = -EINVAL;
+			goto err_serv_unlock;
+		}
+
+		nla_nest_end(skb, attr);
+	}
+	spin_unlock_bh(&serv->sv_lock);
+out_unlock_mtx:
+	mutex_unlock(&nfsd_mutex);
+	genlmsg_end(skb, hdr);
+
+	return genlmsg_reply(skb, info);
+
+err_serv_unlock:
+	spin_unlock_bh(&serv->sv_lock);
+	mutex_unlock(&nfsd_mutex);
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
index 8a0a2b344923..ca9900f9d86f 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -54,12 +54,29 @@ enum {
 	NFSD_A_SERVER_PROTO_MAX = (__NFSD_A_SERVER_PROTO_MAX - 1)
 };
 
+enum {
+	NFSD_A_SOCK_ADDR = 1,
+	NFSD_A_SOCK_TRANSPORT_NAME,
+
+	__NFSD_A_SOCK_MAX,
+	NFSD_A_SOCK_MAX = (__NFSD_A_SOCK_MAX - 1)
+};
+
+enum {
+	NFSD_A_SERVER_SOCK_ADDR = 1,
+
+	__NFSD_A_SERVER_SOCK_MAX,
+	NFSD_A_SERVER_SOCK_MAX = (__NFSD_A_SERVER_SOCK_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
 	NFSD_CMD_THREADS_GET,
 	NFSD_CMD_VERSION_SET,
 	NFSD_CMD_VERSION_GET,
+	NFSD_CMD_LISTENER_SET,
+	NFSD_CMD_LISTENER_GET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
-- 
2.44.0


