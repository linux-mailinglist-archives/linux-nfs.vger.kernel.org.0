Return-Path: <linux-nfs+bounces-21355-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAx8EPUI9mk3RwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21355-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:23:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E24B271B
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F4343031EA4
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A9833D6E1;
	Sat,  2 May 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMIdvf3E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5123375C5;
	Sat,  2 May 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731726; cv=none; b=Vi+Hp4O89mb3ebSQOA4INjJw5SWGUAdgXlCKlDMjUjx1ml8gMubYi48IdlyfHNpP38CEYDxiUiVqsh4wWU0VbA3b4hkhxPNqHcqkq4qD9PUgifSUBC4jY3b7IMKqteSnJzvLFXgwHbyKbZtZ3OkZCWTNd4He+YuofQzcSWM4lQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731726; c=relaxed/simple;
	bh=Q5XtOKwPgaYRn0bnMc3D1rhUvCUILOZDILxVZdxu/kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mlh6ojpN5gpnwyspuWWRAK+peae4dzs4C4rczyFkIg1IBxGMNdrU2oVzUaHHOW1cnZBBfr8VMdVwhuKP9qVC9o/TJaoAad/QWvxI+AdNltXT7f86rSX7GIgpNtSenADqXLEU+bKlxwKS+3/los+sW8koRiqPER5pa0ZO9qgejq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMIdvf3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5A1C2BCB3;
	Sat,  2 May 2026 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731725;
	bh=Q5XtOKwPgaYRn0bnMc3D1rhUvCUILOZDILxVZdxu/kg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WMIdvf3ETPgBUmAqPPqnn9EhoNvRNT/aKk6oRQIrAmbMqvVEhC3sCAH3fkcgsyjJ3
	 bd1gln+mPVei5bGnFkCcWMRye2ngwS6eUDNxgFueMe+VzoTMB17qtrMn24iudRs2Vm
	 BuNEoBBMaM775r3BXiB6APABmW/JL6HxOcDJyj7brsEy2d2SK0QdbTmGWoFVhoKN5A
	 07fxw+dlImH9OLyGJlMFl/Cz2E2kZq8MFA/9jxPU9OqjIgoGjzfn5alCyUXQ281/8K
	 QcTVHc7wkwZ8YPhBG8UMwRphiFKJDsiJG7MIzbzpAqBR8sqIc+JxmMioMzrQXhdFPR
	 5Cf6sWrpU65YQ==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 02 May 2026 10:20:54 -0400
Subject: [PATCH v13 09/15] cifs: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-case-sensitivity-v13-9-aa853140311f@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, Steve French <stfrench@microsoft.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6455;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=AfMflhnl0Iaj4k4wi0ePcL6AtlSGx4FShDTRVk3BfzM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghRCvryjTpV2KXsZz24p+CSVXRY4qHwcyftV
 SYiVGDG4juJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUQAKCRAzarMzb2Z/
 l/dDEACfOosmsJYY+zaT+6F+1U8+q8xsnWfeKn7yv849l64DOunQO1a+JMtjPUgraXyD6VG8H5Y
 LQW4ioExpieZan9/7cR6p/ygug7h1y8zfPxPkfttR0Tq4riSYl2GALW/BP27PxtkEcM/rvBVM0t
 jprZK4TJy+ixV8P/mhgCKcMj05u/VKMJcakiEa7x/K4+1wbR7Qg2Lth9jQrs7fgeGPdb5+IQWHZ
 +JONbQQChFA/9ajWpw6cJCQr5on/nc1qf5bXp79ol88bpj/A/uXIf6bXPAuaxJWEcbABoy3o3r+
 Wh0bQtazV8YmWgOT5LSxKsTNpgnMCq/z+FFmX/fSzuD46byesJQoHmrElynBCYRSbTyRwcyj6tC
 5nB6MefDJf7SZyo7+sNN3rgyszqRUpTbN9nPXFIBP3Ou7W0AnKN7er3VyPjIKj0vpMNorE7wG7W
 hr7LHNKaFJaESRsbIGjwrTLfAz5x1iw+4Vpv4RR3GqtAvuTYUPpiS/jnDGs6Qh/qdSxWirLHY/o
 j7inSIdWOcEfGB4tJzwCO2x+0kZx7n6bDvjnPYm7hJPabb1cutmFucXtFLW3x0TQ60BS6YPYReQ
 jHEqrF1Ixd+8yGY6X2DmdV7WfAsbTs/ytrRH8j12mVbflVOnfPpzKeHn45kI3hBGK6Z+omRoTia
 zDwuBxs11RS1ESw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: C69E24B271B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21355-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nrubsig.org:email,oracle.com:mid,oracle.com:email]

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


