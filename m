Return-Path: <linux-nfs+bounces-21096-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BsvA5If7GnGUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21096-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:57:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 759CF464AE8
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 531C9306559C
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D821265CDD;
	Sat, 25 Apr 2026 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3pOlnwS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7E423BF9F;
	Sat, 25 Apr 2026 01:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082034; cv=none; b=UXkRooZQbqEUQH0+4SyCPc97EBeJTflfWRUbwy/MaOEfwcluI3LSYISzYxnad644wnF9F6CLsI2qXTEGAGgkL3kbg23Vpk6biGNxjgNzJoDrzE2Y0Zx5KdkOtCxpqNIaaKZn+qBJj6OaAL8mY7A3xXHDSeNy3srKhSQ4OanQwi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082034; c=relaxed/simple;
	bh=a2oUrA0xe//8KXon7nK7LgDRTlRSr3NVpBGjFd6WwfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnTiq9oahMm27ko8jstxl5j4EPH6dPl/KnCle+wdADBiybcYAwBM4Y2n+uzeTQ53eo4mTCKI+ObZxWQkYAFDxHTH/JyQ/w1bNA3jFNmRTSR7SMC2/1olcFItidR/ONtKXx49IToGJW82aE0oOgZTCY07VUGa3hUh3cYp8g4fHsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3pOlnwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C33C2BCB2;
	Sat, 25 Apr 2026 01:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082033;
	bh=a2oUrA0xe//8KXon7nK7LgDRTlRSr3NVpBGjFd6WwfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U3pOlnwSxVJOTPZCG1rItktWaaT+CJXRd9dITPdS9ijvMcfdNFdGR6FZyX0UQDHa2
	 XNl9nHoebtbyi62S+XY9NFTbI93SO6ajt8XK+WGATwifUUvTj7y0JOZOfy9AZai36Z
	 QUqbiO/jVvZ9oC785y6vsupXySSjok5gDqbs7fqEk632z5tFI7eEb0U4RXwavQms65
	 ElCAyV/ab8+R7tAyOhj4FongoS7ndytQFJu3Nor8/ToZJ61nXa2s8Vc49JuUuiSF4L
	 HIIloSmOIBc7SFSpY9w/2OZQyh7NwiKtLvcEmQaPgx39usg00h9PtKJXSgRTKWulQP
	 nQAPf4+3yFhTg==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 24 Apr 2026 21:53:14 -0400
Subject: [PATCH v11 12/15] isofs: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-case-sensitivity-v11-12-de5619beddaf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4581;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=mSjVyU0+7gMxVOpF8jjeXoK0ARUH2lVZI4wCKuXJ6hY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6Rt/F187q66PiYnbIHIdzE1i9SQMnias3kh
 kph+eacFZmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekQAKCRAzarMzb2Z/
 l8ZCEACdBgejkIxR+MOjjazHhQE0Xe0Bphrmcgr3a8BAlqU+JfW4oyWYpCg6A13uPzS/70Glcia
 NEAueRbIy8hlIc3d/PikUCXr2w5eDsCPVMxujl+SE/PC1pK8PYFDdJUq4N4ZZ02u+kZ5XRNO7bp
 Qk6iQW9nTTtadaIYIniKTlyp6zSldA4C9N7UJ9Zr9XHuTnHvhz5ZNF/n7OVjUOsjx02RpoBM4Vx
 zTv6aOULc6CBZMVe+pqlBxY9n6BM/Mx+Kg1h6ueqwODwqzOGN8rAqKedSNfAnXnTHbWgfwzGOmA
 QFayP5c7JpTE9Ive/TaGi6DnaxT6M6y2YOpMPd1oMS4ZzFv6Dd/fm6BTzzh3Tz1srYSPZSLOvHW
 n0hGZDjwrYCn8Qxl/cGaXLr7Xz04rC9G5HGPUanUeOcfUPkfNVzOq1zI3S37/Q62wOolsz+TEQC
 IsEjcFFO73LZGhHyQLG83nuJ7O1KakwQOp0W52vglJSxGJgA0/h16MpkjhtbZr5gZ7oKcwWXFhx
 uVijk4t0wbczoQGfMWd20yKploZicGSdV4fyylTSBSKVkEmNbzbEkfh11mJq4C8Y9Vzx5Zo3Iif
 HB2KPWCcuQgewuLpAR/BX6EJDe0WANNoxBH3tO3QdFUjvl8hgOk09W5/XsslBhIbReLK4+szKkw
 x5Wb8RRoYF7ci1Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 759CF464AE8
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
	TAGGED_FROM(0.00)[bounces-21096-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nrubsig.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,suse.cz:email]

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need a way to query whether a
filesystem handles filenames in a case-sensitive manner so
they can provide correct semantics to remote clients. Without
this information, NFS exports of ISO 9660 filesystems cannot
advertise their filename case behavior.

Implement isofs_fileattr_get() to report ISO 9660 case handling
behavior via the FS_XFLAG_CASEFOLD flag. The 'check=r' (relaxed)
mount option enables case-insensitive lookups, and this setting
determines the value reported. By default, Joliet extensions
operate in relaxed mode while plain ISO 9660 uses strict
(case-sensitive) mode. All ISO 9660 variants are case-preserving,
meaning filenames are stored exactly as they appear on the disc.

Case handling is a superblock-wide property, so the callback
must report the same value for every inode type. Regular files
previously had no inode_operations; introduce
isofs_file_inode_operations to carry the callback. Symlinks
previously shared page_symlink_inode_operations; introduce
isofs_symlink_inode_operations, which wires page_get_link
alongside the callback, so that fileattr queries on a symlink
reach the isofs implementation instead of returning
-ENOIOCTLCMD. The flag is set in both fa->fsx_xflags and
fa->flags so FS_IOC_FSGETXATTR and FS_IOC_GETFLAGS agree.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/isofs/dir.c   | 24 ++++++++++++++++++++++++
 fs/isofs/inode.c |  3 ++-
 fs/isofs/isofs.h |  5 +++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 2fd9948d606e..1db6b0db3808 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/filelock.h>
 #include "isofs.h"
+#include <linux/fileattr.h>
 
 int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
 {
@@ -267,6 +268,17 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 	return result;
 }
 
+int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct isofs_sb_info *sbi = ISOFS_SB(dentry->d_sb);
+
+	if (sbi->s_check == 'r') {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
+	return 0;
+}
+
 const struct file_operations isofs_dir_operations =
 {
 	.llseek = generic_file_llseek,
@@ -281,6 +293,18 @@ const struct file_operations isofs_dir_operations =
 const struct inode_operations isofs_dir_inode_operations =
 {
 	.lookup = isofs_lookup,
+	.fileattr_get = isofs_fileattr_get,
+};
+
+const struct inode_operations isofs_file_inode_operations =
+{
+	.fileattr_get = isofs_fileattr_get,
+};
+
+const struct inode_operations isofs_symlink_inode_operations =
+{
+	.get_link = page_get_link,
+	.fileattr_get = isofs_fileattr_get,
 };
 
 
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index efee53717f1c..68c286b7cc35 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1427,6 +1427,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 
 	/* Install the inode operations vector */
 	if (S_ISREG(inode->i_mode)) {
+		inode->i_op = &isofs_file_inode_operations;
 		inode->i_fop = &generic_ro_fops;
 		switch (ei->i_file_format) {
 #ifdef CONFIG_ZISOFS
@@ -1442,7 +1443,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 		inode->i_op = &isofs_dir_inode_operations;
 		inode->i_fop = &isofs_dir_operations;
 	} else if (S_ISLNK(inode->i_mode)) {
-		inode->i_op = &page_symlink_inode_operations;
+		inode->i_op = &isofs_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &isofs_symlink_aops;
 	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index 506555837533..a3cda3430020 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -197,7 +197,12 @@ isofs_normalize_block_and_offset(struct iso_directory_record* de,
 	}
 }
 
+struct file_kattr;
+int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+
 extern const struct inode_operations isofs_dir_inode_operations;
+extern const struct inode_operations isofs_file_inode_operations;
+extern const struct inode_operations isofs_symlink_inode_operations;
 extern const struct file_operations isofs_dir_operations;
 extern const struct address_space_operations isofs_symlink_aops;
 extern const struct export_operations isofs_export_ops;

-- 
2.53.0


