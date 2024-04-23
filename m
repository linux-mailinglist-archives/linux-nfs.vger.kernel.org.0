Return-Path: <linux-nfs+bounces-2951-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03478AE815
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29821C222AD
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D55135A73;
	Tue, 23 Apr 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP2b686n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC0135A4E;
	Tue, 23 Apr 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878773; cv=none; b=MtMYf4/lI9NpD88eNT5s4/1PTbI0JFPKguMB9UY8inZ2vNU6ZjJHw+v5UWAPXoDws0sKHK3SqjZZvaZblTD+TURFqD3eIYro91er2jAwkb6Gl1DrbtnTDBOxIVoB+ck48i+DO5LzbQkR29w4xOBeF/zFikZ063Lzum/+1r2oi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878773; c=relaxed/simple;
	bh=yTEo9n/5WO7Mxq2GJpEN4y9v28k/0PSFfgLUY6jxu3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIaXl5bngN/3eXgZXWg9EYlOloBfNf9M6BspXu4RZDm5g+MnosD8vIOn5TvOmU1AfHAlr9MTl2WUKJzsI5pMccA4affeeVl7DEVEi7K24q54ccWuGWxlAe7BdeOruvNglzkXZhkgW7xpLlUiiWQ1IkFIa3B+t25zbBGzELHm4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP2b686n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA64C116B1;
	Tue, 23 Apr 2024 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713878773;
	bh=yTEo9n/5WO7Mxq2GJpEN4y9v28k/0PSFfgLUY6jxu3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RP2b686nT5F+RELHB6ahrs+5XXM2GUcglgCIgcSQ5mUGCP67DlSCs3vBibN893kBc
	 yTVHVZ9FLj6E9HRrZOPROElMm6U+7YB7MlQk3cDI6XaJgYwKke1ZAr92XqZffJCRmB
	 r0fZ7Atp1041+SHN/wUtOkRkYjGLFIChC1krT1jH89nUk3MEbdoXVsShjfhIB7xYzi
	 Z2IrAO+EoDe2prQgS3JIIKk9g4fz8U09WBZRJoJtiHYZJP3BOV+pdav2vqd+59qR3Z
	 AZFLZpmDeiQO3TmrjzA2XHk19NFfzKzhw5bxvBJirmPNU8u521E1bKWK8+0aq4hA2p
	 HhS+9Mg7hgC5A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: neilb@suse.de,
	lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v9 4/7] NFSD: add write_version to netlink command
Date: Tue, 23 Apr 2024 15:25:41 +0200
Message-ID: <b2c52a9a475b0689d08eaa2c38930103c2df08a0.1713878413.git.lorenzo@kernel.org>
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
index 703c2d11d0a9..77adda1425e2 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -78,6 +78,26 @@ attribute-sets:
       -
         name: scope
         type: string
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
@@ -126,3 +146,20 @@ operations:
             - gracetime
             - leasetime
             - scope
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
index fe9eef5c7f27..b23b0b84a59a 100644
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
 static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_SCOPE + 1] = {
 	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
@@ -18,6 +25,11 @@ static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_SCOPE +
 	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
 };
 
+/* NFSD_CMD_VERSION_SET - do */
+static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_PROTO_VERSION + 1] = {
+	[NFSD_A_SERVER_PROTO_VERSION] = NLA_POLICY_NESTED(nfsd_version_nl_policy),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -39,6 +51,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
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
index 5bfdebb2e7e9..b6b405437aa0 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1796,6 +1796,156 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
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
+ * nfsd_nl_version_get_doit - get the enabled status for all supported nfs versions
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
index e25b9b829749..cd9a6a1a9fc8 100644
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
index 4bbccd5db7cd..7176cd8e6f09 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -39,10 +39,28 @@ enum {
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
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


