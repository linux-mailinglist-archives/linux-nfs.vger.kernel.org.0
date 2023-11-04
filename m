Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150357E0F08
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Nov 2023 12:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjKDLOU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Nov 2023 07:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjKDLOT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Nov 2023 07:14:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190B7D42
        for <linux-nfs@vger.kernel.org>; Sat,  4 Nov 2023 04:14:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F946C433C7;
        Sat,  4 Nov 2023 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699096455;
        bh=capCfYD2XiW1Wu517kGoXSoHMKO5+OzR6iG0rl38P24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbCVm4H6ejjulB8+g1+uqe0JgAbeUHdvMqGHK8jqCunxCdAb6kLAlQYYsGqEK0hw1
         yQLaqIbyMLyKSXV7xZXoJqHCtnYNN8boOEX/DbDRWum/AwWAKhg56B5g8cNW94WvFe
         SRzlbChAV9TSypR/xNQglXiDkptDI0RJQhDYJRIAWYydZ20O6bUWNw/uzFY7JygGOX
         PfZNJrw66+oc8QyuMmJ2UzwwuL3UeGprz1zDSPjyOOgV8ESNCT8n72febFePL/t8vx
         du28ucltvG1uXfzxPd1+v0Jw8RsC+0ykEkn0fXTKh0ureGhykmiCy59KOFi4RyiwEn
         GDOZ1m94s3JbA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, neilb@suse.de, chuck.lever@oracle.com,
        netdev@vger.kernel.org, jlayton@kernel.org, kuba@kernel.org
Subject: [PATCH v4 1/3] NFSD: convert write_threads to netlink command
Date:   Sat,  4 Nov 2023 12:13:45 +0100
Message-ID: <ac01a0f3972dd8175238e27a69db0acf0fed89db.1699095665.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699095665.git.lorenzo@kernel.org>
References: <cover.1699095665.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce write_threads netlink command similar to the ones available
through the procfs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml | 23 +++++++
 fs/nfsd/netlink.c                     | 17 +++++
 fs/nfsd/netlink.h                     |  2 +
 fs/nfsd/nfsctl.c                      | 58 +++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  9 +++
 tools/net/ynl/generated/nfsd-user.c   | 92 +++++++++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   | 47 ++++++++++++++
 7 files changed, 248 insertions(+)

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
index 739ed5bf71cd..0d0394887506 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1693,6 +1693,64 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
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
+	ret = nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
+
+	return ret == nthreads ? 0 : ret;
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
+	return err;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index c8ae72466ee6..99f7855852a1 100644
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
index fec6828680ce..342a00b0474a 100644
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
@@ -90,6 +101,87 @@ struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys)
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
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_SET, 1);
+	ys->req_policy = &nfsd_server_worker_nest;
+
+	if (req->_present.threads)
+		mnl_attr_put_u32(nlh, NFSD_A_SERVER_WORKER_THREADS, req->threads);
+
+	err = ynl_exec(ys, nlh, NULL);
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
index b6b69501031a..4c11119217f1 100644
--- a/tools/net/ynl/generated/nfsd-user.h
+++ b/tools/net/ynl/generated/nfsd-user.h
@@ -30,4 +30,51 @@ void nfsd_rpc_status_get_list_free(struct nfsd_rpc_status_get_list *rsp);
 
 struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys);
 
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
2.41.0

