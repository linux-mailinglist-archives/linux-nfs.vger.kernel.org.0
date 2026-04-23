Return-Path: <linux-nfs+bounces-21035-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJiqCTUd6mntuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21035-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:23:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7B452D4A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED34D30BD153
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A663D3EFD11;
	Thu, 23 Apr 2026 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXLpsysw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D23E6DC6;
	Thu, 23 Apr 2026 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949967; cv=none; b=Xtt568VLyIO5qeEkGQV8Lt5xiyYOURvirnBWqEfMEbA1nYHSV7UqM0rDjAacw14ucTWma/D+vDbGaUjpZTVSM1v3YAEtzM7NrVN8vM6q3QOZqQpb9dF8rfQgAnZIdhlTZn2o/r9vEX6FMJ0E1rF6ru2AL2ewOMByJVV5cJgHR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949967; c=relaxed/simple;
	bh=7+KkoL3tT74ISbeLjawhJGX0pW4ZmQxGjH85QN72LoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfsOXJfenVPB4yOvJjj/Ak26uL42UYA5R5l9a1+KfeqkiJpGK9ZsntjIo6nQAFoeogdyFNNQsKj2VCqc/Lc0LkFfKJVHnav6yBO7P5sQwLG4DEmTkVZv4Y6XVJ+nWsVBI9287DIeoROfUJ5j2V8IXHoZv987VioLLzFTMU86xGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXLpsysw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7ACC2BCB3;
	Thu, 23 Apr 2026 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949967;
	bh=7+KkoL3tT74ISbeLjawhJGX0pW4ZmQxGjH85QN72LoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mXLpsyswAnbg9YRnbdDz5iilJiJtO5A5NQKk4LLzYeYItugpZscHoMirsrTqdZklw
	 uRtkt78P0tF2usiCD+AzS4DxtaFn09xWma60+OGMZDGC2z4KLuqlsVgVocBnT7pLN3
	 fc64IaGd2c1zVnDMRXRPz8Yy3toUI4J6tXtIgz6oc9OeYAFmoWvWPJRtVRyijJdoZV
	 q0sD8aHG6YvDLotHaXuFyr0SPfx/7edOwTyfUiI21xIqb/RDDQlbcOb7OFnCwpf2qi
	 Er0QIXU00YmycTsOCInxKPdy5CSClVcIkivfVV+dtzWSu+NEuNvT8HtwfZ4/hcePzt
	 fHCr2rk40/L+g==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:13 -0400
Subject: [PATCH v10 10/17] cifs: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-10-c385d674a6cf@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, Steve French <stfrench@microsoft.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=x1bL8ZBB5Twab/6NumFLSBXEoTJcokaVZadIWFYQ2n4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq0DXYznTMLZfGDAShXh1kvv0fNjsbzn9DLA
 4AHx4CpQRGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l54FD/9J8IzDKD52G1HUWHY/FdLPMd/d+7cKv1E+H3pyAxYHbbvkBHQTOo20aZ4/jcIsKgebJk7
 9O4KuEmRZdd1a7qxwEMwfae4Vdu5dwkZMKH340nVkskS4IV+ebV6VfpbRH5M8jmqXwmbE8x5x11
 CeQryqSIHtAB2vKyul0bDADKJVUABgdwcsVL3adw2OsR4isefIEmaok0e9pyKI0aQWmCK23daJp
 1uGzMw11Z/kKLNhyexCnbFwzKnhvBEO4u+DruN3WfawsoZ3sR8D2/eekZIYTfaZMj8kr8BhTQ4z
 TgXOgXQOP8u4vmsPSG7qmVyABySAHuLYy/vMWGMnnBK/Bz6h8sZBZuIirGTrIVmC7Kw/9D0tiI/
 WZ3BmTYhsj2D9HGff+17Rpt4TCWRmiBI+IEccebG8+/fWJRTwjdAxr1dGbDmjZNEFoGakPKfrPy
 KVjK5LhJ/s7r6wnHVgcI7bnJ3vVjNA8YByiewwHEm33OVRyAFYCOym7imTZT4hAOx6S2IEmDl7P
 920UVfYLeUU/KnNTPuXXv5W2237g8G90GpKuslHpUxCP+pMK1jD2qS3vGpGIky/BdpfnFZ697UP
 baZKfK7peDX96Z44E065p6B1U7ijJ7txWBmXNElNsgKhs+7vUaiN1cjvdKIj6SA1ySOYcURyUdQ
 IKLvYStt3oWHO8A==
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
	TAGGED_FROM(0.00)[bounces-21035-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62A7B452D4A
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

Acked-by: Steve French <stfrench@microsoft.com>
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


