Return-Path: <linux-nfs+bounces-21033-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBGyNLIc6mntuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21033-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:20:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E7C452C32
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F2EB30E179B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98913F077C;
	Thu, 23 Apr 2026 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC3zMZ8G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876CA3EF0BF;
	Thu, 23 Apr 2026 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949962; cv=none; b=ZUGuzim4IUdy3iurWcM2fJ1A9RQjGRWfBGRkE9E3UceWTDYb5RtxsJZZu1H3VE6ruuPVOTUgVo2DlFp/prfE3d8gobOBkOsCGZMF71NCAgExc03jzPcW6+MHFsEhy5w1IZjkXQIaidy4h3HSfJZoMwxNsGQwkuqekXJxPJBnjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949962; c=relaxed/simple;
	bh=jXYqYekRjpF07wlPDKgx2XWDNqQtTHKbLiod79qFffg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3SIo1r+FsUNfxFFMvP+VwjTDnU/DfH2o7MhyfmyTuqESXRl4+OJ9CAPZ8hPR0VsLWv7eAR0Vk24gawyid/FcjjxmIc4VY4V4OFvg+sWZNaG07CXD3P/q9RDpuLggLt2JW0/GpVaFDQ30KyGpbHYCjUsN/ID2UaoTUTbta9YRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC3zMZ8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3111DC2BCB4;
	Thu, 23 Apr 2026 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949962;
	bh=jXYqYekRjpF07wlPDKgx2XWDNqQtTHKbLiod79qFffg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XC3zMZ8GXEPAPGuVPkpcEGJW/IWUfO9lT5X+da8jeEzG30DrtLhAa90rUVt9Gnx3h
	 Yh7AnsqQoxVGIIhqTnnZbWpcjwN3ItAVSTFp8tiMrIJUWfD4R9OStiy0ZNAyId4XMw
	 d2Z2L5hccCmf7zAV3nqUUdvoQprKmbcKdlOAgW40hdZuQX5OaPfH+A6rab0OZGvDox
	 aDv0P/ZQd9E8C+/Pwl8FA05S6P2NtFlWHsLB8dFv7bB7fMTkseIbph+4Tjrtxq6euV
	 wCsCmNbnex9K3PvwvS3S8q9VkGxuvMVnUOLmsezHOVvd1EDzUUpalew7yOLN8BACBt
	 IegZt8Hz3IuLA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:11 -0400
Subject: [PATCH v10 08/17] ext4: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-8-c385d674a6cf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=TxMd9+19zfe1kcd7z7IWDwky99GfiXSk/tT0Rl2ZM5c=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq01cfRhNAJt0xx2EbnMwGvHTygaBYN6aRTE
 GINZfCUwkSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l+4aD/9AIIDkYsuxGwkaHb0alyjM31f5P4xoH9QnzDFp8NL/UVKvxCdSvFeMeyBHwVa7Fy9ruea
 zMwrMXaFVq2XZWeNySOA0xiFd4HT0xd854+HjYrlIEdnnKtj5zrn3FrAvE3n7mSq5YxhGF9pwhw
 5RavDMmtW/5nOr3HYz1Gp7xrk3hPZOJ2uPXpSOVw9GMxNiotmNg0ZDwjDxSEMkM7+ScHLDGzMFR
 wLhw5l9Rs0mhNYWejSb2IQhDijmYO1Ym35ZiJjNu5ft4ChBGAuoxGL0m5/f8650C7D2PP+Uet9i
 r4Q+ALt7QWYX3HAPWpT2pMx8cFGUD25yODaeNdLKH5AiBlu8KtHiArKHxGo6nIDcxzr5RYhvmYp
 w5CIQChTJ12zqUt2vNfuYzcuNFQxah0Oy3lAmGkW7ZL+juq6mxvkPTy8PJDQvH8wLKBlWDHCpul
 7a2TrzylW2pvpGiW96qRr6ZMwLsQLoWdZl+m5tbuBxniV9qHk/2Qw6yE/bwTx0MySJpVkZZgnZ4
 ty+BBTmKui8m5aOah8Uf621+mouo4Ve7WFdy1i4zWhVUDQgbHt5cn182HB0L7hN8xQrYTHqTyM2
 OKrOHQ/XIP5hQ1O6r2WRIOscUUUEfDJNxwOPDa/Lunw+phN71xW9DR540IhKBRXhREigJfqA7wH
 jFNwOPn3bVc/EfQ==
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
	TAGGED_FROM(0.00)[bounces-21033-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[32];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 57E7C452C32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Report ext4's case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. ext4 always preserves case at rest.

Case sensitivity is a per-directory setting in ext4. If the queried
inode is a casefolded directory, report case-insensitive; otherwise
report case-sensitive (standard POSIX behavior).

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ext4/ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 1d0c3d4bdf47..d1d597a13eeb 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -999,6 +999,13 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
+	/*
+	 * Case folding is a directory attribute in ext4. Set FS_XFLAG_CASEFOLD
+	 * for directories with the casefold attribute; all other inodes use
+	 * standard case-sensitive semantics.
+	 */
+	if (IS_CASEFOLDED(inode))
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	return 0;
 }
 

-- 
2.53.0


