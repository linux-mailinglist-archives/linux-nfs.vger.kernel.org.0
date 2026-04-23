Return-Path: <linux-nfs+bounces-21030-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MVSMGIc6mmUuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21030-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:19:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E4C452B5A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3853630CC391
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F43EFD03;
	Thu, 23 Apr 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrpRvRZn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB873EF0B7;
	Thu, 23 Apr 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949955; cv=none; b=OChQWS4VIIhrLSRjluPEAuMsgOwNkmlIyhQagu2QQ1GdcnYKyHmGqaBJNSrpQFK1FAAsLzKGN3agPWyHkw4kYbVqCVBMP473X7TD2qeWWJOjHw2W79MHlwGFcst+HB9K+A8g+EJPuEGGTZh3E9Nt36q9gOLNF4q4tKSnafBQwaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949955; c=relaxed/simple;
	bh=uXDyD+EwjECxSZf0mUntOuY7XcXST0vj1dof/taqFWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daoCw846C18pl/iW6dNLT/AsuGRNKxiKMhBcy2dOie0ctDzaw6V4xUDtGozn0IjM3B3wKxu/UZ/hHGBeZSif8u/MjQcPsc65rAoXCrvpryGFYW62xD2wyYQ9dutYtO7be0c28ktnNwLxVddaOuo9fM2p0cM0k84WHljzeeS5kbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrpRvRZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ACAC2BCB4;
	Thu, 23 Apr 2026 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949955;
	bh=uXDyD+EwjECxSZf0mUntOuY7XcXST0vj1dof/taqFWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JrpRvRZntlzmSt9ocwtUhG6ddWZYDRjHd3wHgujHOMI9U+AYhPisLM30AAtQOLlQe
	 01Gd53D7Q2vV9Tlsf8KbLhukDQ5hgQYYOpvuq1dTVpn98qVCcMFZjP6zWh9T6RmOwm
	 Q4J5y/KnxbQrB55wwDsee3/b7gsbkSNjakEee+EF832pC8iCotKy5yM1V3jXf0Hmci
	 YPfnl/mmb+3P6krg8qFiojfja3mKm573/WirWY5axwhFtXAJoxqHklWs9N3mNaoLzO
	 aDR/XD/+lyu/LX6JiNaoqZTKOdgpjX5DEG9QZvF8LI5U3eLFapcJPiBWMh405SKV6O
	 vB1BHojFWdvbg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:08 -0400
Subject: [PATCH v10 05/17] ntfs3: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-5-c385d674a6cf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=TP8XZKgmTAxM/QUA73jikSOpFVJB/k8sBiRSJXDKGtA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hqzW2r9DI2tTyUqjzcjwCpAxGOG+xohzyr4R
 dvViUQRyjiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoaswAKCRAzarMzb2Z/
 l4lWD/92UiZReSXXnnUPKjJmt1G4ZpWEncOQ6tZt0cCjJtDe8G6HC7Ymp5d7309jhHESdw2+Ql9
 hmp5c5DBfW72+LbAklR4Cawp9cGUD2ZfV6+gafPxQiq5nDMCDEPDC31pZxzycBAu1hECkD13Mek
 VKS9Q7ItH0o62WvApgRwqNo3dCv4K1cxI1lPBOv3k0yEe4tuHj0/WvZv+6zsZErGj6QJwVp5cEr
 fAzIhEJhBBzUm/Dd85zcYTRfJmqq4mg5+uRxl79jBXtmYvTP/gsYnB9jnIkKSMHIcg2x9Zo0ENL
 KWmrsj4UHG4m9OwNzj3AR97JH7KTsEHwO684d+eL+kgc7U09eo1MH3DjA6W2Oqo0UmIzNwmemFn
 UPR12UzycdjzphFEetoAb4Kgcd4WnBp9F9znLQgF1N8Nc2JQBoXIhUOU6Z/pCbqvzx0cBy99GuA
 f6eH1dp+pHhjxUEGq2wpsXv8J2lWcJNXdX6WrEGjsy5+SGO+iJCK5uBUqbNJTsnIBUxnYERA1Ww
 oMaxHM4H0mcU5rJ5lk8u8cFX8AnrYhnWxyvzpodJax6nUvjtCMtFghxVclEdLXJcHD5KflWHlxD
 l6scL4KOO0s0EIcxLPT8W0cjAY0hLtqH+4LUUdAAkm/EWeH/hdY3fvfCowy0gHjHmMNxC4mz7Og
 W+xGMMk+5zhUy7w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21030-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A2E4C452B5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Report NTFS case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. NTFS always preserves case at rest.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ntfs3/file.c    | 23 +++++++++++++++++++++++
 fs/ntfs3/inode.c   |  1 +
 fs/ntfs3/namei.c   |  2 ++
 fs/ntfs3/ntfs_fs.h |  1 +
 4 files changed, 27 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index b041639ab406..bb3b3a89204d 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -180,6 +180,28 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 }
 #endif
 
+/*
+ * ntfs_fileattr_get - inode_operations::fileattr_get
+ */
+int ntfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ntfs_i(inode))))
+		return -EINVAL;
+
+	/*
+	 * NTFS preserves case (the default). Case sensitivity depends on
+	 * mount options: with "nocase", NTFS is case-insensitive;
+	 * otherwise it is case-sensitive.
+	 */
+	if (sbi->options->nocase)
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	return 0;
+}
+
 /*
  * ntfs_getattr - inode_operations::getattr
  */
@@ -1547,6 +1569,7 @@ const struct inode_operations ntfs_file_inode_operations = {
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct file_operations ntfs_file_operations = {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 42af1abe17f8..a5ff04c2efd3 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2095,6 +2095,7 @@ const struct inode_operations ntfs_link_inode_operations = {
 	.get_link	= ntfs_get_link,
 	.setattr	= ntfs_setattr,
 	.listxattr	= ntfs_listxattr,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct address_space_operations ntfs_aops = {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index b2af8f695e60..eb241d7796ba 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -518,6 +518,7 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct inode_operations ntfs_special_inode_operations = {
@@ -526,6 +527,7 @@ const struct inode_operations ntfs_special_inode_operations = {
 	.listxattr	= ntfs_listxattr,
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct dentry_operations ntfs_dentry_ops = {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index bbf3b6a1dcbe..41db22d652c4 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -529,6 +529,7 @@ bool dir_is_empty(struct inode *dir);
 extern const struct file_operations ntfs_dir_operations;
 
 /* Globals from file.c */
+int ntfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
 int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,

-- 
2.53.0


