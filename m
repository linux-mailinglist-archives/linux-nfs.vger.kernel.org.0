Return-Path: <linux-nfs+bounces-21012-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLjbFFdb6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21012-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:35:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A7F44BC6B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A60D3065FD3
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E870346AE3;
	Wed, 22 Apr 2026 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRNQhzJY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0953932C924;
	Wed, 22 Apr 2026 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900651; cv=none; b=Ajp6MyEWobgQGWW5DKv8tRf82SkDVBuLebv55wJeRrsK24kxoXl59c13i1ZU409NsAyr0X90/8d20Ev299uoqN1a7/mB7pL0SglNoSBhHFZaOD5qw5yKLPytBKpVmZc3xJQAxI13ByRT5nAH5Otz1F20qDTBLegaIUYzN22RiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900651; c=relaxed/simple;
	bh=01dn7VPhZ7IaECyyXD1nCwqLHm0UbGEoyqWSLe5m9tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9/jaf+QrYsLvWsHyZdqp/dfOyAsNXAERDJ/rnv1Aq4hDsk+kyyD6NhYyiQDAAL8dkKrklg4hQz/LN1bE2WGYaS9gD1DMWiTajyI6r2WWZvFpVtwDpRTKOpQIjxTaBBJ4cQISIRIzS9/JWAq+fbnajbmWAGXiv/yM0XWKoMVJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRNQhzJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3F4C19425;
	Wed, 22 Apr 2026 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900650;
	bh=01dn7VPhZ7IaECyyXD1nCwqLHm0UbGEoyqWSLe5m9tM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iRNQhzJYPp4pw6bkhzG2kUISBPMGKc4r5mJxYotWGT5thxubI08DIk5qa70n7X0nY
	 CYDqijAUz5SXcuIjTHS/w/olMp10tbWDVokPkI/h5WY6sSOdeTfVFcboNB+vfKVAym
	 YxGHw6Alx3nlv0kxzSbcU4rCHOQ3nADshR94hgCa5jfYK8hRc0q8Ja9poCWP5pdMpS
	 C4dSDm2n7dxqztAzBn7yRDS2HXwHfxLHIxZisqeRvVD8vgrtZ17cSubMtJoPWWP6E+
	 fo3YKqNJbjvjW5UPFIpZEsevm9BIHx2PHGVF8MRP8XmtQ5EL8VQTP8ciJ7RKvX6+rT
	 PXQWv8V7CXURg==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:30:08 -0400
Subject: [PATCH v9 14/17] isofs: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-14-be023cc070e2@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=kh4Mo9qHXj56Vn2bJA48n97L5gwCBfFYkAAOr9+sl3U=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoGZQsJtBMnjFwQhTw/zhXJZoWoDCubwoAGM
 lTtdNYJPkOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBgAKCRAzarMzb2Z/
 lxzWD/0bbswcNfCXfd/LYYdUB74Xza+PwZJwxaDAGntT1IS5sExaDkbfrHAXTmF1nkPwamWJkbO
 yl9Q0T592fxKKKziwcQvsXlvCcuqmSXq6XVE3rhiZdqde9rLCu48w0654vAQk0wyMtYlGE0Z/jU
 XWpIKL409vVghaZOhdSGZbYaFiEFhX7rKxVSOJ/6I4U3WP0akIFTxpDGURYrsU4HgDInaRjKRgq
 csMnwabRNaJhLZ8z5t62oFNX2DeInB4XJ0MvpZpJI0dvjGujXHnMremOVktTDPE798M00/+Mxmf
 cSfTNnT1Jhm0clTMM6Kcyax+oQOhHkWO2Ck1RbUpNzha03TLchUEIl9RpBgyktRfNsV1fwmWr8V
 apCOmV+A7w7GwTL0i5FEglWpJpuMDfrIHImr5j/Z+9tG1FRGMh8vbQjJNymcdE9OWdBGTJ6hbzS
 4mysifqeP/8YprQhTzY4MFfF2Jh3seJHly1XIgVRUXjfn4Je0NB5NP6nBYql+cvQhy73sW4iTF4
 W7N8EM+w3ptzQJ8AnExQubTxWEw+DKgS5fT0tAs83RxqViFUo+Dj8v6e5ZL0eJVQvXIv6uEaUBr
 MtiNr1hGDgdGOQcuAZBEtAOPrHvLRuVq4tRQwB6lqNRiyPrRdpFAjX6U9v3PgpRubE4yiRfqDNd
 vcMxASGa88CRasA==
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
	TAGGED_FROM(0.00)[bounces-21012-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: B0A7F44BC6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need a way to query whether a
filesystem handles filenames in a case-sensitive manner so
they can provide correct semantics to remote clients. Without
this information, NFS exports of ISO 9660 filesystems cannot
advertise their filename case behavior.

Implement isofs_fileattr_get() to report ISO 9660 case handling
behavior via the FS_XFLAG_CASEFOLD flag. The 'check=r' (relaxed)
mount option enables case-insensitive lookups, and this setting
determines the value reported. By default, Joliet extensions
operate in relaxed mode while plain ISO 9660 uses strict
(case-sensitive) mode. All ISO 9660 variants are case-preserving,
meaning filenames are stored exactly as they appear on the disc.

The callback is registered only on isofs_dir_inode_operations
because isofs has no custom inode_operations for regular
files, and symlinks use the generic page_symlink_inode_operations.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/isofs/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 2fd9948d606e..bca3de5a235d 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/filelock.h>
 #include "isofs.h"
+#include <linux/fileattr.h>
 
 int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
 {
@@ -267,6 +268,15 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 	return result;
 }
 
+static int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct isofs_sb_info *sbi = ISOFS_SB(dentry->d_sb);
+
+	if (sbi->s_check == 'r')
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	return 0;
+}
+
 const struct file_operations isofs_dir_operations =
 {
 	.llseek = generic_file_llseek,
@@ -281,6 +291,7 @@ const struct file_operations isofs_dir_operations =
 const struct inode_operations isofs_dir_inode_operations =
 {
 	.lookup = isofs_lookup,
+	.fileattr_get = isofs_fileattr_get,
 };
 
 

-- 
2.53.0


