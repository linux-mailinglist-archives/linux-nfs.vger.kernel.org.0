Return-Path: <linux-nfs+bounces-21031-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wExMGnkc6mmUuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21031-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:19:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCB8452BB8
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5457E30D1CBF
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A303EFD29;
	Thu, 23 Apr 2026 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbnX9qLG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E13EF0BF;
	Thu, 23 Apr 2026 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949958; cv=none; b=il0gUvY1jIR0WUyZQStsi0fR2D/Az2RYIU0B41Sll7r/vN5Voku5y1ifwtCnliwRjgyCzsDr4MgF+VzV44YfCxf/XoTfWpk9IaGPllrwQVxNC+3okv4dkZkzQQLMDsq/BqACeFG1N/vb1LjGPyGQPlE9n73mkXiHmpX3apWlVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949958; c=relaxed/simple;
	bh=MPKaRNRTQAJmLU63db2cpCz96vGgkp/OyFEdF/JZV/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XuUJy9cqu/TCHSanJccqXHUf/N1AwJBX6dimC0fxErMYUh+v7D+IPIfxOa4oBAtpH1sbFS1xsgTwj4x3yeSdEHmvvsjGlOBMWfyFuYSrDMyEcnseDPDR9sQnpjb2ln9cogMjLkpvHDvUdD4g3Bz50nbzUnPOxCU7H/Dwgi66I2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbnX9qLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C70CC2BCB5;
	Thu, 23 Apr 2026 13:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949957;
	bh=MPKaRNRTQAJmLU63db2cpCz96vGgkp/OyFEdF/JZV/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YbnX9qLGbLoSqLXFmEo+ZrHo2w8tkXdK9XGny3lPAid0kyV9xzsR5Sqa1mfdMSN+L
	 USknez0InEzMtqR8YVgL07V/2drgpYixdd6KuryyUv3RzU+2AZqMP5mWiNX2q7STfu
	 t3IpnghLgGFAut9+GIANa0Bk42uR4ydWwMohzVjOn9Z+2K46cyBbje/1jAxVJR+0tZ
	 c6ZsWC1XxhBHxQSXd5888Y5fAAp3Ud+PYaRXVyp8xWU4UUf5FHq+1QNOkZfgJtjgcE
	 J9jO+u+OUJzwr8qeoVgmm81xSqOS+6w4nNPUQoNgbgaLulJy4Sn3iGqKMAu5gfNJ/n
	 5nZk2watHTCSg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:09 -0400
Subject: [PATCH v10 06/17] hfs: Implement fileattr_get for case sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-6-c385d674a6cf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=sBcf0hJ0mC4j6QqtM39zu2705aCjapPtH74zbWqfwDA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hqzzbILQEa/TWCIPDoZ+K7gVeC/4E0kXJGIh
 ohl6IE0CT6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoaswAKCRAzarMzb2Z/
 l08nEACzGceBSSh2NRK6+AaJyPS8eG6EhtvrS5qjpyxCXzNdl7+8BzsQZRfmZVdVg6X0fBBXcN7
 fDo9uYYA9zVT/VI+HyniAVVh/NH5083YGjivayABq1vkCYfFSC/EOuwxcHIxTKlnSaTvVqdWAyG
 OZLikPvLkpymhBDRnhg3uJbel1ZB3HEowVEIsluR/N1tY1TpilMXGX5x8movwXRr40KNkyZf5Bo
 c388tMfQfUXcxF4+O9LUrM94ia84eXZ15RiNjgr4sv9ullebx7FW+46XmerKtZ1QtOeF1g1Jubl
 9bApRY/nIU0s1UI2piJ16y/6SlwddqX649JfA9rrvkeBIgh3fXqtiOXm0XBunfE2czj2PgGRvZu
 y/Dyk/ySDYHQv/P6KqyR5phkYrdoP5vbfG9J2LyjYuZNj1sO0om7ImLAJZ1QE3KhsqWTA3Z5RI0
 fSYHTGG0QF3sNlhdJPIv2Jt8zsj2LvuEEqQjDTFmWDwfJuSuJLWv4Nb+Fpiap9o4W627+mPab6r
 VTu2h+9fKGBBMQyvQa7W0NKTaqs946fcGiCX7xVtBd6VSUF43pmb+eBgynvFVSsAvqbjQrKULCc
 WX6d0+azDb5xpnzK3m54FXIUMeSNw/SDKLDGTy//M5NtxAEsYWQ7ehhsN1M4uykmvt/AenFhVKQ
 DE3qfCwqPuvVV6g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21031-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7FCB8452BB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Report HFS case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. HFS is always case-insensitive (using Mac OS Roman case
folding) and always preserves case at rest.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfs/dir.c    |  1 +
 fs/hfs/hfs_fs.h |  2 ++
 fs/hfs/inode.c  | 13 +++++++++++++
 3 files changed, 16 insertions(+)

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
index 89b33a9d46d5..f9a10444353a 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/xattr.h>
 #include <linux/blkdev.h>
+#include <linux/fileattr.h>
 
 #include "hfs_fs.h"
 #include "btree.h"
@@ -699,6 +700,17 @@ static int hfs_file_fsync(struct file *filp, loff_t start, loff_t end,
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
+	return 0;
+}
+
 static const struct file_operations hfs_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
@@ -715,4 +727,5 @@ static const struct inode_operations hfs_file_inode_operations = {
 	.lookup		= hfs_file_lookup,
 	.setattr	= hfs_inode_setattr,
 	.listxattr	= generic_listxattr,
+	.fileattr_get	= hfs_fileattr_get,
 };

-- 
2.53.0


