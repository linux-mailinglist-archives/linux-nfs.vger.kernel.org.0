Return-Path: <linux-nfs+bounces-2823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B624E8A5B8A
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 21:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E426BB2448E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB115B96D;
	Mon, 15 Apr 2024 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+tTi46M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128DA156997;
	Mon, 15 Apr 2024 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210318; cv=none; b=MW2GoB+O+4oVl5Mk8Pm4XS0b5xrBGxbncWq/cFiic1kmL+KUZv5msdNGYETZCDDOtpevVXgpDQcMG04A2QELyrZnYk1VQEcV3b7kNhgfcs+2W+FKxsR37ShrO44NmisV1qT4wVg9pMGGGvQlNNd9LbewxP3Lwn5ZQ8by/wycL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210318; c=relaxed/simple;
	bh=7XQ+0gdAhPhCGjjejaaS2vBfsMxwcog45cQabMq/kyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKW3+MYK4YFykmuzdHwRbuWj3PU06NnAfmxQoRoba/baYzT+jtmZgHpfOxc+Y3/iX9gl55pjLNa6UvP8oSqVVknh8qh0e+0Di3STP/SWcQo9jLha19b4EKUF7bDPwkaeAMOrlxqpP0rqXsGYDj2j7g39/CQHpMJcY5W3/5m/8cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+tTi46M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9376AC113CC;
	Mon, 15 Apr 2024 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713210317;
	bh=7XQ+0gdAhPhCGjjejaaS2vBfsMxwcog45cQabMq/kyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+tTi46MwcFcHkbjmGCZ4kunl1xHjFxR3tHH0fyjpXkeYhuhL626Tj0JnskBsf35H
	 7P0jbN2oP1snTJtJp1BACbu2f1yIfqdMjKYpfllHY2n6+sh0goYCi8agNEtKxOBvki
	 yVi9mGl/PD7dbPaj/9hhEpTBbdz7EG2kwf/yo6lM5daqC7znbSdhsczFxKpkh4CL3E
	 FrR41Bc9C1Lq6fhYkIzOB9KTLIBsr8fPYGh1vhOBLD1MlhNIhX0iZRUglmeJze4Ydc
	 ugPi5sbgP2+eoZrDfhkFy6RyerwyxfA+Y67teDotdbJqaTd/3/DifMcH3B+nR9Gxqn
	 j5TB2sYZkNogQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	neilb@suse.de,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v8 3/6] NFSD: add write_version to netlink command
Date: Mon, 15 Apr 2024 21:44:36 +0200
Message-ID: <1036367642228283184f85715edc0e3227a8e3ae.1713209938.git.lorenzo@kernel.org>
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

Introduce write_version netlink command through a "declarative" interface.
This patch introduces a change in behavior since for version-set userspace
is expected to provide a NFS major/minor version list it wants to enable
while all the other ones will be disabled. (procfs write_version
command implements imperative interface where the admin writes +3/-3 to
enable/disable a single version.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  37 +++++++
 fs/nfsd/netlink.c                     |  24 +++++
 fs/nfsd/netlink.h                     |   5 +
 fs/nfsd/netns.h                       |   1 +
 fs/nfsd/nfsctl.c                      | 150 ++++++++++++++++++++++++++
 fs/nfsd/nfssvc.c                      |   3 +-
 include/uapi/linux/nfsd_netlink.h     |  18 ++++
 7 files changed, 236 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index cbe6c5fd6c4d..0396e8b3ea1f 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -74,6 +74,26 @@ attribute-sets:
       -
         name: leasetime
         type: u32
+  -
+    name: version
+    attributes:
+      -
+        name: major
+        type: u32
+      -
+        name: minor
+        type: u32
+      -
+        name: enabled
+        type: flag
+  -
+    name: server-proto
+    attributes:
+      -
+        name: version
+        type: nest
+        nested-attributes: version
+        multi-attr: true
 
 operations:
   list:
@@ -120,3 +140,20 @@ operations:
             - threads
             - gracetime
             - leasetime
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
index 20a646af0324..bf5df9597288 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -10,6 +10,13 @@
 
 #include <uapi/linux/nfsd_netlink.h>
 
+/* Common nested types */
+const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
+	[NFSD_A_VERSION_MAJOR] = { .type = NLA_U32, },
+	[NFSD_A_VERSION_MINOR] = { .type = NLA_U32, },
+	[NFSD_A_VERSION_ENABLED] = { .type = NLA_FLAG, },
+};
+
 /* NFSD_CMD_THREADS_SET - do */
 static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_LEASETIME + 1] = {
 	[NFSD_A_SERVER_WORKER_THREADS] = { .type = NLA_U32, },
@@ -17,6 +24,11 @@ static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_L
 	[NFSD_A_SERVER_WORKER_LEASETIME] = { .type = NLA_U32, },
 };
 
+/* NFSD_CMD_VERSION_SET - do */
+static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_PROTO_VERSION + 1] = {
+	[NFSD_A_SERVER_PROTO_VERSION] = NLA_POLICY_NESTED(nfsd_version_nl_policy),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -38,6 +50,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
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
index 4137fac477e4..c7c0da275481 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -11,6 +11,9 @@
 
 #include <uapi/linux/nfsd_netlink.h>
 
+/* Common nested types */
+extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1];
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
 
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index d4be519b5734..14ec15656320 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -218,6 +218,7 @@ struct nfsd_net {
 /* Simple check to find out if a given net was properly initialized */
 #define nfsd_netns_ready(nn) ((nn)->sessionid_hashtbl)
 
+extern bool nfsd_support_version(int vers);
 extern void nfsd_netns_free_versions(struct nfsd_net *nn);
 
 extern unsigned int nfsd_net_id;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 38a5df03981b..2c8929ef79e9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1757,6 +1757,156 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
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
+		struct nlattr *tb[NFSD_A_VERSION_MAX + 1];
+		u32 major, minor = 0;
+		bool enabled;
+
+		if (nla_type(attr) != NFSD_A_SERVER_PROTO_VERSION)
+			continue;
+
+		if (nla_parse_nested(tb, NFSD_A_VERSION_MAX, attr,
+				     nfsd_version_nl_policy, info->extack) < 0)
+			continue;
+
+		if (!tb[NFSD_A_VERSION_MAJOR])
+			continue;
+
+		major = nla_get_u32(tb[NFSD_A_VERSION_MAJOR]);
+		if (tb[NFSD_A_VERSION_MINOR])
+			minor = nla_get_u32(tb[NFSD_A_VERSION_MINOR]);
+
+		enabled = nla_get_flag(tb[NFSD_A_VERSION_ENABLED]);
+
+		switch (major) {
+		case 4:
+			nfsd_minorversion(nn, minor, enabled ? NFSD_SET : NFSD_CLEAR);
+			break;
+		case 3:
+		case 2:
+			if (!minor)
+				nfsd_vers(nn, major, enabled ? NFSD_SET : NFSD_CLEAR);
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
+			/* Don't record any versions the kernel doesn't have
+			 * compiled in
+			 */
+			if (!nfsd_support_version(i))
+				continue;
+
+			/* NFSv{2,3} does not support minor numbers */
+			if (i < 4 && j)
+				continue;
+
+			attr = nla_nest_start(skb,
+					      NFSD_A_SERVER_PROTO_VERSION);
+			if (!attr) {
+				err = -EINVAL;
+				goto err_nfsd_unlock;
+			}
+
+			if (nla_put_u32(skb, NFSD_A_VERSION_MAJOR, i) ||
+			    nla_put_u32(skb, NFSD_A_VERSION_MINOR, j)) {
+				err = -EINVAL;
+				goto err_nfsd_unlock;
+			}
+
+			/* Set the enabled flag if the version is enabled */
+			if (nfsd_vers(nn, i, NFSD_TEST) &&
+			    (i < 4 || nfsd_minorversion(nn, j, NFSD_TEST)) &&
+			    nla_put_flag(skb, NFSD_A_VERSION_ENABLED)) {
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
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ca193f7ff0e1..4fc91f50138a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -133,8 +133,7 @@ struct svc_program		nfsd_program = {
 	.pg_rpcbind_set		= nfsd_rpcbind_set,
 };
 
-static bool
-nfsd_support_version(int vers)
+bool nfsd_support_version(int vers)
 {
 	if (vers >= NFSD_MINVERS && vers < NFSD_NRVERS)
 		return nfsd_version[vers] != NULL;
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index ccc78a5ee650..8a0a2b344923 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -38,10 +38,28 @@ enum {
 	NFSD_A_SERVER_WORKER_MAX = (__NFSD_A_SERVER_WORKER_MAX - 1)
 };
 
+enum {
+	NFSD_A_VERSION_MAJOR = 1,
+	NFSD_A_VERSION_MINOR,
+	NFSD_A_VERSION_ENABLED,
+
+	__NFSD_A_VERSION_MAX,
+	NFSD_A_VERSION_MAX = (__NFSD_A_VERSION_MAX - 1)
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
-- 
2.44.0


