Return-Path: <linux-nfs+bounces-21093-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEYDFOce7GmpUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21093-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:54:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3109346496E
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD5BF3019062
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE5234994;
	Sat, 25 Apr 2026 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3MMBa7h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCBD23370F;
	Sat, 25 Apr 2026 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082026; cv=none; b=iM082svpC+cBNq53cm+2XqHV0FCXC8wLbzH4WI/EXkb43rD2n/o3KUcUE+MxPO6yBbud2adcfCOcFzPDPaH08T9yO37QyG0qjYpja0CqFOejaZFKrovbjYN/qphxbXIxPi6YJJY6/DEh4xOVrQi0jTvAJrv3+Vik/NcuoBfB/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082026; c=relaxed/simple;
	bh=iqVtUvA2aKvU7uqHLJI96q1iBGdaqv4WpR0C8NAdAPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YGV1OIZREWvJS4DaGd2k4anl/8sh0c7cwobBvNCqwu0DvvyXRymWi+7IBmv9BQx6opa+/Kq7/d3R+0ZksTI/MvlFPSC2H7Yhs+go3uAdGsTHacnbV8XnnLki4KP1SlsMzy9/PSVq4PNUGp+i4mA5cvLlaAaDIRpPhUVxUi6EP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3MMBa7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236A6C2BCB2;
	Sat, 25 Apr 2026 01:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082026;
	bh=iqVtUvA2aKvU7uqHLJI96q1iBGdaqv4WpR0C8NAdAPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K3MMBa7hmnticXooMQM21l1uNgwFutLxc2Gmx64Ztrd0t7AG/xfAVMFOIe8gPnwVy
	 xxE1uv1wKye7AMSlbgkzOEsdB1D9prnltSBvN9dtuRePIObwvuQLepWL8OE+HpPpY7
	 Ldl0BztwODviz4UVRKR/u379rCfy5R1IR1St7/B8SK4ve+OqUrDVif1g+gWe607tqE
	 r0qgXJyE6Yk/vaQYNgRQFV5EF3/uDhq92Pfg9vxDkylK3hAdcaBdEeRSmtw+0opA5f
	 x+3WM58uoL26xLv15ab+2CYJIe+BBmlXurIiRU88sZ/icDo5XZepYSm5kNAdlFDCG1
	 sc2LT4S/abZ+Q==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 24 Apr 2026 21:53:11 -0400
Subject: [PATCH v11 09/15] cifs: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-case-sensitivity-v11-9-de5619beddaf@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, Steve French <stfrench@microsoft.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4927;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=whZ8I7ut1VTIHU0vKs6CtPNqzIY9szgQN51EcCcpO08=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6QSmpPLePycgQR+X9KRG/phCkNRX1KfUFc1
 t2neUXuimiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekAAKCRAzarMzb2Z/
 l+CDD/0a6m3um2MGo56wuLNvdlF3IKwxmf0b1QEHljHVtUdH3arHVqy+JkeGc3Nxf2PBQMG8QIw
 5uXHMcRUvy9gSRP4+2zu1xi1NglLNwtWcb23R2t1g9lswqc7SyqtUxeqnu31zZIVHSehQfadUiv
 Fe9Uvn+D7ZWcdcExqGvz50opYvX5ZVR17IB/tJ4Ydrxkhl+Yuna8x21PDvZAFL2mhwCyshAjp2G
 d0ARfQxgAoGqPC9pcmEVp1wAMMYj1tqIuAESPm+Ce4OP33bXkdSApOAv5PGTKBs3+YMKbAoNf22
 QyllvOgoNwkv/etZArfw6YIUdg8rwuue6WwqYgSwdRAde0saMEZ5dfmhv8O25yXytNsVH1XKjl1
 Rk6WLsSsihQCQQvpZy9r/W26+sjV7lfXVZuF99u3mKv+Y3nrFsjDGuMux9m+sHg/lxu9oOwMJ3q
 fYobeFNxxEvWNppCrm85eOoPMgCVIQ3SAc9M5l4SFDhc+kn42V3ublxxQJqJ+1Y5PnXepT+FOtr
 h3e5FIkISL/uYL3OU0YxtI2iG9BQrEWIgmSfMzAuB4nnTioRpfGH0deQQ5Wo9FGSRd1VQK8DcSm
 MPaeRjLYha8eqSmNt9IVm9+2/+Vn1bF5DdDv3+k+OMBtpuWqRh7c3DokNj9zkxeV9A4UuCrWCYP
 1Xvn5BVT6g8cEgg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 3109346496E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21093-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,nrubsig.org:email]

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

The callback is registered in all three inode_operations structures
(directory, file, and symlink) to ensure consistent reporting across
all inode types.

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
 fs/smb/client/cifsfs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2025739f070a..d71755b59b5b 100644
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
 
+static int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
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
@@ -1261,6 +1302,7 @@ const struct inode_operations cifs_symlink_inode_ops = {
 	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 /*

-- 
2.53.0


