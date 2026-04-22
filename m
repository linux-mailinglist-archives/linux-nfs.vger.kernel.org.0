Return-Path: <linux-nfs+bounces-21002-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP35MYha6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21002-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:32:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF3144BA91
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 754B730DE325
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A335F5F1;
	Wed, 22 Apr 2026 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsjnVQcM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2BA395D99;
	Wed, 22 Apr 2026 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900626; cv=none; b=Juvyqzui3mEI52fd+uKJkaLTqfuPFJsxusAgJd2TvyHdGA/d6diCp3n8+kod0MgmstOM8/RdItQja2TeOnDiAfF7cUgggpSwWUD+iCPwl8Ws6G/PFw0AU5Fk+r2Z67kriv5qx99JRwAyBgkUHfnzSXG/6Xe0m1QXoMnWYRBiRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900626; c=relaxed/simple;
	bh=NB5dGHQsj3zLr3dcAIz13EIGulkS60j2QYCq86MIXR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZHo85pRGeGpr2W+QOjrHCD0QY/oLgd40r9tsp6L2nz99KCGeIQRACryGpWynKWMvYmlupQCpHe/AcUxs4p3md8PkR4hNyy7+ashHh7iw2LJbEbDvPnPTN3t2UCbD7tAJ+2wNaljvNIfFLspASeGzMqQt1jyzH0sGpj5qMhSFig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsjnVQcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8927AC2BCB4;
	Wed, 22 Apr 2026 23:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900626;
	bh=NB5dGHQsj3zLr3dcAIz13EIGulkS60j2QYCq86MIXR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RsjnVQcMVxCIKkjtyLCeNGgFMdK2xgKnWdi3u9DLPI+VF1iH+t4kNcmTzgfSgNGQ7
	 HtBRDnsyAmKlKeNfPFSQmseMC7i39ffTMJzVDDrVRjw+64eu/Qv0nqrz/CMjykVfdQ
	 v5lkjQhll8ZUK0qc/6DdRHPPLL3Q/fUD1LgCbQqkaqI+aa4Zk1+qge4EjbJJOOWOde
	 a+jnsnn/NKYHUS9lhM//gVICpWfwF1h0rJEuRw5K4FZLkCEaKR9pbrMm0tfhC0JJIr
	 Iofw3EkrT1paF6FwccnzVdUKgujMb4i4whkwgdNHCAwSRI1mwyoSxh8G/bCzWJHhmv
	 q7cn7vQd7WKNw==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:29:58 -0400
Subject: [PATCH v9 04/17] exfat: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-4-be023cc070e2@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=q+8BbK8Itxc1BuNkeDUPYf4FrFMUGad4IdP0+8v/SOk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoF0dXjFDljLGiwndXVl0smyJi1TXib4riLb
 fAbdLq9i3mJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 l96oD/9sQOYnspj6pndQAxVjnCKDS8fMacuwOFJhveApT8nc83wU3gaX37Ibap3KHDM67yo9Eo4
 BO0xCWgX+1bi0sHP7g+3wUea7hj5jwxb9sL3ux5ARn60I91KKMEphlBof9zAu9hKRQR2zefHHr9
 78gzFXYz6cQqXoFzDjebheZFsUqD5smnovnGnaqhTyyLEU4DfwdAlZ8dfDsY3f1A+cAObqyiwZG
 paS/Z0IgG+KDsDNzfOMa3vkpK4C3fil3pNzkr05pFCKiZIY2JI6MnA00DLEcNLEKfhlu3lBHmfB
 kJxCk9Ic5vxO6h3xt2GD+KLmjt3eYPWhwOaYqBIXjY5qYVv6ns7WCFaUCUGu8og54eWqZwWjhB/
 //hDFcCrGKLprrx6n2jrjaiwwmlbNEDKRTEnByiU8IooJaA7iKMP60BQCnkrpB5JIfA7kM0DC2D
 FHemwa53kjXku5rBwfI13ZInxdhDEs2QeY4jF4nHYVlurew8pQss8UuCqKaIaw/i6uHTWy/mFHO
 QRuPWQ4DxG6sYvgA/DE9Cv8BVITtlsq3pdiefLzKy6J/grUkSIasCAQdzXPQn6imssRGWavMiTW
 n9FXaUAWTJcDWYJB7655idsXto6L8TgSe5cYARfIkVskkJctd/FRBlO/cVrcugjApA9DLvpSvVY
 /vwhLos9Qe9KXIQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21002-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EF3144BA91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Report exFAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. exFAT is always case-insensitive (using an upcase table for
comparison) and always preserves case at rest.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/exfat/exfat_fs.h |  2 ++
 fs/exfat/file.c     | 17 +++++++++++++++--
 fs/exfat/namei.c    |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

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
index 354bdcfe4abc..8af829ef54c4 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -14,6 +14,7 @@
 #include <linux/writeback.h>
 #include <linux/filelock.h>
 #include <linux/falloc.h>
+#include <linux/fileattr.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -323,6 +324,17 @@ int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
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
+	return 0;
+}
+
 int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr)
 {
@@ -817,6 +829,7 @@ const struct file_operations exfat_file_operations = {
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


