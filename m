Return-Path: <linux-nfs+bounces-21422-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJKdIhVY/GlOOAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21422-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:15:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE04E4E5A1E
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9884B31257B5
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1DC3AC0EF;
	Thu,  7 May 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdgAia4V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FA39EF0A;
	Thu,  7 May 2026 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144041; cv=none; b=IxUdahBVZLRlGD7LTtSjVzG2vhhLfeDh1WEx+0VPjmrVV/vIP/Lvflq3oMqdKnjUNJtUJYAhXB1FzZAksoAUeHAtHAzxcJwXJSG3KCu9fXvFyrD5nYbfvbbRgEZv9ZG68YU3/mPswj4KF/eBi1ZyOFzjLd5+M/1ENMWHOlz0dtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144041; c=relaxed/simple;
	bh=CpkP5qXoychwgQhX7e5UaD0uZEj/2vnARHn3ZWzY3lE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eF3ot7BZ+wY40cJEG3vsTyLB6sVZKho5M+lUSgWRrxyRNY7sYcIlfezVC46BBempb0K1VUETwmC1qhVg7WflXAa8fZqjXzR6SpAKoI6D7e+e7Zbycnomp91xD2nkf1hKGBOEsc3STiqj5Alu9I2Qu6TUB56A5oT8RSEJY9iEtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdgAia4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5A2C2BCB2;
	Thu,  7 May 2026 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144040;
	bh=CpkP5qXoychwgQhX7e5UaD0uZEj/2vnARHn3ZWzY3lE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mdgAia4VjXayPTDEocoKQ5NFbkqPGipGQV03bbMQQShP43/KoaXumCHe4egRLVeGN
	 eEXgrPNHpoBmYNEnazpFH4EJVqFPnHSFJoIuyG4BasSqyXflwBiSiz183urtPZ/aSH
	 4Ydvq83P4EkoSlToNMhAr+O4JxihtQrNZMvyznTIteBkW9lA8KBGhZrglyyNhUjK2P
	 t3h2t3fe6cgheS96KMbVbq4Eh8b4LEInjnRwVYiE4KpXBUAw28jAPw0Vc25iO5oNh5
	 3hEvGharzmYjTSpGIDUO9HbZRW+76Xq/cssp+UWeSkb24ugB2FicDtFOOfY0pWtcvc
	 hJ0JUl9IWSoUg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 07 May 2026 04:52:58 -0400
Subject: [PATCH v14 05/15] ntfs3: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-case-sensitivity-v14-5-e62cc8200435@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=L0NeySD9QaaPp35s1Dug6uu6ElkMQLL1BoFsiPZmIBE=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL13DJRT6JTajZnDiuUp7aIst6+o4YGoXcYV
 unAdfCmXpaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9QAKCRAzarMzb2Z/
 l0lPEACeBg0D/yuuSIDAEl/vYv/EEPCmU0v+ilcE7+SBZIDJHaPnMpOHcq2VcriDEoGLeDrFBA1
 M5OdlF+qfCDnUt/ZGOBj4CEvGmEvg5rID+7oi5Z3S36u9TunsuyBCR1BeeSpfsr/EZwHO/cDvlz
 wrkw+ABiNWokGIIUVHE1ICZk8oYZtMWrFZ6Q2N34kuZvYuj9pnRmkZqhfLFuEE1VLWHyELIc5E1
 pea8oDHkxAdWpv/439mA611MaiBAhAB0qkDAIFLYX3L3llGvGDi3ZYUeRu61BQ5XSUngAdTHLPF
 wOphbl3YHVLVxZwARMlKD5+Yv7PQpScwFc6bMShhrYD4ka8SidtqTkpWycgtE1GnDwh1EIY4qk/
 zeemz+0yGHpx3Bm5KKRgLfYJaOKYX+RWSQAH4CpsKyfBTgBR198rwy7X4E6eOJnnMAa+CS97zX2
 /4BaxOleA2VZeMUaPjSpb3j6jmbrGA9nLi5UYhNEUJ9bzEPXPJhgYcYxKOi3Ubj2TDhrpUUNUzo
 Kx3KEoMrW5S4yWtMMLAFTqNyVrNRnOZxmfrN/hfjhwQAFMJrJsEM4jd8ZsXsFvNszxtH9I1Z5c1
 Dj4qXXm5zAuwZiW6LXoCTuBOnI8Z8Xc3geTj74ipQoWDhqGh47IyJAABNiuXT55GGeq0DC8ytSj
 UYQzN1kC5Vd9HoQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: EE04E4E5A1E
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
	TAGGED_FROM(0.00)[bounces-21422-lists,linux-nfs=lfdr.de];
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

Report NTFS case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. NTFS always preserves case at rest.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ntfs3/file.c    | 29 +++++++++++++++++++++++++++++
 fs/ntfs3/namei.c   |  1 +
 fs/ntfs3/ntfs_fs.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index b041639ab406..ad9350d7fc3f 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -180,6 +180,34 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg)
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
+	if (sbi->options->nocase) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
+	if (inode->i_flags & S_IMMUTABLE) {
+		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
+		fa->flags |= FS_IMMUTABLE_FL;
+	}
+	return 0;
+}
+
 /*
  * ntfs_getattr - inode_operations::getattr
  */
@@ -1547,6 +1575,7 @@ const struct inode_operations ntfs_file_inode_operations = {
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct file_operations ntfs_file_operations = {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index b2af8f695e60..e159ba66a34a 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -518,6 +518,7 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct inode_operations ntfs_special_inode_operations = {
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


