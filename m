Return-Path: <linux-nfs+bounces-20999-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFJIATla6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-20999-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:31:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A48EA44B9BF
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA91630730AA
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1783A451E;
	Wed, 22 Apr 2026 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3ZxNZDI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F32395D99;
	Wed, 22 Apr 2026 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900619; cv=none; b=g251bEe58zLYVC6rAXJFKS/4MgikeOLYmCFZJJJJ1n8HbFwXwOeFSG9M1ZrL2L3r2r0QngH2vZr+WJaRuN3rqem6a/uzQdayJ6/EfGssmEIR1+kKBR8SQxTc9UgO9ljErCQ/AzX6/bwtPGHZm+ZMyWLtFAuHLU11g21yQ96o2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900619; c=relaxed/simple;
	bh=bctXXTPbBEuad4Pxq4bP9lSf9quyJ0lnmg+KuyXxPH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVJqjiP7mKzEuDZnuJewz7SqQfcSQ08ctXxsWuuOXy9ryXxjIZuZmxT7V9s+3zlgoTNJeUf3mb3VS+78Z+jlGaLEFmHWtLMC0wZfHlcNhIgqACnrue24OilmV5F2JxhxpkgwWe2fQ76RKFLyOFxVoeFn5ujSA6Kr15YiyFu92BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3ZxNZDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D5FC2BCAF;
	Wed, 22 Apr 2026 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900619;
	bh=bctXXTPbBEuad4Pxq4bP9lSf9quyJ0lnmg+KuyXxPH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M3ZxNZDIeZhKMd2X9+NlQlR577y1NpSl01J2FVXN03pWa3CBeSLxdQ9DUQ6f9Y4sw
	 UMi9BgF0IpRMZVW/toOsMY2defUR4VHWR/IwSqkSbcsgOInXbmIgUZ21m4cNNtUDjl
	 5d/BI3BFEp9bkrt2MgaXMcBcYxUISQTZzr2+uktLrkBBJMoH+nonIuhGVud0I5PGiO
	 2vHzgh6+UgAr9AGqq7KifwNOJ/wVnVdhvWwyMtRWaprSzYHu7oLhI6rcwkcpQTJwlr
	 hHy4JgcZKsuFjGYBzXYFlQWYBsgcdhjrVpsY1MO/TWyFeTjOrMK6ReLmlmdF5Btz4x
	 vlnYzNOMAxREw==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:29:55 -0400
Subject: [PATCH v9 01/17] fs: Move file_kattr initialization to callers
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-1-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3501;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=tI06eoaKz9315rXjbGykMIxbiHJmdgGU8s/nGVMwtnA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoFA3fAjX74FSJ4imm2PqqdSRR23lY9hRXdR
 H8tIE2EgfqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 lzkGD/wPvBSeGWtLxCSOZNi/+/xYdOyxsFXcUJHyozmi+gSkQc7kE8CBS/h/E04hWxe+jumJLYc
 5isVzwGsG47c/YCSbsJ05QXTlXdbDIlnhdMrjD81dhtOGU49mWssVMdR+HNe7QMGgHTdeNteK8m
 8xLQ8DLGOJadTfo1vil0z4FVIVOKIcB3kGPmp7Ze0JWoFm9Fn/b6Zddy7/5nQSma+S2fgzGrVQA
 +u6SV5xXGdCIKOCOCQVdfHP3VqfO0JbrmMvOzOLC4ZvWw+h/roCoFoKbTuFib6uTayXf524jOFZ
 1+11lz9L7vEvbGretw87tWH+HTUTmnycdGW6xM0c12NzcE1DwZhBGwu5SVyJxDUpkfIAFkDUHbH
 7a73p6w0SaEv3lRaKc9aS4LDGg9Eih7ZDcO21+OA4/NdiQGvhY5gAlbVjJQpiiYydqu8AtkL6Xl
 i07wNoI598Q+erp8RLgYgO25xuOgohaMvzUzQ45UyS7xnIsRaQhWzyNEwfOGWDkaJUr2zzlX9ob
 zTta1H1PWaru8vK6xCNF6D9m9wHi7IJIPtC/VCqLt7On40mipe8SwaGlFAiDvHDD1n2tB/cLvoU
 usmAoioCylaoAj7jIXEVYcFvpWuDU8bnL7Co0DhUO9UXTLJEnktM9czBhSe+wXHAr0mf2SNBRSj
 8N1Ovw8vYuS5zVw==
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
	TAGGED_FROM(0.00)[bounces-20999-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: A48EA44B9BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

fileattr_fill_xflags() and fileattr_fill_flags() memset the
entire file_kattr struct before populating select fields, so
callers cannot pre-set fields in fa->fsx_xflags without having
their values clobbered. Darrick Wong noted that a function
named "fill_xflags" touching more than xflags forces callers
to know implementation details beyond its apparent scope.

Drop the memset from both fill functions and initialize at the
entry points instead: ioctl_setflags(), ioctl_fssetxattr(),
the file_setattr() syscall, and xfs_ioc_fsgetxattra() now
declare fa with an aggregate initializer. ioctl_getflags(),
ioctl_fsgetxattr(), and the file_getattr() syscall already
aggregate-initialize fa to pass flags_valid/fsx_valid hints
into vfs_fileattr_get().

Subsequent patches rely on this so that ->fileattr_get()
handlers can set case-sensitivity flags (FS_XFLAG_CASEFOLD,
FS_XFLAG_CASENONPRESERVING) in fa->fsx_xflags before the fill
functions run.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c     | 12 ++++--------
 fs/xfs/xfs_ioctl.c |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index da983e105d70..f429da66a317 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -15,12 +15,10 @@
  * @fa:		fileattr pointer
  * @xflags:	FS_XFLAG_* flags
  *
- * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
- * other fields are zeroed.
+ * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).
  */
 void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
 {
-	memset(fa, 0, sizeof(*fa));
 	fa->fsx_valid = true;
 	fa->fsx_xflags = xflags;
 	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
@@ -48,11 +46,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
  * @flags:	FS_*_FL flags
  *
  * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
- * All other fields are zeroed.
  */
 void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
 {
-	memset(fa, 0, sizeof(*fa));
 	fa->flags_valid = true;
 	fa->flags = flags;
 	if (fa->flags & FS_SYNC_FL)
@@ -325,7 +321,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	unsigned int flags;
 	int err;
 
@@ -357,7 +353,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int err;
 
 	err = copy_fsxattr_from_user(&fa, argp);
@@ -431,7 +427,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	struct path filepath __free(path_put) = {};
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 46e234863644..ed9b4846c05f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -517,7 +517,7 @@ xfs_ioc_fsgetxattra(
 	xfs_inode_t		*ip,
 	void			__user *arg)
 {
-	struct file_kattr	fa;
+	struct file_kattr	fa = {};
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
 	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);

-- 
2.53.0


