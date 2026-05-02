Return-Path: <linux-nfs+bounces-21350-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB4tHH0I9mk3RwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21350-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:21:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE644B2548
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49F6C3006016
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACBF33A715;
	Sat,  2 May 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyjdR5lb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25907299929;
	Sat,  2 May 2026 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731696; cv=none; b=kHnl2JpIgZ6nCD/cXkffA9jYjgr1XUG7yS9wHFvZEQA7YkqIOMXlqQgIdI8M1FpUWxx0C9P6pVF5m73fABz2S7asn+dnUh08c7bHMUrr4EVygUSUEVw5I0itPckYKBVZkfmNolr71ZwmiXkYIm6IMpIeYBy4FCz9J21QXlJX/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731696; c=relaxed/simple;
	bh=dJoqE7xg5dnDwM8zJtU22ff7SFmezUgNm6OnXSD6EvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6HmasQSAQjrQMYUKfcgz4X79UB3LxalB+zmJH2STVyUzFphqT6X9fdbnA9PKeP8+lSYAFCKgPRhhzFGT90HAHfMQ4QfAIOSh5GJI5C6QvUquVj+n5CIJ9xFtTxtA6YH047FPFyO2D7nK/CVtuposIsEZSuqkpUrB4KFcKEHyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyjdR5lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4603DC19425;
	Sat,  2 May 2026 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731695;
	bh=dJoqE7xg5dnDwM8zJtU22ff7SFmezUgNm6OnXSD6EvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WyjdR5lb9D8b02akU1M7YOd6zUj1wjvRXJgEjmvNVDUmBHc5yY+CW0OkboOq3Nvci
	 sY94N3aXFL6LyVhp2CwWVWw68XO1Vn4lD02PO0mTTlQL7mA8itScfQOV3BCPFh+jd9
	 Qp/dGl6WJ2Rsu4zblVDXhwz3ykFBeUJLQrkJj3Y4qN3geD8I92L8pI1dZZAA/i4M+r
	 pw52Z5gNoGzQpLUoLfGDUYSmNupcZznx2u1SdJIuf1pz+T/YSJT9t2wqfeNmJQN+Rm
	 PtGtVzJeCtoiA/YauyAp26dKMBu/Rfw+ZgLS83t6i7nMFR/4XDGhE7FLaEvxjnB8dF
	 uirmNFIWKfE5A==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 02 May 2026 10:20:49 -0400
Subject: [PATCH v13 04/15] exfat: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-case-sensitivity-v13-4-aa853140311f@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2811;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=w3256AVp6CHVnoJXu0KmBiEb3facwwFeSKlsCd+l9ow=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghQwVydV/I6FUYHtpFOKOuxrA5/yrQacOPAA
 XepyKUb+vyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUAAKCRAzarMzb2Z/
 l2xrD/461UqAsREpMVKet2RbTKHxJsI0yc9d+c1UnTQLFF9/UHlxCoFemStk2bG27wgEU8YkPi5
 pp0TXqGq04h5xhIr/0QLrl65NW3rVVA1RSQO6HEO9jBiNpd1Ze4M81TANAnZwgoCXtyERVO8jNu
 uoPAkMsLP8TXZSgkqjWfOi1EOBKNaYPndA2/ll1sIQIrzfhw9tejp5+CAk5qy55NaWDVo7Bxhp7
 5+6uTWeGLhIgTtZO+Qfog6FcQYq9SoqYed5zp+U/FTgKnLsDBJO8Q3Ra8CWwwp9+COslescvHjn
 fiF0YNAAOH/c3Ammw2bKNNdyQgLRyTERvoIyauudqAzZWTM4NQ0kVFlPPHhiMZ54qb0LULlmFhR
 CWPFn4vAR8kXe/65s7Wh6IAWHoJwQJpnyHmw5PQ1y3R+7p6bFPBRzIE0Z/Y944+GePV51PQWmbn
 oG95qaWEOrww393FMcSwV8Fot8uYlqsVZMIR6qqXSGCt1QGKuFK4GXeXGixAubZJpfdtFHvT/RS
 NGovTmsPtzmSEWhmIZI2PLYfcs+Az33gQdBVmoMwuBzqptsbELyBb7W7NszDFcIgEkyeeUyN/wK
 5M+eivWKwhV7l876sdXHwErHowguQuiRaLSDrl1BOx8LhLVA/n0Fbm8IV7Fbk+FBhw8Vl0+LqD3
 IcrnyunSfNdjGrA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: AFE644B2548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21350-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nrubsig.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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


