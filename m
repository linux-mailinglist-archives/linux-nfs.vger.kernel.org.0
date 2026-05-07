Return-Path: <linux-nfs+bounces-21420-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAIjLUlY/GlOOAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21420-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:15:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B51F4E5A3C
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D053119276
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4693A7825;
	Thu,  7 May 2026 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLtLybem"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE339D6E8;
	Thu,  7 May 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144026; cv=none; b=hvJcWworkgIMoWPzFMaI7tjZk/7LfrKU5rO0zLj3DjZ4SjypJcPrLiGh6Xd0lo34/PLy/IdALeI+hn57txiUG/mVbr04A8cm1zT52D/UOSPomfreRMW3v1BvltBdEQ/L0OmwrrisB59QwpMTZn5aIoDjC16eMf7gMNX33CA85KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144026; c=relaxed/simple;
	bh=VR5IPc+tFJzycK0UcE5Jbwk0EDkpbGyJE15n77IJHGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=azOiMzSE/S5iLkSTNWiMwb2u8NCFmdX0/jLftcYwQln4aMalqoaRzrAXAAQ2GwpJc1yb9In2CNQ9hAVhauSDCmTwOMbdhQkfI37bJ78OAkoXX4cTEJvD698eEtwARVGMNDBsBiKAbQcTPGK+S6NECFBlPntuyyRnaR4v3HiTEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLtLybem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B29C2BCB2;
	Thu,  7 May 2026 08:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144025;
	bh=VR5IPc+tFJzycK0UcE5Jbwk0EDkpbGyJE15n77IJHGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FLtLybemuNm208K4Z+hWYxbHG96mvth2fjkpP8nXfRZVVDnqPWYpbEw+6zMGagZDN
	 qUpFFOhQF6cW8Or5CQMIan6AG9hn447PpTM/718rixqZdmF3Pj2Yz2OuEGo0Ha6TFk
	 O12zYvpt7HF6fiR67rg9xKJ5Q7csvRBT9Il1mhbDJlCmYBnTsPmgcFo4D7G7gUF4Bg
	 IAWpEzKUi6NaVzPlohnWN9T2k5tr3/GaLq511iF0vBY5jP3AHXp4UUiSOfAJoiFR/0
	 jdfHvgGV7p10ZIaJ6z2ICUVhQhm8CMu0mJuad/U2GXS1wzNvvk0GqY75u3lZPadAuO
	 RVqVgTyvyhBcg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 07 May 2026 04:52:56 -0400
Subject: [PATCH v14 03/15] fat: Implement fileattr_get for case sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4362;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=9b+u/mWoEz9peMeExQH28HkC0yIPxzHosHi0xcms5fc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL13ap/p4dVIsp+5QfdsEFrkqNQsJ/m07/1M
 xeh8VDcF1uJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9QAKCRAzarMzb2Z/
 l5ZnD/9aWBipo8tKAewFwUsZjLow2wYgQYmqehy7hiNaM03rdF6wPfMGIjCz1RqHfUtJKaAxaIS
 rfQtm5PbcPy5f+mK+4oPJS3PvbPKbbqi+pCXgFSXSQeRwuPJ4rmgDvUg26MsKRe92rjNfr6qm6h
 4JvyGPPJrHBsOXtNW1MvH4BjXipdzpA/S2D0D48IiakWV1GgON36nZ4tpvFWy13VgGIK6DU6tAg
 MYtHPuV0fIwdJi9C13ktLQmIrbeXnRTqAl0VTxMwwPGfRgurBdPfe1Vio3Ysc9ghDm9BJ60ytLu
 wtpKgj1F6WfcFtodjZd8qwceI80V3zf+/ZOCXW0XS8YUiehPcvvJw813gbEd7BUFzo3K1PjYuQY
 0Kjde2CkCDcGSI3k8zzsTs+5G86GCzP02/6xkc9hUqJDMR4zS1WM4mfcHSGcSxCPALA80+oTROq
 zA2XI/qIqxrtnbkT2hVflKlrz+cGktRtkjlTndpYk4x7xXRYCfmIIabfb49n3CDKkPUTvUJFooT
 gB5SgsyOIUs08k1DdoV8vbBXjbai7Sc/jH1WClla0Ix6uECSyPpS8Ir/GiO8klmIk/ufIO5rbeW
 ilJ3+i3mEqiZtKL1sb32gzTPzdc6k/O3sL7hBTe2q9+JXugVSzvnlgWc7ZdwJhWz45M+XZEGZgb
 N1QCCSSgZ5nhH1w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 0B51F4E5A3C
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
	TAGGED_FROM(0.00)[bounces-21420-lists,linux-nfs=lfdr.de];
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


