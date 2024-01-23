Return-Path: <linux-nfs+bounces-1299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229F839465
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 17:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102E128BCB1
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FEC664C0;
	Tue, 23 Jan 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0nUmzYv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A3664BE
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026328; cv=none; b=c2lAhY/2DiaLO2cEphvtgqZubFeBvOlaSJuj9CgCauEvU3ALNFKOH3uUEyGP2oXUPPRLgbKf/bc0loeDD1NZS+04ZyVsn2zEYYVGzSJ0dPEHW51gA5rHzJWA2zZj/GRK7Uk5KgPAiPh1QEjDiG+L6A2H53YlHNvArzQaGdN10sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026328; c=relaxed/simple;
	bh=IStJxbdbescuyly+kae/Jox5teKRW4Wj1y6PyBVG6gM=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=GnriypqX4WP/S4kFtME7BSsT32X8lL7cTMHNOkmc9C6XZG05m3Co7gvPgKHjSfJXAGt8gAi7DdFU3NZQBw+r2iybdYOyDzLpf6XybdFsHfAHoiFLYiIZri/jIDc3Ynet0FuhP3AIsQpcuF3gKzhBlPbI9ovjGcfaYMb/dZbKEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0nUmzYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E76CC433C7
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 16:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706026327;
	bh=IStJxbdbescuyly+kae/Jox5teKRW4Wj1y6PyBVG6gM=;
	h=Subject:From:To:Date:From;
	b=O0nUmzYvoNmLtQsC3VqM8atdPjfp13by7SVNCQjRwGihfD7SCH6bMmwzyn3Wh3HIO
	 LDFNS+qc5jg7yVvc/71CEb9NsnYVP1vhFLu71FNWequQdpppz+gvr8DJHLDnwyst+B
	 HfXu9SINOWdXl+i3THBNX/GZfCD9/vcdwPtDpF1gpe4U5+NgAIZ6x3DF4ArmD3L8l/
	 WYwu9R+WxCqcVGIIV5IKOl4/CmE3xLpwzLJuLhhq7IEmNE6W/mGcUv7sECbniwj5oB
	 KJScLURvT140S7JwXMnNhtAKBJlU3vJvBbvTZVqKWh22F/IXGbBvnXbgBCPBS0BR8y
	 aF3MvTjuH+VnA==
Subject: [PATCH v1] NFSD: Add a switch to disable nfsd_splice_read()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Tue, 23 Jan 2024 11:12:06 -0500
Message-ID: 
 <170602632623.217131.13021600519850917517.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

This enables us to ensure that testing properly covers the readv
paths as well as the spliced read paths, which are more commonly
used. Also this makes it easier to do benchmark comparisons between
splice and vectored reads.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml |   19 +++++++
 fs/nfsd/netlink.c                     |   17 ++++++
 fs/nfsd/netlink.h                     |    3 +
 fs/nfsd/netns.h                       |    1 
 fs/nfsd/nfsctl.c                      |   45 ++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |    8 +++
 tools/net/ynl/generated/nfsd-user.c   |   95 +++++++++++++++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   |   47 ++++++++++++++++
 8 files changed, 235 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 05acc73e2e33..1a3c5e78b388 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -62,6 +62,12 @@ attribute-sets:
         name: compound-ops
         type: u32
         multi-attr: true
+  -
+    name: splice-read
+    attributes:
+      -
+        name: enabled
+        type: u32
 
 operations:
   list:
@@ -87,3 +93,16 @@ operations:
             - sport
             - dport
             - compound-ops
+    -
+      name: splice-read
+      doc: Disable the use of splice for NFS READ operations
+      attribute-set: splice-read
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - enabled
+      dump:
+        reply:
+          attributes:
+            - enabled
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 0e1d635ec5f9..c47f3527d30b 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -10,6 +10,11 @@
 
 #include <uapi/linux/nfsd_netlink.h>
 
+/* NFSD_CMD_SPLICE_READ - do */
+static const struct nla_policy nfsd_splice_read_nl_policy[NFSD_A_SPLICE_READ_ENABLED + 1] = {
+	[NFSD_A_SPLICE_READ_ENABLED] = { .type = NLA_U32, },
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
+		.cmd		= NFSD_CMD_SPLICE_READ,
+		.doit		= nfsd_nl_splice_read_doit,
+		.policy		= nfsd_splice_read_nl_policy,
+		.maxattr	= NFSD_A_SPLICE_READ_ENABLED,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_SPLICE_READ,
+		.dumpit	= nfsd_nl_splice_read_dumpit,
+		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index d83dd6bdee92..2d96d0f093bb 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -16,6 +16,9 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
 
 int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				  struct netlink_callback *cb);
+int nfsd_nl_splice_read_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_splice_read_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 74b4360779a1..3b9e09fecbfc 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -109,6 +109,7 @@ struct nfsd_net {
 
 	bool nfsd_net_up;
 	bool lockd_up;
+	bool spliced_reads;
 
 	seqlock_t writeverf_lock;
 	unsigned char writeverf[8];
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 8e6dbe9e0b65..86f466dbc784 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1696,6 +1696,51 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
 	return 0;
 }
 
+/**
+ * nfsd_nl_splice_read_doit - Set the value of splice_read
+ * @skb: call buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Returns zero on success, or a negative errno.
+ */
+int nfsd_nl_splice_read_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
+	u32 newval;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SPLICE_READ_ENABLED))
+		return -EINVAL;
+
+	newval = nla_get_u32(info->attrs[NFSD_A_SPLICE_READ_ENABLED]);
+	nn->spliced_reads = newval ? true : false;
+	return 0;
+}
+
+/**
+ * nfsd_nl_splice_read_dumpit - Return the value of splice_read
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_splice_read_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
+	void *hdr;
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &nfsd_nl_family, 0, NFSD_CMD_SPLICE_READ);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put_s32(skb, NFSD_A_SPLICE_READ_ENABLED,
+			(nn->spliced_reads ? 1 : 0)))
+		return -ENOBUFS;
+
+	genlmsg_end(skb, hdr);
+	return 0;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 3cd044edee5d..c2542ed18b50 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -29,8 +29,16 @@ enum {
 	NFSD_A_RPC_STATUS_MAX = (__NFSD_A_RPC_STATUS_MAX - 1)
 };
 
+enum {
+	NFSD_A_SPLICE_READ_ENABLED = 1,
+
+	__NFSD_A_SPLICE_READ_MAX,
+	NFSD_A_SPLICE_READ_MAX = (__NFSD_A_SPLICE_READ_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
+	NFSD_CMD_SPLICE_READ,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
index 360b6448c6e9..14957bdfbe9c 100644
--- a/tools/net/ynl/generated/nfsd-user.c
+++ b/tools/net/ynl/generated/nfsd-user.c
@@ -15,6 +15,7 @@
 /* Enums */
 static const char * const nfsd_op_strmap[] = {
 	[NFSD_CMD_RPC_STATUS_GET] = "rpc-status-get",
+	[NFSD_CMD_SPLICE_READ] = "splice-read",
 };
 
 const char *nfsd_op_str(int op)
@@ -47,6 +48,15 @@ struct ynl_policy_nest nfsd_rpc_status_nest = {
 	.table = nfsd_rpc_status_policy,
 };
 
+struct ynl_policy_attr nfsd_splice_read_policy[NFSD_A_SPLICE_READ_MAX + 1] = {
+	[NFSD_A_SPLICE_READ_ENABLED] = { .name = "enabled", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest nfsd_splice_read_nest = {
+	.max_attr = NFSD_A_SPLICE_READ_MAX,
+	.table = nfsd_splice_read_policy,
+};
+
 /* Common nested types */
 /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
 /* NFSD_CMD_RPC_STATUS_GET - dump */
@@ -198,6 +208,91 @@ nfsd_rpc_status_get_dump(struct ynl_sock *ys)
 	return NULL;
 }
 
+/* ============== NFSD_CMD_SPLICE_READ ============== */
+/* NFSD_CMD_SPLICE_READ - do */
+void nfsd_splice_read_req_free(struct nfsd_splice_read_req *req)
+{
+	free(req);
+}
+
+int nfsd_splice_read(struct ynl_sock *ys, struct nfsd_splice_read_req *req)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_SPLICE_READ, 1);
+	ys->req_policy = &nfsd_splice_read_nest;
+
+	if (req->_present.enabled)
+		mnl_attr_put_u32(nlh, NFSD_A_SPLICE_READ_ENABLED, req->enabled);
+
+	err = ynl_exec(ys, nlh, NULL);
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
+/* NFSD_CMD_SPLICE_READ - dump */
+int nfsd_splice_read_rsp_dump_parse(const struct nlmsghdr *nlh, void *data)
+{
+	struct nfsd_splice_read_rsp_dump *dst;
+	struct ynl_parse_arg *yarg = data;
+	const struct nlattr *attr;
+
+	dst = yarg->data;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NFSD_A_SPLICE_READ_ENABLED) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.enabled = 1;
+			dst->enabled = mnl_attr_get_u32(attr);
+		}
+	}
+
+	return MNL_CB_OK;
+}
+
+void nfsd_splice_read_rsp_list_free(struct nfsd_splice_read_rsp_list *rsp)
+{
+	struct nfsd_splice_read_rsp_list *next = rsp;
+
+	while ((void *)next != YNL_LIST_END) {
+		rsp = next;
+		next = rsp->next;
+
+		free(rsp);
+	}
+}
+
+struct nfsd_splice_read_rsp_list *nfsd_splice_read_dump(struct ynl_sock *ys)
+{
+	struct ynl_dump_state yds = {};
+	struct nlmsghdr *nlh;
+	int err;
+
+	yds.ys = ys;
+	yds.alloc_sz = sizeof(struct nfsd_splice_read_rsp_list);
+	yds.cb = nfsd_splice_read_rsp_dump_parse;
+	yds.rsp_cmd = NFSD_CMD_SPLICE_READ;
+	yds.rsp_policy = &nfsd_splice_read_nest;
+
+	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_SPLICE_READ, 1);
+
+	err = ynl_exec_dump(ys, nlh, &yds);
+	if (err < 0)
+		goto free_list;
+
+	return yds.first;
+
+free_list:
+	nfsd_splice_read_rsp_list_free(yds.first);
+	return NULL;
+}
+
 const struct ynl_family ynl_nfsd_family =  {
 	.name		= "nfsd",
 };
diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
index 989c6e209ced..5732c5a665e7 100644
--- a/tools/net/ynl/generated/nfsd-user.h
+++ b/tools/net/ynl/generated/nfsd-user.h
@@ -64,4 +64,51 @@ nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_status_get_rsp_list *rsp);
 struct nfsd_rpc_status_get_rsp_list *
 nfsd_rpc_status_get_dump(struct ynl_sock *ys);
 
+/* ============== NFSD_CMD_SPLICE_READ ============== */
+/* NFSD_CMD_SPLICE_READ - do */
+struct nfsd_splice_read_req {
+	struct {
+		__u32 enabled:1;
+	} _present;
+
+	__u32 enabled;
+};
+
+static inline struct nfsd_splice_read_req *nfsd_splice_read_req_alloc(void)
+{
+	return calloc(1, sizeof(struct nfsd_splice_read_req));
+}
+void nfsd_splice_read_req_free(struct nfsd_splice_read_req *req);
+
+static inline void
+nfsd_splice_read_req_set_enabled(struct nfsd_splice_read_req *req,
+				 __u32 enabled)
+{
+	req->_present.enabled = 1;
+	req->enabled = enabled;
+}
+
+/*
+ * Disable the use of splice for NFS READ operations
+ */
+int nfsd_splice_read(struct ynl_sock *ys, struct nfsd_splice_read_req *req);
+
+/* NFSD_CMD_SPLICE_READ - dump */
+struct nfsd_splice_read_rsp_dump {
+	struct {
+		__u32 enabled:1;
+	} _present;
+
+	__u32 enabled;
+};
+
+struct nfsd_splice_read_rsp_list {
+	struct nfsd_splice_read_rsp_list *next;
+	struct nfsd_splice_read_rsp_dump obj __attribute__ ((aligned (8)));
+};
+
+void nfsd_splice_read_rsp_list_free(struct nfsd_splice_read_rsp_list *rsp);
+
+struct nfsd_splice_read_rsp_list *nfsd_splice_read_dump(struct ynl_sock *ys);
+
 #endif /* _LINUX_NFSD_GEN_H */



