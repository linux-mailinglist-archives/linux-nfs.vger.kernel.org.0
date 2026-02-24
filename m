Return-Path: <linux-nfs+bounces-19188-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONUxLxv7nWmeSwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19188-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:25:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B00518C08E
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC95830B5026
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882033ACA59;
	Tue, 24 Feb 2026 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwohSV4K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C23ACA53
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961081; cv=none; b=KWu1MWzWQsFAW4D7sKW3h+jNzB2wQ1OHoCle1uID8XQqT0o3GkWyxQUTu6vlTC/R2N2MBEWvN+hqGjeRChn5jsgmdARe9UbHxsu+BZ9Njuz/irMWAw4z7aK1XdPUWDxBrfDEcIyHGpTgHEJs6DZYTyMUBxcVqGzLcjr4cww+a1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961081; c=relaxed/simple;
	bh=JApx5kKnp9o9Uo7jPk+8ABrVdHkTjIIjhHreqGkS8Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVAP2uthIxcqVb1nCrpgmC39bLXqzz6Y8OPuxcdLsks9rxRYceNJ++u768eMBvTt4yrgaG+wF78CGUfq6ZuZf8+hlgDeDlBgy07gRoY380YfNfSfILdG+ZKWoFZzby1Q2g/25Ryp7Hw6qmOR4xppp3GKUig8PMy3T5wJzBJRpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwohSV4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EBDC116D0;
	Tue, 24 Feb 2026 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771961081;
	bh=JApx5kKnp9o9Uo7jPk+8ABrVdHkTjIIjhHreqGkS8Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwohSV4KDC6WrEwpcf2lxqIl81LPoVHiKaFpoT9hgMlhwyXM5Uk6j4htEPAFk1DMY
	 tqXC83tpZ604/8HZx//bQhWAtz4ZLikEElBTwoA7gB3KDeCbkie+g5OS3KfftZwaVJ
	 tlTesXJRc88FfkXXwAq53VnSnpBNdGfTM+82s9YsWe50ik4IdTrFzfOWZIxBc3zNtN
	 W86PxxyIQT3JEvYNfzZ18Ho61frV0PoIYkcTfjUEaQj+mgF+7ySj4N7i8y1Hp7zmPl
	 VUqNv8RzuFNQ36dRoxBby3CCAlEAn47zyBmcExy+mKDkT3NBEsTHSImiT6sSxwQu/8
	 Qh6jEQjFdySsQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 01/11] exportfs: add ability to advertise NFSv4 ACL passthru support
Date: Tue, 24 Feb 2026 14:24:28 -0500
Message-ID: <20260224192438.25351-2-snitzer@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19188-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B00518C08E
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

Add EXPORT_OP_NFSV4_ACL_PASSTHRU flag that an export should set if
relevant new methods are added to export_operations (e.g. .setacl and
.getacl which will be added in future commits).

NFSD will use exportfs_may_passthru_nfs4acl() to check for this flag
before passing nfs4_acl thru to exported FS (using new methods in
export_operations).

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 include/linux/exportfs.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 8bcdba28b406..7823c9693346 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -307,6 +307,7 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
+#define EXPORT_OP_NFSV4_ACL_PASSTHRU	(0x80) /* fs MAY handle NFSv4 ACL passthru */
 	unsigned long	flags;
 };
 
@@ -322,6 +323,18 @@ exportfs_cannot_lock(const struct export_operations *export_ops)
 	return export_ops->flags & EXPORT_OP_NOLOCKS;
 }
 
+/**
+ * exportfs_may_passthru_nfs4acl() - check if export MAY passthru NFSv4 ACLs
+ * @export_ops:	the nfs export operations to check
+ *
+ * Returns true if the export MAY support NFSv4 ACL passthru.
+ */
+static inline bool
+exportfs_may_passthru_nfs4acl(const struct export_operations *export_ops)
+{
+	return export_ops->flags & EXPORT_OP_NFSV4_ACL_PASSTHRU;
+}
+
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent,
 				    int flags);
-- 
2.44.0


