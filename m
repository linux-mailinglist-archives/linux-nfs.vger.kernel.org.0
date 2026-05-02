Return-Path: <linux-nfs+bounces-21349-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIKrN3AI9mk/RwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21349-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:21:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E044B24F5
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13BC9300B760
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F233A708;
	Sat,  2 May 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF7HURzM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB42820AC;
	Sat,  2 May 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731690; cv=none; b=tlR+upqDIDCEO9Gdcnt7qa/w0hNsw1Ek7QjEtXkZqhlhdBB9+pEcIuDtUSj2AAVyEZa7zGxmKGCSdX2i5DQ09lCjpt/QgXCI4naRn7dwOSD0gw9Cfnx8cOWM2FNdayacJ/AgDQIj+4s+JtsAGkVMExQpTU8lSegmUJFyyInk1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731690; c=relaxed/simple;
	bh=VR5IPc+tFJzycK0UcE5Jbwk0EDkpbGyJE15n77IJHGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubCJNT+3fPeWdZM2ocEbEg48CckX6UXYhMbdAnsoxukhVPs862K48ZYDGoYw1EfmIg/xyZ2sta5ZS/XBKD9RH1dPd1+lWmvUaxBNtOu9v4ocmza+4uZTN18oX4bi+hqL7EI2B9hufqhtoDzRj6gEIXvECo6cQfKMjHn9CtYRvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF7HURzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B94C2BCB3;
	Sat,  2 May 2026 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731689;
	bh=VR5IPc+tFJzycK0UcE5Jbwk0EDkpbGyJE15n77IJHGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mF7HURzMVcc76AIdcJ4gN+EjOH3PvQ+JAuxCubIcHZ3DqTATPTmSOPz/jj0c5a8eD
	 28ZXs+L6pe/biOR5DUyWkJHPJDw5dleKQ/IRG0xh1H5xyiuhhLw3v4NcwXJX/tNmPl
	 slpIdOSJ4IBOx6SCzJ67PwcS8rkOVM4CDrlRuUhzIXbtan473DhGspkciBPe0VevA6
	 Rp2ocOlWAHkGCdsO0j9rfVlgh+qZXcwWH5E8UI5KU1WwF5OW0XNdX1C6+y6HCJAWle
	 4bcHP6g4kfp77H3pKtZwKEQurPLu3aTximYGPcgJm6eEg/e7hAw1UNnz826iFUl/eL
	 q1+/gmUdmiL+A==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 02 May 2026 10:20:48 -0400
Subject: [PATCH v13 03/15] fat: Implement fileattr_get for case sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-case-sensitivity-v13-3-aa853140311f@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4362;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=9b+u/mWoEz9peMeExQH28HkC0yIPxzHosHi0xcms5fc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghQ1BYK25WvfFyqzaHIDtV9hFSfc8aMAu7+E
 /AjIghIsY2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUAAKCRAzarMzb2Z/
 l+sCEACEwFRDD4cEH+PMA/LESHjhccu/7sgZ/W4dO0ReHcgG6q8I3VlIBGNwySJb3aQT6tPBR2P
 3fEALKs5vj4BcjwnQ/T7wi6mwonrIzt3/H+9ZpBO4ICDfo4eylvEsjK07IBWs6+VZrJSZM50aPO
 LCpBxPaF/SjqIgV5o3ECVcsngrUolIDiKCFzdZQZ7RQhKwwL62FAkCtT/F4VZK0MlnxVbmeafts
 i9IBGfkvqLlctMiKC8hRY8VkgQHfePgcxnt5Ls/dSqBQIayK1VGzji8MNrHvBQzltvnpG3JX9Ng
 3d7SaNtBapC50AQ6O5E8D50xh3kD3/Q0Ug2WBke9rBQ1lujCwg+QLZrgBf8f9lGnCd1A5yuGuco
 kkWs7v7kK6Fkpptrz+W5oPDX5UZOv+sZY3trZiulaarYUDRjAnAU5eMnMZk4iD9avtCfSOu/t4M
 XDrmv8f9YTg829LpDEHZjaT7yjoax6U8UgWHZCuxo/Eh82T/uWHhqFBYmtnEpm8e5zzDlOYGVtV
 vLmTYoVy/zHK6VRD9YxUUgOMzcqBDdBwXp7Q/ftJiYg9aZoeOt+vX/FaauCtnkig073tY56kXP6
 eqxS31rR+BIHroVbUd7CHiXnToOhHWg25QOt1V9rfqvGyxziWOIrLyNKY8ExwBn9mYFIPwvAgNY
 9+K8ozD0F9oABqw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: A4E044B24F5
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
	TAGGED_FROM(0.00)[bounces-21349-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nrubsig.org:email,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

Report FAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
and FS_XFLAG_CASENONPRESERVING flags. FAT filesystems are
case-insensitive by default.

MSDOS supports a 'nocase' mount option that enables case-sensitive
behavior; check this option when reporting case sensitivity.

VFAT long filename entries preserve case; without VFAT, only
uppercased 8.3 short names are stored. MSDOS with 'nocase' also
preserves case since the name-formatting code skips upcasing when
'nocase' is set. Check both options when reporting case preservation.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/fat/fat.h         |  3 +++
 fs/fat/file.c        | 36 ++++++++++++++++++++++++++++++++++++
 fs/fat/namei_msdos.c |  1 +
 fs/fat/namei_vfat.c  |  1 +
 4 files changed, 41 insertions(+)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 5a58f0bf8ce8..99ed9228a677 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -10,6 +10,8 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 
+struct file_kattr;
+
 /*
  * vfat shortname flags
  */
@@ -408,6 +410,7 @@ extern void fat_truncate_blocks(struct inode *inode, loff_t offset);
 extern int fat_getattr(struct mnt_idmap *idmap,
 		       const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int flags);
+int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 extern int fat_file_fsync(struct file *file, loff_t start, loff_t end,
 			  int datasync);
 
diff --git a/fs/fat/file.c b/fs/fat/file.c
index becccdd2e501..37e7049b4c8c 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -17,6 +17,7 @@
 #include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/falloc.h>
+#include <linux/fileattr.h>
 #include "fat.h"
 
 static long fat_fallocate(struct file *file, int mode,
@@ -398,6 +399,40 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
 	fat_flush_inodes(inode->i_sb, inode, NULL);
 }
 
+int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
+	bool case_sensitive;
+
+	/*
+	 * FAT filesystems are case-insensitive by default. VFAT
+	 * becomes case-sensitive when mounted with 'check=strict',
+	 * which installs vfat_dentry_ops. MSDOS has no such option;
+	 * its 'nocase' mount option selects case-sensitive matching.
+	 *
+	 * VFAT long filename entries preserve case. Without VFAT, only
+	 * uppercased 8.3 short names are stored. MSDOS with 'nocase'
+	 * also preserves case.
+	 */
+	if (sbi->options.isvfat)
+		case_sensitive = sbi->options.name_check == 's';
+	else
+		case_sensitive = sbi->options.nocase;
+
+	if (!case_sensitive) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+		if (!sbi->options.isvfat)
+			fa->fsx_xflags |= FS_XFLAG_CASENONPRESERVING;
+	}
+	if (d_inode(dentry)->i_flags & S_IMMUTABLE) {
+		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
+		fa->flags |= FS_IMMUTABLE_FL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fat_fileattr_get);
+
 int fat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
@@ -575,5 +610,6 @@ EXPORT_SYMBOL_GPL(fat_setattr);
 const struct inode_operations fat_file_inode_operations = {
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
+	.fileattr_get	= fat_fileattr_get,
 	.update_time	= fat_update_time,
 };
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 4cc65f330fb7..0fd2971ad4b1 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -644,6 +644,7 @@ static const struct inode_operations msdos_dir_inode_operations = {
 	.rename		= msdos_rename,
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
+	.fileattr_get	= fat_fileattr_get,
 	.update_time	= fat_update_time,
 };
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 918b3756674c..e909447873e3 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1185,6 +1185,7 @@ static const struct inode_operations vfat_dir_inode_operations = {
 	.rename		= vfat_rename2,
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
+	.fileattr_get	= fat_fileattr_get,
 	.update_time	= fat_update_time,
 };
 

-- 
2.53.0


