Return-Path: <linux-nfs+bounces-21347-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNvpBGEI9mk3RwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21347-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:21:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD94B24D0
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B917E300B997
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF82ED16D;
	Sat,  2 May 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9dqznjq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150C22E3E9;
	Sat,  2 May 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731678; cv=none; b=L7xgg3qxX1cgwJ7xyPbHxrstRwi9qXJJPcJARoPShv/IOrXtsfg58/uIAwTdnWj3FaYp+36DB+g70RhFIj7ZMd6zGYKzpPAKzejl03AleIJQaYJNE+tKbZrF1ClUdhi1wlk/rF62qr/w34joZLatu+xXGCZ4NCPWbRePiUeOeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731678; c=relaxed/simple;
	bh=93lkf1HBQv1pjT23tKqszLwADekuVqw95GHVpFk/qSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hc+0kEH02tN9X/q3nnqxZhuPMl4g0JyfH3n36pvCE2qf69fDjTCsbHp6+XvGhBtfI3/qiKNkGfYSjEkFUwH4iTqetNwXX3EiA3GTQ1mNf7Jia6eU09yEgHJJmOgsStoAuRhoCiyLBplyXL6QxT11z/FawnH55NK1ZtfhTxOP2ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9dqznjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6D2C2BCB3;
	Sat,  2 May 2026 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731678;
	bh=93lkf1HBQv1pjT23tKqszLwADekuVqw95GHVpFk/qSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c9dqznjqT3nK0gCeQf+quqbALJ8ZkUx/FFV7TY+6LxJNYXOuPjd18CBcyRsW7f8Xo
	 6U0JvbsS17ncMuKHbtY6r0j1lVz72vfsVnNSyCb1BCp5hxNjNyq9+rJIkK4xWhox5X
	 KLEoejPahTxkRDbaukchtykIpVIzsv2N87a7n+OPeo5GZPqOy72bPuTiwOOWfmvYIi
	 qSrsD7ZJPp9sS649/dSuRGSMF0+o7yhh6/3p30Yi/6lWFkg3tA7ZRtCwsuJiq8zooe
	 +i80WYpX1Ewa8uI54CY9/87F1WtD1c9n6rOFJgOEDK5QH+UdMJGtYjCnx/pNYz5Xad
	 jDSjFr1aSQm9w==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 02 May 2026 10:20:46 -0400
Subject: [PATCH v13 01/15] fs: Move file_kattr initialization to callers
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-case-sensitivity-v13-1-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
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
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghQxFmZlM8hYOkYPWqHSSZmcZJ8CLh1PP/PV
 +Mcq86IS9aJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUAAKCRAzarMzb2Z/
 l6D0D/9nv8DJn/N4olT5nofAbnfCPhd3NiX0SPC6Gijz5K/lVi+fk2ZgRC0u9rHGkFoB2v8+IPA
 IE8J75WNmzrOhZbbkEeHle4EL/+O9LZFxmCLI3NscUDjscohPfIuRiDHSuCIDdTtUvaSFcteY6Q
 lSL2D7xPQPiUS2wmlT9UFZI19hIvSAIK7NZ1/MY5O4pqKYTQTp3a+R9h4n14GJdyxuQsPepP6PE
 BrHtJdqxb8OS32B9wi7zNgIi/OkyHUYob0OJXTMESPNcM5uokgn19Z3j+3d8f/IF101sARLiR4D
 nWn2wItMJv3zHiccy609tHPxcNZm5mQyHdrBJyVL1eAi8Z5yEDoNvVNF9oqx4LnqUB1JJdboWQT
 ondxrZ3iYYdeEZtlgJpB4vyLJ6S0YSJveawbMLUcrq/N8uZAjIL2YU9uxsZU4p0obzywlqqN1rq
 jZoBk9Hkuv9rEhLudlSHA/tEKURDapop2YKRLPRtljb6bpKDZr/gnLfYb3cZTDp5dnnfPkOb9lP
 a+2ffHzokxKLL0+Lb6MDogG9EK4bSjQELufwgdCIzfFT9NJ5Fv4mcxCfJmgggaaOrQIUhxKC6cr
 aPc/Wy0JR3yXVRtVPbkCn5hTBg9u2/daaw3lEGVVHE+FDG+aWEkZdkPr4aUBVNLYy0Mab6f+9ey
 WkQt0xrO3fuUkCA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: B6FD94B24D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21347-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nrubsig.org:email,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


