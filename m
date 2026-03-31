Return-Path: <linux-nfs+bounces-20568-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI7wIMw4zGlFRgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20568-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:12:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D210D371730
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D7830D3E76
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 21:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CAD402B8E;
	Tue, 31 Mar 2026 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYn9ks/l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2449640242B;
	Tue, 31 Mar 2026 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991229; cv=none; b=X+yYnxDDWy36gt5sYijSr8vFk1fvSxgPkLh/T87Ao3fSlFJZQ5SuATWLz+0bL1ZfWILachHznFbtOwvB4BYUHymvSk0tyuVOW5caW+199tpfADVJFSGHP6UzfWbRBzVqu/f/Zrl5ybaxg0XkhTgTVhU18bAmwwcYgEG3bN/hCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991229; c=relaxed/simple;
	bh=noo4W/SAxd9y+MZoKjp2KKQx1jX0GmPv8LXLO/6UGG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HDmIJC8xwK7+yISmZ+vctoe8pQtfONkc3k0Kki9oqRGLNEI58FOwlSWZq82RUK2WlyAciHNopG28vM/Q3X7ES3HeRbRbq21dqDINR1k5OUXJ9ABjwQIqJoFtkOy/h2feccV2C+rf9hytIaQ/VydK8YwGlY9Oe9AE4GzDS3GOlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYn9ks/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C8CC19423;
	Tue, 31 Mar 2026 21:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991229;
	bh=noo4W/SAxd9y+MZoKjp2KKQx1jX0GmPv8LXLO/6UGG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qYn9ks/l9eaQxtshHoLDiiyc5zZ5HjhSyYO4ZQlCbN4OwWxbJ3zowvemTu8d27fO6
	 i+ioEEPOxMh+uxtG3l68Fhx33zft2+5VObfzn0+Q5hgHc991hFsTBr/9eJ5G8wBRrK
	 UBiXjGtsPp37KL1jIQiHMRzkUjJVCt0DZhERAx8hAiLwpLHA1/oIKk+W6OyldrDpKk
	 5w9+A1LyidCyLaPulQ+ecqaRlZW8VPwtqjUnm83kJhjH20RcXz//hmkCJ6hSJyia81
	 XemOnwKpzfqnM6VWK1S9gOJ6q63umklhEHQg8rqduZktvtm++Jtfx5BukbkjPrn5Ex
	 weG5gdtWycMvg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 17:06:57 -0400
Subject: [PATCH v7 3/7] NFSD: Add NFSD_CMD_UNLOCK_FILESYSTEM netlink
 command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v7-3-d8d2eee93f53@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5685;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=KZQQpZ1eK9sXJbpD/7mfyWLJ9SwPblj3TnYsL7D9BI4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzDd5a1XoQhPKnjyq4R9n04AbdHov5BzkV6qJ/
 oz5lrSccYKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacw3eQAKCRAzarMzb2Z/
 l9kVD/9PqmVElFDvHR9rvD+cx3LigXnqErfh77b83jFOOJsXiYnuyKhg6XmPwZmrssNd6YzOUgU
 fEqqj+zizRd8HPGw2Qgp0JxHEsa0dSS3Qp2nSbc2f5KkbDwXWgm5mQ4+aq98QfgBBm9QHqYhn1L
 y+8hcAhJr8EdwUFNceNSmdiLAuyEUyDCrfqpmCV3cCWqQcrB9/bg1rmso4cCJtUEnS0z80dvbUU
 jomVZMGI9Az/TQuIXZq4CvoxZkiTk35h2NET1NP0JL+/f2E/7v66egnwwVhl1pm2n+RZg7TGYA8
 G1nnJsOwo5shqRrtA3NzpgA+OtltGXf0oIGdB5aFdBpH6HZotRGW0frhml47I0UoojJZeHaE0de
 6EmmstT4xzGYYqfFvBI37A8PxPlP4MPAnMqfNz+wcsLgnt7eEQ5Z3YeMkLSDd8FKoJe1dIl5KWG
 XSohEpN1Mu97skLjGMqt6VHVUbRz/Zkav6cDMabAeTniKt1V3MwbNMF6ods4ri4NT56w8nGNV/V
 fR6jHbEQ1art+9ORbUNl/aFdp5Rei+9+J4T0UQoG83ZkF1LWRp15mL3vicn/ISEb+A9oTHYrYd7
 +Qdm3SyK+3IUCShpCz6w5juGuU8CcLeesBDEi2gRFdCFeBMCUIct4k4y/TfqaWXszwxfXBAg8NE
 zYPNqw9Aw9VIueg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20568-lists,linux-nfs=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,oracle.com:server fail];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D210D371730
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Add NFSD_CMD_UNLOCK_FILESYSTEM as a dedicated netlink command for
revoking NFS state under a filesystem path, providing a netlink
equivalent of /proc/fs/nfsd/unlock_fs.

The command requires a "path" string attribute containing the
filesystem path whose state should be released. The handler
resolves the path to its superblock, then cancels async copies,
releases NLM locks, and revokes NFSv4 state on that superblock.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml | 16 ++++++++++++++
 fs/nfsd/netlink.c                     | 12 +++++++++++
 fs/nfsd/netlink.h                     |  1 +
 fs/nfsd/nfsctl.c                      | 40 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  8 +++++++
 5 files changed, 77 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 9918b9a84d88..e83209a4a19d 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -141,6 +141,13 @@ attribute-sets:
         doc: struct sockaddr_in or struct sockaddr_in6.
         checks:
           min-len: 16
+  -
+    name: unlock-filesystem
+    attributes:
+      -
+        name: path
+        type: string
+        doc: Filesystem path whose state should be released.
 
 operations:
   list:
@@ -251,3 +258,12 @@ operations:
         request:
           attributes:
             - address
+    -
+      name: unlock-filesystem
+      doc: revoke NFS state under a filesystem path
+      attribute-set: unlock-filesystem
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - path
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 6b7221ce6869..18afebaf4fef 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -53,6 +53,11 @@ static const struct nla_policy nfsd_unlock_ip_nl_policy[NFSD_A_UNLOCK_IP_ADDRESS
 	[NFSD_A_UNLOCK_IP_ADDRESS] = NLA_POLICY_MIN_LEN(16),
 };
 
+/* NFSD_CMD_UNLOCK_FILESYSTEM - do */
+static const struct nla_policy nfsd_unlock_filesystem_nl_policy[NFSD_A_UNLOCK_FILESYSTEM_PATH + 1] = {
+	[NFSD_A_UNLOCK_FILESYSTEM_PATH] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -115,6 +120,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.maxattr	= NFSD_A_UNLOCK_IP_ADDRESS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_UNLOCK_FILESYSTEM,
+		.doit		= nfsd_nl_unlock_filesystem_doit,
+		.policy		= nfsd_unlock_filesystem_nl_policy,
+		.maxattr	= NFSD_A_UNLOCK_FILESYSTEM_PATH,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 3c2d5996612f..9535782b529a 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -27,6 +27,7 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e1e89d52e6de..ed0d12f77405 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2238,6 +2238,46 @@ int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info)
 	return nlmsvc_unlock_all_by_ip(sap);
 }
 
+/**
+ * nfsd_nl_unlock_filesystem_doit - revoke NFS state under a filesystem path
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return: 0 on success or a negative errno.
+ */
+int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb,
+				   struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct path path;
+	int error;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_UNLOCK_FILESYSTEM_PATH))
+		return -EINVAL;
+
+	trace_nfsd_ctl_unlock_fs(net,
+			nla_data(info->attrs[NFSD_A_UNLOCK_FILESYSTEM_PATH]));
+	error = kern_path(
+			nla_data(info->attrs[NFSD_A_UNLOCK_FILESYSTEM_PATH]),
+			0, &path);
+	if (error)
+		return error;
+
+	nfsd4_cancel_copy_by_sb(net, path.dentry->d_sb);
+	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
+
+	mutex_lock(&nfsd_mutex);
+	if (nn->nfsd_serv)
+		nfsd4_revoke_states(nn, path.dentry->d_sb);
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
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 4153e9c69fbf..51f926c0b15b 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -88,6 +88,13 @@ enum {
 	NFSD_A_UNLOCK_IP_MAX = (__NFSD_A_UNLOCK_IP_MAX - 1)
 };
 
+enum {
+	NFSD_A_UNLOCK_FILESYSTEM_PATH = 1,
+
+	__NFSD_A_UNLOCK_FILESYSTEM_MAX,
+	NFSD_A_UNLOCK_FILESYSTEM_MAX = (__NFSD_A_UNLOCK_FILESYSTEM_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -99,6 +106,7 @@ enum {
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
 	NFSD_CMD_UNLOCK_IP,
+	NFSD_CMD_UNLOCK_FILESYSTEM,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


