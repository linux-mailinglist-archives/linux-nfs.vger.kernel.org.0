Return-Path: <linux-nfs+bounces-1212-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A3833587
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jan 2024 18:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8EA28331E
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jan 2024 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFBC12B75;
	Sat, 20 Jan 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMZxR+OM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545412B65;
	Sat, 20 Jan 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705772049; cv=none; b=guF4w6XMlUheLWLfRqU3QiAN1bgYzs/EY2G4S7vX7BLFb37iJWDyzpMUSKjfpouDVmbDy8AXeeO2gm0qLB4vU+ZhjlaM35GUCuwXtH0efj+Gi+E0VaN+SgYmSqAjpezqEkTlBr01bp1Y9D/Z9gMGkwAqktrO3yhsjSX7dJ3dkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705772049; c=relaxed/simple;
	bh=ecXWJnApMveHoNdqgWpRkzzuCExAaGIrUSwoj/SFdAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOjcUCNjfn9HXoILOMXIAq9MOZ7bm1oTEXgXrfV4f0BmtVU5LG+5r1UMzPElqiqzn7DMU6s/Ob3k+dax3ygLS+ACLRJFJU4LzClWlicuZYjyCCutvWz6mojlC+aR+ENWe9O9f5ecMP7Q0yGjQpCy9A98/cFe/bdkeVAE3xCmYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMZxR+OM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E621FC433C7;
	Sat, 20 Jan 2024 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705772049;
	bh=ecXWJnApMveHoNdqgWpRkzzuCExAaGIrUSwoj/SFdAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMZxR+OM+RPPOiMCcPuC/xXzgcLqDcP1FrfXi4uBJqcGOR6CXHulFHim2L4A4oOPY
	 C+nj7Y3N7Y2l52Jmc/2FaV0W5v/Xj0hTHdPSfepfvmkan2F8zbpzPRCMd/A5+eJBCq
	 /zK95WmB7bilG7TdrDBf1ftTnRvmMNrLwToJsn/04dc7HyYMYigVvfscMuY7HA6DNM
	 hA+d/FyzTuHT3Em/W/ewPGmEEIZRmBkdBviLMgUMJqkWbyKMbk85Il4u8oTINBsGb+
	 DWJJzecjxP7mTMkEJHoiSpknNZ4XcVA6VSqHxEfs2LR0BONT5PiPSkG/IFpKlX6Zj2
	 6Roqb0KlCKTWw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	neilb@suse.de,
	jlayton@kernel.org,
	kuba@kernel.org,
	chuck.lever@oracle.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 2/3] NFSD: add write_version to netlink command
Date: Sat, 20 Jan 2024 18:33:31 +0100
Message-ID: <fd54905f4d66b84afbc9a8270261d27ad509f0a0.1705771400.git.lorenzo@kernel.org>
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

Introduce write_version netlink command. For version-set, userspace is
expected to provide a NFS major/minor version list it wants to enable
(all the other ones will be disabled).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  34 +++++
 fs/nfsd/netlink.c                     |  23 ++++
 fs/nfsd/netlink.h                     |   5 +
 fs/nfsd/nfsctl.c                      | 140 ++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  17 +++
 tools/net/ynl/generated/nfsd-user.c   | 176 ++++++++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   |  53 ++++++++
 7 files changed, 448 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index c92e1425d316..30f18798e84e 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -68,6 +68,23 @@ attribute-sets:
       -
         name: threads
         type: u32
+  -
+    name: nfs-version
+    attributes:
+      -
+        name: major
+        type: u32
+      -
+        name: minor
+        type: u32
+  -
+    name: server-proto
+    attributes:
+      -
+        name: version
+        type: nest
+        nested-attributes: nfs-version
+        multi-attr: true
 
 operations:
   list:
@@ -110,3 +127,20 @@ operations:
         reply:
           attributes:
             - threads
+    -
+      name: version-set
+      doc: set nfs enabled versions
+      attribute-set: server-proto
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - version
+    -
+      name: version-get
+      doc: get nfs enabled versions
+      attribute-set: server-proto
+      do:
+        reply:
+          attributes:
+            - version
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 1a59a8e6c7e2..5cbbd3295543 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -10,11 +10,22 @@
 
 #include <uapi/linux/nfsd_netlink.h>
 
+/* Common nested types */
+const struct nla_policy nfsd_nfs_version_nl_policy[NFSD_A_NFS_VERSION_MINOR + 1] = {
+	[NFSD_A_NFS_VERSION_MAJOR] = { .type = NLA_U32, },
+	[NFSD_A_NFS_VERSION_MINOR] = { .type = NLA_U32, },
+};
+
 /* NFSD_CMD_THREADS_SET - do */
 static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_THREADS + 1] = {
 	[NFSD_A_SERVER_WORKER_THREADS] = { .type = NLA_U32, },
 };
 
+/* NFSD_CMD_VERSION_SET - do */
+static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_PROTO_VERSION + 1] = {
+	[NFSD_A_SERVER_PROTO_VERSION] = NLA_POLICY_NESTED(nfsd_nfs_version_nl_policy),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -36,6 +47,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_threads_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_VERSION_SET,
+		.doit		= nfsd_nl_version_set_doit,
+		.policy		= nfsd_version_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_PROTO_VERSION,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_VERSION_GET,
+		.doit	= nfsd_nl_version_get_doit,
+		.flags	= GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 4137fac477e4..c9a1be693fef 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -11,6 +11,9 @@
 
 #include <uapi/linux/nfsd_netlink.h>
 
+/* Common nested types */
+extern const struct nla_policy nfsd_nfs_version_nl_policy[NFSD_A_NFS_VERSION_MINOR + 1];
+
 int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
 int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
 
@@ -18,6 +21,8 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				  struct netlink_callback *cb);
 int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 68718448d660..53af82303f93 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1756,6 +1756,146 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/**
+ * nfsd_nl_version_set_doit - set the nfs enabled versions
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	const struct nlattr *attr;
+	struct nfsd_net *nn;
+	int i, rem;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_PROTO_VERSION))
+		return -EINVAL;
+
+	mutex_lock(&nfsd_mutex);
+
+	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	if (nn->nfsd_serv) {
+		mutex_unlock(&nfsd_mutex);
+		return -EBUSY;
+	}
+
+	/* clear current supported versions. */
+	nfsd_vers(nn, 2, NFSD_CLEAR);
+	nfsd_vers(nn, 3, NFSD_CLEAR);
+	for (i = 0; i <= NFSD_SUPPORTED_MINOR_VERSION; i++)
+		nfsd_minorversion(nn, i, NFSD_CLEAR);
+
+	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+		struct nlattr *tb[ARRAY_SIZE(nfsd_nfs_version_nl_policy)];
+		u32 major, minor = 0;
+
+		if (nla_type(attr) != NFSD_A_SERVER_PROTO_VERSION)
+			continue;
+
+		if (nla_parse_nested(tb, ARRAY_SIZE(tb), attr,
+				     nfsd_nfs_version_nl_policy,
+				     info->extack) < 0)
+			continue;
+
+		if (!tb[NFSD_A_NFS_VERSION_MAJOR])
+			continue;
+
+		major = nla_get_u32(tb[NFSD_A_NFS_VERSION_MAJOR]);
+		if (tb[NFSD_A_NFS_VERSION_MINOR])
+			minor = nla_get_u32(tb[NFSD_A_NFS_VERSION_MINOR]);
+
+		switch (major) {
+		case 4:
+			nfsd_minorversion(nn, minor, NFSD_SET);
+			break;
+		case 3:
+		case 2:
+			if (!minor)
+				nfsd_vers(nn, major, NFSD_SET);
+			break;
+		default:
+			break;
+		}
+	}
+
+	mutex_unlock(&nfsd_mutex);
+
+	return 0;
+}
+
+/**
+ * nfsd_nl_version_get_doit - get the nfs enabled versions
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nfsd_net *nn;
+	int i, err;
+	void *hdr;
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
+	for (i = 2; i <= 4; i++) {
+		int j;
+
+		for (j = 0; j <= NFSD_SUPPORTED_MINOR_VERSION; j++) {
+			struct nlattr *attr;
+
+			if (!nfsd_vers(nn, i, NFSD_TEST))
+				continue;
+
+			/* NFSv{2,3} does not support minor numbers */
+			if (i < 4 && j)
+				continue;
+
+			if (i == 4 && !nfsd_minorversion(nn, j, NFSD_TEST))
+				continue;
+
+			attr = nla_nest_start_noflag(skb,
+					NFSD_A_SERVER_PROTO_VERSION);
+			if (!attr) {
+				err = -EINVAL;
+				goto err_nfsd_unlock;
+			}
+
+			if (nla_put_u32(skb, NFSD_A_NFS_VERSION_MAJOR, i) ||
+			    nla_put_u32(skb, NFSD_A_NFS_VERSION_MINOR, j)) {
+				err = -EINVAL;
+				goto err_nfsd_unlock;
+			}
+
+			nla_nest_end(skb, attr);
+		}
+	}
+
+	mutex_unlock(&nfsd_mutex);
+	genlmsg_end(skb, hdr);
+
+	return genlmsg_reply(skb, info);
+
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
index 1b6fe1f9ed0e..2a06f9fe6fe9 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -36,10 +36,27 @@ enum {
 	NFSD_A_SERVER_WORKER_MAX = (__NFSD_A_SERVER_WORKER_MAX - 1)
 };
 
+enum {
+	NFSD_A_NFS_VERSION_MAJOR = 1,
+	NFSD_A_NFS_VERSION_MINOR,
+
+	__NFSD_A_NFS_VERSION_MAX,
+	NFSD_A_NFS_VERSION_MAX = (__NFSD_A_NFS_VERSION_MAX - 1)
+};
+
+enum {
+	NFSD_A_SERVER_PROTO_VERSION = 1,
+
+	__NFSD_A_SERVER_PROTO_MAX,
+	NFSD_A_SERVER_PROTO_MAX = (__NFSD_A_SERVER_PROTO_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
 	NFSD_CMD_THREADS_GET,
+	NFSD_CMD_VERSION_SET,
+	NFSD_CMD_VERSION_GET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
index f4121a52ccf8..ad498543f464 100644
--- a/tools/net/ynl/generated/nfsd-user.c
+++ b/tools/net/ynl/generated/nfsd-user.c
@@ -17,6 +17,8 @@ static const char * const nfsd_op_strmap[] = {
 	[NFSD_CMD_RPC_STATUS_GET] = "rpc-status-get",
 	[NFSD_CMD_THREADS_SET] = "threads-set",
 	[NFSD_CMD_THREADS_GET] = "threads-get",
+	[NFSD_CMD_VERSION_SET] = "version-set",
+	[NFSD_CMD_VERSION_GET] = "version-get",
 };
 
 const char *nfsd_op_str(int op)
@@ -27,6 +29,16 @@ const char *nfsd_op_str(int op)
 }
 
 /* Policies */
+struct ynl_policy_attr nfsd_nfs_version_policy[NFSD_A_NFS_VERSION_MAX + 1] = {
+	[NFSD_A_NFS_VERSION_MAJOR] = { .name = "major", .type = YNL_PT_U32, },
+	[NFSD_A_NFS_VERSION_MINOR] = { .name = "minor", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest nfsd_nfs_version_nest = {
+	.max_attr = NFSD_A_NFS_VERSION_MAX,
+	.table = nfsd_nfs_version_policy,
+};
+
 struct ynl_policy_attr nfsd_rpc_status_policy[NFSD_A_RPC_STATUS_MAX + 1] = {
 	[NFSD_A_RPC_STATUS_XID] = { .name = "xid", .type = YNL_PT_U32, },
 	[NFSD_A_RPC_STATUS_FLAGS] = { .name = "flags", .type = YNL_PT_U32, },
@@ -58,7 +70,60 @@ struct ynl_policy_nest nfsd_server_worker_nest = {
 	.table = nfsd_server_worker_policy,
 };
 
+struct ynl_policy_attr nfsd_server_proto_policy[NFSD_A_SERVER_PROTO_MAX + 1] = {
+	[NFSD_A_SERVER_PROTO_VERSION] = { .name = "version", .type = YNL_PT_NEST, .nest = &nfsd_nfs_version_nest, },
+};
+
+struct ynl_policy_nest nfsd_server_proto_nest = {
+	.max_attr = NFSD_A_SERVER_PROTO_MAX,
+	.table = nfsd_server_proto_policy,
+};
+
 /* Common nested types */
+void nfsd_nfs_version_free(struct nfsd_nfs_version *obj)
+{
+}
+
+int nfsd_nfs_version_put(struct nlmsghdr *nlh, unsigned int attr_type,
+			 struct nfsd_nfs_version *obj)
+{
+	struct nlattr *nest;
+
+	nest = mnl_attr_nest_start(nlh, attr_type);
+	if (obj->_present.major)
+		mnl_attr_put_u32(nlh, NFSD_A_NFS_VERSION_MAJOR, obj->major);
+	if (obj->_present.minor)
+		mnl_attr_put_u32(nlh, NFSD_A_NFS_VERSION_MINOR, obj->minor);
+	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
+}
+
+int nfsd_nfs_version_parse(struct ynl_parse_arg *yarg,
+			   const struct nlattr *nested)
+{
+	struct nfsd_nfs_version *dst = yarg->data;
+	const struct nlattr *attr;
+
+	mnl_attr_for_each_nested(attr, nested) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NFSD_A_NFS_VERSION_MAJOR) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.major = 1;
+			dst->major = mnl_attr_get_u32(attr);
+		} else if (type == NFSD_A_NFS_VERSION_MINOR) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.minor = 1;
+			dst->minor = mnl_attr_get_u32(attr);
+		}
+	}
+
+	return 0;
+}
+
 /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
 /* NFSD_CMD_RPC_STATUS_GET - dump */
 int nfsd_rpc_status_get_rsp_dump_parse(const struct nlmsghdr *nlh, void *data)
@@ -291,6 +356,117 @@ struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys)
 	return NULL;
 }
 
+/* ============== NFSD_CMD_VERSION_SET ============== */
+/* NFSD_CMD_VERSION_SET - do */
+void nfsd_version_set_req_free(struct nfsd_version_set_req *req)
+{
+	unsigned int i;
+
+	for (i = 0; i < req->n_version; i++)
+		nfsd_nfs_version_free(&req->version[i]);
+	free(req->version);
+	free(req);
+}
+
+int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_req *req)
+{
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_VERSION_SET, 1);
+	ys->req_policy = &nfsd_server_proto_nest;
+
+	for (unsigned int i = 0; i < req->n_version; i++)
+		nfsd_nfs_version_put(nlh, NFSD_A_SERVER_PROTO_VERSION, &req->version[i]);
+
+	err = ynl_exec(ys, nlh, &yrs);
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
+/* ============== NFSD_CMD_VERSION_GET ============== */
+/* NFSD_CMD_VERSION_GET - do */
+void nfsd_version_get_rsp_free(struct nfsd_version_get_rsp *rsp)
+{
+	unsigned int i;
+
+	for (i = 0; i < rsp->n_version; i++)
+		nfsd_nfs_version_free(&rsp->version[i]);
+	free(rsp->version);
+	free(rsp);
+}
+
+int nfsd_version_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
+{
+	struct ynl_parse_arg *yarg = data;
+	struct nfsd_version_get_rsp *dst;
+	unsigned int n_version = 0;
+	const struct nlattr *attr;
+	struct ynl_parse_arg parg;
+	int i;
+
+	dst = yarg->data;
+	parg.ys = yarg->ys;
+
+	if (dst->version)
+		return ynl_error_parse(yarg, "attribute already present (server-proto.version)");
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NFSD_A_SERVER_PROTO_VERSION) {
+			n_version++;
+		}
+	}
+
+	if (n_version) {
+		dst->version = calloc(n_version, sizeof(*dst->version));
+		dst->n_version = n_version;
+		i = 0;
+		parg.rsp_policy = &nfsd_nfs_version_nest;
+		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+			if (mnl_attr_get_type(attr) == NFSD_A_SERVER_PROTO_VERSION) {
+				parg.data = &dst->version[i];
+				if (nfsd_nfs_version_parse(&parg, attr))
+					return MNL_CB_ERROR;
+				i++;
+			}
+		}
+	}
+
+	return MNL_CB_OK;
+}
+
+struct nfsd_version_get_rsp *nfsd_version_get(struct ynl_sock *ys)
+{
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
+	struct nfsd_version_get_rsp *rsp;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_VERSION_GET, 1);
+	ys->req_policy = &nfsd_server_proto_nest;
+	yrs.yarg.rsp_policy = &nfsd_server_proto_nest;
+
+	rsp = calloc(1, sizeof(*rsp));
+	yrs.yarg.data = rsp;
+	yrs.cb = nfsd_version_get_rsp_parse;
+	yrs.rsp_cmd = NFSD_CMD_VERSION_GET;
+
+	err = ynl_exec(ys, nlh, &yrs);
+	if (err < 0)
+		goto err_free;
+
+	return rsp;
+
+err_free:
+	nfsd_version_get_rsp_free(rsp);
+	return NULL;
+}
+
 const struct ynl_family ynl_nfsd_family =  {
 	.name		= "nfsd",
 };
diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
index e162a4f20d91..d062ee8fa8b6 100644
--- a/tools/net/ynl/generated/nfsd-user.h
+++ b/tools/net/ynl/generated/nfsd-user.h
@@ -19,6 +19,16 @@ extern const struct ynl_family ynl_nfsd_family;
 const char *nfsd_op_str(int op);
 
 /* Common nested types */
+struct nfsd_nfs_version {
+	struct {
+		__u32 major:1;
+		__u32 minor:1;
+	} _present;
+
+	__u32 major;
+	__u32 minor;
+};
+
 /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
 /* NFSD_CMD_RPC_STATUS_GET - dump */
 struct nfsd_rpc_status_get_rsp_dump {
@@ -111,4 +121,47 @@ void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp);
  */
 struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
 
+/* ============== NFSD_CMD_VERSION_SET ============== */
+/* NFSD_CMD_VERSION_SET - do */
+struct nfsd_version_set_req {
+	unsigned int n_version;
+	struct nfsd_nfs_version *version;
+};
+
+static inline struct nfsd_version_set_req *nfsd_version_set_req_alloc(void)
+{
+	return calloc(1, sizeof(struct nfsd_version_set_req));
+}
+void nfsd_version_set_req_free(struct nfsd_version_set_req *req);
+
+static inline void
+__nfsd_version_set_req_set_version(struct nfsd_version_set_req *req,
+				   struct nfsd_nfs_version *version,
+				   unsigned int n_version)
+{
+	free(req->version);
+	req->version = version;
+	req->n_version = n_version;
+}
+
+/*
+ * set nfs enabled versions
+ */
+int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_req *req);
+
+/* ============== NFSD_CMD_VERSION_GET ============== */
+/* NFSD_CMD_VERSION_GET - do */
+
+struct nfsd_version_get_rsp {
+	unsigned int n_version;
+	struct nfsd_nfs_version *version;
+};
+
+void nfsd_version_get_rsp_free(struct nfsd_version_get_rsp *rsp);
+
+/*
+ * get nfs enabled versions
+ */
+struct nfsd_version_get_rsp *nfsd_version_get(struct ynl_sock *ys);
+
 #endif /* _LINUX_NFSD_GEN_H */
-- 
2.43.0


