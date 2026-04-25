Return-Path: <linux-nfs+bounces-21095-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML3/El8f7GnGUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21095-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:56:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E2E464AD0
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 893A83064C4C
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1C24293C;
	Sat, 25 Apr 2026 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPU0sXdu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1D23BF9F;
	Sat, 25 Apr 2026 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082031; cv=none; b=NKdWbWvuLElq+y5eSfgowxXCAYmWN5espNDoVVyM8g7uj36f4Iqhk4LIr/PtF36jgGaj4qNLswP1AMNDI2PrLT9GhSkPrbR6dgX1yAwZJgutgyepOAZs9z1D9oCFTfUM7EGDV8nGhnE+rpvREwQxI0vleICPmE1US2DoBxpVffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082031; c=relaxed/simple;
	bh=4PnVhA68/lwOR6kFOGBj/fhhmjpnw+nIMjeX3NeO8qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSgSy3OL8SbIqNKixYIpUxCs2mMXyx6RLNJQ523oe/lkYe1vgmGMQ1td4bBlY8uF773ujo39KchdUY7K60Icz9MIeN7NYv0H0PkUPXF/hU9y67e/k+YcUrE7CdIGeqvr8V9ade51qQUYsH01HMmnrIvJvh7pgWiQZHE9DAWOUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPU0sXdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2164CC19425;
	Sat, 25 Apr 2026 01:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082031;
	bh=4PnVhA68/lwOR6kFOGBj/fhhmjpnw+nIMjeX3NeO8qI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XPU0sXdusgKR2faoucu2GIZUyvwpi5qc/Tx4pATcaPYiOs9/xRT7xHJqNfsD/y5hj
	 hnfVwRQQLhjxSIKgirOh425juEGx5yrNVZbN0s5Jn59hG1bgO1dgGUiKlP23QfWb4S
	 ZDkhv4At/uzzUz3nUqho6rlmu6/Gq3CLcBEQi2LHXHjyu0+LCdnknX4eB4Gduz7fHR
	 GCOAI18NGgsS++dNfbaCsGI0fegIADYyeb1t8YdEcs+xYhJ9aIZlUc9Cj3shPf5uXT
	 Kast23E73mNUJXj41UdFsVX5vu0Su+Gy3Un+p1Qw8o2UNOoE9N3LgtQ1qXd2lpCERL
	 bXsyJweA7/N/w==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 24 Apr 2026 21:53:13 -0400
Subject: [PATCH v11 11/15] vboxsf: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-case-sensitivity-v11-11-de5619beddaf@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4902;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=IS91PG/gteNIi+mr5kWAFzEwamMgenFgJebFqDZEBwA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6QD2/v1Og2a6npNZhNIVKP3sLXPVAaPHf/8
 gbDwgcQSyaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekAAKCRAzarMzb2Z/
 lwscD/42UZlXNbJGfR9yBtqQ5IjCzJLzkaZxmvnKUyam2frovMPqdC+jnbUgUmqqbdRrfLF1d7x
 cogPU8Fb7zftU8Rul8/PPr8EGUReN2X2te/xTgKwR6w7k2buKTWwx1Rqa9C6K5I3clNI9E9kknE
 EVvZtRg2i5TZIH8rwVXj0EdFKDWxGtNFDBAYeqZpaj7LldK6T1Ds9jLaExOpEZbP+mbC6Gyyk5M
 9T09BKhUk7LiqTlICfdVpy7bQh3IAPFvOz/WG2Vcj8chZ+86T8fcfn9vzxiyhKiFlvIa62VZ22w
 AZURa2+rD0qRzrWgUd/qXS2getmfMSU+T8FUvNHurTfK/jhhhCsXBRUuCA1qkA7BgoyEvVLYaax
 Ak7qVOuUrIeW8KqDaFNEFZipNALtMY8WWMKFN2hOUc/madJgaEQb/aOMjz90DU+B1gjhhSTNJT+
 KfASc8JZK4DSi862nMJpwZxp7VpSeBRw5H5O6b2prUegUOs8L8CCLDo24MjXfUOBlbwvNn8uywz
 vfDTvnauxnqclyi/6Ewrpb2winPpKPwLE2yuS5gB4QoU9BWbI/cNcEdAEE3Jp6EHqvYALA+b12q
 YPcmqAq+gbJ9+P6tPlqhWuzXbu0nxBLZeg1hnms/82W6qfN7sBLyG9izJFTOmH5y1U/MMq4f9Et
 mHunepBtSOjfWUw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: D0E2E464AD0
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
	TAGGED_FROM(0.00)[bounces-21095-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,nrubsig.org:email]

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need a way to query whether a
filesystem handles filenames in a case-sensitive manner. Report
VirtualBox shared folder case handling behavior via the
FS_XFLAG_CASEFOLD flag.

The case sensitivity property is queried from the VirtualBox host
service at mount time and cached in struct vboxsf_sbi. The host
determines case sensitivity based on the underlying host filesystem
(for example, Windows NTFS is case-insensitive while Linux ext4 is
case-sensitive).

VirtualBox shared folders always preserve filename case exactly
as provided by the guest. The host interface does not expose a
separate case-preserving property; leaving
FS_XFLAG_CASENONPRESERVING unset reports the POSIX-default
case-preserving behavior, which matches vboxsf semantics.

The callback is registered in all three inode_operations
structures (directory, file, and symlink) to ensure consistent
reporting across all inode types.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/vboxsf/dir.c    |  1 +
 fs/vboxsf/file.c   |  6 ++++--
 fs/vboxsf/super.c  |  7 +++++++
 fs/vboxsf/utils.c  | 30 ++++++++++++++++++++++++++++++
 fs/vboxsf/vfsmod.h |  6 ++++++
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 42bedc4ec7af..c5bd3271aa96 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -477,4 +477,5 @@ const struct inode_operations vboxsf_dir_iops = {
 	.symlink = vboxsf_dir_symlink,
 	.getattr = vboxsf_getattr,
 	.setattr = vboxsf_setattr,
+	.fileattr_get = vboxsf_fileattr_get,
 };
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 7a7a3fbb2651..943953867e18 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -222,7 +222,8 @@ const struct file_operations vboxsf_reg_fops = {
 
 const struct inode_operations vboxsf_reg_iops = {
 	.getattr = vboxsf_getattr,
-	.setattr = vboxsf_setattr
+	.setattr = vboxsf_setattr,
+	.fileattr_get = vboxsf_fileattr_get,
 };
 
 static int vboxsf_read_folio(struct file *file, struct folio *folio)
@@ -389,5 +390,6 @@ static const char *vboxsf_get_link(struct dentry *dentry, struct inode *inode,
 }
 
 const struct inode_operations vboxsf_lnk_iops = {
-	.get_link = vboxsf_get_link
+	.get_link = vboxsf_get_link,
+	.fileattr_get = vboxsf_fileattr_get,
 };
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index a618cb093e00..a61fbab51d37 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -185,6 +185,13 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto fail_unmap;
 
+	/*
+	 * A failed query leaves sbi->case_insensitive false, so the
+	 * mount defaults to reporting case-sensitive behavior. Do not
+	 * fail the mount over an advisory attribute.
+	 */
+	vboxsf_query_case_sensitive(sbi);
+
 	sb->s_magic = VBOXSF_SUPER_MAGIC;
 	sb->s_blocksize = 1024;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index 440e8c50629d..298bfc93255c 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -11,6 +11,7 @@
 #include <linux/sizes.h>
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
+#include <linux/fileattr.h>
 #include "vfsmod.h"
 
 struct inode *vboxsf_new_inode(struct super_block *sb)
@@ -567,3 +568,32 @@ int vboxsf_dir_read_all(struct vboxsf_sbi *sbi, struct vboxsf_dir_info *sf_d,
 
 	return err;
 }
+
+int vboxsf_query_case_sensitive(struct vboxsf_sbi *sbi)
+{
+	struct shfl_volinfo volinfo = {};
+	u32 buf_len;
+	int err;
+
+	buf_len = sizeof(volinfo);
+	err = vboxsf_fsinfo(sbi->root, 0, SHFL_INFO_GET | SHFL_INFO_VOLUME,
+			    &buf_len, &volinfo);
+	if (err)
+		return err;
+	if (buf_len < sizeof(volinfo))
+		return 0;
+
+	sbi->case_insensitive = !volinfo.properties.case_sensitive;
+	return 0;
+}
+
+int vboxsf_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct vboxsf_sbi *sbi = VBOXSF_SBI(dentry->d_sb);
+
+	if (sbi->case_insensitive) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
+	return 0;
+}
diff --git a/fs/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
index 05973eb89d52..b61afd0ce842 100644
--- a/fs/vboxsf/vfsmod.h
+++ b/fs/vboxsf/vfsmod.h
@@ -47,6 +47,7 @@ struct vboxsf_sbi {
 	u32 next_generation;
 	u32 root;
 	int bdi_id;
+	bool case_insensitive;
 };
 
 /* per-inode information */
@@ -111,6 +112,11 @@ void vboxsf_dir_info_free(struct vboxsf_dir_info *p);
 int vboxsf_dir_read_all(struct vboxsf_sbi *sbi, struct vboxsf_dir_info *sf_d,
 			u64 handle);
 
+int vboxsf_query_case_sensitive(struct vboxsf_sbi *sbi);
+
+struct file_kattr;
+int vboxsf_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+
 /* from vboxsf_wrappers.c */
 int vboxsf_connect(void);
 void vboxsf_disconnect(void);

-- 
2.53.0


