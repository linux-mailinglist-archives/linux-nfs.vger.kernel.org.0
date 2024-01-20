Return-Path: <linux-nfs+bounces-1213-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F2833588
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jan 2024 18:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E824B1F21E3C
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jan 2024 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863610979;
	Sat, 20 Jan 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixCXJbcZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126812E69;
	Sat, 20 Jan 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705772053; cv=none; b=s2ib3z+HZCofQuYrlodU/qgYJ57dbPDjp1u3YFngqLdMBbRxNjgw49VmaLsT1/zQbKpnh6JAstu0dPMj50eP2W8HRm6Z93+yAAEYhTVau7pWGjCIQUH7AMJXDxswEcjIBcDi283sRmbaN+BMzWpLxGWFTNd+LO7QXOOzOlb9orI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705772053; c=relaxed/simple;
	bh=ruM2NBGtCaMvPwK4jKMWDCEJ5nTyHnabdH5DAh7BMUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tF34N/XivnFJVv5cX9YsRnqj8CPmoFR9VNaQDUGs9OpxuIeyhoGeFKKW8QKyoXqrxkBK7krMRAfZcE6Ki1S9Vj+1lDmWNwDUJzZLptbd06Y/dOzevShcJ6dFEzMTOyvabwbszzfQcK+/6U+sFR395manlP4v0K241okj//LK5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixCXJbcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90283C433C7;
	Sat, 20 Jan 2024 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705772053;
	bh=ruM2NBGtCaMvPwK4jKMWDCEJ5nTyHnabdH5DAh7BMUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixCXJbcZBIKdr1NGeJ2gqzn+OIj94ssPXKFo9Y5DiGv63nkOBM8raATmVXsJ6dGir
	 YuNYC1T/RiQJNmZBIdfjC8wisrUQLUhFV1YBzZkinocsqrVyWGh08ke0B7r/o2bgga
	 Z22dtGc5iPPfhypS0A/bhfY5DTNpdX4aV++bUbHb6EKkrJumcTmmbZRhjgBxIT1X5a
	 193d5ygs2tYgZGjQinYthXYam2OT5FDC5qze6mj0YFCZzxqvcD87kLuJGBcE+RP6/h
	 AG+O84JSaqtDqdFQlqc2Ccx2Q1e0/PfddMbU+aVdZ6Iy/RE66pYKZHK6ar3uIfa4Hy
	 SlDEXj0JB3Efg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	neilb@suse.de,
	jlayton@kernel.org,
	kuba@kernel.org,
	chuck.lever@oracle.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Date: Sat, 20 Jan 2024 18:33:32 +0100
Message-ID: <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705771400.git.lorenzo@kernel.org>
References: <cover.1705771400.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce write_ports netlink command. For listener-set, userspace is
expected to provide a NFS listeners list it wants to enable (all the
other ports will be closed).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  37 +++++
 fs/nfsd/netlink.c                     |  23 +++
 fs/nfsd/netlink.h                     |   3 +
 fs/nfsd/nfsctl.c                      | 196 ++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  18 +++
 tools/net/ynl/generated/nfsd-user.c   | 191 +++++++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   |  55 ++++++++
 7 files changed, 523 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 30f18798e84e..296ff24b23ac 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -85,6 +85,26 @@ attribute-sets:
         type: nest
         nested-attributes: nfs-version
         multi-attr: true
+  -
+    name: server-instance
+    attributes:
+      -
+        name: transport-name
+        type: string
+      -
+        name: port
+        type: u32
+      -
+        name: inet-proto
+        type: u16
+  -
+    name: server-listener
+    attributes:
+      -
+        name: instance
+        type: nest
+        nested-attributes: server-instance
+        multi-attr: true
 
 operations:
   list:
@@ -144,3 +164,20 @@ operations:
         reply:
           attributes:
             - version
+    -
+      name: listener-set
+      doc: set nfs running listeners
+      attribute-set: server-listener
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - instance
+    -
+      name: listener-get
+      doc: get nfs running listeners
+      attribute-set: server-listener
+      do:
+        reply:
+          attributes:
+            - instance
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 5cbbd3295543..c772f9e14761 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -16,6 +16,12 @@ const struct nla_policy nfsd_nfs_version_nl_policy[NFSD_A_NFS_VERSION_MINOR + 1]
 	[NFSD_A_NFS_VERSION_MINOR] = { .type = NLA_U32, },
 };
 
+const struct nla_policy nfsd_server_instance_nl_policy[NFSD_A_SERVER_INSTANCE_INET_PROTO + 1] = {
+	[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] = { .type = NLA_NUL_STRING, },
+	[NFSD_A_SERVER_INSTANCE_PORT] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_INSTANCE_INET_PROTO] = { .type = NLA_U16, },
+};
+
 /* NFSD_CMD_THREADS_SET - do */
 static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_THREADS + 1] = {
 	[NFSD_A_SERVER_WORKER_THREADS] = { .type = NLA_U32, },
@@ -26,6 +32,11 @@ static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_PROTO_VE
 	[NFSD_A_SERVER_PROTO_VERSION] = NLA_POLICY_NESTED(nfsd_nfs_version_nl_policy),
 };
 
+/* NFSD_CMD_LISTENER_SET - do */
+static const struct nla_policy nfsd_listener_set_nl_policy[NFSD_A_SERVER_LISTENER_INSTANCE + 1] = {
+	[NFSD_A_SERVER_LISTENER_INSTANCE] = NLA_POLICY_NESTED(nfsd_server_instance_nl_policy),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -59,6 +70,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_version_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_LISTENER_SET,
+		.doit		= nfsd_nl_listener_set_doit,
+		.policy		= nfsd_listener_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_LISTENER_INSTANCE,
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
index c9a1be693fef..10a26ad32cd0 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -13,6 +13,7 @@
 
 /* Common nested types */
 extern const struct nla_policy nfsd_nfs_version_nl_policy[NFSD_A_NFS_VERSION_MINOR + 1];
+extern const struct nla_policy nfsd_server_instance_nl_policy[NFSD_A_SERVER_INSTANCE_INET_PROTO + 1];
 
 int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
 int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
@@ -23,6 +24,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 53af82303f93..562b209f2921 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1896,6 +1896,202 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/**
+ * nfsd_nl_listener_set_doit - set the nfs running listeners
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *tb[ARRAY_SIZE(nfsd_server_instance_nl_policy)];
+	struct net *net = genl_info_net(info);
+	struct svc_xprt *xprt, *tmp_xprt;
+	const struct nlattr *attr;
+	struct svc_serv *serv;
+	const char *xcl_name;
+	struct nfsd_net *nn;
+	int port, err, rem;
+	sa_family_t af;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_INSTANCE))
+		return -EINVAL;
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
+	/* 1- create brand new listeners */
+	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+		if (nla_type(attr) != NFSD_A_SERVER_LISTENER_INSTANCE)
+			continue;
+
+		if (nla_parse_nested(tb, ARRAY_SIZE(tb), attr,
+				     nfsd_server_instance_nl_policy,
+				     info->extack) < 0)
+			continue;
+
+		if (!tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] ||
+		    !tb[NFSD_A_SERVER_INSTANCE_PORT])
+			continue;
+
+		xcl_name = nla_data(tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME]);
+		port = nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_PORT]);
+		if (port < 1 || port > USHRT_MAX)
+			continue;
+
+		af = nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_INET_PROTO]);
+		if (af != PF_INET && af != PF_INET6)
+			continue;
+
+		xprt = svc_find_xprt(serv, xcl_name, net, PF_INET, port);
+		if (xprt) {
+			svc_xprt_put(xprt);
+			continue;
+		}
+
+		/* create new listerner */
+		if (svc_xprt_create(serv, xcl_name, net, af, port,
+				    SVC_SOCK_ANONYMOUS, get_current_cred()))
+			continue;
+	}
+
+	/* 2- remove stale listeners */
+	spin_lock_bh(&serv->sv_lock);
+	list_for_each_entry_safe(xprt, tmp_xprt, &serv->sv_permsocks,
+				 xpt_list) {
+		struct svc_xprt *rqt_xprt = NULL;
+
+		nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+			if (nla_type(attr) != NFSD_A_SERVER_LISTENER_INSTANCE)
+				continue;
+
+			if (nla_parse_nested(tb, ARRAY_SIZE(tb), attr,
+					     nfsd_server_instance_nl_policy,
+					     info->extack) < 0)
+				continue;
+
+			if (!tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] ||
+			    !tb[NFSD_A_SERVER_INSTANCE_PORT])
+				continue;
+
+			xcl_name = nla_data(
+				tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME]);
+			port = nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_PORT]);
+			if (port < 1 || port > USHRT_MAX)
+				continue;
+
+			af = nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_INET_PROTO]);
+			if (af != PF_INET && af != PF_INET6)
+				continue;
+
+			if (!strcmp(xprt->xpt_class->xcl_name, xcl_name) &&
+			    port == svc_xprt_local_port(xprt) &&
+			    af == xprt->xpt_local.ss_family &&
+			    xprt->xpt_net == net) {
+				rqt_xprt = xprt;
+				break;
+			}
+		}
+
+		/* remove stale listener */
+		if (!rqt_xprt) {
+			spin_unlock_bh(&serv->sv_lock);
+			svc_xprt_close(xprt);
+			spin_lock_bh(&serv->sv_lock);
+		}
+	}
+	spin_unlock_bh(&serv->sv_lock);
+
+	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
+		nfsd_destroy_serv(net);
+
+	mutex_unlock(&nfsd_mutex);
+
+	return 0;
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
+	if (!nn->nfsd_serv) {
+		err = -EINVAL;
+		goto err_nfsd_unlock;
+	}
+
+	serv = nn->nfsd_serv;
+	spin_lock_bh(&serv->sv_lock);
+	list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
+		struct nlattr *attr;
+
+		attr = nla_nest_start_noflag(skb,
+					     NFSD_A_SERVER_LISTENER_INSTANCE);
+		if (!attr) {
+			err = -EINVAL;
+			goto err_serv_unlock;
+		}
+
+		if (nla_put_string(skb, NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME,
+				   xprt->xpt_class->xcl_name) ||
+		    nla_put_u32(skb, NFSD_A_SERVER_INSTANCE_PORT,
+				svc_xprt_local_port(xprt)) ||
+		    nla_put_u16(skb, NFSD_A_SERVER_INSTANCE_INET_PROTO,
+				xprt->xpt_local.ss_family)) {
+			err = -EINVAL;
+			goto err_serv_unlock;
+		}
+
+		nla_nest_end(skb, attr);
+	}
+	spin_unlock_bh(&serv->sv_lock);
+	mutex_unlock(&nfsd_mutex);
+
+	genlmsg_end(skb, hdr);
+
+	return genlmsg_reply(skb, info);
+
+err_serv_unlock:
+	spin_unlock_bh(&serv->sv_lock);
+err_nfsd_unlock:
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
index 2a06f9fe6fe9..659ab76b8840 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -51,12 +51,30 @@ enum {
 	NFSD_A_SERVER_PROTO_MAX = (__NFSD_A_SERVER_PROTO_MAX - 1)
 };
 
+enum {
+	NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME = 1,
+	NFSD_A_SERVER_INSTANCE_PORT,
+	NFSD_A_SERVER_INSTANCE_INET_PROTO,
+
+	__NFSD_A_SERVER_INSTANCE_MAX,
+	NFSD_A_SERVER_INSTANCE_MAX = (__NFSD_A_SERVER_INSTANCE_MAX - 1)
+};
+
+enum {
+	NFSD_A_SERVER_LISTENER_INSTANCE = 1,
+
+	__NFSD_A_SERVER_LISTENER_MAX,
+	NFSD_A_SERVER_LISTENER_MAX = (__NFSD_A_SERVER_LISTENER_MAX - 1)
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
diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
index ad498543f464..d52f392c7f59 100644
--- a/tools/net/ynl/generated/nfsd-user.c
+++ b/tools/net/ynl/generated/nfsd-user.c
@@ -19,6 +19,8 @@ static const char * const nfsd_op_strmap[] = {
 	[NFSD_CMD_THREADS_GET] = "threads-get",
 	[NFSD_CMD_VERSION_SET] = "version-set",
 	[NFSD_CMD_VERSION_GET] = "version-get",
+	[NFSD_CMD_LISTENER_SET] = "listener-set",
+	[NFSD_CMD_LISTENER_GET] = "listener-get",
 };
 
 const char *nfsd_op_str(int op)
@@ -39,6 +41,17 @@ struct ynl_policy_nest nfsd_nfs_version_nest = {
 	.table = nfsd_nfs_version_policy,
 };
 
+struct ynl_policy_attr nfsd_server_instance_policy[NFSD_A_SERVER_INSTANCE_MAX + 1] = {
+	[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] = { .name = "transport-name", .type = YNL_PT_NUL_STR, },
+	[NFSD_A_SERVER_INSTANCE_PORT] = { .name = "port", .type = YNL_PT_U32, },
+	[NFSD_A_SERVER_INSTANCE_INET_PROTO] = { .name = "inet-proto", .type = YNL_PT_U16, },
+};
+
+struct ynl_policy_nest nfsd_server_instance_nest = {
+	.max_attr = NFSD_A_SERVER_INSTANCE_MAX,
+	.table = nfsd_server_instance_policy,
+};
+
 struct ynl_policy_attr nfsd_rpc_status_policy[NFSD_A_RPC_STATUS_MAX + 1] = {
 	[NFSD_A_RPC_STATUS_XID] = { .name = "xid", .type = YNL_PT_U32, },
 	[NFSD_A_RPC_STATUS_FLAGS] = { .name = "flags", .type = YNL_PT_U32, },
@@ -79,6 +92,15 @@ struct ynl_policy_nest nfsd_server_proto_nest = {
 	.table = nfsd_server_proto_policy,
 };
 
+struct ynl_policy_attr nfsd_server_listener_policy[NFSD_A_SERVER_LISTENER_MAX + 1] = {
+	[NFSD_A_SERVER_LISTENER_INSTANCE] = { .name = "instance", .type = YNL_PT_NEST, .nest = &nfsd_server_instance_nest, },
+};
+
+struct ynl_policy_nest nfsd_server_listener_nest = {
+	.max_attr = NFSD_A_SERVER_LISTENER_MAX,
+	.table = nfsd_server_listener_policy,
+};
+
 /* Common nested types */
 void nfsd_nfs_version_free(struct nfsd_nfs_version *obj)
 {
@@ -124,6 +146,64 @@ int nfsd_nfs_version_parse(struct ynl_parse_arg *yarg,
 	return 0;
 }
 
+void nfsd_server_instance_free(struct nfsd_server_instance *obj)
+{
+	free(obj->transport_name);
+}
+
+int nfsd_server_instance_put(struct nlmsghdr *nlh, unsigned int attr_type,
+			     struct nfsd_server_instance *obj)
+{
+	struct nlattr *nest;
+
+	nest = mnl_attr_nest_start(nlh, attr_type);
+	if (obj->_present.transport_name_len)
+		mnl_attr_put_strz(nlh, NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME, obj->transport_name);
+	if (obj->_present.port)
+		mnl_attr_put_u32(nlh, NFSD_A_SERVER_INSTANCE_PORT, obj->port);
+	if (obj->_present.inet_proto)
+		mnl_attr_put_u16(nlh, NFSD_A_SERVER_INSTANCE_INET_PROTO, obj->inet_proto);
+	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
+}
+
+int nfsd_server_instance_parse(struct ynl_parse_arg *yarg,
+			       const struct nlattr *nested)
+{
+	struct nfsd_server_instance *dst = yarg->data;
+	const struct nlattr *attr;
+
+	mnl_attr_for_each_nested(attr, nested) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME) {
+			unsigned int len;
+
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+
+			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
+			dst->_present.transport_name_len = len;
+			dst->transport_name = malloc(len + 1);
+			memcpy(dst->transport_name, mnl_attr_get_str(attr), len);
+			dst->transport_name[len] = 0;
+		} else if (type == NFSD_A_SERVER_INSTANCE_PORT) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.port = 1;
+			dst->port = mnl_attr_get_u32(attr);
+		} else if (type == NFSD_A_SERVER_INSTANCE_INET_PROTO) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.inet_proto = 1;
+			dst->inet_proto = mnl_attr_get_u16(attr);
+		}
+	}
+
+	return 0;
+}
+
 /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
 /* NFSD_CMD_RPC_STATUS_GET - dump */
 int nfsd_rpc_status_get_rsp_dump_parse(const struct nlmsghdr *nlh, void *data)
@@ -467,6 +547,117 @@ struct nfsd_version_get_rsp *nfsd_version_get(struct ynl_sock *ys)
 	return NULL;
 }
 
+/* ============== NFSD_CMD_LISTENER_SET ============== */
+/* NFSD_CMD_LISTENER_SET - do */
+void nfsd_listener_set_req_free(struct nfsd_listener_set_req *req)
+{
+	unsigned int i;
+
+	for (i = 0; i < req->n_instance; i++)
+		nfsd_server_instance_free(&req->instance[i]);
+	free(req->instance);
+	free(req);
+}
+
+int nfsd_listener_set(struct ynl_sock *ys, struct nfsd_listener_set_req *req)
+{
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_SET, 1);
+	ys->req_policy = &nfsd_server_listener_nest;
+
+	for (unsigned int i = 0; i < req->n_instance; i++)
+		nfsd_server_instance_put(nlh, NFSD_A_SERVER_LISTENER_INSTANCE, &req->instance[i]);
+
+	err = ynl_exec(ys, nlh, &yrs);
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
+/* ============== NFSD_CMD_LISTENER_GET ============== */
+/* NFSD_CMD_LISTENER_GET - do */
+void nfsd_listener_get_rsp_free(struct nfsd_listener_get_rsp *rsp)
+{
+	unsigned int i;
+
+	for (i = 0; i < rsp->n_instance; i++)
+		nfsd_server_instance_free(&rsp->instance[i]);
+	free(rsp->instance);
+	free(rsp);
+}
+
+int nfsd_listener_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
+{
+	struct nfsd_listener_get_rsp *dst;
+	struct ynl_parse_arg *yarg = data;
+	unsigned int n_instance = 0;
+	const struct nlattr *attr;
+	struct ynl_parse_arg parg;
+	int i;
+
+	dst = yarg->data;
+	parg.ys = yarg->ys;
+
+	if (dst->instance)
+		return ynl_error_parse(yarg, "attribute already present (server-listener.instance)");
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NFSD_A_SERVER_LISTENER_INSTANCE) {
+			n_instance++;
+		}
+	}
+
+	if (n_instance) {
+		dst->instance = calloc(n_instance, sizeof(*dst->instance));
+		dst->n_instance = n_instance;
+		i = 0;
+		parg.rsp_policy = &nfsd_server_instance_nest;
+		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+			if (mnl_attr_get_type(attr) == NFSD_A_SERVER_LISTENER_INSTANCE) {
+				parg.data = &dst->instance[i];
+				if (nfsd_server_instance_parse(&parg, attr))
+					return MNL_CB_ERROR;
+				i++;
+			}
+		}
+	}
+
+	return MNL_CB_OK;
+}
+
+struct nfsd_listener_get_rsp *nfsd_listener_get(struct ynl_sock *ys)
+{
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
+	struct nfsd_listener_get_rsp *rsp;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_GET, 1);
+	ys->req_policy = &nfsd_server_listener_nest;
+	yrs.yarg.rsp_policy = &nfsd_server_listener_nest;
+
+	rsp = calloc(1, sizeof(*rsp));
+	yrs.yarg.data = rsp;
+	yrs.cb = nfsd_listener_get_rsp_parse;
+	yrs.rsp_cmd = NFSD_CMD_LISTENER_GET;
+
+	err = ynl_exec(ys, nlh, &yrs);
+	if (err < 0)
+		goto err_free;
+
+	return rsp;
+
+err_free:
+	nfsd_listener_get_rsp_free(rsp);
+	return NULL;
+}
+
 const struct ynl_family ynl_nfsd_family =  {
 	.name		= "nfsd",
 };
diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
index d062ee8fa8b6..5765fb6f2ef5 100644
--- a/tools/net/ynl/generated/nfsd-user.h
+++ b/tools/net/ynl/generated/nfsd-user.h
@@ -29,6 +29,18 @@ struct nfsd_nfs_version {
 	__u32 minor;
 };
 
+struct nfsd_server_instance {
+	struct {
+		__u32 transport_name_len;
+		__u32 port:1;
+		__u32 inet_proto:1;
+	} _present;
+
+	char *transport_name;
+	__u32 port;
+	__u16 inet_proto;
+};
+
 /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
 /* NFSD_CMD_RPC_STATUS_GET - dump */
 struct nfsd_rpc_status_get_rsp_dump {
@@ -164,4 +176,47 @@ void nfsd_version_get_rsp_free(struct nfsd_version_get_rsp *rsp);
  */
 struct nfsd_version_get_rsp *nfsd_version_get(struct ynl_sock *ys);
 
+/* ============== NFSD_CMD_LISTENER_SET ============== */
+/* NFSD_CMD_LISTENER_SET - do */
+struct nfsd_listener_set_req {
+	unsigned int n_instance;
+	struct nfsd_server_instance *instance;
+};
+
+static inline struct nfsd_listener_set_req *nfsd_listener_set_req_alloc(void)
+{
+	return calloc(1, sizeof(struct nfsd_listener_set_req));
+}
+void nfsd_listener_set_req_free(struct nfsd_listener_set_req *req);
+
+static inline void
+__nfsd_listener_set_req_set_instance(struct nfsd_listener_set_req *req,
+				     struct nfsd_server_instance *instance,
+				     unsigned int n_instance)
+{
+	free(req->instance);
+	req->instance = instance;
+	req->n_instance = n_instance;
+}
+
+/*
+ * set nfs running listeners
+ */
+int nfsd_listener_set(struct ynl_sock *ys, struct nfsd_listener_set_req *req);
+
+/* ============== NFSD_CMD_LISTENER_GET ============== */
+/* NFSD_CMD_LISTENER_GET - do */
+
+struct nfsd_listener_get_rsp {
+	unsigned int n_instance;
+	struct nfsd_server_instance *instance;
+};
+
+void nfsd_listener_get_rsp_free(struct nfsd_listener_get_rsp *rsp);
+
+/*
+ * get nfs running listeners
+ */
+struct nfsd_listener_get_rsp *nfsd_listener_get(struct ynl_sock *ys);
+
 #endif /* _LINUX_NFSD_GEN_H */
-- 
2.43.0


