Return-Path: <linux-nfs+bounces-21361-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHMqHO8I9mk3RwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21361-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:23:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B944B2705
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8A85300D163
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB4E33DEDF;
	Sat,  2 May 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQkPGs/V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935933D4FD;
	Sat,  2 May 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731762; cv=none; b=TOHtApi3RdBSy9028I2ebeoMjw5k0bewNW7gLHqv8DolPeP0WHH/d9oeT2ZTNtVOhHYAIfwBjd99Gp+/cbQzKwF5H+VSUmys0FVspQ4NHWJTkETt7l1Zm43v7YmiGpizGuN5cQdle0pLHjxe7b93mmOnhMOXttzGYVKvPFb2Y7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731762; c=relaxed/simple;
	bh=qee/kCsMg8C4eRFPxmiZaknm+clMPDWXLjgwoKgpYx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NF5H1zE0PM0S4gXxYA+loTOfA48k6RPeafuDOTudMFDobmyqqnoXZOs4kc4V/jm7vsqtuaX5nSq4C2BmFg/UBAi7kaoOerGg4GZiHS7lzzn9zixzl+7OjMc1wpnfKfoMZErkED8m7g8OajvzEsk4ScPhERR8wDKcSUXO908/Asc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQkPGs/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DDFC19425;
	Sat,  2 May 2026 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731762;
	bh=qee/kCsMg8C4eRFPxmiZaknm+clMPDWXLjgwoKgpYx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bQkPGs/VClTXVe7RJWNstN5TRHFnJPur402C7r15f8ZfoCNm+mc62dH87hRvCnli9
	 AIAkrLYBzmzx1ZL/dwfSGYCoIhV6YopiR3pphFxnwS5hPYzVlSa9UfmXValKG6W44R
	 DNcfOtD8C2VzZ7qxgI9AqXItn6XpNLzSfGrcxfbr+cU+rPB/BQ0vLES3y3wjmW3ZWv
	 M+z8CZmNPolQ34BzYg1vsXL6mk94AOF1GlygCWn7EEHcaN08VMHpVNdN/m5FwGl/Oj
	 6CBh+asEl+qCGvNJh2q7I1rPLRno2O+374hMYm+B3s+xydTaMBOM4LouQSR8cJJhCg
	 boI+EqT0UQh7g==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 02 May 2026 10:21:00 -0400
Subject: [PATCH v13 15/15] ksmbd: Report filesystem case sensitivity via
 FS_ATTRIBUTE_INFORMATION
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-case-sensitivity-v13-15-aa853140311f@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2812;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=3j19l6mVyr/XReBrhpdSBMPAL80WouHe9sT+TihiyQM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghR5o+RiEOKLVYs8fKHluTob3cyoRHlSuLpO
 IhopKWa5I2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUQAKCRAzarMzb2Z/
 l0/sD/9NAN/eiWStj0uMUbgslClWKS0KXDa0CJiGF0vGNQ20tWI3HeSmZA6JphPx39504bWoStu
 U9abYmvZJr2BB5PC4nQBaHFd09QP2X5/zKhHQqVZHoiVU3ItQaxgCb2NBKFtfZ4eSbqMhy87g0C
 TceN7w3DgaKI5qtIbS2DrEck538I04k6SclOw4jDJAKkQ0s9v2VQK46AiT8zfLpZtKxyD3TBLj1
 bR6RuhpvU1Wba5LSR3E5nRAtIkj6Yd29JVJRbFsvVOj5b1s66Gt1iWZ/IpOXqd3akt5SsfF2uXQ
 TDBUbFUGkRZJKUlIAOdLm4K3psQ9mwISzEurgdO8wmzaAxLM6FvKbNDv99JoOOX73sJpsYEzRMd
 G/BRCdUN5Rb3J51anmd1cEoxYQy4mVTySi/L2HdVIOeoOrfgAlpYMm+RB2gAc8Y5uIMqYgjZnBb
 4ydECc0FI1ya4xsU8jkEUmU9ZczhuATaFNT3YYkiN6deNgqMIq7Mtqxe4thwfTdsX9BJ1lPtX6I
 6WmShv8pUqdjPIAcS++OpNuLb65oDOIcELEqXpjGkbj30nBBjmN8meuU0MQMwKtQzj20V82Xkv9
 URfRjBYVKorxQuwwUEHwPjt0xH2wdwnW5eBfDnf7zECnmHgLNF6Cb/txRqw79dQ7h9e/ZiFHrYt
 BIs73uA2+CXMpqA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: E4B944B2705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21361-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nrubsig.org:email,oracle.com:mid,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/server/smb2pdu.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ee32e61b6d3c..cf0bc453a036 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -14,6 +14,7 @@
 #include <linux/falloc.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fileattr.h>
 
 #include "glob.h"
 #include "smbfsctl.h"
@@ -5541,16 +5542,33 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
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
+		/*
+		 * -EINVAL, -EOPNOTSUPP: ntfs-3g and other FUSE
+		 * filesystems that lack FS_IOC_FSGETXATTR support.
+		 */
+		if (err && err != -ENOIOCTLCMD && err != -ENOTTY &&
+		    err != -EINVAL && err != -EOPNOTSUPP) {
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


