Return-Path: <linux-nfs+bounces-21038-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBwvEDUc6mmUuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21038-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:18:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77007452B12
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DE5B303396A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93203EFD09;
	Thu, 23 Apr 2026 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPM16o/s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42DC3EFD07;
	Thu, 23 Apr 2026 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949974; cv=none; b=GQVmAY4OYpDLDNhuHhqdgJ7NIROqXBG+SP0fQg7xaHSkoAQBe4CsYq2Op1pm4tocmWa8XJb6+xOFDdo93mDlRgfBxkA8WgqzqcytwLPxt7mmoIVi7WOadOhYrrY8dRXo+Qgnxwv3bIabdWlRpjRev9E9ZxHVCIvfuu//cWUmq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949974; c=relaxed/simple;
	bh=xTnUJBzhUaJt7Dk+a5+/UM+0og4vgCLh8INVoPYiQlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mf+3ysgxcBo/HPuN41AcygZMFdOhEW5hw4y/2t4yKUqX5VdwVm423awPz/t8CeV9VdRlwXcrxg7RTDLDmcFsCsONndlJWQk61+3GRfTRVhYZUUHnkrQ2wicensEPjFs7sD1K3p4TcBvs4bGL1FeOxXg/xJTj5V7VQJm9INFR8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPM16o/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21458C2BCAF;
	Thu, 23 Apr 2026 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949974;
	bh=xTnUJBzhUaJt7Dk+a5+/UM+0og4vgCLh8INVoPYiQlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lPM16o/sNzHkzOjlOaPRa0y9RJbPLZbCTOyIH29KrrDYZ/n9y4s+YNT6KxLXg3kcz
	 CD2SQyfWtBZdoEEjdvDT4mwGdNiXqojNcy5Z36UzgK2qNLa+OuXfTXR6YYCnvavPXr
	 VrFfPWHlgpjjOqyuzRpE5Hm5sDFir+Nt41guOPmCqBTZQPM9q8iuNso1PeJPgDQsrY
	 NMh3c6l9ffyAp8bspC+KOMRwYDuNs+IOcH4pRcJRqVX5a6EfUzuOfoNipDLMSrjwi6
	 LCvAbmbr4O9KuwA2ItCJ0fuek1ZkRiHuBez4NHzT5p+2F7bh5KdPXlayM84UOI/Ztg
	 r8uyN72BeVBPA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:16 -0400
Subject: [PATCH v10 13/17] vboxsf: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-13-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4806;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=U3Tf1iN9l6gRsu2HPLJbtQm3eFhk1EJ4rfpa5UQrh+k=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq0JHFJUq25NmA3t1UhOZHaHx4uPK2myeQ2p
 rSy1x1GvLGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l60QD/9f3C8ut9/eTp+/vstUXouz8Ayy73cHBgh2xknNmM+PGTvcw6LY0kl0b4tYWdILo1HApMa
 za/G3ejAqZj/Bu8eE+UVGG7W3P2l0mUs9utKAlY5dAiJhvoFDNMZLaDwjyQoqjVM+eGrGz80QTO
 6z92dV8sidTSZDO/yuiVE+dGa3s/ARSnp0vQnT1rbnDbD7JNJHsco7OE27MB21m03yPWAsfX48D
 sKhJdNkjUfOBXqcjAze7V91l4+SSG9rLvrS8qEyTpUEUj0Lznpu7hbS8c1Vo4ffeKVG4msYKsEs
 7jmfumMaOg2mO/HcOf5Y5HELWh1aA2jWl56rDE/ln3KI5PgUqntAQYR+M2YsEM7XKCBZ83lBeHV
 ANuVRi998lV3YYrcc8I25V1sPngqIpehjoJ0q1a73gM7fUJ9uj7/hJAa3ugIsUu30K4kV3gHssL
 V6uUCwdVrVPr4BIxagij4HPvtlqglhP9iIRaHPeWui1x36FI+xWfrB8oAVxB9BwE5HyllpTjJSN
 A6bdV6/K9KLj//Cl1AqNRzopPWcM6BL+5Q3No7dX5ptCYSsJ5b68NcrclehuxY++2or2PRcrG+C
 xeVprW6fvA+ZJbGouiM0OjN+VcH8I8qnx4Q4MU3IGw/eMlmrZ4qbPQsWluNL0G1mVGFCsET5fhH
 Ie9aSV+InsDwPZw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21038-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[32];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 77007452B12
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
 fs/vboxsf/utils.c  | 28 ++++++++++++++++++++++++++++
 fs/vboxsf/vfsmod.h |  6 ++++++
 5 files changed, 46 insertions(+), 2 deletions(-)

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
index 440e8c50629d..8655670061dc 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -11,6 +11,7 @@
 #include <linux/sizes.h>
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
+#include <linux/fileattr.h>
 #include "vfsmod.h"
 
 struct inode *vboxsf_new_inode(struct super_block *sb)
@@ -567,3 +568,30 @@ int vboxsf_dir_read_all(struct vboxsf_sbi *sbi, struct vboxsf_dir_info *sf_d,
 
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


