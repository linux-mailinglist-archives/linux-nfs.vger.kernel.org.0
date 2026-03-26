Return-Path: <linux-nfs+bounces-20437-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG05Hnl0xWnw+QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20437-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:01:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D3D339B8C
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4772A30AB693
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDF6421EF5;
	Thu, 26 Mar 2026 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD3qgxmM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE892421EE0;
	Thu, 26 Mar 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547742; cv=none; b=Wncnx9POFD4ERxW4r932bPa9ubZY49LAbHzC44RNxFMZL96T7BAraQpH1Sw3ehn3CQtpbkTvjiT5fxj0Fw9FDk4OUGtBhd28Fv889HB4tyexA2q+ZrktCl6OAJ53Reh8fqJ3sbRw3tgRC2Lby9tCIQ1IiRMwDVM8KXYh6xN3yJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547742; c=relaxed/simple;
	bh=xsYpgzvzwoiMkeAGIFlQUSIcHnLjX4F/TQY7SFhy4Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1VAk4tXesWraSRXFV4tYzoauBIqnV0jqk/PmaSl7Qqaz2AzReEKHpJcPE2+lRnrvvVspvxYVGvXuObBiU+fOVUjMySFTDPj/RyL2gNnUdJ+1RQXUxW+hlHiwjuHVxRGBdI4hXyvGuuj3uLPYeSXRcEKNj0ZJ1wF6XGpcf7gxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD3qgxmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC26C2BCB1;
	Thu, 26 Mar 2026 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547742;
	bh=xsYpgzvzwoiMkeAGIFlQUSIcHnLjX4F/TQY7SFhy4Xo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UD3qgxmMo0iX9P254kkYimV9QM3aFKz10641IUg5TdJKnxrROdfU5qAyZYlBkNRqR
	 CLafZq+MieK3EFH75YOSgv/KAh8zhdCUi0CySDzibwDSC405W5jiYBiBynlmZtPJlP
	 Y33F9s5+DyGzmnhW6i1lhPLltW/jHbEPFIZLyN1kDVsvo+iH8Wo/5YD/ylueINMUFp
	 2bQHsyv5kITo0ixdxxiQ43N2OC2tr9HT0NXWP1mI7xSwu/hOcI3gADLLzbG8lyilzV
	 qW/OBA0h9KsaUX/pWUlt4W83bibvWxi2IupzO1WfP0d4XUYBR2seoH06gvpiUemYC+
	 6n1RkDXg3zktQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 13:55:25 -0400
Subject: [PATCH v5 6/7] NFSD: Add NFSD_CMD_UNLOCK_EXPORT netlink command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-umount-kills-nfsv4-state-v5-6-d2ce071b3570@oracle.com>
References: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
In-Reply-To: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11490;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Y4iVnMfqrNXFNkYTJGuUFr50MAS2Vmys3yo7Q1YoVDI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxXMYPerZdEa0yeXBzLNJRSJLTiipuIQj/5CZg
 Xa1PFdHkBWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacVzGAAKCRAzarMzb2Z/
 l6CYD/444Mzx25TDy1ASz9aTN0ZGED91Qqh6jDdr4HtehQFNh4Ncdjwlm2oBXvsbQVudsQpFwf2
 eLE8Fi+9qKVdXyhg3bM0Xphy1gLBBaELPr12WSOdLIl/SO9utACyZdiyDVl3ITZvrOJLEmHrbl+
 yX/lnkqcQepTBZVbpeIWH5LgKrU4z/Ldp7O8ohl5A8NiBo2Db1YTGottMxCA+n1b7C1dkbG1UgI
 ++cBTutBRHkw1AGZRIPwN1U8mPV0JryxdvL6U0MUnsijuqf+iAjeRKvs45ZASBYLalkbnKr7r6C
 zkp3PgLKuzw7dlut+hynXPyurcRoIcl5DF8OGIGpnRScmdKeA+SZ13f1aOvFpSDRI3A1fwmsbQs
 M3eJPymZ+viPDguupm75h0buPEFKMk+u9EQx+Ac9/XLv1QAmVj7vTEDm/IUYLnzlUtbiCxx+j3H
 USzrxA/HP3TEzMxn2Blous3tR07s8Q9ofAilidsX95v17RK2lZAurR0FX0OANNcKoEnmUj6POQf
 PeFlCWAQAYfgIE9/mjEzP/biWWlKy+YWov8llSGPVpFtpNBN9nZgoEc6D3Vuccu23fPjKTKt8WV
 kxBye+hevx/EqX5qspSnLPvS27WXYazb0Y/qGQkkVieEcJe7dUFIJivMaPFhfpgfGVQqKCpQh4M
 YpmQjAx56JC1tlg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20437-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57D3D339B8C
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
index ebbc83d7877e..eca49020f4cf 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1896,6 +1896,73 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
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
+				revoke_one_stid(clp, stid);
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


