Return-Path: <linux-nfs+bounces-2954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E08AE81A
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91781289BAA
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195FC13699E;
	Tue, 23 Apr 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1ecvhUX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA013698B;
	Tue, 23 Apr 2024 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878784; cv=none; b=cNLJ7Nr3I81VgLsierGkXUfJiY1uwb8yITfKCId14osvYh6OV5ls7Ke61BBeCfW/46GLMpEbWKm1lNq7yJexrvcbMyvRbgx1IIfHNWtGVtjEfg3SFjay3Xb0bbmXREAt4R+MTpgom0nrPx/ALwQiqW/lGDEDm5lSBpc0ahCmURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878784; c=relaxed/simple;
	bh=EOQD+LvkbgNjO2ZneSwyu37b0vAQPgqWEzYcNpnNGRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFVXgL/yzyf9yto0PQ6HbPaJh+zr75Ir5EJLz2JVYnMbDYkki8ubsHsryZNirEiR2fGbH1gmHcQSvteM5COkLz9g1tYnlcxUWzOD9xd7JVro2SCMzuHXq9i6uiNN4JBHL/Q/WpopAO7BUCigogi7tgkvFgKxubDDXqf83xg4e8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1ecvhUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9DBC3277B;
	Tue, 23 Apr 2024 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713878783;
	bh=EOQD+LvkbgNjO2ZneSwyu37b0vAQPgqWEzYcNpnNGRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1ecvhUXi12clQCLVV2/lmgTje2lV9gcUFJnxbc8+Tj6DtXD1B4dWIgsY7yXMNTwe
	 YJnhkMh18XcC2qKzca/KDGqR+AeQGkaKrfyaTjcHQkXBy/sjh0k0h5RO32JPlcHzrU
	 p2BfxkhXO/ozaHA2If7h8lJF4Z/9KujmzQgcWmATYe+NBP+1//qlD3cANrTlO5v5zO
	 PnjLKNoMQsbypvYiS+mPituS4ltasZW7kTOIuX11ncb4tVDADTzXnfdRGBabOZKTE1
	 Ox/bIshgwUVAssHTUDkHM70Wt8nDISwphvpaJvXDf2kBoI9c3GPG3ln201bpkLsDAj
	 QBf8B4TIzNrfQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: neilb@suse.de,
	lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v9 7/7] NFSD: add listener-{set,get} netlink command
Date: Tue, 23 Apr 2024 15:25:44 +0200
Message-ID: <5835bd2662ecae789ce8cd13de8ad396ec0f29de.1713878413.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713878413.git.lorenzo@kernel.org>
References: <cover.1713878413.git.lorenzo@kernel.org>
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
index 77adda1425e2..d21234097167 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -98,6 +98,23 @@ attribute-sets:
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
@@ -163,3 +180,20 @@ operations:
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
index b23b0b84a59a..62d2586d9902 100644
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
@@ -30,6 +35,11 @@ static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_PROTO_VE
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
@@ -63,6 +73,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
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
index b6b405437aa0..202140df8f82 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1946,6 +1946,226 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
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
index 7176cd8e6f09..24c86dbc7ed5 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -55,12 +55,29 @@ enum {
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


