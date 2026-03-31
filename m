Return-Path: <linux-nfs+bounces-20571-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCqTIvM4zGn7RQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20571-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:13:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EB337176C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E11C30FAD09
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 21:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17403F7ABE;
	Tue, 31 Mar 2026 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj5hTM7f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921844102C;
	Tue, 31 Mar 2026 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991231; cv=none; b=S2GhYct/0lOL/AdXOUf+t3uqHwYdh8bdWBGVZtIu4fmod2EgSgJbK/CekMT0kJk1b1XIFemS9I+noZ/+mqMR2zNHOPsiZ3xbAbEhBJH2y2uLvRdeeMGNzr7tx6gHxt0/FhAjoPiOkwHc0JkqP02Zh0Ea5fMzjIeoHqkWhp+q+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991231; c=relaxed/simple;
	bh=4NJ0nHptw5SkSazD9OdYZseYTkmCUTwDp9Ov6RwpUhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxKvBi2IWI2OCh1Xfu5jUEXTocZIgrhLeqsIUMHLL2E+jvY4/1w61wrl+4wl3rZGLk4hBEonSGE3eiCMn93glWKF/49m+FxqarZYZ50dx1bPmGrRJadxIPAK6HhcvLsGeCrfFJStGjS3lJVg2xZ0n1jhAur/yj1t+DFJS4dmY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj5hTM7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE92C2BC9E;
	Tue, 31 Mar 2026 21:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991231;
	bh=4NJ0nHptw5SkSazD9OdYZseYTkmCUTwDp9Ov6RwpUhM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rj5hTM7fUHK+zFoHEZ4DfuhB9te8Uf3lt0oHONvldf3/AGiSuaV9ut9QlCrpAer6A
	 3B7JgkE/1r8e6VTEJmfG/hnjDu6Vs3ASoYOnz8+UZCUXuF4K3Xf4yC4D9ZRpW+Qtrq
	 HsA8IyimtmOTabZLnIuXdXw/Oc69tqYe0+iN5v/VAW3PABCkLbiexV6GIUDtO0TW+s
	 WD1iZCyExCs0jhJ28Lnk938HD9t0BPG5D/S77FQXXfGkhq1lDO7AmMfgk2kqqaAqxg
	 waK+EyJ6GlVF5SS1/1fv/RxXuVWJ99JgUdygnfZXSio68ScP8DP/AAavzrRBWDfeL+
	 4fugNN9HocNeg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 17:07:00 -0400
Subject: [PATCH v7 6/7] NFSD: Add NFSD_CMD_UNLOCK_EXPORT netlink command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v7-6-d8d2eee93f53@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11541;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=fAPtUknfeS0wPA19YfksxMnMzCJQfW8UeWAvSNPP/VI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzDd5xo3v52jTHek7TBKNOBgN1h1Vx2FrlKnRY
 +L6Fae7f8GJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacw3eQAKCRAzarMzb2Z/
 l6whD/9oQKs5YMsDud02l0zuAo2X1+NIUkXF0SSiHbd3BrbGJCufVvdmYNAlistrLJDyWaJ2+FG
 HRn62cqg2TyXfFnFu21BjS81YRGlUtuIROiEaXh7e53+OC7Rk66VfIQawdEXbuVs/KZUbEgzKPm
 jyUdWCgcYAxNAXiAHWFrETVCnsWcXE5Il3pmEWXI4q013chx7PU1ap0EIOyIvx0/abZ+tosTVLc
 xQW11P+We9dGGxyxJz+IgqiUREnkDR3dQRvRf16agQNOssYTUkPhBbIPQ13iq0qTxem2G7AjxV8
 VOPK/jdvmC/UDZo1zVuydGY/1GZ71JXsH4CGf6O4NEFHrPJIwz0MbXz5VhM39+DZGTiMJ6EYYI2
 eJW/SbrJ9NBGWi/ljUeNCkJxG803A/GQQIvXT7WpP0Z3KD50iSxIMivDMAg6xU8v3ma0PLSR1q9
 PVM0Us2Yvol3ERXDK5mQhidTGW6j2vb0AtWWXKEdt9DNlLHprTiUiLAt257wVKlO5DUpe/p4T6R
 Ux/p4RvNVkLA3ZjpwUPLhdSkRqtRgk+bMCJh/1xfg3MOUlh/Cz9138Y/GE5reEsrqfmY8Ntyi4r
 Z2l45Y9Du/ql8EINYTMHoDtDmoLuxeXugiQeerBzIesXuMFa9kNWHSgpEWcI9+GX8sd6IAPYTMg
 9AmrhF62SZcWUGA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20571-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 31EB337176C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

When a filesystem is exported to NFS clients, NFSv4 state
(opens, locks, delegations, layouts) holds references that
prevent the underlying filesystem from being unmounted.
NFSD_CMD_UNLOCK_FILESYSTEM addresses this at superblock
granularity, but administrators unexporting a single path on a
shared filesystem (e.g., one of several exports on the same device)
need finer control.

Add NFSD_CMD_UNLOCK_EXPORT, which revokes NFSv4 state acquired
through exports of a specific path.  Matching is by path identity
(dentry + vfsmount) via the sc_export field on each nfs4_stid,
so multiple svc_export objects for the same path -- one per
auth_domain -- are handled correctly without requiring the caller
to name a specific client.

The command takes a single "path" attribute.  Userspace (exportfs
-u) sends this after removing the last client for a given path,
enabling the underlying filesystem to be unmounted.  When multiple
clients share an export path, individual unexports do not trigger
state revocation; only the final one does.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml | 27 ++++++++++++++
 fs/nfsd/netlink.c                     | 12 +++++++
 fs/nfsd/netlink.h                     |  1 +
 fs/nfsd/nfs4state.c                   | 67 +++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsctl.c                      | 45 +++++++++++++++++++++++
 fs/nfsd/state.h                       |  5 +++
 fs/nfsd/trace.h                       | 19 ++++++++++
 include/uapi/linux/nfsd_netlink.h     |  8 +++++
 8 files changed, 184 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index e83209a4a19d..2607c4bd8920 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -148,6 +148,19 @@ attribute-sets:
         name: path
         type: string
         doc: Filesystem path whose state should be released.
+  -
+    name: unlock-export
+    attributes:
+      -
+        name: path
+        type: string
+        doc: >-
+          Export path whose NFSv4 state should be revoked.
+          All state (opens, locks, delegations, layouts) acquired
+          through any export of this path is revoked, regardless
+          of which client holds the state. Intended for use after
+          all clients have been unexported from a given path,
+          enabling the underlying filesystem to be unmounted.
 
 operations:
   list:
@@ -267,3 +280,17 @@ operations:
         request:
           attributes:
             - path
+    -
+      name: unlock-export
+      doc: >-
+        Revoke NFSv4 state acquired through exports of a given path.
+        Unlike unlock-filesystem, which operates at superblock granularity,
+        this command targets only state associated with a specific export
+        path. Userspace (exportfs -u) sends this after removing the last
+        client for a path so the underlying filesystem can be unmounted.
+      attribute-set: unlock-export
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - path
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 18afebaf4fef..3b885084b9f8 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -58,6 +58,11 @@ static const struct nla_policy nfsd_unlock_filesystem_nl_policy[NFSD_A_UNLOCK_FI
 	[NFSD_A_UNLOCK_FILESYSTEM_PATH] = { .type = NLA_NUL_STRING, },
 };
 
+/* NFSD_CMD_UNLOCK_EXPORT - do */
+static const struct nla_policy nfsd_unlock_export_nl_policy[NFSD_A_UNLOCK_EXPORT_PATH + 1] = {
+	[NFSD_A_UNLOCK_EXPORT_PATH] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -127,6 +132,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.maxattr	= NFSD_A_UNLOCK_FILESYSTEM_PATH,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_UNLOCK_EXPORT,
+		.doit		= nfsd_nl_unlock_export_doit,
+		.policy		= nfsd_unlock_export_nl_policy,
+		.maxattr	= NFSD_A_UNLOCK_EXPORT_PATH,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 9535782b529a..5b946f23059a 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -28,6 +28,7 @@ int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_unlock_export_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f8d7656f6dad..fa657badf5f8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1897,6 +1897,73 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 	spin_unlock(&nn->client_lock);
 }
 
+static struct nfs4_stid *find_one_export_stid(struct nfs4_client *clp,
+					     const struct path *path,
+					     unsigned int sc_types)
+{
+	unsigned long id = 0;
+	struct nfs4_stid *stid;
+
+	spin_lock(&clp->cl_lock);
+	while ((stid = idr_get_next_ul(&clp->cl_stateids, &id)) != NULL) {
+		if ((stid->sc_type & sc_types) &&
+		    stid->sc_status == 0 &&
+		    stid->sc_export &&
+		    path_equal(&stid->sc_export->ex_path, path)) {
+			refcount_inc(&stid->sc_count);
+			break;
+		}
+		id++;
+	}
+	spin_unlock(&clp->cl_lock);
+	return stid;
+}
+
+/**
+ * nfsd4_revoke_export_states - revoke nfsv4 states acquired through an export
+ * @nn:   used to identify instance of nfsd (there is one per net namespace)
+ * @path: export path whose states should be revoked
+ *
+ * All nfs4 states (open, lock, delegation, layout) acquired through any
+ * export matching @path are revoked, regardless of which client holds
+ * them.  Matching is by path identity (dentry + vfsmount), so multiple
+ * svc_export objects for the same path -- one per auth_domain -- are
+ * handled correctly.
+ *
+ * Userspace (exportfs -u) sends this after removing the last client
+ * for a path, enabling the underlying filesystem to be unmounted.
+ */
+void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
+{
+	unsigned int idhashval;
+	unsigned int sc_types;
+
+	sc_types = SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYPE_LAYOUT;
+
+	spin_lock(&nn->client_lock);
+	for (idhashval = 0; idhashval < CLIENT_HASH_SIZE; idhashval++) {
+		struct list_head *head = &nn->conf_id_hashtbl[idhashval];
+		struct nfs4_client *clp;
+	retry:
+		list_for_each_entry(clp, head, cl_idhash) {
+			struct nfs4_stid *stid = find_one_export_stid(
+							clp, path,
+							sc_types);
+			if (stid) {
+				spin_unlock(&nn->client_lock);
+				revoke_one_stid(nn, clp, stid);
+				nfs4_put_stid(stid);
+				spin_lock(&nn->client_lock);
+				if (clp->cl_minorversion == 0)
+					nn->nfs40_last_revoke =
+						ktime_get_boottime_seconds();
+				goto retry;
+			}
+		}
+	}
+	spin_unlock(&nn->client_lock);
+}
+
 static inline int
 hash_sessionid(struct nfs4_sessionid *sessionid)
 {
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ed0d12f77405..0bbcd5bae340 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2278,6 +2278,51 @@ int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb,
 	return error;
 }
 
+/**
+ * nfsd_nl_unlock_export_doit - revoke NFSv4 state for an export path
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Revokes all NFSv4 state (opens, locks, delegations, layouts) acquired
+ * through any export of the given path, regardless of which client holds
+ * the state.  Userspace (exportfs -u) sends this after removing the last
+ * client for a path so the underlying filesystem can be unmounted.
+ *
+ * Unlike NFSD_CMD_UNLOCK_FILESYSTEM, which operates at superblock
+ * granularity, this command revokes only the state associated with
+ * exports of a specific path.
+ *
+ * Return: 0 on success or a negative errno.
+ */
+int nfsd_nl_unlock_export_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct path path;
+	int error;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_UNLOCK_EXPORT_PATH))
+		return -EINVAL;
+
+	trace_nfsd_ctl_unlock_export(net,
+			nla_data(info->attrs[NFSD_A_UNLOCK_EXPORT_PATH]));
+	error = kern_path(
+			nla_data(info->attrs[NFSD_A_UNLOCK_EXPORT_PATH]),
+			0, &path);
+	if (error)
+		return error;
+
+	mutex_lock(&nfsd_mutex);
+	if (nn->nfsd_serv)
+		nfsd4_revoke_export_states(nn, &path);
+	else
+		error = -EINVAL;
+	mutex_unlock(&nfsd_mutex);
+
+	path_put(&path);
+	return error;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 7d7e99eeffa5..811c148f36fc 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -862,6 +862,7 @@ struct nfsd_file *find_any_file(struct nfs4_file *f);
 
 #ifdef CONFIG_NFSD_V4
 void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb);
+void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path);
 void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb);
 int nfsd_net_cb_init(struct nfsd_net *nn);
 void nfsd_net_cb_shutdown(struct nfsd_net *nn);
@@ -869,6 +870,10 @@ void nfsd_net_cb_shutdown(struct nfsd_net *nn);
 static inline void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 {
 }
+static inline void nfsd4_revoke_export_states(struct nfsd_net *nn,
+					      const struct path *path)
+{
+}
 static inline void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 {
 }
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 976815f6f30f..a13d18447324 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2021,6 +2021,25 @@ TRACE_EVENT(nfsd_ctl_unlock_fs,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_unlock_export,
+	TP_PROTO(
+		const struct net *net,
+		const char *path
+	),
+	TP_ARGS(net, path),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__string(path, path)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__assign_str(path);
+	),
+	TP_printk("path=%s",
+		__get_str(path)
+	)
+);
+
 TRACE_EVENT(nfsd_ctl_filehandle,
 	TP_PROTO(
 		const struct net *net,
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 51f926c0b15b..93dc1c4a28e6 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -95,6 +95,13 @@ enum {
 	NFSD_A_UNLOCK_FILESYSTEM_MAX = (__NFSD_A_UNLOCK_FILESYSTEM_MAX - 1)
 };
 
+enum {
+	NFSD_A_UNLOCK_EXPORT_PATH = 1,
+
+	__NFSD_A_UNLOCK_EXPORT_MAX,
+	NFSD_A_UNLOCK_EXPORT_MAX = (__NFSD_A_UNLOCK_EXPORT_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -107,6 +114,7 @@ enum {
 	NFSD_CMD_POOL_MODE_GET,
 	NFSD_CMD_UNLOCK_IP,
 	NFSD_CMD_UNLOCK_FILESYSTEM,
+	NFSD_CMD_UNLOCK_EXPORT,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


