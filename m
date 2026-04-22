Return-Path: <linux-nfs+bounces-21004-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCcdJ7da6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21004-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:33:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD2C44BADD
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5667430FC52F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F6F3A1697;
	Wed, 22 Apr 2026 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1fXpcMg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4834C9AC;
	Wed, 22 Apr 2026 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900631; cv=none; b=aRKDIR7MK8goySVLJ4odrAyLUfPfOvewXNnixBjUEke+LIyIsmiYZWMeugW0Y3fksVBQiop8kc8Qo1S8BncsbaLFUWllbvjnZcNDdpfwrPs9PqVG11VxapING5jAEGgEHAIzc7/CuTSIeSn5JlxmTwK/NiUCMXS1xfTwVSpMqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900631; c=relaxed/simple;
	bh=MPKaRNRTQAJmLU63db2cpCz96vGgkp/OyFEdF/JZV/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6jtvbrnQyKyfmpukWt/xXv5TOcTuh1LiJiKu/qWtFf66pWOkNxFB5aIZu2DO1nKtcwNxENS5ei95i65i87C3QUfw3ovWBqiUb8A9dvAg8NmMKMJurZoCWidp6hAwvzjZ+Qp/hI9lUIOZb9lT7xDqszwfaqZy8tkgOvE5GamyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1fXpcMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB28C2BCAF;
	Wed, 22 Apr 2026 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900631;
	bh=MPKaRNRTQAJmLU63db2cpCz96vGgkp/OyFEdF/JZV/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e1fXpcMgY2SMHELymHXAHGmlviYXMcVNNlzqAal1VpBV7erYU5endNHTdfpX5MooZ
	 f+JuWCRMqWL8e80hPpoWXAMxwkLn7IB16/cZi65NHBXkaEf5TnjrdoRFxM8gZBlUgw
	 Jk5gSsECQJX431rYYHXu3slHqw18xxQLdCv2bHvyydinfN/H8Och5gEK/HOFZ1URNE
	 sikpykcJTWAt1mjnIFmlUtkZL/SlIfOInaRd0XfuqRpPEkd5nL/zwnCt0YOWtB4QCE
	 qVqm6JBvyG2Jyn5j2Fqlxel64Q8npSc62QcurcUgvsUsFjsTWnYi5wPy/wVugDgj3N
	 c0Cs7DCx8Ifaw==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:30:00 -0400
Subject: [PATCH v9 06/17] hfs: Implement fileattr_get for case sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-6-be023cc070e2@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=sBcf0hJ0mC4j6QqtM39zu2705aCjapPtH74zbWqfwDA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoFF0e4b6ogjDyg7qWQkKa2tzF23QmRrkvgl
 1JhhI/4PUiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 l6l6D/47inW6njVnLrm9cGl7rHBeXIeOzLam4R8IitrDpY/z9a0zHYqOMJJtNF4VPorGh56iQmq
 /Y33ADa4D2dGJvToyK1aWZiTwsw+VjlbXb8UFyE40/8uCycVaLHZzxWWKH9s4MECvRJ8nkhSh/N
 rYsQCA5w9+t/IOUESMngCZN63l6bwvacQhWLL155XEsRY0XECv4Y6CQtbJH48v9WH885Ai9sr7v
 XlvyYXX7BowqvkHrRxctP8guMj0SVXnKJXnlY2U53sWE3BYeIejoxMnc6IVfYQnv/r81SBpuRj0
 jPXLpDfwbrklFXl3YBT2jrfPnO+dnjRWY1GIvEmYRMOAWFfCapZl1ugQ+PSX2RZ27MwTfLjNcU8
 brWqM7TwREyysQvVO1A11EoMHpUWqw8U2CzrylD5rQt8EeYl7WG6WAGFUxdqZYLRtgB9mGxDfTF
 /qnkuIbEku1s8PeZW0ZgguYkwD4iXOAdJZaOauoHa8GJ/cFg0ibvBufljiRD/96SVfAw5iR+0/6
 Z19gbXyPIL9b5rK4/m+yxTHbgJ8v7ZLIs5KVqLYRgkj/LX+C7oXRKSeYnBzRe9B7K7Mip7V+QLq
 J1HUIJX2OJifJx3FpAitNTAGywhsnFNHHR9na6cAAoNKdYNJxTJlSASJz14vppwK7TS5KJZA28l
 5dJ1Gsn27wSg1ow==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21004-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:email,oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FD2C44BADD
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


