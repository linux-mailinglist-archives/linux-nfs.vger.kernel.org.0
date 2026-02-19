Return-Path: <linux-nfs+bounces-19046-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOxwJz2Ll2n/0AIAu9opvQ
	(envelope-from <linux-nfs+bounces-19046-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D068163105
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092C6303FAF3
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2122DB79E;
	Thu, 19 Feb 2026 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6QjzWPF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B81DE3B5
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539238; cv=none; b=h7MtZ4/RL/QWDk7JPRv1YoV9YKSWXQnWsc+eb898O/tHm3Gh1BQXpkIEprmj+LoxrY/jP2mvVSpSXYuXQfU3d+PkKQNu1fygG38Bn4Lo5nwNytqrzjGOosIpm02qUO728KGpunRvN3NEceT24W5O0MOZubP7bjsEsjSKVJIz0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539238; c=relaxed/simple;
	bh=kc+/5R0A768BORNoltu7Ib8dyIX56o06TSVgpfaJeNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCjq+pI0/9J837Udp4dCeTYRtyFCgbSNlpys13hMuMnYwXFc1wYmszJvL8+/MUycszyYdSeWFjLX4kfyOcK7ooWtfKPZf/cEIZ0S5ZW3EZtvqV616wJbhaNOz6rdwiPks8quzQQm+5DVzzMEUFYGZ/STddoTNQ+Td8PyHsOo+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6QjzWPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AABC116C6;
	Thu, 19 Feb 2026 22:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539238;
	bh=kc+/5R0A768BORNoltu7Ib8dyIX56o06TSVgpfaJeNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6QjzWPFJTeYYA3zihxsiPaYrNx0VUeqrETkl/G2pG1Tt7Mq23wiWx+DNRh/7OoN5
	 S2OnS9sEOiSiDzBdwkPm+F3QmVZGgGLmal4f4YDuASvvIkbG7Nb2gA2yvGkAxd2L2N
	 mP1x4pETG8xZu6adWeIobWqs4I9pYXkp2Ej0cDjfcg1qCJOp1E9G6lAB64bfF9Qe96
	 EOhun/3cFEUkO+bKXwEStNWgSRw+tV/h1hH5WkgiBIBMc/xwHavyAFAJLmuACChNhd
	 kv3B/wtjQ2qdC5t8pDVp1NJ5ER31rXqtT+aXt98uHq3Wywqb1ztxK2OkxDsP8vtXE0
	 FYbJTrHq6FiJw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 03/11] NFS/NFSD: data structure enablement for nfs4_acl passthru support
Date: Thu, 19 Feb 2026 17:13:44 -0500
Message-ID: <20260219221352.40554-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260219221352.40554-1-snitzer@kernel.org>
References: <20260219221352.40554-1-snitzer@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19046-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 3D068163105
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
index 0262c9258b34..e73e7ba5ef45 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -10,6 +10,7 @@ struct inode;
 struct iomap;
 struct super_block;
 struct vfsmount;
+struct nfs4_acl;
 
 /* limit the handle size to NFSv4 handle size now */
 #define MAX_HANDLE_SZ 128
@@ -215,6 +216,12 @@ struct fid {
  * commit_metadata:
  *    @commit_metadata should commit metadata changes to stable storage.
  *
+ * setacl:
+ *    @setacl will use the nfs4_acl @acl to establish the acl using SETATTR.
+ *
+ * getacl:
+ *    @getacl will use the nfs4_acl @acl to retrieve the acl using GETATTR.
+ *
  * Locking rules:
  *    get_parent is called with child->d_inode->i_mutex down
  *    get_name is not (which is possibly inconsistent)
@@ -238,6 +245,8 @@ struct export_operations {
 			  bool write, u32 *device_generation);
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
+	int (*setacl)(struct inode *inode, struct nfs4_acl *acl);
+	int (*getacl)(struct inode *inode, struct nfs4_acl *acl);
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
 #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 147a4d178c12..28c10edeea5b 100644
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
index 2b30af613bab..65dbe7c05346 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -827,13 +827,6 @@ struct nfs_setattrargs {
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


