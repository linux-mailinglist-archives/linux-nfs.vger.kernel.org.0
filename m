Return-Path: <linux-nfs+bounces-21426-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNOgChVV/GlOOAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21426-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:02:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBC74E56F1
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7383B313DF25
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 08:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38B73AE706;
	Thu,  7 May 2026 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUDtlQTX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B5388E49;
	Thu,  7 May 2026 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144072; cv=none; b=tkrwlb+BlPfohYSJUAVicHIlWpXLEzKtybY17ZOITp9dSpVvCmZ4Hclzkx1dTxn2kq6+2mEOlFqNNuMzCVCJhlBN/WObZ5znovEJQuG58JKiirc96L8Wx+RJPSaHhsiHEVKw2w1Z5/9dVQ5todxKsrItOP9+kdycVUfDDeQlY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144072; c=relaxed/simple;
	bh=Q5XtOKwPgaYRn0bnMc3D1rhUvCUILOZDILxVZdxu/kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLt0L1PeZDt67b0PBOJn2QQm08sTaPqM40WU4tDoWpkwsqlJHK6iMTVkPd3/Lz/WVUCMX9Z0XbAR8tqLrdeHLRAlhROp9ubOGXyiArJUWcD5W2QqS+39uhej5nczooNGB9F9UbmEBni7RYyk34PJX16zrXRKGeSrY75jfMVcE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUDtlQTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05E4C2BCB2;
	Thu,  7 May 2026 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144069;
	bh=Q5XtOKwPgaYRn0bnMc3D1rhUvCUILOZDILxVZdxu/kg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lUDtlQTXmlzxOQ/X0FohKbKIh1xULRrnTE/cngGXTlrkSIBP8aZ8meLOpNeAgzA3W
	 H3/fHoPbllum6rqob/+R+ki/Dw7qUuXFvtJEWsIa2bddHy8IjQZ9PZwzfCQ5nFV6vt
	 EUpczYOInPaO03V0ZJGObZurU5XA3+enNACY2skjX2ktBvbfOsW4LGSUGMRsUZM+9K
	 PZrlsIvcUBA+KJOT/nYYIMibb8oNJs1oNX7qsyA8DI4T9yi1LVT4izOi4skOCEOg7L
	 DOckiUsMHjd7JTAf/u3yYScqKQfQ0EhVrZJuhOCPHzO2KLlPsJsWO/AjAiaxB6rWj5
	 sWZ3FSzw2VZfg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 07 May 2026 04:53:02 -0400
Subject: [PATCH v14 09/15] cifs: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-case-sensitivity-v14-9-e62cc8200435@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, Steve French <stfrench@microsoft.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6455;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=AfMflhnl0Iaj4k4wi0ePcL6AtlSGx4FShDTRVk3BfzM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL2d8kJb1tOYvHXz+fH7V18IdYgTFiCNbaC8
 2KZ27PclnOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9gAKCRAzarMzb2Z/
 l6FkEACnPvUtZsjNyLaXe2wADKnIca3RrsMW5dR1xeapQh/SEO4frwIkxhl5nkun0GlnbmvpOVY
 W8vFlUw2DI+ElmjAGkzj9u3hOgD0V1t9bs1O8Qsfy2QJWK9910cmrL6MNuaWCw2L+W2kE3i7+CU
 K43Csiu5JEpbGuBXOXD9GMa6WIY2UmTp+5Llox6T1FnV8hIRs/8mSz5Dgv4TS5Eq6lZLPtgm1W6
 xcS+boGn9wtMqQDptBj56jasIdAbq3eYw9oeR2nmJ8zUxL5mX8KM2cRVLGT087xeAkOriYbDdTB
 R2cys4CYC2ieTbHAkNgqTnml4S4XKa4WYwxWbue55VoRf0pekIhCgyH8CBdaS1r8k2egI2g+yoH
 c9Mtu3BjUH2uH6ocotJ9VdeQQwilmwSFUdtosX8LZnRm8Oxv/jbzVGqtboRsHSqay+YvdITL+JT
 E0tIsV4dZJC8ujJ8pJ8dYLhoxIVREyfPf/ncF+mK1hNLRqjXfxfieK8yrdSnuHvXCulI+LIjhYc
 01L6WSyD9LwNU+YklJRlaq/XrHBk78Bbyr3l016mjEwYU6w8M+aqcpgtiCpVC6LZ1MUDmAmPs9y
 ewLStSyqsG3EIrxTMzK/r7z0mH8naL7pQ09RAz5eq53ke4X8j+GcMoO4erLSAszBy/Y3M9v+wzS
 4V6sCBtLvidKClA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: BEBC74E56F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21426-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[34];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,nrubsig.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need a way to query whether a filesystem
handles filenames in a case-sensitive manner. Report CIFS/SMB case
handling behavior via FS_XFLAG_CASEFOLD and
FS_XFLAG_CASENONPRESERVING.

The authoritative source is the server itself: at mount time CIFS
issues QueryFSInfo(FS_ATTRIBUTE_INFORMATION) and caches the reply
on the tcon. That reply carries FILE_CASE_SENSITIVE_SEARCH and
FILE_CASE_PRESERVED_NAMES, which reflect whatever case handling
the share actually implements after SMB3.1.1 POSIX extensions
negotiation. Translating those two bits into the VFS flags lets
cifs_fileattr_get report what the server advertises rather than
what the client was asked to pretend.

QueryFSInfo is best-effort; the mount completes even if the server
does not answer. MaxPathNameComponentLength is zero in that case
and is used as the "no reply received" sentinel. When no reply is
available, fall back to the nocase mount option so that the reported
behavior agrees with the dentry comparison operations installed on
the superblock.

The callback is registered on cifs_dir_inode_ops so that NFSD,
ksmbd, and other consumers querying case handling against a
directory get a definitive answer, and on cifs_file_inode_ops to
preserve FS_COMPR_FL reporting on regular files. cifs_set_ops()
also installs cifs_namespace_inode_operations on DFS referral
directories that carry IS_AUTOMOUNT; register the same callback
there so the answer does not depend on whether the directory is
a referral point.

Registering fileattr_get routes FS_IOC_GETFLAGS through
vfs_fileattr_get() and short-circuits the syscall's fallback to
cifs_ioctl(). That fallback invoked CIFSGetExtAttr() under
CONFIG_CIFS_POSIX and CONFIG_CIFS_ALLOW_INSECURE_LEGACY on servers
advertising CIFS_UNIX_EXTATTR_CAP, surfacing the SMB1 Unix-extension
immutable, append, and nodump bits. cifs_fileattr_get carries over
only FS_COMPR_FL from cached cifsAttrs; the SMB1 extattr fetch is
not reproduced. SMB1 is deprecated, and acquiring a netfid from
within a dentry-only callback is not worth preserving a path tied
to an insecure legacy dialect.

Acked-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/client/cifsfs.c    | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/smb/client/cifsfs.h    |  3 +++
 fs/smb/client/namespace.c |  1 +
 3 files changed, 57 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2025739f070a..6c113ae7fdd3 100644
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
@@ -1199,6 +1200,56 @@ struct file_system_type smb3_fs_type = {
 MODULE_ALIAS_FS("smb3");
 MODULE_ALIAS("smb3");
 
+int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+	struct inode *inode = d_inode(dentry);
+	u32 attrs;
+
+	/* Preserve FS_COMPR_FL previously reported by cifs_ioctl(). */
+	if (CIFS_I(inode)->cifsAttrs & ATTR_COMPRESSED)
+		fa->flags |= FS_COMPR_FL;
+
+	/*
+	 * FS_CASEFOLD_FL is defined by UAPI as a folder attribute,
+	 * and userspace tools (e.g., lsattr) display it only on
+	 * directories. Confine the case-handling bits to directories
+	 * to match that convention; for non-directories the share's
+	 * case semantics are still discoverable through the parent.
+	 */
+	if (!S_ISDIR(inode->i_mode))
+		return 0;
+
+	/*
+	 * The server's FS_ATTRIBUTE_INFORMATION response, cached on
+	 * the tcon at mount, reflects the share's case-handling
+	 * semantics after any POSIX extensions negotiation. Prefer
+	 * it over the client-local nocase mount option, which only
+	 * governs dentry comparison on this superblock.
+	 *
+	 * QueryFSInfo is best-effort at mount; when it did not
+	 * populate fsAttrInfo, MaxPathNameComponentLength remains
+	 * zero. In that case fall back to nocase so the reporting
+	 * matches the comparison behavior installed on the sb.
+	 */
+	if (le32_to_cpu(tcon->fsAttrInfo.MaxPathNameComponentLength) == 0) {
+		if (tcon->nocase) {
+			fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+			fa->flags |= FS_CASEFOLD_FL;
+		}
+		return 0;
+	}
+	attrs = le32_to_cpu(tcon->fsAttrInfo.Attributes);
+	if (!(attrs & FILE_CASE_SENSITIVE_SEARCH)) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
+	if (!(attrs & FILE_CASE_PRESERVED_NAMES))
+		fa->fsx_xflags |= FS_XFLAG_CASENONPRESERVING;
+	return 0;
+}
+
 const struct inode_operations cifs_dir_inode_ops = {
 	.create = cifs_create,
 	.atomic_open = cifs_atomic_open,
@@ -1217,6 +1268,7 @@ const struct inode_operations cifs_dir_inode_ops = {
 	.listxattr = cifs_listxattr,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const struct inode_operations cifs_file_inode_ops = {
@@ -1227,6 +1279,7 @@ const struct inode_operations cifs_file_inode_ops = {
 	.fiemap = cifs_fiemap,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 7370b38da938..5f0d459d1a89 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -89,6 +89,9 @@ extern const struct inode_operations cifs_file_inode_ops;
 extern const struct inode_operations cifs_symlink_inode_ops;
 extern const struct inode_operations cifs_namespace_inode_operations;
 
+struct file_kattr;
+int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+
 
 /* Functions related to files and directories */
 extern const struct netfs_request_ops cifs_req_ops;
diff --git a/fs/smb/client/namespace.c b/fs/smb/client/namespace.c
index 52a520349cb7..52a51b032fae 100644
--- a/fs/smb/client/namespace.c
+++ b/fs/smb/client/namespace.c
@@ -294,4 +294,5 @@ struct vfsmount *cifs_d_automount(struct path *path)
 }
 
 const struct inode_operations cifs_namespace_inode_operations = {
+	.fileattr_get	= cifs_fileattr_get,
 };

-- 
2.53.0


