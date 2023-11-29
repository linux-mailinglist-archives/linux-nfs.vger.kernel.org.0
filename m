Return-Path: <linux-nfs+bounces-173-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9F27FDE16
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 18:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDEF1C20DE9
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D12481B5;
	Wed, 29 Nov 2023 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQziKdmF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97A40BF1;
	Wed, 29 Nov 2023 17:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72ABC433C8;
	Wed, 29 Nov 2023 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701277996;
	bh=l9Z0We60ZGdQxJd8SmFEnBj59eN7TiQ+MbgOp34HzH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQziKdmFjgiyvIBLL2OBvVWQZP9HnbY6K8k7o57CsgGo1UjDWNu1Q+0mA/JjnQw13
	 J2m6pjOdNEC1iJ+Bu4ZQukbP+Om4xAtGecHcMzFTH8f4M3dF7gwVatU4d8bIbSwpCa
	 aj4Udw30J4nqGG0MDNERhALKNQdRFND7Qit95SwGDN7C7ER+lMPHMaOovp5Fu39qNS
	 og2/Luss/RSG/t5WG/BeEeYoCpdimXqMKqD9GNFa4Dd0eQ1ks1rNIG94Jtl7VPBYaj
	 qlAdUHABg6GM/hFMNmht3lw8jg5THv8nKoEEo39wnKEA0mnTXCEhE+SXWyr2UDSHNv
	 E5zSUcPOVSd7Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	neilb@suse.de,
	netdev@vger.kernel.org,
	jlayton@kernel.org,
	kuba@kernel.org
Subject: [PATCH v5 2/3] NFSD: convert write_version to netlink command
Date: Wed, 29 Nov 2023 18:12:44 +0100
Message-ID: <8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701277475.git.lorenzo@kernel.org>
References: <cover.1701277475.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce write_version netlink command similar to the ones available
through the procfs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  32 ++++++++
 fs/nfsd/netlink.c                     |  19 +++++
 fs/nfsd/netlink.h                     |   3 +
 fs/nfsd/nfsctl.c                      | 105 ++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  11 +++
 tools/net/ynl/generated/nfsd-user.c   |  81 ++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   |  55 ++++++++++++++
 7 files changed, 306 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index c92e1425d316..6c5e42bb20f6 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -68,6 +68,18 @@ attribute-sets:
       -
         name: threads
         type: u32
+  -
+    name: server-version
+    attributes:
+      -
+        name: major
+        type: u32
+      -
+        name: minor
+        type: u32
+      -
+        name: status
+        type: u8
 
 operations:
   list:
@@ -110,3 +122,23 @@ operations:
         reply:
           attributes:
             - threads
+    -
+      name: version-set
+      doc: enable/disable server version
+      attribute-set: server-version
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - major
+            - minor
+            - status
+    -
+      name: version-get
+      doc: dump server versions
+      attribute-set: server-version
+      dump:
+        reply:
+          attributes:
+            - major
+            - minor
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 1a59a8e6c7e2..0608a7bd193b 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -15,6 +15,13 @@ static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_T
 	[NFSD_A_SERVER_WORKER_THREADS] = { .type = NLA_U32, },
 };
 
+/* NFSD_CMD_VERSION_SET - do */
+static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_VERSION_STATUS + 1] = {
+	[NFSD_A_SERVER_VERSION_MAJOR] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_VERSION_MINOR] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_VERSION_STATUS] = { .type = NLA_U8, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -36,6 +43,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_threads_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_VERSION_SET,
+		.doit		= nfsd_nl_version_set_doit,
+		.policy		= nfsd_version_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_VERSION_STATUS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_VERSION_GET,
+		.dumpit	= nfsd_nl_version_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 4137fac477e4..7d203cec08e4 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -18,6 +18,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				  struct netlink_callback *cb);
 int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 130b3d937a79..f04430f79687 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1757,6 +1757,111 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/**
+ * nfsd_nl_version_set_doit - enable/disable the provided nfs server version
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
+	enum vers_op cmd;
+	u32 major, minor;
+	u8 status;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_MAJOR) ||
+	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_MINOR) ||
+	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_STATUS))
+		return -EINVAL;
+
+	major = nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_MAJOR]);
+	minor = nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_MINOR]);
+
+	status = nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_STATUS]);
+	cmd = !!status ? NFSD_SET : NFSD_CLEAR;
+
+	mutex_lock(&nfsd_mutex);
+	switch (major) {
+	case 4:
+		ret = nfsd_minorversion(nn, minor, cmd);
+		break;
+	case 2:
+	case 3:
+		if (!minor) {
+			ret = nfsd_vers(nn, major, cmd);
+			break;
+		}
+		fallthrough;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	mutex_unlock(&nfsd_mutex);
+
+	return ret;
+}
+
+/**
+ * nfsd_nl_version_get_doit - Handle verion_get dumpit
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb)
+{
+	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
+	int i, ret = -ENOMEM;
+
+	mutex_lock(&nfsd_mutex);
+
+	for (i = 2; i <= 4; i++) {
+		int j;
+
+		if (i < cb->args[0]) /* already consumed */
+			continue;
+
+		if (!nfsd_vers(nn, i, NFSD_AVAIL))
+			continue;
+
+		for (j = 0; j <= NFSD_SUPPORTED_MINOR_VERSION; j++) {
+			void *hdr;
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
+			hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+					  cb->nlh->nlmsg_seq, &nfsd_nl_family,
+					  0, NFSD_CMD_VERSION_GET);
+			if (!hdr)
+				goto out;
+
+			if (nla_put_u32(skb, NFSD_A_SERVER_VERSION_MAJOR, i) ||
+			    nla_put_u32(skb, NFSD_A_SERVER_VERSION_MINOR, j))
+				goto out;
+
+			genlmsg_end(skb, hdr);
+		}
+	}
+	cb->args[0] = i;
+	ret = skb->len;
+out:
+	mutex_unlock(&nfsd_mutex);
+
+	return ret;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 1b6fe1f9ed0e..1b3340f31baa 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -36,10 +36,21 @@ enum {
 	NFSD_A_SERVER_WORKER_MAX = (__NFSD_A_SERVER_WORKER_MAX - 1)
 };
 
+enum {
+	NFSD_A_SERVER_VERSION_MAJOR = 1,
+	NFSD_A_SERVER_VERSION_MINOR,
+	NFSD_A_SERVER_VERSION_STATUS,
+
+	__NFSD_A_SERVER_VERSION_MAX,
+	NFSD_A_SERVER_VERSION_MAX = (__NFSD_A_SERVER_VERSION_MAX - 1)
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
index 9768328a7751..4cb71c3cd18d 100644
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
@@ -58,6 +60,17 @@ struct ynl_policy_nest nfsd_server_worker_nest = {
 	.table = nfsd_server_worker_policy,
 };
 
+struct ynl_policy_attr nfsd_server_version_policy[NFSD_A_SERVER_VERSION_MAX + 1] = {
+	[NFSD_A_SERVER_VERSION_MAJOR] = { .name = "major", .type = YNL_PT_U32, },
+	[NFSD_A_SERVER_VERSION_MINOR] = { .name = "minor", .type = YNL_PT_U32, },
+	[NFSD_A_SERVER_VERSION_STATUS] = { .name = "status", .type = YNL_PT_U8, },
+};
+
+struct ynl_policy_nest nfsd_server_version_nest = {
+	.max_attr = NFSD_A_SERVER_VERSION_MAX,
+	.table = nfsd_server_version_policy,
+};
+
 /* Common nested types */
 /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
 /* NFSD_CMD_RPC_STATUS_GET - dump */
@@ -290,6 +303,74 @@ struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys)
 	return NULL;
 }
 
+/* ============== NFSD_CMD_VERSION_SET ============== */
+/* NFSD_CMD_VERSION_SET - do */
+void nfsd_version_set_req_free(struct nfsd_version_set_req *req)
+{
+	free(req);
+}
+
+int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_req *req)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_VERSION_SET, 1);
+	ys->req_policy = &nfsd_server_version_nest;
+
+	if (req->_present.major)
+		mnl_attr_put_u32(nlh, NFSD_A_SERVER_VERSION_MAJOR, req->major);
+	if (req->_present.minor)
+		mnl_attr_put_u32(nlh, NFSD_A_SERVER_VERSION_MINOR, req->minor);
+	if (req->_present.status)
+		mnl_attr_put_u8(nlh, NFSD_A_SERVER_VERSION_STATUS, req->status);
+
+	err = ynl_exec(ys, nlh, NULL);
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
+/* ============== NFSD_CMD_VERSION_GET ============== */
+/* NFSD_CMD_VERSION_GET - dump */
+void nfsd_version_get_list_free(struct nfsd_version_get_list *rsp)
+{
+	struct nfsd_version_get_list *next = rsp;
+
+	while ((void *)next != YNL_LIST_END) {
+		rsp = next;
+		next = rsp->next;
+
+		free(rsp);
+	}
+}
+
+struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock *ys)
+{
+	struct ynl_dump_state yds = {};
+	struct nlmsghdr *nlh;
+	int err;
+
+	yds.ys = ys;
+	yds.alloc_sz = sizeof(struct nfsd_version_get_list);
+	yds.cb = nfsd_version_get_rsp_parse;
+	yds.rsp_cmd = NFSD_CMD_VERSION_GET;
+	yds.rsp_policy = &nfsd_server_version_nest;
+
+	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_VERSION_GET, 1);
+
+	err = ynl_exec_dump(ys, nlh, &yds);
+	if (err < 0)
+		goto free_list;
+
+	return yds.first;
+
+free_list:
+	nfsd_version_get_list_free(yds.first);
+	return NULL;
+}
+
 const struct ynl_family ynl_nfsd_family =  {
 	.name		= "nfsd",
 };
diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
index e162a4f20d91..e61c5a9e46fb 100644
--- a/tools/net/ynl/generated/nfsd-user.h
+++ b/tools/net/ynl/generated/nfsd-user.h
@@ -111,4 +111,59 @@ void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp);
  */
 struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
 
+/* ============== NFSD_CMD_VERSION_SET ============== */
+/* NFSD_CMD_VERSION_SET - do */
+struct nfsd_version_set_req {
+	struct {
+		__u32 major:1;
+		__u32 minor:1;
+		__u32 status:1;
+	} _present;
+
+	__u32 major;
+	__u32 minor;
+	__u8 status;
+};
+
+static inline struct nfsd_version_set_req *nfsd_version_set_req_alloc(void)
+{
+	return calloc(1, sizeof(struct nfsd_version_set_req));
+}
+void nfsd_version_set_req_free(struct nfsd_version_set_req *req);
+
+static inline void
+nfsd_version_set_req_set_major(struct nfsd_version_set_req *req, __u32 major)
+{
+	req->_present.major = 1;
+	req->major = major;
+}
+static inline void
+nfsd_version_set_req_set_minor(struct nfsd_version_set_req *req, __u32 minor)
+{
+	req->_present.minor = 1;
+	req->minor = minor;
+}
+static inline void
+nfsd_version_set_req_set_status(struct nfsd_version_set_req *req, __u8 status)
+{
+	req->_present.status = 1;
+	req->status = status;
+}
+
+/*
+ * enable/disable server version
+ */
+int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_req *req);
+
+/* ============== NFSD_CMD_VERSION_GET ============== */
+/* NFSD_CMD_VERSION_GET - dump */
+struct nfsd_version_get_list {
+	struct nfsd_version_get_list *next;
+	struct nfsd_version_get_rsp obj __attribute__ ((aligned (8)));
+};
+
+void nfsd_version_get_list_free(struct nfsd_version_get_list *rsp);
+
+struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock *ys);
+
 #endif /* _LINUX_NFSD_GEN_H */
-- 
2.43.0


