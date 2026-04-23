Return-Path: <linux-nfs+bounces-21039-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJGgKhMd6mntuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21039-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:22:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D586452CFF
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 092AD30F235F
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3719F3F1672;
	Thu, 23 Apr 2026 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b16TdICr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD703F0765;
	Thu, 23 Apr 2026 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949977; cv=none; b=BewrqMdI1I7l61xInj1oxNO9CWmTImBCgDXg4HVrIqzpIcGHvVtE2A+iIZwIfEbj5LhVuyWGW3K3LJ3bvZYMS6kzaMP0qItOlX00hpSv5vhlTHxjEnEOEw/OsW9ffDNHd6sbYdizffxAOFQ0vseh4HxwPy8svHlWZ6+jGaAOZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949977; c=relaxed/simple;
	bh=01dn7VPhZ7IaECyyXD1nCwqLHm0UbGEoyqWSLe5m9tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AO4ATylozwoQiWcHcvegWeZTtUy3UEaDC5yXKA4ylKUV+TImU2MmpodHfLS2SY47JQfy4CfheNPogMS1LlIUtZLLt6iusZSn7aaO2F8SV9LgzCxTdv9VV6D/d6oM9IZ/99ZN3GC08/7tJJ1x8qlzDEmJe/eOBl3tDLv+FCHAxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b16TdICr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D18DC2BCB3;
	Thu, 23 Apr 2026 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949976;
	bh=01dn7VPhZ7IaECyyXD1nCwqLHm0UbGEoyqWSLe5m9tM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b16TdICr9mZe60kFhLdeV6cmaDGNpfEikcnOLDeDMJQaI50PMYJ71SyZVynZC8kiL
	 AV1QLGVMlgt6HwMfbeFabkL6Y+SN+LBBGg6qX/tlVtV+u05nW5VAC8ZOQESOXIyszj
	 84pqe2SvG62KTSfPha1KhHSE6T9VQCz+MvgcXa0VMB1b+W0dY0KzW+a/4mi35X3SGw
	 Q7D7BnK3q0aX9whLuq+knJl0jPHkYwvluDxHMYnS2X0FsMxf0Ndl5upRjY+tH4qADo
	 70V+o6eBQ2/Pff74JQ6znYpd23LcrqWPJXaS6s/glYbhQeGb6ETkDiG538HQ/hNS5E
	 7okz82vlQMJtg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:17 -0400
Subject: [PATCH v10 14/17] isofs: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-14-c385d674a6cf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=kh4Mo9qHXj56Vn2bJA48n97L5gwCBfFYkAAOr9+sl3U=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq0A+HVhmB7vI2F2Wlqq9NFQfEtQyqUXWu+o
 +K1syaw55CJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l3wCD/0Q0GwJCTMg1VCavAps86ODA+BZ5Sf+KZI3WsJhfi2Q6VEwF2nE3f68CAKD2qEFpQNJTjZ
 p8CXuvaXF50nUleUavJovdk1Ml64Z285yMMMC/BddkYYlI8svFlX5otSLfer7YdS43KsqZ9LmFx
 rslu71Ht6Ih/pLG1yF+C7nVVfSAwRZOfe/1dWWkzUEkbb0Kl8OppNiil5kKyC8SpQ1JnwDlH3k8
 x21yKTb1OQJ0juDNBSnGi8exnrtW41fFwc6BGFmn4aJ623MUFrdpZvcM5rz3ZoLdLDItLGbkXOq
 /Ik6XeetDOYWsniur/T72bGu1Zl+L5LmSjlXRL2yTQnM0W3pEwYchxCq6rCbccvVfLNht0TASAc
 Rq0Z1/fSFvEJ7gbsEM5Kod3pxFtb1hF3rjOYD4hrZTZf9mPcWMVpNIwbnBci4x0tqJ0m/QuoJlm
 lebV5vx9y1Gv/2Ofz0kuJzn4bC3DFfAVqnLH7+CmYDgeJhFWvBnPjwbALsQl/nbvexmc8zEKoU6
 9+xr5X3TUoXH2P/OiH2Un3rJPPA0r/dUU07y5Xxv20Z3Kq124f+KfCxhF75Mkp0O9q1J1DqRsnd
 X42RnlWOnseNgKD/pWK+0g0gnw1eU02tEGLhyyMVtCqTWaEcAwPIFaJItnNz0Ufem7750QiY3kU
 xKhp7ACxhq+whDg==
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
	TAGGED_FROM(0.00)[bounces-21039-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 4D586452CFF
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


