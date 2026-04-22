Return-Path: <linux-nfs+bounces-21011-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J1rJo9a6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21011-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:32:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A586644BAA6
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27518301E65E
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862B8346AE3;
	Wed, 22 Apr 2026 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STidkhiA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F333B6E3;
	Wed, 22 Apr 2026 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900648; cv=none; b=c1X4qQ4O4rVlmawUbtj6fbWJdLOjM1URIHLCRXR5LbyOsoLP6CVLMiCmcBEcq+EWbtkLq8ho+su0DboX8xQ5StsSh0JSK99z9JZNFApVxZxgwI78GFuneszq5hgQHjoq4Aspma2N+2h++uPwjnOAoyBlYOyRjWV52y6JlZPWZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900648; c=relaxed/simple;
	bh=jjv42QbxTnNRC8fn85isOGhp+dmzdXqDdMc239rdxgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrfnGzyI3ah+f6cjolSTgTBgKKSnexIbSzKPVJ3OlIa80VP9MX3ndsKGy1AHeIwC6wKfzwarr6sMyT2N8r4m3I7fPIIOPezNpgWq2U+x0iLcn9x1J65ifKR6t2L0/idX+LU93nLby6ltJ4bP7VygmkJWESQjw7qEg3qeU2aaTfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STidkhiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20747C2BCAF;
	Wed, 22 Apr 2026 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900648;
	bh=jjv42QbxTnNRC8fn85isOGhp+dmzdXqDdMc239rdxgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=STidkhiA9lQXxT5c5P64kyxrp7mM5GktRnjp7EHM/Lj/Aa7J0IojBeQk3A9HKOc6Y
	 qGgMeJrMg/MASGztWuuzTobWe3Tzx4tY/TXktFiuVRuHbGh0tjblPTcK+R0QQN3gts
	 wLo1vgoKE7NBzcqbztXiddSR5KhldMXcB8KbixqQFiCLMcXNNevNy14va0sX65umU0
	 x5C93cCmolSy/L5iRuJIXeIrU1VpFG/PEKXTtooDZrZyVijEEpbdQYUPtJkAaRd4d0
	 cBuHztLrOCpyWqgXnK54e2N3OO5G6qYmhL3+Sak7LSQKMx0idxJleuasYD7fSMnew7
	 kYdxNR/OsWd7g==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:30:07 -0400
Subject: [PATCH v9 13/17] vboxsf: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-13-be023cc070e2@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4756;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=uVU5WRfpYdn2bSA7vDAjqhdwLXQziO1Qec+1HfL59eY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoGiV8fZwXXifsOX0sdu6oVrHn50vsz8nnuk
 ZrmUUqfzo2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBgAKCRAzarMzb2Z/
 l+mGD/9XYLTzl0twQkvVd7HpXUIrErQFIddtDgO0ySXrcxusT/Me86jsrFQ3NBJvBOxSJI7uPEb
 HHtXzfGf+7a0MQeMnIOKH7aSu+qXBY5KbaVFYfK5bp1yCE5TH5vrEQ+Zm35Q5tiVBjlAxqA0vtH
 Irrhfn5BKOJ+utOU/xIwE+caTU+xfevILCp5EM2CfkZjAvCZlH1iKWZ9W2rHCRzj6b84Pzdjab8
 Dfs3fomMvK/JxWS+XG86Bokj0M1R5cnqBTEEutC6eQ3FAW4pmchEcn2S5iYLdolitRNvxpW5dN9
 Ocp+TFvDoi/Fskp/sla3F154ZHgkfU0xlxE7tsuXT4cr23+cJd6A2hX0ImxgRQMsPkW1zL4Dn7Y
 c6X8ADDhhH9xgkbGpPCAMjhuU1idB0T9IWo6ZL17IGZdX1eGNSQgkp17SO2YL8QKFhxj6fllfK4
 ksCWymnOrm7MpWtgBEyVtpfzqu5e+IL+ii9D8hD8qV5HLqmH5l/d801WKpxFZ9t5hOiKuEqi3EH
 EKi/rAR7tRhgiPxygKpS2VK8IFHja5Lb5wypnXCwoeGh1U2MeKz4r2Ap+F1mdCnifjYKJu1m6Jg
 43DvzJhjmBH6zh7NoTEy8IebX0bct6+75H/8gJ5dmw1ioCid+IsW+eB5V4kaLE62jlu622vh0dN
 qis6+d/XcS5y/Hw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21011-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: A586644BAA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/vboxsf/dir.c    |  1 +
 fs/vboxsf/file.c   |  6 ++++--
 fs/vboxsf/super.c  |  7 +++++++
 fs/vboxsf/utils.c  | 26 ++++++++++++++++++++++++++
 fs/vboxsf/vfsmod.h |  6 ++++++
 5 files changed, 44 insertions(+), 2 deletions(-)

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
index 440e8c50629d..647a0ecb334a 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -11,6 +11,7 @@
 #include <linux/sizes.h>
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
+#include <linux/fileattr.h>
 #include "vfsmod.h"
 
 struct inode *vboxsf_new_inode(struct super_block *sb)
@@ -567,3 +568,28 @@ int vboxsf_dir_read_all(struct vboxsf_sbi *sbi, struct vboxsf_dir_info *sf_d,
 
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
+
+	sbi->case_insensitive = !volinfo.properties.case_sensitive;
+	return 0;
+}
+
+int vboxsf_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct vboxsf_sbi *sbi = VBOXSF_SBI(dentry->d_sb);
+
+	if (sbi->case_insensitive)
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
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


