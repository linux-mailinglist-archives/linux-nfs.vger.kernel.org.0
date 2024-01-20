Return-Path: <linux-nfs+bounces-1211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D203C833585
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jan 2024 18:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5361C1F2204B
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jan 2024 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACB211737;
	Sat, 20 Jan 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgBwypnE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668211733;
	Sat, 20 Jan 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705772045; cv=none; b=J/2bR5KZdV5Pj5pDT8s7k8UpYFYCz+OO4+qXbmhOJCL/qDOgsSF2/4sB4/fdqfs8MvNIUHFEYzNlQKOHu8a7vEaUPRRbnYjiVW+xeMyiSftiXTsstGhqRwDGrVJ/vTPwSRDDPbn/b+CcRetYzF2u2AT/Z0pa0/+7+IsZqmObyEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705772045; c=relaxed/simple;
	bh=faQP214UQVyjOF2wg6Q3l4tSrn9De1BK7U/zsIHTFow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lfkd+oepUHJvHXMMkPAeE6N4JfdQR0EylSw992iMGMze985t1ivRHTyG7Um63kdkA/sorNCqMQx9kj9ZWGBNsCRxg2vOEzV1Gk4eqtGmLxnM0pA4Z8a7j8Syl46W7C8+fblq0myvKoViuDw7rWzypN0KIunu7VaP0xp+SsO5Pz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgBwypnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A49C433C7;
	Sat, 20 Jan 2024 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705772045;
	bh=faQP214UQVyjOF2wg6Q3l4tSrn9De1BK7U/zsIHTFow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgBwypnEEMuY6ivfUw0xno7oet450Dlydhnz2UodE9+CFsYBiobFZjOcZK+jbPlAl
	 7d/cVfuyE2fBifY1xKGsgRNEJakEzwW2somVRDsxHqdocT00w46ZTdMCagc1slZYkS
	 14OpQn/z6mpIozR67aEi4vNWaVO6xG/vCH/DtbafGURQjycnxcVHGHUU4mc9o0e50T
	 P/+T+DUKBApkmEHNqGif+WqeVJ7/w0DzmJKC9YM0znwwqek7Bs7ywMGFeWb5+DxBYp
	 hXt3hDUtXYD1FGLLDIbckEPcOTPDlh0UOJ6OG+e9oLs0pYCWloeBytW3b7P+RLpHie
	 MDtzG7tDXourw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	neilb@suse.de,
	jlayton@kernel.org,
	kuba@kernel.org,
	chuck.lever@oracle.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 1/3] NFSD: convert write_threads to netlink command
Date: Sat, 20 Jan 2024 18:33:30 +0100
Message-ID: <054723fd005379bba529b35f26ee5be3a72ce143.1705771400.git.lorenzo@kernel.org>
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

Introduce write_threads netlink command similar to the one available
through the procfs.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml | 23 +++++++
 fs/nfsd/netlink.c                     | 17 +++++
 fs/nfsd/netlink.h                     |  2 +
 fs/nfsd/nfsctl.c                      | 60 +++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  9 +++
 tools/net/ynl/generated/nfsd-user.c   | 93 +++++++++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   | 47 ++++++++++++++
 7 files changed, 251 insertions(+)

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
index 8e6dbe9e0b65..68718448d660 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1696,6 +1696,66 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
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
diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
index 360b6448c6e9..f4121a52ccf8 100644
--- a/tools/net/ynl/generated/nfsd-user.c
+++ b/tools/net/ynl/generated/nfsd-user.c
@@ -15,6 +15,8 @@
 /* Enums */
 static const char * const nfsd_op_strmap[] = {
 	[NFSD_CMD_RPC_STATUS_GET] = "rpc-status-get",
+	[NFSD_CMD_THREADS_SET] = "threads-set",
+	[NFSD_CMD_THREADS_GET] = "threads-get",
 };
 
 const char *nfsd_op_str(int op)
@@ -47,6 +49,15 @@ struct ynl_policy_nest nfsd_rpc_status_nest = {
 	.table = nfsd_rpc_status_policy,
 };
 
+struct ynl_policy_attr nfsd_server_worker_policy[NFSD_A_SERVER_WORKER_MAX + 1] = {
+	[NFSD_A_SERVER_WORKER_THREADS] = { .name = "threads", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest nfsd_server_worker_nest = {
+	.max_attr = NFSD_A_SERVER_WORKER_MAX,
+	.table = nfsd_server_worker_policy,
+};
+
 /* Common nested types */
 /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
 /* NFSD_CMD_RPC_STATUS_GET - dump */
@@ -198,6 +209,88 @@ nfsd_rpc_status_get_dump(struct ynl_sock *ys)
 	return NULL;
 }
 
+/* ============== NFSD_CMD_THREADS_SET ============== */
+/* NFSD_CMD_THREADS_SET - do */
+void nfsd_threads_set_req_free(struct nfsd_threads_set_req *req)
+{
+	free(req);
+}
+
+int nfsd_threads_set(struct ynl_sock *ys, struct nfsd_threads_set_req *req)
+{
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_SET, 1);
+	ys->req_policy = &nfsd_server_worker_nest;
+
+	if (req->_present.threads)
+		mnl_attr_put_u32(nlh, NFSD_A_SERVER_WORKER_THREADS, req->threads);
+
+	err = ynl_exec(ys, nlh, &yrs);
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
+/* ============== NFSD_CMD_THREADS_GET ============== */
+/* NFSD_CMD_THREADS_GET - do */
+void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp)
+{
+	free(rsp);
+}
+
+int nfsd_threads_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
+{
+	struct ynl_parse_arg *yarg = data;
+	struct nfsd_threads_get_rsp *dst;
+	const struct nlattr *attr;
+
+	dst = yarg->data;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NFSD_A_SERVER_WORKER_THREADS) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.threads = 1;
+			dst->threads = mnl_attr_get_u32(attr);
+		}
+	}
+
+	return MNL_CB_OK;
+}
+
+struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys)
+{
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
+	struct nfsd_threads_get_rsp *rsp;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_GET, 1);
+	ys->req_policy = &nfsd_server_worker_nest;
+	yrs.yarg.rsp_policy = &nfsd_server_worker_nest;
+
+	rsp = calloc(1, sizeof(*rsp));
+	yrs.yarg.data = rsp;
+	yrs.cb = nfsd_threads_get_rsp_parse;
+	yrs.rsp_cmd = NFSD_CMD_THREADS_GET;
+
+	err = ynl_exec(ys, nlh, &yrs);
+	if (err < 0)
+		goto err_free;
+
+	return rsp;
+
+err_free:
+	nfsd_threads_get_rsp_free(rsp);
+	return NULL;
+}
+
 const struct ynl_family ynl_nfsd_family =  {
 	.name		= "nfsd",
 };
diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
index 989c6e209ced..e162a4f20d91 100644
--- a/tools/net/ynl/generated/nfsd-user.h
+++ b/tools/net/ynl/generated/nfsd-user.h
@@ -64,4 +64,51 @@ nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_status_get_rsp_list *rsp);
 struct nfsd_rpc_status_get_rsp_list *
 nfsd_rpc_status_get_dump(struct ynl_sock *ys);
 
+/* ============== NFSD_CMD_THREADS_SET ============== */
+/* NFSD_CMD_THREADS_SET - do */
+struct nfsd_threads_set_req {
+	struct {
+		__u32 threads:1;
+	} _present;
+
+	__u32 threads;
+};
+
+static inline struct nfsd_threads_set_req *nfsd_threads_set_req_alloc(void)
+{
+	return calloc(1, sizeof(struct nfsd_threads_set_req));
+}
+void nfsd_threads_set_req_free(struct nfsd_threads_set_req *req);
+
+static inline void
+nfsd_threads_set_req_set_threads(struct nfsd_threads_set_req *req,
+				 __u32 threads)
+{
+	req->_present.threads = 1;
+	req->threads = threads;
+}
+
+/*
+ * set the number of running threads
+ */
+int nfsd_threads_set(struct ynl_sock *ys, struct nfsd_threads_set_req *req);
+
+/* ============== NFSD_CMD_THREADS_GET ============== */
+/* NFSD_CMD_THREADS_GET - do */
+
+struct nfsd_threads_get_rsp {
+	struct {
+		__u32 threads:1;
+	} _present;
+
+	__u32 threads;
+};
+
+void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp);
+
+/*
+ * get the number of running threads
+ */
+struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
+
 #endif /* _LINUX_NFSD_GEN_H */
-- 
2.43.0


