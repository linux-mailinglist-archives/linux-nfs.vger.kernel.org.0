Return-Path: <linux-nfs+bounces-21427-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAhSJexY/GlOOAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21427-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:18:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6424E5AAE
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4836F310AE0D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C593B0AE5;
	Thu,  7 May 2026 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXpqx2q6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663839B48E;
	Thu,  7 May 2026 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144078; cv=none; b=dzm3u1ja7q8l0d6OuNujGXmTTH/zHTlwp/wuDWeX3lKKtKMVYjqDfP5dCwg/SCizl8cVY3EXfjrC1vyqWBIfIYv+EIg3Kdln2fGIEFX1pJiUlr1nr4VOAoihdFFkfP2zNF2anovclpOB4PL7FmdOo0eLQnRKjpn6NjKMCFppvBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144078; c=relaxed/simple;
	bh=9nooxPrfBRIjK/Acp/NaZ0Q+Rwi4qp420v8ZRvdn5qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNyIwwd0I2xFy/lNpxkERsQqcyTn3FfhcJ0zudveTE6UfFxsSTQZIU9E6eiHEEy9/8XoFQQTpnL8aEr4L2q88Lb4IFqZL/hbKhWnE5fdBBMNbx5cfRNcRz0TiKryGVVEOWTGeHrVfQd5+8yLP9JAaEe22365imi7i9MmMHMhZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXpqx2q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CAEC2BCB8;
	Thu,  7 May 2026 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144077;
	bh=9nooxPrfBRIjK/Acp/NaZ0Q+Rwi4qp420v8ZRvdn5qk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nXpqx2q6R1jRyo8xNS2DMhhyCW4jZJ6zzGbHgDvchJK4mfGTz9b5/3llkCSIAlhpy
	 1NLYRzPXkPH6rxiuFULybFKLB/wLN2ArtNhbKiaaFfg95vkYPCMKw6zH5eoVjq1nbc
	 Agl5XfI742M8YRfWcnVlJU+wOGPnq5UQRiTXK8gRJI3YtPrCoYPhNwEU4SZ0cqLduY
	 pHCv6mt4sZRshHx56q39XwkadsEuDeohqQFZVcFtKVJ/p/DDACx0FrQFYKytRfYNKL
	 7u2ZKrLD+99oHFflw5CG6LSwm5SjvpSrtyavGOZ0JZEaJ/kSJemDo49sZmV15rC7HM
	 y3JFyHNf2tMWg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 07 May 2026 04:53:03 -0400
Subject: [PATCH v14 10/15] nfs: Implement fileattr_get for case sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-case-sensitivity-v14-10-e62cc8200435@oracle.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
 linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
 almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
 adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, 
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
 trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
 hansg@kernel.org, senozhatsky@chromium.org, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12010;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=X9YdmY/tj/XZQQAyXOBY7aoQoBqe6+gdm4sMmcjTpKg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL2nwNUcelMY5MT2xburvqwQ3p8t0yZmyZlU
 ZY6MzG90M+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9gAKCRAzarMzb2Z/
 l6fdEACSL/jY1Rpcw6h+4DPNN53ekz6DWKyxVRG/jtMejZLm0J6u4D6uK0sGXkFgW3QMXv58El9
 pq1P8iKtTTjFfu4Dqz2JLSmFnW9yeZHI76aQdSC0voy2ZbSi1bRRiA9pb9FCcJYMWw1qYjWxqOF
 E/e5tAoWCdBN5/bbX+NGjxKsSJh9ItZR/mE82U2vRxSeaSn1GhbtBJS3Gx2E7AR24XEV77zL/Wq
 D7ZhXFxhPjIkfTrN6cWxY/s1AeMSPTnO+wCMob7acQczXCf/MVUlLcdRFxDxh7yVxxAYfdAgmdR
 PTMhMW9YSNcfxLTEgQPGK7pCsMYhQWL5xOXZUL/1BsBOzXrk0c3yZsNqSqORNw9KSmi7h7aQn1A
 5AbdSbHauIp5ZrCoXUaiT721gnyvCOF3dte+NrAGlPNUl7C4Pj/dpjVJaDpSfzveUIPhk9buZtL
 hGgiXD2sYLN/VI5VHD+beGHWTx3qyqjTbnOkrHAGcV0msx103QfYn4wNr332Bsn4qu7wwF8MdB8
 bXTTAzYZgmfqCmIIhQD7jiKMOPWADWWUvzDV/C0sb+a8sYtVbUYhWdn7j3/Wx1byQl6em0ipDF1
 TJnxPkeK6t/pPQDT/1pJ8SC0L/tv3EC+KrET3OvSmcujuHH8NIsYtyeXeAjJJ8Fleph+nIv2Y3V
 gI+DQexQ9LJCERg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 0C6424E5AAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21427-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

An NFS server re-exporting an NFS mount point needs to report
the case sensitivity behavior of the underlying filesystem to
its clients. NFSD's attribute encoder obtains that information
by calling vfs_fileattr_get() on the lower filesystem, so the
NFS client must implement fileattr_get to surface what it
learned from its own server.

The NFS client already retrieves case sensitivity information
from servers during mount via PATHCONF (NFSv3) or the
FATTR4_CASE_INSENSITIVE/FATTR4_CASE_PRESERVING attributes
(NFSv4). Expose this information through fileattr_get by
reporting the FS_XFLAG_CASEFOLD and FS_XFLAG_CASENONPRESERVING
flags. NFSv2 lacks PATHCONF support, so mounts using that protocol
version default to standard POSIX behavior: case-sensitive and
case-preserving.

PATHCONF is now invoked unconditionally for NFSv2 and NFSv3 mounts
so the case-sensitivity capabilities are established even when the
user pins server->namelen with the namlen= mount option. That option
is orthogonal to case handling, and skipping PATHCONF because
namelen was already known would leave the caps unset.

The two capability bits carry opposite polarity because their POSIX
defaults differ. Most servers are case-sensitive and case-
preserving, matching "neither xflag set." NFS_CAP_CASE_INSENSITIVE
is set only when the server affirms case insensitivity, so "server
said no" and "server did not answer" both collapse to the case-
sensitive default. NFS_CAP_CASE_NONPRESERVING follows the same
pattern in the opposite direction: set only when the server affirms
that it does not preserve case, so that silence or a missing
attribute lands on the case-preserving default. The NFSv4 probe
checks res.attr_bitmask[0] to distinguish "server said false" from
"server omitted the attribute" before setting the bit.

Both capability bits are cleared before each probe so a remount,
an NFSv4 transparent state migration to a server with different
case semantics, or a probe whose reply does not arrive does not
retain stale capabilities from the prior probe.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/client.c           | 21 +++++++++++++++------
 fs/nfs/inode.c            | 15 +++++++++++++++
 fs/nfs/internal.h         |  3 +++
 fs/nfs/namespace.c        |  2 ++
 fs/nfs/nfs3proc.c         |  2 ++
 fs/nfs/nfs3xdr.c          |  7 +++++--
 fs/nfs/nfs4proc.c         | 10 +++++++---
 fs/nfs/proc.c             |  3 +++
 fs/nfs/symlink.c          |  3 +++
 include/linux/nfs_fs_sb.h |  2 +-
 include/linux/nfs_xdr.h   |  2 ++
 11 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index be02bb227741..3db2f18315b8 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -914,6 +914,7 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
  */
 static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, struct nfs_fattr *fattr)
 {
+	struct nfs_pathconf pathinfo = { };
 	struct nfs_fsinfo fsinfo;
 	struct nfs_client *clp = server->nfs_client;
 	int error;
@@ -933,15 +934,23 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
 
 	nfs_server_set_fsinfo(server, &fsinfo);
 
-	/* Get some general file system info */
-	if (server->namelen == 0) {
-		struct nfs_pathconf pathinfo;
+	pathinfo.fattr = fattr;
+	nfs_fattr_init(fattr);
 
-		pathinfo.fattr = fattr;
-		nfs_fattr_init(fattr);
+	/* Clear before probing so a failed RPC does not retain stale bits. */
+	if (clp->rpc_ops->version < 4)
+		server->caps &= ~(NFS_CAP_CASE_INSENSITIVE |
+				  NFS_CAP_CASE_NONPRESERVING);
 
-		if (clp->rpc_ops->pathconf(server, mntfh, &pathinfo) >= 0)
+	if (clp->rpc_ops->pathconf(server, mntfh, &pathinfo) >= 0) {
+		if (server->namelen == 0)
 			server->namelen = pathinfo.max_namelen;
+		if (clp->rpc_ops->version < 4) {
+			if (pathinfo.case_insensitive)
+				server->caps |= NFS_CAP_CASE_INSENSITIVE;
+			if (!pathinfo.case_preserving)
+				server->caps |= NFS_CAP_CASE_NONPRESERVING;
+		}
 	}
 
 	if (clp->rpc_ops->discover_trunking != NULL &&
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 98a8f0de1199..fdcbe6f2052c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -41,6 +41,7 @@
 #include <linux/freezer.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
+#include <linux/fileattr.h>
 
 #include "nfs4_fs.h"
 #include "callback.h"
@@ -1101,6 +1102,20 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 }
 EXPORT_SYMBOL_GPL(nfs_getattr);
 
+int nfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (nfs_server_capable(inode, NFS_CAP_CASE_INSENSITIVE)) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
+	if (nfs_server_capable(inode, NFS_CAP_CASE_NONPRESERVING))
+		fa->fsx_xflags |= FS_XFLAG_CASENONPRESERVING;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nfs_fileattr_get);
+
 static void nfs_init_lock_context(struct nfs_lock_context *l_ctx)
 {
 	refcount_set(&l_ctx->count, 1);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index fc5456377160..309d3f679bb3 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -449,6 +449,9 @@ extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
+struct file_kattr;
+int nfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 /* localio.c */
 struct nfs_local_dio {
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index af9be0c5f516..6d0073c24771 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -246,11 +246,13 @@ nfs_namespace_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 const struct inode_operations nfs_mountpoint_inode_operations = {
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
 
 const struct inode_operations nfs_referral_inode_operations = {
 	.getattr	= nfs_namespace_getattr,
 	.setattr	= nfs_namespace_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
 
 static void nfs_expire_automounts(struct work_struct *work)
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 95d7cd564b74..b80d0c5efc27 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -1053,6 +1053,7 @@ static const struct inode_operations nfs3_dir_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 #ifdef CONFIG_NFS_V3_ACL
 	.listxattr	= nfs3_listxattr,
 	.get_inode_acl	= nfs3_get_acl,
@@ -1064,6 +1065,7 @@ static const struct inode_operations nfs3_file_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 #ifdef CONFIG_NFS_V3_ACL
 	.listxattr	= nfs3_listxattr,
 	.get_inode_acl	= nfs3_get_acl,
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index e17d72908412..e745e78faab0 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2276,8 +2276,11 @@ static int decode_pathconf3resok(struct xdr_stream *xdr,
 	if (unlikely(!p))
 		return -EIO;
 	result->max_link = be32_to_cpup(p++);
-	result->max_namelen = be32_to_cpup(p);
-	/* ignore remaining fields */
+	result->max_namelen = be32_to_cpup(p++);
+	p++;	/* ignore no_trunc */
+	p++;	/* ignore chown_restricted */
+	result->case_insensitive = be32_to_cpup(p++) != 0;
+	result->case_preserving = be32_to_cpup(p) != 0;
 	return 0;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d839a97df822..62f66684fbc8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3933,7 +3933,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		server->caps &=
 			~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS |
 			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS |
-			  NFS_CAP_OPEN_XOR | NFS_CAP_DELEGTIME);
+			  NFS_CAP_OPEN_XOR | NFS_CAP_DELEGTIME |
+			  NFS_CAP_CASE_INSENSITIVE | NFS_CAP_CASE_NONPRESERVING);
 		server->fattr_valid = NFS_ATTR_FATTR_V4;
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
@@ -3944,8 +3945,9 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->caps |= NFS_CAP_SYMLINKS;
 		if (res.case_insensitive)
 			server->caps |= NFS_CAP_CASE_INSENSITIVE;
-		if (res.case_preserving)
-			server->caps |= NFS_CAP_CASE_PRESERVING;
+		if ((res.attr_bitmask[0] & FATTR4_WORD0_CASE_PRESERVING) &&
+		    !res.case_preserving)
+			server->caps |= NFS_CAP_CASE_NONPRESERVING;
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
 			server->caps |= NFS_CAP_SECURITY_LABEL;
@@ -10598,6 +10600,7 @@ static const struct inode_operations nfs4_dir_inode_operations = {
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 	.listxattr	= nfs4_listxattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
 
 static const struct inode_operations nfs4_file_inode_operations = {
@@ -10605,6 +10608,7 @@ static const struct inode_operations nfs4_file_inode_operations = {
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 	.listxattr	= nfs4_listxattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
 
 static struct nfs_server *nfs4_clone_server(struct nfs_server *source,
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 70795684b8e8..03c2c1f31be9 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -598,6 +598,7 @@ nfs_proc_pathconf(struct nfs_server *server, struct nfs_fh *fhandle,
 {
 	info->max_link = 0;
 	info->max_namelen = NFS2_MAXNAMLEN;
+	info->case_preserving = true;
 	return 0;
 }
 
@@ -718,12 +719,14 @@ static const struct inode_operations nfs_dir_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
 
 static const struct inode_operations nfs_file_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
 
 const struct nfs_rpc_ops nfs_v2_clientops = {
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 58146e935402..74a072896f8d 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -22,6 +22,8 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 
+#include "internal.h"
+
 /* Symlink caching in the page cache is even more simplistic
  * and straight-forward than readdir caching.
  */
@@ -74,4 +76,5 @@ const struct inode_operations nfs_symlink_inode_operations = {
 	.get_link	= nfs_get_link,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.fileattr_get	= nfs_fileattr_get,
 };
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 4daee27fa5eb..34d294774f8c 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -306,7 +306,7 @@ struct nfs_server {
 #define NFS_CAP_ATOMIC_OPEN	(1U << 4)
 #define NFS_CAP_LGOPEN		(1U << 5)
 #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
-#define NFS_CAP_CASE_PRESERVING	(1U << 7)
+#define NFS_CAP_CASE_NONPRESERVING	(1U << 7)
 #define NFS_CAP_REBOOT_LAYOUTRETURN	(1U << 8)
 #define NFS_CAP_OFFLOAD_STATUS	(1U << 9)
 #define NFS_CAP_ZERO_RANGE	(1U << 10)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index ff1f12aa73d2..7c2057e40f99 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -182,6 +182,8 @@ struct nfs_pathconf {
 	struct nfs_fattr	*fattr; /* Post-op attributes */
 	__u32			max_link; /* max # of hard links */
 	__u32			max_namelen; /* max name length */
+	bool			case_insensitive;
+	bool			case_preserving;
 };
 
 struct nfs4_change_info {

-- 
2.53.0


