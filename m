Return-Path: <linux-nfs+bounces-21421-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLtiDNZX/GmvOQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21421-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:13:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B4E4E59A3
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F4F1311EBB3
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49DD3AB291;
	Thu,  7 May 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L85Q5TD3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51423386C22;
	Thu,  7 May 2026 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144034; cv=none; b=CPNIR5/kJIRRoqJ53PfK9F9C1/r/3fVMWRA8h9kEmyxAKqDceWD4sCtJyNHd+eJP8ijahvZSJabfx5KY0lYBeTTBQtp7QtloeTJAniOwIWXiqMnSfOvGLDYpKeZ3eSjaB45w/+caLffCgI3di6Ae09jVQ6KNmdfstd8dIQ5xxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144034; c=relaxed/simple;
	bh=dJoqE7xg5dnDwM8zJtU22ff7SFmezUgNm6OnXSD6EvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gzk4Ula3Ag170qOG3bsc/gx7429bQuGUYB0dWpIupWF1vupD1w5lp7RhFUG5q2mXzR6BIaYie+8KboOw5us/FZCoBotOcmdxgnpvfMKeHBrwucGxaQapG7kytJ8X5BQhGQiAlfKLNKz4bLEee6ldbXfEIZouyge5SjbpYtvjmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L85Q5TD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9CEC2BCC4;
	Thu,  7 May 2026 08:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144032;
	bh=dJoqE7xg5dnDwM8zJtU22ff7SFmezUgNm6OnXSD6EvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L85Q5TD3eVqbCAHZiRTxSBIy8PO1SlrX4v0pYLwLE7rSXdad6jvwlOJuFU98cfleq
	 Teij/hunMOKETCQXfPZZ7OFoHguSUrHTkHy/EHZH8coNZRLi0z71vE/34+L4jzAb1t
	 hbckLkzmanZiw8lC2EZIvTFjN0Kshn45qHEVkX4qC0XKvTptHZQLhlDf5MUg3eD2V+
	 ylSh3NCAFdLPAmPjWpNS3jxTHNv1l0tE57blLc99d18zldTYW2zZ4P0R7t5u1Qq5Tw
	 Z1/Hflw0qU+UWJ3CW1+W8bsaD8ogs8Q6cwrdowg1Kh7finZ2329ZsoXUoEqTD0gD3g
	 /cM8yZ44f+gxg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 07 May 2026 04:52:57 -0400
Subject: [PATCH v14 04/15] exfat: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-case-sensitivity-v14-4-e62cc8200435@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2811;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=w3256AVp6CHVnoJXu0KmBiEb3facwwFeSKlsCd+l9ow=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL1KSTD7yzZDYzk403Z+TPKqPxdxL05QV6XI
 nkBMfwetH+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9QAKCRAzarMzb2Z/
 l50ZD/wO02jLlG4vXX66EXxvnjRGqWKb+NI+O371fJxDb/42G+4vrOSpgtY/xniSk8f5Yo7JeuS
 fXHr4pVLOlh/EUOYMTHbeCUZN6A1n7u6cqWDpRba9g4BvDJjS2YnZzFIm+6RG1//r1eiiymsVob
 k9zfXzXpBCZRbDVvCQ39CYBVH5mqtcul0YqnEk/ZOzlfdOs1w6QKAxNWNymf/BWanbtM8y0+tT4
 As/cq/QhF1EAYOvE+d54UUtt2T4YCidszuibqHST35Fv55aiVgoWfN6CKAXe013Wj5faa1/IVPW
 yei1xQoUYJ9uu+avNf4jSHOQ0eljT+9pUxWCs7772IYbAPETpQfzzjI7mB0joAEvmX1oBuIKRMI
 X9jzQqzlVSRTcypfJkOnVETijnQ8MqRyXDoCBbhI6Hq0UC/8bsGyb/hnp0jqLJujmJUoDxUDh3D
 +PfW55Rd97AdXmNBX9kC9wRccVKQY7CCWhG9UH8SmVEHnrQnMLG8DqrpFO71lxVcr/HhDRiht02
 BkSnw89YyVicL8lEzZsR3shqp4s9S82gI44BcPedYpsibsZNJNOwmn8UFW/WoQjCZVN7clK+Pak
 OKitJTW0+MrNbP5AxJFRjFa664Egyz8CfQYPY8TsipcNgUS9cwmiCV0efN/REDLwYh37yNLtpZC
 sDDG+TF5j6T2+vA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: D0B4E4E59A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21421-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Report exFAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. exFAT compares names through the volume's upcase table; in
practice that table folds case, and case is preserved at rest.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/exfat/exfat_fs.h |  2 ++
 fs/exfat/file.c     | 18 ++++++++++++++++--
 fs/exfat/namei.c    |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 89ef5368277f..aff4dcd4e75a 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -496,6 +496,8 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, unsigned int request_mask,
 		  unsigned int query_flags);
+struct file_kattr;
+int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 354bdcfe4abc..91e5511945d1 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -14,6 +14,7 @@
 #include <linux/writeback.h>
 #include <linux/filelock.h>
 #include <linux/falloc.h>
+#include <linux/fileattr.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -323,6 +324,18 @@ int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
+int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	/*
+	 * exFAT compares filenames through an upcase table, so lookup
+	 * is always case-insensitive. Long names are stored in UTF-16
+	 * with case intact; CASENONPRESERVING stays clear.
+	 */
+	fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	fa->flags |= FS_CASEFOLD_FL;
+	return 0;
+}
+
 int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr)
 {
@@ -817,6 +830,7 @@ const struct file_operations exfat_file_operations = {
 };
 
 const struct inode_operations exfat_file_inode_operations = {
-	.setattr     = exfat_setattr,
-	.getattr     = exfat_getattr,
+	.setattr	= exfat_setattr,
+	.getattr	= exfat_getattr,
+	.fileattr_get	= exfat_fileattr_get,
 };
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 2c5636634b4a..94002e43db08 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1311,4 +1311,5 @@ const struct inode_operations exfat_dir_inode_operations = {
 	.rename		= exfat_rename,
 	.setattr	= exfat_setattr,
 	.getattr	= exfat_getattr,
+	.fileattr_get	= exfat_fileattr_get,
 };

-- 
2.53.0


