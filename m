Return-Path: <linux-nfs+bounces-21040-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLnXBtkc6mntuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21040-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:21:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49A452C83
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B2ED30E7D7D
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D53EFD30;
	Thu, 23 Apr 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI1lnQkm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7953EFD35;
	Thu, 23 Apr 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949979; cv=none; b=hE1euMw3y0NBtHu1sxzz12eAIyEhC8CEruQQj4ySYaNvn4Baip924EWCmS+ZrykLp8EB7/N5XawV9s5P90RRBU345sYwhk+fAMjzVNnk78gE8fHvyo31wTpijE7tpnq9M+h8aKLd5FfiHoKXJCK9hnS5/5J6k5KYjxH/Sr1i1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949979; c=relaxed/simple;
	bh=b2dPmXiYdZEdDVlEWEKTU56nDPF7wC71gMJX3L/kz+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BdEVwJ9030pWwkkK6NRBI/5A+/R3NRkDAQh1utYpkR4sCJTipfUYzFM3Ld6z4w+cx19hfsqtY5D/CB36AuicAgpSIBhMfI+NqdyqA7RHGMN4zRBLv/3g91nNZJSH3pxK7ZGus0yzYyemzsY77WcPWm6tX8cmZPkaVywCa1IQRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI1lnQkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC05AC2BCB4;
	Thu, 23 Apr 2026 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949979;
	bh=b2dPmXiYdZEdDVlEWEKTU56nDPF7wC71gMJX3L/kz+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mI1lnQkm6RfNPIjsMGBVJVU3j26XM23JXglQ2fZQQNBvsvYF4d78fRm5Cg7n9ezeH
	 fLkqByN4zAmIeHQ2+FxQoVVAxzpUg1OsTYOng4yrgovTVYpCUOgcfI1Tu4Z3CWNy+a
	 eFgwOld/3qEFixeNgepdUEU6FaD+APnEhaD5QnNTJX15UuHk2wPAgAmjlyYqxxQmVg
	 K486/vJOI1ln7Yltv2C3JywN6NhX9KWDDJdaC+siBKF+egijU947DR4arOHJD/9yho
	 nfZsT6T2cqobbp+01cK2mdhDDoNlmoBfhZDg+vhxf4Wg3wcQydh0aPowv91nBlCMWW
	 12uTCQYhOTo2g==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:18 -0400
Subject: [PATCH v10 15/17] nfsd: Report export case-folding via NFSv3
 PATHCONF
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-15-c385d674a6cf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3896;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=FWeVSPw+YdPTuck0Z7TVDFaDekbEULCniedO5xWHewY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq08F3kBTIMzG1w1pCx8/D7XOKJ/OzKDATb8
 ZkZf2jccJ6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l3AmD/0ew5WxBiwPakZjBrvudPQysJnteqWgpoPM1vBNuLjc7HUTgoSZ727oYMcEp+rdc5/SC9a
 jdzCH46KGdjo6mfmRIxZmfQZfb1MNJmavrsh4qJukACBsUj30UOo7nSizrbd9Q265/lAhZ+/0Z7
 3BxN3U4odSmK//ey26PYV+IuZstfgWBgSAVZ5QOkyLn4kggCPP/iqzABhxByQz9Jn9DMQx7kVfY
 q817bg8wvBk2yMvO5Dbyzob/8c79LJr0BBXUvE4+rq6RDCr/xeaD/TkXucXOhDd5nMIAFlYLgVE
 DE+zgBphYgBACm9dLsRjpBh69AUOXXIUyFWzpsK3NbuHlPrI9vpGLUlQg1zcyxnijOb3EVz34CO
 cg+EbvaGRhCoq2hzB597EwfUfbeqdQclOw7jKvalgE3uLzisF1+VQiUw8ExSY2xZP2WvNsP3qTo
 Zpo8rJKiEvc7G4cmg9iV2YuUx9nJtAfVKof/6w3avT2jgyzUCorc8GQnDHHnN/W7EmtwpjKUM2n
 KSdsH5MXqfTBy+ZrQ22DVRGW/XrS1bV6o0t1JTwYR00xH+HC/cWkEAdl/dmjptfo5zzyLjSAsKV
 XKlk40SG9BgI8OT8I69DI4ASRga/IJMwO8R/q+snDfO0cq2hjtjWPFPzjvlo9m7LlsSi4fO641J
 2G8InNOjh3/HouA==
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
	TAGGED_FROM(0.00)[bounces-21040-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 2B49A452C83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The hard-coded MSDOS_SUPER_MAGIC check in nfsd3_proc_pathconf()
only recognizes FAT filesystems as case-insensitive. Modern
filesystems like F2FS, exFAT, and CIFS support case-insensitive
directories, but NFSv3 clients cannot discover this capability.

Query the export's actual case behavior through ->fileattr_get
instead. This allows NFSv3 clients to correctly handle case
sensitivity for any filesystem that implements the fileattr
interface. Filesystems without ->fileattr_get continue to report
the default POSIX behavior (case-sensitive, case-preserving).

This change depends on commit ("fat: Implement fileattr_get for
case sensitivity"), which ensures FAT filesystems report their
case behavior correctly via the fileattr interface.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 18 ++++++++++--------
 fs/nfsd/vfs.c      | 29 +++++++++++++++++++++++++++++
 fs/nfsd/vfs.h      |  3 +++
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 42adc5461db0..7b094c5908f1 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -717,17 +717,19 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 
 	if (resp->status == nfs_ok) {
 		struct super_block *sb = argp->fh.fh_dentry->d_sb;
+		bool case_insensitive, case_preserving;
 
-		/* Note that we don't care for remote fs's here */
-		switch (sb->s_magic) {
-		case EXT2_SUPER_MAGIC:
+		if (sb->s_magic == EXT2_SUPER_MAGIC) {
 			resp->p_link_max = EXT2_LINK_MAX;
 			resp->p_name_max = EXT2_NAME_LEN;
-			break;
-		case MSDOS_SUPER_MAGIC:
-			resp->p_case_insensitive = 1;
-			resp->p_case_preserving  = 0;
-			break;
+		}
+
+		resp->status = nfsd_get_case_info(argp->fh.fh_dentry,
+						  &case_insensitive,
+						  &case_preserving);
+		if (resp->status == nfs_ok) {
+			resp->p_case_insensitive = case_insensitive;
+			resp->p_case_preserving = case_preserving;
 		}
 	}
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index eafdf7b7890f..09878fd0ad41 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -32,6 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/security.h>
 #include <linux/sunrpc/xdr.h>
+#include <linux/fileattr.h>
 
 #include "xdr3.h"
 
@@ -2891,3 +2892,31 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+/**
+ * nfsd_get_case_info - get case sensitivity info for a dentry
+ * @dentry: dentry to query
+ * @case_insensitive: output, true if the filesystem is case-insensitive
+ * @case_preserving: output, true if the filesystem preserves case
+ *
+ * Filesystems without ->fileattr_get report POSIX defaults
+ * (case-sensitive, case-preserving). Outputs are unmodified on
+ * failure.
+ *
+ * Returns nfs_ok on success, or an nfserr on failure.
+ */
+__be32
+nfsd_get_case_info(struct dentry *dentry, bool *case_insensitive,
+		   bool *case_preserving)
+{
+	struct file_kattr fa = {};
+	int err;
+
+	err = vfs_fileattr_get(dentry, &fa);
+	if (err && err != -ENOIOCTLCMD && err != -ENOTTY)
+		return nfserrno(err);
+
+	*case_insensitive = fa.fsx_xflags & FS_XFLAG_CASEFOLD;
+	*case_preserving = !(fa.fsx_xflags & FS_XFLAG_CASENONPRESERVING);
+	return nfs_ok;
+}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 702a844f2106..abf33389ee81 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -156,6 +156,9 @@ __be32		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 			     loff_t *, struct readdir_cd *, nfsd_filldir_t);
 __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 				struct kstatfs *, int access);
+__be32		nfsd_get_case_info(struct dentry *dentry,
+				   bool *case_insensitive,
+				   bool *case_preserving);
 
 __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 				struct dentry *dentry, int acc);

-- 
2.53.0


