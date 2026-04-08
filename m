Return-Path: <linux-nfs+bounces-20734-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOt4MO9L1ml8DQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20734-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:37:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D72053BC38C
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1868630094CF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C44E3C6619;
	Wed,  8 Apr 2026 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6lECJsc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A93C73D7;
	Wed,  8 Apr 2026 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651413; cv=none; b=pJB3woBO1I7eW2NZnw33sRUP5+7kAs5XIwcrj+fZpxG5m6M7vpUBZa11PcjKhiJ/pijaHWlLsvk3jgx0Jty66beqMBVIer0Rsl/3jnlC9mLxfWBIaZpufWOJFVQCnH2xPt1s4mS2ghACXtXooe+THgREho5E0sXkPItnnCDXtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651413; c=relaxed/simple;
	bh=AftLV/+wJjVEI+i3XOqEN5cNQkDKxM+CvGQrz7ITAAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuMQUnxq7LefPmlvRKrNEROGur9mvw4+Gsim2Bvi8OaBKgKqe9Zl63n6yLWcvhwAVIXyptLoB8kRrPSsJv4kxsPLV2bpboHZzimWdf+QArlkN8W4MOjwkkxH4V3s38FkrwtFJ8v61kocBmBDXvHGkMq4qBgkMn260d07YRIC/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6lECJsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C713C19421;
	Wed,  8 Apr 2026 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775651413;
	bh=AftLV/+wJjVEI+i3XOqEN5cNQkDKxM+CvGQrz7ITAAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R6lECJscGiR7LtNpBVIfIsvyxQIQlK1D10geWEO5XgC4Lllv39bJexRHGDlvsrePx
	 w9KjlnfUdiv7HPz+j/4CuGOfr7PhEGBIB8NgU1jM7z9TP4cyFplZ/YngXso2ZR8flz
	 vBJY8mRQ6M2BRInq2ciHbz+T/JCC+ttfbPGF+1hsH5iIfcQ6ezX1mUzl9Ngmg4c8x+
	 kHcqJFNJCV+zbYvVF8PgXL3RNfE1BzFLiZ28eOEh/vmrm6D4vhehaNhVQzBbDObXr9
	 TDpb/h89rpdnVnB6BliyXf1dVT+1h1FlRht/hNrlQDzZT/ZVzTQDA1lpv2W50lrNOF
	 v7HLDBVILWvuQ==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 08 Apr 2026 08:29:55 -0400
Subject: [PATCH v8 5/9] NFSD: Add NFSD_CMD_UNLOCK_FILESYSTEM netlink
 command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-umount-kills-nfsv4-state-v8-5-6e02a1d03d60@oracle.com>
References: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
In-Reply-To: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5689;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=PADaqiydDsD5GxnN6oVUZUmtedhYz6fcca9CKFXLQ9Q=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp1kpP0alVbG6bmewgm07i1twGuR9XRqqZfmlx0
 BZwM7P2s7GJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCadZKTwAKCRAzarMzb2Z/
 l0eOD/0bxyBiEc30jGBiJBEoQrPOP25Gyi7TUfLAvpEkdt7XiVlGF+mWy3ES7Eb6dnsPjwljy5R
 kJA+4YWEl1u1kdbwI58EgWtY1jxgRp6kFdw5WpKVexhkZCZlNwcZbPCemBrktoXaOr3FrOvRY17
 shvoqrKGvQ48j5rkDcxpRv6z+D+PeT/w39K9vnyjgwMe2k1Q27UBBsgSs3sV077P/u28EFAgM0G
 5VGV3Bh/Tc84XBJBggVMRDZstFRlIks5DTHwHfRVr0HM77AaMzDCu/MOVAdvKq5hrv84r9kH5DV
 y07Q+IJi3OV0nAoPFAPoOp6JJx2xNbU/AgPj57+ushg2KM87W8I9M6QiPsjqZ1gCtroiMZtqI6U
 lXZr7Apn6zSxOZuPQAsqBQ7YtWrzwQUfl3YKZ/rskTvoSaFoohTguY5vnaODzqTIWD8CVy2S7NS
 bE6GHiXwy52KRLT0U7GYwqSaGT8oJ6cs7ITYYAWWeYJDJ2YeuFZySikaJ5hQaQpRDAiov6pe63A
 0ZtfzGQ1wILiuWYFRfV23JRBD1hvvGGwK8cvZ3I0lJ0rA/ux56/b8iosDskJYKf0oqYZ134ji+G
 BvjWcV06NJgr5pvO97WpkCX7Q7QYpGER4yi319FWpk3zqiOt4CqCAuTM+74ZXTO/MzFMt//07eV
 FOi6q4PbjOqACng==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20734-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D72053BC38C
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
index 2c4883cfd50a..f3b21d4ba660 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -310,6 +310,13 @@ attribute-sets:
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
@@ -473,6 +480,15 @@ operations:
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
 
 mcast-groups:
   list:
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 96d326095768..dae7ad560bd8 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -118,6 +118,11 @@ static const struct nla_policy nfsd_unlock_ip_nl_policy[NFSD_A_UNLOCK_IP_ADDRESS
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
@@ -215,6 +220,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
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
 
 static const struct genl_multicast_group nfsd_nl_mcgrps[] = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 88edbbc68453..29bd5468d401 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -40,6 +40,7 @@ int nfsd_nl_expkey_get_reqs_dumpit(struct sk_buff *skb,
 int nfsd_nl_expkey_set_reqs_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NFSD_NLGRP_NONE,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c5ce4af28287..c35774786374 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2317,6 +2317,46 @@ int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info)
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
index 90ef1e686769..d01096c06d72 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -211,6 +211,13 @@ enum {
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
@@ -228,6 +235,7 @@ enum {
 	NFSD_CMD_EXPKEY_SET_REQS,
 	NFSD_CMD_CACHE_FLUSH,
 	NFSD_CMD_UNLOCK_IP,
+	NFSD_CMD_UNLOCK_FILESYSTEM,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


