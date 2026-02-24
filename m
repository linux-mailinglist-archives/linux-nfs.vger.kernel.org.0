Return-Path: <linux-nfs+bounces-19190-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KoJAgv7nWmeSwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19190-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:24:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8419E18C060
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C992E30BAEDA
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 19:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9EC3ACA78;
	Tue, 24 Feb 2026 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShFtbU3P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D33ACA74
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961083; cv=none; b=RmrB79v2bB90UBvB6wTErMPdLm7Ps7RYnl+pnqPFbrsDF3K0n+hP62zfFmjaYawxsLw1IAAAeMw5F2kMVCHkbXS85vjvjNa4N8U5vmlvUtGL/auYB/An5HhvDk9G+FtQkWQ3F5zrx1iTTO8TMQ/3SdxMoTy5Ew19KLSpKAZU89A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961083; c=relaxed/simple;
	bh=4Z+tgxI5KHSS1m0PNKtMt3Dj61FjczI42HNTnr9mLok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHNmTdesVnxPYCE6Qx+gAeSUB/HqMeC2JdkQW98RCXAXK8ldIS1vYk1zcWxZ/mbRzr78UY2z7CfUODnoAoFkFBfdNhm0EK/o6JLFKtmsle7HhFQ0k8owfEHmdLSPZJGiIywILctsg6eOmQ3vAxIGS/JxLsdnqCfIv20Pg5YgLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShFtbU3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF3C19422;
	Tue, 24 Feb 2026 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771961083;
	bh=4Z+tgxI5KHSS1m0PNKtMt3Dj61FjczI42HNTnr9mLok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShFtbU3PohSaElnAwK2Z/hc93pcAHVWutdmQMQHUGXr8gZHrOAtORiVQz+bC0L6FW
	 H2H/V4O/jB48PrpufYe9XfV/bkQr84unSMsNlf477Yj5CnlgqP0BOErsQFfMnG6Z9r
	 r0nu5WTSZpiDOluwanvvdRSQf/l2bomZ+YT8W4wk9OIOh6QuSM94ggQYjFzID/nj58
	 6WirU6Xq65o8SJzGfuYt7vls9+ABfbKyAX5P7Y9U5sHVWGj/jLzgKlO6MBVoJiuOdH
	 lXMqw/PVez24x0R/kScnLPCFatsE9GGnTkqHbal/20QyssawA5UZNoisWQWGd1AaTY
	 lESw0/dxUsl1A==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 03/11] NFS/NFSD: data structure enablement for nfs4_acl passthru support
Date: Tue, 24 Feb 2026 14:24:30 -0500
Message-ID: <20260224192438.25351-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260224192438.25351-1-snitzer@kernel.org>
References: <20260224192438.25351-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19190-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 8419E18C060
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

Add setacl and getacl to export_operations structure. Both of these
methods allow NFSD to pass an nfs4_acl structure to exported
filesystem.

Update the nfs4_acl structure to allow for dual use of the new
nfs4_acl passthru support in addition to its existing usage. This
duality is reflected through use of a union, but the xdr_buf payload
is used to initialize all members in the union needed for passthru (in
a later NFSD commit).

Move nfs4_acl_type structure to include/linux/nfsacl.h so that it can
be used by NFS and NFSD.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 include/linux/exportfs.h |  9 +++++++++
 include/linux/nfs4.h     | 23 +++++++++++++++++++++--
 include/linux/nfs_xdr.h  |  7 -------
 include/linux/nfsacl.h   |  7 +++++++
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 7823c9693346..9e3a818019f8 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -11,6 +11,7 @@ struct inode;
 struct iomap;
 struct super_block;
 struct vfsmount;
+struct nfs4_acl;
 
 /* limit the handle size to NFSv4 handle size now */
 #define MAX_HANDLE_SZ 128
@@ -269,6 +270,12 @@ struct handle_to_path_ctx {
  * @commit_blocks:
  *    Commit blocks in a layout once the client is done with them.
  *
+ * @setacl:
+ *    @setacl will use the nfs4_acl @acl to establish the acl using SETATTR.
+ *
+ * @getacl:
+ *    @getacl will use the nfs4_acl @acl to retrieve the acl using GETATTR.
+ *
  * @flags:
  *    Allows the filesystem to communicate to nfsd that it may want to do things
  *    differently when dealing with it.
@@ -298,6 +305,8 @@ struct export_operations {
 			     int nr_iomaps, struct iattr *iattr);
 	int (*permission)(struct handle_to_path_ctx *ctx, unsigned int oflags);
 	struct file * (*open)(const struct path *path, unsigned int oflags);
+	int (*setacl)(struct inode *inode, struct nfs4_acl *acl);
+	int (*getacl)(struct inode *inode, struct nfs4_acl *acl);
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
 #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index d87be1f25273..8cfa748c7efa 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/uidgid.h>
 #include <uapi/linux/nfs4.h>
+#include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/xdrgen/nfs4_1.h>
 
@@ -38,8 +39,26 @@ struct nfs4_ace {
 };
 
 struct nfs4_acl {
-	uint32_t	naces;
-	struct nfs4_ace	aces[];
+	union {
+		struct {
+			/*
+			 * Payload to use for deferred decode into
+			 * pages once ACL passthru is required
+			 * (which uses abnormal members below).
+			 */
+			struct xdr_buf payload;
+			/* Normal counted list of ACEs */
+			uint32_t naces;
+			struct nfs4_ace	aces[];
+		} __attribute__ ((packed));
+		struct {
+			/* Abnormal counted list of pages */
+			uint32_t type;
+			uint32_t len;
+			uint32_t pgbase;
+			struct page *pages[];
+		} __attribute__ ((packed));
+	};
 };
 
 #define NFS4_MAXLABELLEN	2048
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index ff1f12aa73d2..3260d3116127 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -828,13 +828,6 @@ struct nfs_setattrargs {
 	const struct nfs4_label		*label;
 };
 
-enum nfs4_acl_type {
-	NFS4ACL_NONE = 0,
-	NFS4ACL_ACL,
-	NFS4ACL_DACL,
-	NFS4ACL_SACL,
-};
-
 struct nfs_setaclargs {
 	struct nfs4_sequence_args	seq_args;
 	struct nfs_fh *			fh;
diff --git a/include/linux/nfsacl.h b/include/linux/nfsacl.h
index 8e76a79cdc6a..a1941dc56db0 100644
--- a/include/linux/nfsacl.h
+++ b/include/linux/nfsacl.h
@@ -22,6 +22,13 @@
 #define NFS_ACL_MAX_ENTRIES_INLINE	(5)
 #define NFS_ACL_INLINE_BUFSIZE	((2*(2+3*NFS_ACL_MAX_ENTRIES_INLINE)) << 2)
 
+enum nfs4_acl_type {
+	NFS4ACL_NONE = 0,
+	NFS4ACL_ACL,
+	NFS4ACL_DACL,
+	NFS4ACL_SACL,
+};
+
 static inline unsigned int
 nfsacl_size(struct posix_acl *acl_access, struct posix_acl *acl_default)
 {
-- 
2.44.0


