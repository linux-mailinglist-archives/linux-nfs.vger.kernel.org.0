Return-Path: <linux-nfs+bounces-2822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8D18A5B88
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 21:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C508E288C45
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 19:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419315B579;
	Mon, 15 Apr 2024 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJJq0ioo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29C156997;
	Mon, 15 Apr 2024 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210314; cv=none; b=FhlgL4s2wG9yy7bAOpSlxpCjTcANugpVMxF1Jx49nprCDlQgFLfBkO6K+eZKO7fFpebZiRcpOlFKeZxFHeZSetw6+wohYNc5xLeReXbQTyEc78MliQEU5e6wkx1AVdvYFXDkIn8fvyynx1+CNLzMVouM6P907iOsEQ/U1iKhyEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210314; c=relaxed/simple;
	bh=c9appUypE9UwFM2sEKyJ8H+OyIHk9lowUrJlHVql6u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyqzQsiD9r9LikiMkWIvJ2JHLBq60WNT+wgt52hpPVEC52YqXA6F4Jysd44C/Rm8FqNFlj2sJ05XKWwQnrOaG4LpznnSma9Tp4bVzAskWW1FxXTGPs6OgIl/fvk0CLx7B6Jkj5h+Mgo5yk4PSJqO6OHFpyJk/gUNB2gdUc9XarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJJq0ioo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CF5C113CC;
	Mon, 15 Apr 2024 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713210314;
	bh=c9appUypE9UwFM2sEKyJ8H+OyIHk9lowUrJlHVql6u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJJq0ioo7RTzKLMwDs6z06bd6imCptNi3cVb2fJVeRvW+PFB1MNIPNuIn57gj6TJI
	 Xvbsk8rhJL/gNNgjDgy0zQXgOl7regZ5tb3BvYjaHFeXkJh/mAUwPNsUNC3ZrPnQpK
	 kmwd9QP1eVgLyYanZ6/j3FDWabyiBkzs5pOWi1vzm36QMFO6VfguparZ3ZMm+odXHG
	 Vn5EMDROfYpiFqDnBk/h0FPxU/kPmgvPnENjYJzEF79EG1JMSGSyGJ/S8LVnLnT7yQ
	 973cHRx+3AP6g13sDF8x92CtkWMLmQg5qshlv1RTUhW2iitS/cbqzIM8IWwMNmOuI+
	 mTYDL3EzseC1Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v8 2/6] NFSD: convert write_threads to netlink command
Date: Mon, 15 Apr 2024 21:44:35 +0200
Message-ID: <4ff777ebb8652e31709bd91c3af50693edf86a26.1713209938.git.lorenzo@kernel.org>
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

Introduce write_threads netlink command similar to the one available
through the procfs.

Tested-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Co-developed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  33 ++++++++
 fs/nfsd/netlink.c                     |  19 +++++
 fs/nfsd/netlink.h                     |   2 +
 fs/nfsd/nfsctl.c                      | 104 ++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  11 +++
 5 files changed, 169 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 05acc73e2e33..cbe6c5fd6c4d 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -62,6 +62,18 @@ attribute-sets:
         name: compound-ops
         type: u32
         multi-attr: true
+  -
+    name: server-worker
+    attributes:
+      -
+        name: threads
+        type: u32
+      -
+        name: gracetime
+        type: u32
+      -
+        name: leasetime
+        type: u32
 
 operations:
   list:
@@ -87,3 +99,24 @@ operations:
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
+            - gracetime
+            - leasetime
+    -
+      name: threads-get
+      doc: get the number of running threads
+      attribute-set: server-worker
+      do:
+        reply:
+          attributes:
+            - threads
+            - gracetime
+            - leasetime
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 0e1d635ec5f9..20a646af0324 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -10,6 +10,13 @@
 
 #include <uapi/linux/nfsd_netlink.h>
 
+/* NFSD_CMD_THREADS_SET - do */
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_LEASETIME + 1] = {
+	[NFSD_A_SERVER_WORKER_THREADS] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_WORKER_GRACETIME] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_WORKER_LEASETIME] = { .type = NLA_U32, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -19,6 +26,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.done	= nfsd_nl_rpc_status_get_done,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NFSD_CMD_THREADS_SET,
+		.doit		= nfsd_nl_threads_set_doit,
+		.policy		= nfsd_threads_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_WORKER_LEASETIME,
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
index f2e442d7fe16..38a5df03981b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1653,6 +1653,110 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
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
+	struct net *net = genl_info_net(info);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	int ret = -EBUSY;
+	u32 nthreads;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_WORKER_THREADS))
+		return -EINVAL;
+
+	nthreads = nla_get_u32(info->attrs[NFSD_A_SERVER_WORKER_THREADS]);
+
+	mutex_lock(&nfsd_mutex);
+	if (info->attrs[NFSD_A_SERVER_WORKER_GRACETIME] ||
+	    info->attrs[NFSD_A_SERVER_WORKER_LEASETIME]) {
+		const struct nlattr *attr;
+
+		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
+			goto out_unlock;
+
+		ret = -EINVAL;
+		attr = info->attrs[NFSD_A_SERVER_WORKER_GRACETIME];
+		if (attr) {
+			u32 gracetime = nla_get_u32(attr);
+
+			if (gracetime < 10 || gracetime > 3600)
+				goto out_unlock;
+
+			nn->nfsd4_grace = gracetime;
+		}
+
+		attr = info->attrs[NFSD_A_SERVER_WORKER_LEASETIME];
+		if (attr) {
+			u32 leasetime = nla_get_u32(attr);
+
+			if (leasetime < 10 || leasetime > 3600)
+				goto out_unlock;
+
+			nn->nfsd4_lease = leasetime;
+		}
+	}
+
+	ret = nfsd_svc(nthreads, net, get_current_cred());
+out_unlock:
+	mutex_unlock(&nfsd_mutex);
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
+	struct net *net = genl_info_net(info);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
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
+	err = nla_put_u32(skb, NFSD_A_SERVER_WORKER_GRACETIME,
+			  nn->nfsd4_grace) ||
+	      nla_put_u32(skb, NFSD_A_SERVER_WORKER_LEASETIME,
+			  nn->nfsd4_lease) ||
+	      nla_put_u32(skb, NFSD_A_SERVER_WORKER_THREADS,
+			  nn->nfsd_serv ? nn->nfsd_serv->sv_nrthreads : 0);
+	mutex_unlock(&nfsd_mutex);
+
+	if (err) {
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
index 3cd044edee5d..ccc78a5ee650 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -29,8 +29,19 @@ enum {
 	NFSD_A_RPC_STATUS_MAX = (__NFSD_A_RPC_STATUS_MAX - 1)
 };
 
+enum {
+	NFSD_A_SERVER_WORKER_THREADS = 1,
+	NFSD_A_SERVER_WORKER_GRACETIME,
+	NFSD_A_SERVER_WORKER_LEASETIME,
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


