Return-Path: <linux-nfs+bounces-2950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D268AE813
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371401C22E5A
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E250135A5C;
	Tue, 23 Apr 2024 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK94rAF/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564BD45BFD;
	Tue, 23 Apr 2024 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878769; cv=none; b=KiBkzlUEIdjceBZ2ARBwbf11rJoUK4xIw2qxSnqUmbTVxRes4Nsjdbpx1otnpnbFtnrOZi48EGvNahN4yVoo4CnoXutfcRKuxdI0KYMnh6LvQ58sXqyS8XmF5eweNv9+HGxK411nqYj4e+KWIXwTiHHOjTpdvsUNTMF6G5NqK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878769; c=relaxed/simple;
	bh=z8nPcdCSrZjCTNmI4npnW+nJtWJcTk2uyjQWqx7QF/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMPgmZbpoJ49vxwJ5t2W29/B4IgL+CPD4uPuB2reWarNRRg5fE/vBT/qTm+4xw3Rl5xTkwGaAWM7iNgx70IVZRDwdq1ABN3k8vwCGHgw8pABF42nBUVDWE/Y1F2SPCo6tmr41TR88UhQQaIEJmY1VZ6zZ1vHWRRLAcZdUdriD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK94rAF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8576C116B1;
	Tue, 23 Apr 2024 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713878769;
	bh=z8nPcdCSrZjCTNmI4npnW+nJtWJcTk2uyjQWqx7QF/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sK94rAF/fk8TbrzNUEdhvYrS/yUKSAUs0DwyIztAz5CguxG2JJfrAdaRs/GkQNIuy
	 KJgyInCf2uNy+TLXareu6RdNPJvqTSDpaaI4QaNFtdlZQFOtvW/CJJpcMA3vvGM2tI
	 jkc+i3EUvKIed0sDjrsnlgxJt/yTZ00Nibd2JIyikF/wDjqH3lN7+BzM41GUmpNxh2
	 YYXb9Ob1nEdGB/XiOtefBojF9NU6e/FiLWJpnbY/zNay+Q3a3awWQZEIsa+TaSIWHh
	 Zvv9m/Hn4KBb6VdhCfFi+9iJwEM2S5ptLqmlo/xfrAfJJvkITm+IrPxRTvzTaFIPPh
	 zqK5KXfea/SZg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: neilb@suse.de,
	lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v9 3/7] NFSD: convert write_threads to netlink command
Date: Tue, 23 Apr 2024 15:25:40 +0200
Message-ID: <5e6ec472d58f9945a936f16c0ebf2e1e089e7ae0.1713878413.git.lorenzo@kernel.org>
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

Introduce write_threads netlink command similar to the one available
through the procfs.

Tested-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Co-developed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  39 +++++++
 fs/nfsd/netlink.c                     |  20 ++++
 fs/nfsd/netlink.h                     |   2 +
 fs/nfsd/nfsctl.c                      | 143 ++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  12 +++
 5 files changed, 216 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 05acc73e2e33..703c2d11d0a9 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -62,6 +62,22 @@ attribute-sets:
         name: compound-ops
         type: u32
         multi-attr: true
+  -
+    name: server
+    attributes:
+      -
+        name: threads
+        type: u32
+        multi-attr: true
+      -
+        name: gracetime
+        type: u32
+      -
+        name: leasetime
+        type: u32
+      -
+        name: scope
+        type: string
 
 operations:
   list:
@@ -87,3 +103,26 @@ operations:
             - sport
             - dport
             - compound-ops
+    -
+      name: threads-set
+      doc: set the number of running threads
+      attribute-set: server
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - threads
+            - gracetime
+            - leasetime
+            - scope
+    -
+      name: threads-get
+      doc: get the number of running threads
+      attribute-set: server
+      do:
+        reply:
+          attributes:
+            - threads
+            - gracetime
+            - leasetime
+            - scope
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 0e1d635ec5f9..fe9eef5c7f27 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -10,6 +10,14 @@
 
 #include <uapi/linux/nfsd_netlink.h>
 
+/* NFSD_CMD_THREADS_SET - do */
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_SCOPE + 1] = {
+	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -19,6 +27,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.done	= nfsd_nl_rpc_status_get_done,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NFSD_CMD_THREADS_SET,
+		.doit		= nfsd_nl_threads_set_doit,
+		.policy		= nfsd_threads_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_SCOPE,
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
index 34148d73b6c1..5bfdebb2e7e9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -15,6 +15,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/gss_api.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
+#include <linux/sunrpc/svc.h>
 #include <linux/module.h>
 #include <linux/fsnotify.h>
 
@@ -1653,6 +1654,148 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
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
+	int nthreads = 0, count = 0, nrpools, ret = -EOPNOTSUPP, rem;
+	struct net *net = genl_info_net(info);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	const struct nlattr *attr;
+	const char *scope = NULL;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_THREADS))
+		return -EINVAL;
+
+	/* count number of SERVER_THREADS values */
+	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
+			count++;
+	}
+
+	mutex_lock(&nfsd_mutex);
+
+	nrpools = nfsd_nrpools(net);
+	if (nrpools && count > nrpools)
+		count = nrpools;
+
+	/* XXX: make this handle non-global pool-modes */
+	if (count > 1)
+		goto out_unlock;
+
+	nthreads = nla_get_u32(info->attrs[NFSD_A_SERVER_THREADS]);
+	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
+	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
+	    info->attrs[NFSD_A_SERVER_SCOPE]) {
+		ret = -EBUSY;
+		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
+			goto out_unlock;
+
+		ret = -EINVAL;
+		attr = info->attrs[NFSD_A_SERVER_GRACETIME];
+		if (attr) {
+			u32 gracetime = nla_get_u32(attr);
+
+			if (gracetime < 10 || gracetime > 3600)
+				goto out_unlock;
+
+			nn->nfsd4_grace = gracetime;
+		}
+
+		attr = info->attrs[NFSD_A_SERVER_LEASETIME];
+		if (attr) {
+			u32 leasetime = nla_get_u32(attr);
+
+			if (leasetime < 10 || leasetime > 3600)
+				goto out_unlock;
+
+			nn->nfsd4_lease = leasetime;
+		}
+
+		attr = info->attrs[NFSD_A_SERVER_SCOPE];
+		if (attr)
+			scope = nla_data(attr);
+	}
+
+	ret = nfsd_svc(nthreads, net, get_current_cred(), scope);
+
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
+
+	err = nla_put_u32(skb, NFSD_A_SERVER_GRACETIME,
+			  nn->nfsd4_grace) ||
+	      nla_put_u32(skb, NFSD_A_SERVER_LEASETIME,
+			  nn->nfsd4_lease) ||
+	      nla_put_string(skb, NFSD_A_SERVER_SCOPE,
+			  nn->nfsd_name);
+	if (err)
+		goto err_unlock;
+
+	if (nn->nfsd_serv) {
+		int i;
+
+		for (i = 0; i < nfsd_nrpools(net); ++i) {
+			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
+
+			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
+					  atomic_read(&sp->sp_nrthreads));
+			if (err)
+				goto err_unlock;
+		}
+	} else {
+		err = nla_put_u32(skb, NFSD_A_SERVER_THREADS, 0);
+		if (err)
+			goto err_unlock;
+	}
+
+	mutex_unlock(&nfsd_mutex);
+
+	genlmsg_end(skb, hdr);
+
+	return genlmsg_reply(skb, info);
+
+err_unlock:
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
index 3cd044edee5d..4bbccd5db7cd 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -29,8 +29,20 @@ enum {
 	NFSD_A_RPC_STATUS_MAX = (__NFSD_A_RPC_STATUS_MAX - 1)
 };
 
+enum {
+	NFSD_A_SERVER_THREADS = 1,
+	NFSD_A_SERVER_GRACETIME,
+	NFSD_A_SERVER_LEASETIME,
+	NFSD_A_SERVER_SCOPE,
+
+	__NFSD_A_SERVER_MAX,
+	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
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


