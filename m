Return-Path: <linux-nfs+bounces-21283-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGRmOotJ8mnNpQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21283-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:10:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0BF498BFF
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A68B302C346
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD04219ED;
	Wed, 29 Apr 2026 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sn5WNYcw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2EB41C2F4;
	Wed, 29 Apr 2026 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486064; cv=none; b=iuzi7gpdi9BRwTBZEjnkeq088+LvmIlLdS/YzAlcZzm2Nh9RaiMoeN430084JTjNvi1ObWI9jBPawhalPDvgCc9khwiY+QjQhV6P+tN8t14Azv9DeX8iwWOl0ku9BcaEpRXq0IO/RORmWRNdzuQC+83o04T6X8kaUggpYSlLUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486064; c=relaxed/simple;
	bh=+3MOBq8tIY5WA12oHUqvFyZTiNAU0Ok39mLnTTLF1eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLZvWBYLzrjjxxb9hWCGMd+hHrFTLd2oDzGiUnovDumM4O6k8OAKI0/V87U/BmUeCzEBrqxzjX2qAcSTWinxHNumr/qS4/FgqwWH8Tcj/a0dXOV7OpHp/RSLi+EQiyNnC4B99IGoHFfC0wzPGNaUMe1I4oVYFfRMYdhkmYcasBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sn5WNYcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A24C19425;
	Wed, 29 Apr 2026 18:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486063;
	bh=+3MOBq8tIY5WA12oHUqvFyZTiNAU0Ok39mLnTTLF1eI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sn5WNYcwOS5XkPUDifxALSSvjDsQAw+ctspndg7a+7yGJf66U5P/pwLtU37qZgdMl
	 LIKkqy62iDfd5R6bLLajEXvtUAepv4Qzue7IPilxoZgCg1lGP05qvpG2DS33iWExBD
	 6TjR9HPXAEFvLzL/FKMQR/q2Kdpb2dXYT+v6J4EjhVSTGFAq76Ce3yGRQCH6WqYlR3
	 Yand7R2gFHFpRIM9CeDi1VGnHS2Dltv3UyfJvZh//bW6cZa4+vzZzkgXqNiV8aDjXu
	 /1MUlShgFOIPwiMYGDqwi+ECUr/tDxKCY5mfIRqvbxkoeHazrCHDp+G7lB9yrEPiE8
	 +/l5Gi/iOpYDw==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 14:07:17 -0400
Subject: [PATCH v12 06/15] hfs: Implement fileattr_get for case sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-case-sensitivity-v12-6-8057123bebe0@oracle.com>
References: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
In-Reply-To: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=2Xqe+DnVGNfulHUCzpURt2jTiqbh233GQupN+nsg0Mc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8kjcMbu8J3ZZsnJNx5OSfXNR0ib9yCFwb/FWx
 f6j5ru9r0OJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJI3AAKCRAzarMzb2Z/
 l0ElD/9CG/JBuZOsRDy5u0rsIVVp85xaf9Pwdb9wPm1EMWgEdP/MtQqJT+aF418t1ODxydLtMbc
 URaCw4swffGw8Y9Ye6yA58Rkqc7e3fnaboPeS8N4szbZKUjx31UN4UTJ1w2EtNmSsjJtewLfetr
 OAxzPaqmIwv4QgVmC0Ds66xv6/aICpiNRrkjn6OWG+qngSobPfJ8OGwPVTY3kJ2Wi6XSVaGgxzg
 FS09eFYuvC+OPL3xmuMIy+fBg5PXd1X64C5Xg1QJQQGV+KOEREy9WK6sywnWl4HPWmv10GgbART
 4w11eU0QBjohFy2eW8cW3EXzdRKo+odZPIruAWWjXhVHLpEIis9vXChLWL4QiLqIPP9QySWzkPX
 Z0gxKe2VuAHjwMp4+FDkWU16A6H5+OOz2bBOrPABYoJpopDyMTvU8YfeJ0XroDBvTWv/Gvuvch2
 skDD1L0DvmgD8s89IBfqWRHsjdphECH/yAOdJtm44UNqIyaWA9VKbZb3N2KUHkIyMWEf7noSinH
 Gr2WAV6ebteMNaqeWqfeUzVR6N83mRgI32XBHGpui0ZP6iqgrx9S1tepz2qjQmTu65Y+s4pgKiY
 P05zJTQuM1wDP6Jnzc03kVW9sL9G+15YpY9OkzbPgzrfORIqiEfZnfDijD53dLzj3EGx7LHm/ju
 NctRkRdmw4g3Sow==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 5C0BF498BFF
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
	TAGGED_FROM(0.00)[bounces-21283-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:email,nrubsig.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

Report HFS case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. HFS is always case-insensitive (using Mac OS Roman case
folding) and always preserves case at rest.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfs/dir.c    |  1 +
 fs/hfs/hfs_fs.h |  2 ++
 fs/hfs/inode.c  | 14 ++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index f5e7efe924e7..c4c6e1623f55 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -328,4 +328,5 @@ const struct inode_operations hfs_dir_inode_operations = {
 	.rmdir		= hfs_remove,
 	.rename		= hfs_rename,
 	.setattr	= hfs_inode_setattr,
+	.fileattr_get	= hfs_fileattr_get,
 };
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ac0e83f77a0f..1b23448c9a48 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -177,6 +177,8 @@ extern int hfs_get_block(struct inode *inode, sector_t block,
 extern const struct address_space_operations hfs_aops;
 extern const struct address_space_operations hfs_btree_aops;
 
+struct file_kattr;
+int hfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int hfs_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 		    loff_t pos, unsigned int len, struct folio **foliop,
 		    void **fsdata);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 89b33a9d46d5..f41cc261684d 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/xattr.h>
 #include <linux/blkdev.h>
+#include <linux/fileattr.h>
 
 #include "hfs_fs.h"
 #include "btree.h"
@@ -699,6 +700,18 @@ static int hfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	return ret;
 }
 
+int hfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	/*
+	 * HFS compares filenames using Mac OS Roman case folding, so
+	 * lookup is always case-insensitive. Names are stored on disk
+	 * with case intact; CASENONPRESERVING stays clear.
+	 */
+	fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	fa->flags |= FS_CASEFOLD_FL;
+	return 0;
+}
+
 static const struct file_operations hfs_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
@@ -715,4 +728,5 @@ static const struct inode_operations hfs_file_inode_operations = {
 	.lookup		= hfs_file_lookup,
 	.setattr	= hfs_inode_setattr,
 	.listxattr	= generic_listxattr,
+	.fileattr_get	= hfs_fileattr_get,
 };

-- 
2.53.0


