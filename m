Return-Path: <linux-nfs+bounces-21088-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANhkE+Qe7GmuUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21088-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:54:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF046494F
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2516E303DF62
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486DC239085;
	Sat, 25 Apr 2026 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fozMK6S9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BC199FAB;
	Sat, 25 Apr 2026 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082014; cv=none; b=UaPTX8PP3PCy5/Pqg6EHNeD3fObhAVBQTDomD3s+DnEFU74buh36u5OxaK7jwjw4OwZW3J6b+aUQIj/BYDJPTj2r17Vt3aKj43xk7OmJEJC8W/mzHnl+GZ8tjwYvQHwvnfryH4hTKGLRlUSsTMu0vGfpa3sruFr01Lanas3+vrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082014; c=relaxed/simple;
	bh=wqnEoHXABCWnB4qIWNaXjQlMxqtzft0aZTt1jlyUTc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxXB9gpEBWUmzAcziu5J0wUGSNdtUL/kbXJ+yQ97aWCsHPX0I4CRpMXLZbpYs7CGgxq+HcKDyyeomMAHH8SdhJ4hx+DxyRRd/PQc6SOvasUDcFjltd2e1Z6LiH8pzgG9pO9bHiPPVMGa/YfeAqRuG/eZG0Y29aP4SVdhnCIjn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fozMK6S9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8034EC2BCB9;
	Sat, 25 Apr 2026 01:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082013;
	bh=wqnEoHXABCWnB4qIWNaXjQlMxqtzft0aZTt1jlyUTc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fozMK6S9eYLfaRO1+ETFl93gEvxMEK3W3hWvSjoJE/6PwL7erxD1UgMB71Hkw/W2J
	 rCZKAK38ItJTKA6p3Q43icJu+6uD5WQAYVa96GULbu/NabHBAAQfGtFWmS47rDotPq
	 Ld1Xw8SnG0S31/uhfm5XCM6Plg08lXZfy+wkaQIX/jVgQ5yFDLchZxAgozuzSRtYEx
	 ttJs+7NZCh6PDCa5gw0Vk+n5v42YE7a7soHU3w1Xdn3HUaT1BB+6v5gIx5hsCUoxNe
	 gCkhy4JQDH9H0xJdvSN7FbIcLEHgeItoDVMzQJMlzTW3FUbWihk0YkYxwOedWINTrf
	 oY/diOPP+8Pkg==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 24 Apr 2026 21:53:06 -0400
Subject: [PATCH v11 04/15] exfat: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-case-sensitivity-v11-4-de5619beddaf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Jrgq3TGYmS+gsjYQgXc1oI5YkxxrwLITLmwEPv8w32E=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6QBuYz3NECRagQ5ROLT/1nvTP6F/YQBFkHh
 k+rXhvNmymJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekAAKCRAzarMzb2Z/
 l04kD/9/XtL1PCnDsaBe6bqOf/yFrG0jpUzClM+mDrkjVvvvuGkvYYHioDSZBGQeEG/fJc2u/WK
 PQ4QMfQN6rtxj2xRrd5K3AFaApP2I7IZM9GoJBNVvZO72xHahvDZmkY3Qn35Igd6EbBS+KFewL8
 fMWtHZRLCBLOJGxVRbnfLkLokjnl5APRObRvqIUOkMBcn1YhoZfzDLvLzNDqqtD8y8kFl2OAVDe
 /R335GvPLyh7EmFLRtYvoOPYCSmt7YthR6xdbYx6p35j9HBp3TW2zn10aC3cHTaJWINg2aLOlgY
 CoeTKZC+bds8EvEc7NGViZR1FZ3Q0r1jwaoIh7V0KwZAuz01z4oXVWVJI+QOgNa8ARMHxvv5j6F
 cyfsGwj5z5oKVSSwkviuXbyZkcPlzys+kzkW0qqvzDCpUjfmW+7dizmAMwYGw58xxDY2Xi9wX1U
 TMcGgrZmmX4mFa+x92Aecdl9qv3Hu9VpvOSiwB3jMGhRvxSwifHcB+/cFc1L4ayh7G+GBDujBOj
 Hcr90oXLrjbguBPv48S1bbP7oXpFZMtHcnHEopKsWdMVCLTlpRXFOZjJfbgAEnyu8l1GLos/vs0
 xxFBvhwnA8gmiPMqtRjE4Lu5fiwtDdYlSlzVN8Vc0X3GTWFDkn3SKcrOcjOkVl5oNmVoV/u+8Gc
 1WZsuX/riZO9Lzg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 0FFF046494F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21088-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,nrubsig.org:email]

From: Chuck Lever <chuck.lever@oracle.com>

Report exFAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. exFAT is always case-insensitive (using an upcase table for
comparison) and always preserves case at rest.

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


