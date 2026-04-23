Return-Path: <linux-nfs+bounces-21042-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AIlNaUc6mmUuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21042-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:20:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E76DF452C17
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54E73303D223
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBB3F23BD;
	Thu, 23 Apr 2026 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4OLhQiL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247FD3F23B2;
	Thu, 23 Apr 2026 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949985; cv=none; b=C+AqvCgPwi4EZl6fQuoOgjd7ZdiKjQgAu33AtrFJMxPaZoD57XrtISu1L0R5YwZs511X4oi/V2cLsJMPI1eVM4dMvYSYpy0GPZo39CekHcZgU+HMffMRg9WLCyGLHn7V5OXEM87KTafQ0GRfk6VoAH8NGTiV7H4DhCkw98W9vhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949985; c=relaxed/simple;
	bh=UNo7HHcDIV7JWpD0f7CVGZkCuGE2I4nW5HuPOm8dnXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFoGM9q1ptcXGfOh4X/vMEoz05ayRRr/DyvTud6r2CAsxn7rxwTWaQFqhelx4hCjtXx3SBtIEbIVgGfs7CS6bNyVBr0y0QtAA8y1APHLmYfWD9TXLpuBnQEcZ6DE6gVOztHksYCHndBOndjvf8Ki/CdHC7e4EkGzKbasPZ6/UO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4OLhQiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F73C4AF0B;
	Thu, 23 Apr 2026 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949984;
	bh=UNo7HHcDIV7JWpD0f7CVGZkCuGE2I4nW5HuPOm8dnXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K4OLhQiL5q2gmBR6fMg7OQc8/AgWzGgE7c8lWakCv7FgQPstzhyPNpp5NVg8rSH5t
	 mboZro4Y4RDogKy4pwOYTTBKrM1nSl9+T/ayjwK5XjqPBicW7it5FJsOONHrR9vTxJ
	 Em4nM8x6k2v7UjnhrFFcU6nGFe5bpzMFO9Yv2iH5Dpjv9OQ0eAYvP12zCL5VShV54s
	 MD1CiSWkCn5D5uE2yRw158f+KjfNGR6ZDQrcaMl9StikZc7kMsAlmk6gXyZp6scNMI
	 iFwiMOsMVpSckv3ECa8Psgpi8yqngU7TcH0G6Y1+SeQ/6d/A1XCfyYIuIAkh/plDrG
	 RKm2aYHMHvm+A==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:20 -0400
Subject: [PATCH v10 17/17] ksmbd: Report filesystem case sensitivity via
 FS_ATTRIBUTE_INFORMATION
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-17-c385d674a6cf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2582;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=/M15phZsxO4dYF/kfeaMD4laDtLmxamo65xsRXL/kkg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq0lrMRP/taRhAjVj2Nj34LkMZtiUQ1WGFUj
 5GhhBTIsAWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l7+iD/9RTr4hntMPxhl7UX1Xa9+pHwyzL17Hm9T+TA6M+p7usu+ddsGl6douosfJVOewO3FyoUV
 kUkhZBoIos+DHr5mWvcU/p0Bmt6IvhCdDIg7EkUJHbOUd+a821W9CDt9NGNwLdWnHU7rJATocLP
 1IGEUvEUEm12ihgZPtNYLLOGf99q7H8f3fkR0RtAxSKaP3KkPkYO5IDkZJlqKdShfxbwU/l0IRD
 3yb59efObNpfct0TPF9BY3UR/YAGA97NsvtptvyitXjtb65xeeFKZVJN7GyAGSkvQ8YFAxiYYLt
 SshlPCE3GLBxxGmAQBgkH56S67IiXI1kxMrddESmsTOExvc0rzaVvm97m9wYoLvy+dmt+12UBJ4
 WUGXgh41TFpWIt1+RYtZ/WBboC0B5IhkSou7z6IlksVYl5G8q/9fUAoQBM79v0B0bNbzWXWfq0a
 WjPFYvD3qovj8sX7CcfPXlXnNU0L40gt+MNRbNGtZjppbWixbTv77TAGbn51rxVQnTfulBLoDpF
 4+VqzzCzM1XTKJCPYOETZ/yhXvjZZtNa5BQVaerGOMBIaCOC7yop2xyTiBOoMevYEA+qaoZzGqz
 9+XTxfknXthMElnBLQC5JLn6zz/IHiwZx5awniQHRHH18z8MiIXnIbCjfrj92Owq7tSiKzrCsNU
 V1E030k7effzOsA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21042-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[32];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E76DF452C17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

FS_ATTRIBUTE_INFORMATION responses have always reported
FILE_CASE_SENSITIVE_SEARCH and FILE_CASE_PRESERVED_NAMES
unconditionally. Case-insensitive filesystems like exFAT, and
casefolded directories on ext4 or f2fs, have no way to signal
their actual semantics to SMB clients.

Now that filesystems expose case behavior through ->fileattr_get,
query it via vfs_fileattr_get() and translate the FS_XFLAG_CASEFOLD
and FS_XFLAG_CASENONPRESERVING flags into the corresponding SMB
attributes. Filesystems without ->fileattr_get continue reporting
default POSIX behavior (case-sensitive, case-preserving).

SMB's FS_ATTRIBUTE_INFORMATION reports per-share attributes from
the share root, not per-file. Shares mixing casefold and
non-casefold directories report the root directory's behavior.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/server/smb2pdu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ee32e61b6d3c..05245562bcb8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -14,6 +14,7 @@
 #include <linux/falloc.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fileattr.h>
 
 #include "glob.h"
 #include "smbfsctl.h"
@@ -5541,16 +5542,28 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	case FS_ATTRIBUTE_INFORMATION:
 	{
 		FILE_SYSTEM_ATTRIBUTE_INFO *info;
+		struct file_kattr fa = {};
 		size_t sz;
+		u32 attrs;
+		int err;
 
 		info = (FILE_SYSTEM_ATTRIBUTE_INFO *)rsp->Buffer;
-		info->Attributes = cpu_to_le32(FILE_SUPPORTS_OBJECT_IDS |
-					       FILE_PERSISTENT_ACLS |
-					       FILE_UNICODE_ON_DISK |
-					       FILE_CASE_PRESERVED_NAMES |
-					       FILE_CASE_SENSITIVE_SEARCH |
-					       FILE_SUPPORTS_BLOCK_REFCOUNTING);
+		attrs = FILE_SUPPORTS_OBJECT_IDS |
+			FILE_PERSISTENT_ACLS |
+			FILE_UNICODE_ON_DISK |
+			FILE_SUPPORTS_BLOCK_REFCOUNTING;
 
+		err = vfs_fileattr_get(path.dentry, &fa);
+		if (err && err != -ENOIOCTLCMD && err != -ENOTTY) {
+			path_put(&path);
+			return err;
+		}
+		if (!(fa.fsx_xflags & FS_XFLAG_CASEFOLD))
+			attrs |= FILE_CASE_SENSITIVE_SEARCH;
+		if (!(fa.fsx_xflags & FS_XFLAG_CASENONPRESERVING))
+			attrs |= FILE_CASE_PRESERVED_NAMES;
+
+		info->Attributes = cpu_to_le32(attrs);
 		info->Attributes |= cpu_to_le32(server_conf.share_fake_fscaps);
 
 		if (test_share_config_flag(work->tcon->share_conf,

-- 
2.53.0


