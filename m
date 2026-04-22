Return-Path: <linux-nfs+bounces-21008-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OziJgZb6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21008-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:34:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F313744BBC3
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04EC6311FBAB
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B07B32C924;
	Wed, 22 Apr 2026 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vE9qOI1S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A163A1E9B;
	Wed, 22 Apr 2026 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900641; cv=none; b=Qcfnk9jLuzk0ZSPk3QGT/ef2XNjoWaDde9EKKwiw3bbxxxIdH2x48MOxesN+M6ZjSWu0CcZyd2bjbmk8MgGpxcrvubMxDKseVQirK7zbCsNY2kBw/HjN+n1zGK4ps/7F/SRkjhl1VGjP3vwE+kyMFAwVcfdBs7XyfGThZ6sHnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900641; c=relaxed/simple;
	bh=3FDGIbyd53hieTFjHcvjm5nzg+D7ONlzAFyULte93sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4hLW5ce87PnuRpMlkH8yxYLlEPwyMnwg0ZBHbIjVA5ywwgyacnxr3ZplyNMWm6pYY9T+vcRNb2kroRHUui8VIJLKiDdYMRHjupzXbFEy8afogFBlOpBDYgRKsHNJAJLe3+jEbPqroJcYd/WKt/XyHZUmYNekn8uZnMBmqwzGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vE9qOI1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69EEC2BCB4;
	Wed, 22 Apr 2026 23:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900641;
	bh=3FDGIbyd53hieTFjHcvjm5nzg+D7ONlzAFyULte93sg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vE9qOI1Sv3eEEQbTnMhAdvgAPFVNBB8eyOmJISRYI8Es6gRuR8yDUFqmj9bm7DMxi
	 a98lClsih+0h8JdzHKdnTtLERNelh3ovsyoUuZw9lMaVq4+O7VcGybWCrwy+cfQ8st
	 YMrVopGGJlHOPR0/UaYwC+q1BlA3X0xKmCAKrg22XaOk5yQKqx05jx2q8XCPCiSlIF
	 SMFXYY+60TKlJYBbHaYMNtN3NHCRCGyPknFipeS4TSv3Ip/aadAvZS9mljjkUxCVNx
	 AgX3ddjqjh68xVkMFMP7EK1otdlubwVGtwrswCe8HU5iLHM+5Xkt3Z7ENUHHbGLfjw
	 WugcZz4oQGIhA==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:30:04 -0400
Subject: [PATCH v9 10/17] cifs: Implement fileattr_get for case sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-10-be023cc070e2@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2841;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=NHGFFutdF7XUq+F6V/57X13tbeSdQC6FWxwg7Cn1opw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoGOIp8bkRnF4kmb5Vb8E8yCgkwTWDUH1XIY
 FZmPD9guTuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBgAKCRAzarMzb2Z/
 l6AYD/95c629HAYMskEDv6EbLOg7b/4PdO9vAfj+Remfjt9CYqLZvGYeHRVnbSqj4dNuks55fSB
 DVxWxX2hRviI6Y9AnJBx0xyHDXp+3lUUT02TFBfuOll4bJ8oV2wlRuNJ0uAnXtQpv1tTcmPPFc2
 cdPwV5zmlNxNeL9cQuNYaPy+xT33MnqkvlmM+9OU9/XVn4mEi2EPTNtfWp1XcBLdOgRlLY6je4i
 lPDHzG7JGBhBC6AQJBf3yyaRD3YUn54e56WKiGgSqAz4IqOtR0vqhrNLSZrQPzWp8ZjEW80Ud1e
 nfvWhTjLXoTyKTUrCGNActqia/X2M6Gu0P+9GnJeWDtOcDu9CyS8KwsNPdWj1Hm12pECYhBhddP
 Ius5AYvAsnq1vkSgYAPeMQxMz9fgr01BW7g25lBn1hS8d6ieElEYfPu+3urr1UxCS4DA3FVjq0d
 bHdGfd5m858vQtxbprsaifDAiei0ZlHGedpcwgdi6x2BXjpjL/ZL444lzluge5F2P8gMTZRe+3d
 SnMBVQMuEQt3KgKLPpKlvqP6TdcEE/sUoP1FYYwPrDZ4X11ng+VNEjYRLZFe8KVaBfZ9aC5MT48
 Ght4dWsn2Nt6iziswdU/jSaqy+DtZIMFqO2//pc1gnkyZp7l/gHK5MjUiDUXkkGZVO9kv4Rrqml
 +B1DB2l+LXtmazw==
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
	TAGGED_FROM(0.00)[bounces-21008-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F313744BBC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need a way to query whether a filesystem
handles filenames in a case-sensitive manner. Report CIFS/SMB case
handling behavior via the FS_XFLAG_CASEFOLD flag.

CIFS servers (typically Windows or Samba) are usually case-insensitive
but case-preserving, meaning they ignore case during lookups but store
filenames exactly as provided.

The implementation reports case sensitivity based on the nocase mount
option, which reflects whether the client expects the server to perform
case-insensitive comparisons. When nocase is set, the mount is reported
as case-insensitive.

The callback is registered in all three inode_operations structures
(directory, file, and symlink) to ensure consistent reporting across
all inode types.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/client/cifsfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2025739f070a..9b70ffa3e01d 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -30,6 +30,7 @@
 #include <linux/xattr.h>
 #include <linux/mm.h>
 #include <linux/key-type.h>
+#include <linux/fileattr.h>
 #include <uapi/linux/magic.h>
 #include <net/ipv6.h>
 #include "cifsfs.h"
@@ -1199,6 +1200,22 @@ struct file_system_type smb3_fs_type = {
 MODULE_ALIAS_FS("smb3");
 MODULE_ALIAS("smb3");
 
+static int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+
+	/*
+	 * The nocase mount option installs case-insensitive dentry
+	 * operations on this superblock. SMB preserves case on the
+	 * wire and at rest, so the mount matches FS_XFLAG_CASEFOLD
+	 * semantics: case-folded lookup, verbatim storage.
+	 */
+	if (tcon->nocase)
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	return 0;
+}
+
 const struct inode_operations cifs_dir_inode_ops = {
 	.create = cifs_create,
 	.atomic_open = cifs_atomic_open,
@@ -1217,6 +1234,7 @@ const struct inode_operations cifs_dir_inode_ops = {
 	.listxattr = cifs_listxattr,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const struct inode_operations cifs_file_inode_ops = {
@@ -1227,6 +1245,7 @@ const struct inode_operations cifs_file_inode_ops = {
 	.fiemap = cifs_fiemap,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
@@ -1261,6 +1280,7 @@ const struct inode_operations cifs_symlink_inode_ops = {
 	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 /*

-- 
2.53.0


