Return-Path: <linux-nfs+bounces-21286-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COucAUVJ8mnOpQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21286-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:09:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6384498AF8
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3380B301861C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1BA4218A9;
	Wed, 29 Apr 2026 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX2n2cKq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4841C2EA;
	Wed, 29 Apr 2026 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486071; cv=none; b=oO11oQJlhqYoNOvDvdRGgXgpXwkUMBAokKa41fIZk8VfL8KTiYv3ZOkXPYZoFbDLktX3QJXf/uaJp3S+xeKhH5aKaj6qCqQ2WkGOmj21vM8zk9uljqKWYoeoxGLIVheFYsorjtUmLtaq0gCsLSN7whVf6NZfEk2DOX5Hyq1p8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486071; c=relaxed/simple;
	bh=bjnsM/1LrSZrTO9ZBZW3Xrmg7KU8lzL236VyXdB5T94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhpwBU5mjVsYuk7GRGN5UDcGXi1pSp/BhDRoJW9JPa6Up1r2jb1yoDlo7vOMUQPpUkNw+fgyg/olYOMrVwjlvVFTIqgpNKwG5UVGCHYCEWXNDOni+4vLHOgydnsm/OgOXoxBxvaaGpj6jjSF+JxhlGa2JNY6hnKsiSe3bBI5rIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX2n2cKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73670C2BCC9;
	Wed, 29 Apr 2026 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486070;
	bh=bjnsM/1LrSZrTO9ZBZW3Xrmg7KU8lzL236VyXdB5T94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jX2n2cKqNxs9/eBtE0K3ldmdw7VPwqaUDQtK3v70Im3HnV+zpP1tHOmaUV0Bqr0TA
	 5hIIUQ0UksGiM9KfhJeNldcDQtxqAJIe9u8/1gPx+iFCIVKfl8xLm7GmBh8XNvXqxZ
	 zQLTWys7n9GSw4kUsjudYrtgoJb13QRUEo1ICRdSC1ybTlPhATNByb7DVY90KYrVO7
	 BL+oJDipHNQSwTxJIv5Nl4zxTT/XvFp6ofNzP12nRivs60qcaaPlE6QkyXonIITC8w
	 fbnXKYOT0lH2CMu3LuWw+xJ5FP2syor0bsLOjxsxXNAiunarNsfMxtIu61np4Lp+Zm
	 E5/la67NDTavQ==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 14:07:20 -0400
Subject: [PATCH v12 09/15] cifs: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-case-sensitivity-v12-9-8057123bebe0@oracle.com>
References: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
In-Reply-To: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6029;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=lkiMsfMNZqz1N8jxrYrsxKA6VL8UHLCrzuPBYO2nVe0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8kjd4XcTscVuxvYljUn7dPNwuyadxg5cFsmUr
 ruHn5u3U7SJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJI3QAKCRAzarMzb2Z/
 lyEFD/4kq8AI7aycO2xscVJpEKWg1hyy0MaZi5CKj2pgM33Qr1b5Ls4lKBxKPMSzYLugw5IymsU
 HjYEWRvxr/qr5KbeGBlhx4wKwa0/s48PUiUVTBc44l46qDiBVWw25Vm/CPl16GxYQtHJuegopLS
 7XAlKjxNezMpG7hHmz/jB247VQ9QlHXb8/BiWTHlgPG/F13CTTdO+/msnyUQVLE2X3UxbabNo0S
 gj2nOgVIBeufyQ9toJZWadtpnBPz1cB5mvPTyEdAzE7C1mBSMfIG5NU5kpUvDScpXftixA+xlXb
 Z5xpEEyNWasnwIWhrbvK0TkdJ8sl0K0lcMzZKnwqayqYnFEeZd0sn6mqCD/DvE1rA1DqRnJecGY
 O4xjIMrOqHEsIK5/FCJejoRnm+L9prYU1TesFlQiYNfW4HeVkFQ0GXBwzHALNOle2VTsa+GAdYI
 5jj6bWG9oQSl8tUyrKvf/CZ7DYsNJXurbcJHMOXqB49iGWlWNUjv4g9pfl+ou0nbeBK6C/eq43Q
 DVt75zCoAuMUXyi1TSVkboP3nkq0RfA/gSIE/kX4upupWm2Lbi7Fnk6qMhRooPp9+Ibj1b4sIDn
 CSqsaXssx1MtCSg780uNutodqh9qt/HX+n8gsVvowqusiPrFgXqfGQlcb3d+ZNLzBB4wHu8r6V+
 APgzp36F07zDsLQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: D6384498AF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21286-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nrubsig.org:email,oracle.com:mid,oracle.com:email]

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
 fs/smb/client/cifsfs.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/smb/client/cifsfs.h    |  3 +++
 fs/smb/client/namespace.c |  1 +
 3 files changed, 45 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2025739f070a..0912d74e32de 100644
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
@@ -1199,6 +1200,44 @@ struct file_system_type smb3_fs_type = {
 MODULE_ALIAS_FS("smb3");
 MODULE_ALIAS("smb3");
 
+int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+	u32 attrs = le32_to_cpu(tcon->fsAttrInfo.Attributes);
+
+	/* Preserve FS_COMPR_FL previously reported by cifs_ioctl(). */
+	if (CIFS_I(d_inode(dentry))->cifsAttrs & ATTR_COMPRESSED)
+		fa->flags |= FS_COMPR_FL;
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
@@ -1217,6 +1256,7 @@ const struct inode_operations cifs_dir_inode_ops = {
 	.listxattr = cifs_listxattr,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const struct inode_operations cifs_file_inode_ops = {
@@ -1227,6 +1267,7 @@ const struct inode_operations cifs_file_inode_ops = {
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


