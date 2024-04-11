Return-Path: <linux-nfs+bounces-2765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A38A1D1F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 20:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5384C283A84
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A11CAE64;
	Thu, 11 Apr 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekIeCrz4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF771C9ED6;
	Thu, 11 Apr 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854091; cv=none; b=K4bbfj0aYiOfLrHJutoup4HCbszBVBSxKHjKJm1tGSjIKh7pzLmwC6FZVK9AZAp3VaKQxovsA45jQI5XxqCSe2fLbO78dlYLqloLdMKoOob2XvCZoJ9iQQdw3r2/39QVQfV+NFUuhrLB8O5YsTsxkbEm6JAvMj9dWZdGkf1+5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854091; c=relaxed/simple;
	bh=u/ipy1Tv7BtnE+bkldWfP6d9+N4j1z+dyZC5kC47fpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tS7Dln4+JzF2fkRjEUcUr1xdQC1irbM01lCc9MTXQWKPYMf6nT4VNu9SAABlLIS1B23UWSo/xMX5jkAvqyWTNDWfVjclz75t5xWvLkYFI6iivhPZPqMjFYS0uLvgH1XnmOLkUDXM1T/B1Swe6HwO7GmI4yJD/9HkJZD018FLmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekIeCrz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33AFC072AA;
	Thu, 11 Apr 2024 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854091;
	bh=u/ipy1Tv7BtnE+bkldWfP6d9+N4j1z+dyZC5kC47fpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekIeCrz4A61A4Hwfx4lzg73WTatEMnvrDCxDt7gVAByr+vGhyRL3vJgScfwGBFai5
	 2KTNCQ6q/LNMy9Ya6c3knQ4an6R/N59mJxr/fNkeZdqJfNqmPSP+CuyIhbYT3H25yA
	 dX4ajm1He485xfl0Qh5clL0k0L5vdeTq+sqbZo7v9Ti6GfsPgq+aLyTOtO5JiUeEGx
	 jBb/xdA7qMR9b+2C8G6U/VDMTVWsPS4CLucuho2kYle9KGQhFHMm9jFhnw6SfbFhWQ
	 GY1rmxMMUicQZtVnq17w8BkwGllHE5zoEVMRASN4lFwRyV/VYY+mYND1CIvsCHhBAL
	 s1ShpqWEgga/A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org
Subject: [PATCH v7 5/5] NFSD: add listener-{set,get} netlink command
Date: Thu, 11 Apr 2024 18:47:28 +0200
Message-ID: <b11df42eba3d7b0304747dc78e78541ea86e0f05.1712853394.git.lorenzo@kernel.org>
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

Introduce write_ports netlink command. For listener-set, userspace is
expected to provide a NFS listeners list it wants enabled. All other
sockets will be closed.

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
index cb93e3e37119..5b8645abb007 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -88,6 +88,23 @@ attribute-sets:
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
@@ -147,3 +164,20 @@ operations:
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
index 75f609b57ceb..51863043552e 100644
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
@@ -27,6 +32,11 @@ static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_PROTO_VE
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
@@ -60,6 +70,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
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
index 341efab4eaa7..5ccdfe9a10a5 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1864,6 +1864,226 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
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
+		attr = nla_nest_start_noflag(skb, NFSD_A_SERVER_SOCK_ADDR);
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
index ccf3e15fe160..5253039aeb4d 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -52,12 +52,29 @@ enum {
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


