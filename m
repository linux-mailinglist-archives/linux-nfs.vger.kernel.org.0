Return-Path: <linux-nfs+bounces-21085-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AkGD64e7GmpUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21085-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:53:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9F464851
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68028302C74F
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C528E239E9B;
	Sat, 25 Apr 2026 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLgar0Jl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38C199FAB;
	Sat, 25 Apr 2026 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082006; cv=none; b=pXTfnLdS/pc5SBw9lZ1eboNj5cPCW/BeD598svVav6+1SVpdwoUER5JXNocVE9z6v9wErMpPhPSl8pQrKgIFbS9d/EmNCgquuDC/D3ZAvVsb/B35gjUMI305s5zWEdJWh9KDru2B4zqY2Ot3Tb6HAvnWUkL5CDjUVFD+r3e5+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082006; c=relaxed/simple;
	bh=93lkf1HBQv1pjT23tKqszLwADekuVqw95GHVpFk/qSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G6sepbULFPmcmAmoOgwvhsXlmWToFoO7nrOD/VoHF0G0eZ/zSHfODxEk5EKL4bjZjs0vPM/hcU0tXmNF633BC4DXBchEQDxk+TWJ6qXIEcBUAmGxggcLO5qGlHVX7BfDQ9m/3ulzkWcJG5KuRutJJBKJOBYslgObd39KSZGnUvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLgar0Jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CBDC2BCB9;
	Sat, 25 Apr 2026 01:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082006;
	bh=93lkf1HBQv1pjT23tKqszLwADekuVqw95GHVpFk/qSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gLgar0JlfMzpbf4h91bIQ2/oFxbB7DQVGd6O1qEFahj9FGQOAfeyXajR/xwkwjAt+
	 ihSFQ6DYf8y4gaEi8CH34lbpMLIkYx6hmSb0bVCOlrjLntSjKUThEH076NVG2YjU/x
	 AEwjOo54XLJBzPOEixPYwdanXVwtZHgHcf6psGz5nZjZioUs/NrbIsNCQm63ji4U4r
	 VJREGv7tZdYjV9lcrKYxPirABgUpJn23YTprhJFNlXTs6mX7/8oaE8mGfScEhADRQl
	 IsmY+0rZm54pPYdQ2t48PsCb7AA/MyJCVNnJ3BXYbLvjMbkJoNY5FCgd4ibEr4xEAO
	 ZPlhMkWL62A4Q==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 24 Apr 2026 21:53:03 -0400
Subject: [PATCH v11 01/15] fs: Move file_kattr initialization to callers
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-case-sensitivity-v11-1-de5619beddaf@oracle.com>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
In-Reply-To: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3605;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=AWgZwG1E8rlvIL3m0PCLX9DfISmeBrTqPl/lfHkVgk0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6QVc6wzpY9y1nPJJFj5Jdl4iXMAz76LGW6g
 QkQqdisSOGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekAAKCRAzarMzb2Z/
 l48ZD/95d8pCbGgiAP60eaV3lvhqpJjBSSgyy5uBrXc6hOSYY7Rn4m4SC1Lmsvv7v1z4LUWF1zI
 Ez9rxr0ebHLjWUnGXRzmXFmrsylzHuPqTBVeFSSAUNhZL1zVI5CH79+XChwlj+K8kWlmpyE/4Ad
 xE68yIWjWCTtMwfuo9u985OatxMY4Fh9AqB6FpRF21dmTUBI6JpT3RSr9DjiSCCIa3loQuHNUD4
 EpB0tp33RZUoFIDqosozztV0Z/YS5czglE6kL2loY9CX/sR4pbtmgqpe9zaD8TNsb7JESzaBIJ2
 6ri4qY6CnkBm7zd9Rn2b/BWfCVl7X93O/HqukK3RRUadCopSGvibhD9iM/uzOwPpJKqincRl4/S
 0lvSxRbuBosTWj+JDPDIXOvQfR/UWojct3gI7nkqAPhe1R8JIfZJdxrxWa4xziItVi5WXqVTLSS
 zuRANrBRobLYHPXza3AKZqd0Qk1KYWEy8/qeWe+++YRfcjlFlT6tt0FpMos+fsRbUxATRkbIqsY
 hGCmQQpvf7Q5rWYay7vCY6L/DvkcAuWh+QBab+0xU8OYIu2oPn15rml0RCC6Xs24uMTw+hTEjSr
 wXIkQuTJCnXk6bVxqkk31fdz5WxqggdoqLLhKWRzRVCpWAQFGtHpAQt1Woqhvb6cso9F7u3W5wC
 4T7+ODkEGqSN0Ww==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: EEB9F464851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21085-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[34];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
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


