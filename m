Return-Path: <linux-nfs+bounces-21029-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGSuAIcc6mntuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21029-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:20:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E556C452BDE
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5860307A2B7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF153EF667;
	Thu, 23 Apr 2026 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D98UTL4V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4FB3B95E0;
	Thu, 23 Apr 2026 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949953; cv=none; b=eG7J0dQWv67EFwqerOnY/o/4rKxX6YuK4ndSUzOQFVZdGETHEw3186hWU6BpLmvX8wl1d0WwqUOyU94ulzTNzmTrDilONk6Sma5T8EVnL3rpHq5X3lrNuz/VrpX9MNcyEc1MAWOBM70mVeV8Cog8HhXriMaiaVVJHLNL5PcKx9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949953; c=relaxed/simple;
	bh=NB5dGHQsj3zLr3dcAIz13EIGulkS60j2QYCq86MIXR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p87MIm2dDSoE5rl+A1iK9PTDbYmXYHkNeWj21dCTMgUMqCGdMCox4YtafgzN0pyV/s8OC+ZJbT8deTpiBXr6l8QlM7q9bxL9gzI02Bpe9D/kgMCRXzLJoYl8kzJEvh8tv0CisIVLtTltwOqH0q/nYyrbUaaO57dnbtqAWyh/GRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D98UTL4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF79C2BCB3;
	Thu, 23 Apr 2026 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949952;
	bh=NB5dGHQsj3zLr3dcAIz13EIGulkS60j2QYCq86MIXR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D98UTL4VZGvNig5IFBGeqogFyeD8yZuecZNbBLZmLJadhvvFCSQYIsk10SlU9f/Y+
	 OilgzQOVVccEasG0B749UAOI7RhNxfCWBiNlrR3Hz+tnWKqeLhsRv+VXbjTZMlv/ux
	 TX1CkvfY8ciWeI0Qci2N7cFt63GndPHClbVaWAz4QEC+t6Jkqd3eSqPW/4PVUVl2Fx
	 TQPBgMbhg81ujDtUwg/Y3lMZTtBfQ58BrLkYX2SLN7xO59LyDLNW0V+GYMCfluVEjm
	 AoNB3Vagugb48Hde7VHL6aox2TDS19bagoXJAkKaQXpaTRMnoEJEVn5zeIUfVFQQMQ
	 A+jh8m7Qfzc7A==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:07 -0400
Subject: [PATCH v10 04/17] exfat: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-4-c385d674a6cf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=q+8BbK8Itxc1BuNkeDUPYf4FrFMUGad4IdP0+8v/SOk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hqzDXUgGpeYrfk6G6fKlquI9oIt/yNQiAPuM
 X2KRQzy4biJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoaswAKCRAzarMzb2Z/
 l0FdD/4rKdHL/ffqgOqkeiFmk+BTAPJ0+Chaj3sOX5l8VwCV0SNp95QyLXh9+rpXnv2wE5X8+3e
 dydGtn83WRNrKipUisa/ujBAKndGTMd6I03NskMVMG3EluoBZ9Bg3vhL47Y0y2QmWMH4t+1xPaJ
 Pdxkw9dovPwZyAngsV2C3pl7GMipSHtuQW0KkA8Q+3iieTONjFt5C5G3LWC0IfqiuHDJNBASvw3
 VDObDcMAgnX24DsjyMeW6DfDtQetAwJpYpxUv8aQof8Y1BxYvKseIAKEpeDONS/RxDBtwJu34bm
 37XQ4C5oYPgnQ4ody3mh/Okpu6GrX2yWFjsANQz0J9txcA7E+ulZSH5dujzGR9H16ZBwlt+1sjh
 3JBD8AbVeMshHrMRzclMIAH5jwNbUqtWJbNmpcSpCXW9ebyz0NaDrs5hOxeK7RNVl3OVoe4Lli9
 Z8L8iHKcv1F39u6grow366tMzYrSRYtYavg/grLzGdXE/zpRGDRtrm919JTrdfMS3aENy07tb79
 BLKoF4i06AKLwsOoc/4NefbfwtSCNUodqIviMNFkRsxwvmwT4AcId+OKI5t7CuBDnQ+/T9UTGvm
 mR+lszn8Pi5P/7REpwVwAYmCryVi/OT1+cvO5PkYbluM92MZpZBcbrxin5fFbYceJm9fcStrq9f
 Mp2pR4AvdGvquGg==
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
	TAGGED_FROM(0.00)[bounces-21029-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[32];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:server fail];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E556C452BDE
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


