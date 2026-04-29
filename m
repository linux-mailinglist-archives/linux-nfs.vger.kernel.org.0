Return-Path: <linux-nfs+bounces-21290-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLBdLgRK8mnOpQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21290-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:12:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDD2498D3A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8B4C3083DD5
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2400A41C2F8;
	Wed, 29 Apr 2026 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avPaysqo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A43FF89E;
	Wed, 29 Apr 2026 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486081; cv=none; b=fdoGNi5OiK//RCG+r8cmq2tzcPBc6Pn9VIiWz1K1GoPP4KeIrxuMsFXo5/oL8FkdNePgOVrZp2xcG4L/arzpQWungZE3R3X/dfOBVLtxGNN+/+Njek/nGKMTjKal/FtGWkPfensWyiS04JEVZJ7aFoGQXrhyVhcsmQ9qxUBDtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486081; c=relaxed/simple;
	bh=3ibEXRs6ZqvvbnwWfb9g39rNFPAvDiuuC7ysYxFiMFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hI80LpHfW2EBHaFlwNwgFflwjvOPqjvqr3FvCFSROy2FPeamCS2Yy40v0hz14j6pEoDxrag4jKZg7mCLCoMWKbi3pj5xWoZ32m25spMO0cPjKRCvqw7dt/nHceBR+No7LpEdxHeMmQlDyWesHHM9+YeVK64/palCaLUuaM60+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avPaysqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5290BC19425;
	Wed, 29 Apr 2026 18:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486080;
	bh=3ibEXRs6ZqvvbnwWfb9g39rNFPAvDiuuC7ysYxFiMFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=avPaysqoEqIPCzZCnl6ij89BiLHf1e+VaFwQMtv3iz7PwPXJ2F7caCqxbNmIItpZC
	 NyUkMf0z0v/JKnu3IgN8M0X4bSaMoZmJHHd4RgVROqOKVWOXXUgqT44nGGU9MymVyR
	 MzU7hfeha6I8cvsS8F4wx1n2QwEJeJ8+Xi1EP0q6KY1v2Fl5IVqge69y9c+gFCn8uz
	 bkg/AhDwaHsCeNwZo0xzVFwcMkHqMrXuqzv81td6fPM0ZeQwiuwZpr+N0bmWmTYlfJ
	 4JOSZap4WyeGApeDeTWUBn+AytkjWPPqiVTlmPCMu8w9lQ4UYsjB9tmTGkYhXCCo1v
	 JECjOCsojZl3w==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 14:07:24 -0400
Subject: [PATCH v12 13/15] nfsd: Report export case-folding via NFSv3
 PATHCONF
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-case-sensitivity-v12-13-8057123bebe0@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6586;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=IpXstYLd1S+g4AYnnCs2sKNY6pmlFdt467tqNXA8Pt4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8kjdByccVEcEEBgQ8M2KviDpwfaOt8WgIOkww
 rIDrOpjY0aJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJI3QAKCRAzarMzb2Z/
 l7ddD/98CaYLuxipMbpe2ovAbP1yoj4kQpytu6hqH+62Yz7nNilpadWnIi4+mfXdyzFaEdt5p2S
 Itv/hOQLIgiX6VegXIUonQ3NlXL4JyNnnGKgAuixXFDE+cW76qHTXQQKeQnu+LpFSvGYr1IWxhS
 hnyaIW/lhxhmXoU5df/F/tR8dTFV1JLUqDBxMriUTBuNhXu+bx7Xi7b6QUeCaKL/4WPlFiujTEq
 plNyVFIk2dMEmBNf0H07QLO6XTzVvspi2wcwf5iXpvaH7pie0QuRH3BFTQ4MlqEEBJuuuIdg9hP
 X9TaWGkmIh2mNY1OQ9qCZX9rexnANVFCO469cm7fYVu3DRNONsrcsgqD1rzo0OhUzz55WT9ldIT
 nT0b/ConxQGMhscbm1pCJgv/IiNnZgE57Ygns3ajQwre1UUW1X0tfbMz34VkoxqZMN7CnWp2f+o
 UM0XOmHJm8Qs8Va99zevK/KYTwvG5x0ngTGAfsLdV5W4xEL4UQ0E3/JSyg0bK4rkqRqK40WtZO5
 D7O9jiAcKSnJ0AOmwZzM4U6BUGdEfO2hNTbli9ZU+sSWpOzS9A6I+ysEFiPN6pNWNCFbSr58F3k
 ZyeM5hx9Scq7EkJa/HLs8JXOugEVrbNPNjeYfkupNtXGjz3HwHkKVIl3ZzPv0VcNRpbHGYKUwzg
 JTEtS+s5vy2AR4A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 4EDD2498D3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21290-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nrubsig.org:email,oracle.com:mid,oracle.com:email]

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

This change depends on the earlier "fat: Implement fileattr_get
for case sensitivity" patch in this series, which ensures FAT
filesystems report their case behavior correctly via the
fileattr interface.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 36 +++++++++++++++++++++------
 fs/nfsd/vfs.c      | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h      |  3 +++
 fs/nfsd/xdr3.h     |  4 +--
 4 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 42adc5461db0..62ebc65b8af2 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -710,23 +710,43 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 	resp->p_name_max = 255;		/* at least */
 	resp->p_no_trunc = 0;
 	resp->p_chown_restricted = 1;
-	resp->p_case_insensitive = 0;
-	resp->p_case_preserving = 1;
+	resp->p_case_insensitive = false;
+	resp->p_case_preserving = true;
 
 	resp->status = fh_verify(rqstp, &argp->fh, 0, NFSD_MAY_NOP);
 
 	if (resp->status == nfs_ok) {
 		struct super_block *sb = argp->fh.fh_dentry->d_sb;
+		int err;
 
-		/* Note that we don't care for remote fs's here */
-		switch (sb->s_magic) {
-		case EXT2_SUPER_MAGIC:
+		if (sb->s_magic == EXT2_SUPER_MAGIC) {
 			resp->p_link_max = EXT2_LINK_MAX;
 			resp->p_name_max = EXT2_NAME_LEN;
+		}
+
+		err = nfsd_get_case_info(argp->fh.fh_dentry,
+					 &resp->p_case_insensitive,
+					 &resp->p_case_preserving);
+		/*  
+		 * RFC 1813 lists NFS3ERR_STALE, NFS3ERR_BADHANDLE, and
+		 * NFS3ERR_SERVERFAULT as the only PATHCONF errors.
+		 */
+		switch (err) {
+		case 0:
+		case -EOPNOTSUPP:
+			/* Both arms leave the output booleans valid. */
 			break;
-		case MSDOS_SUPER_MAGIC:
-			resp->p_case_insensitive = 1;
-			resp->p_case_preserving  = 0;
+		case -EACCES:
+		case -EPERM:
+			/*
+			 * Policy denied the query. Report STALE so the
+			 * handle is unusable without implying a server
+			 * malfunction.
+			 */
+			resp->status = nfserr_stale;
+			break;
+		default:
+			resp->status = nfserr_serverfault;
 			break;
 		}
 	}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index eafdf7b7890f..4bd63d8efbf7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -32,6 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/security.h>
 #include <linux/sunrpc/xdr.h>
+#include <linux/fileattr.h>
 
 #include "xdr3.h"
 
@@ -2891,3 +2892,74 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+/**
+ * nfsd_get_case_info - get case sensitivity info for a dentry
+ * @dentry: dentry to query
+ * @case_insensitive: set to true if the filesystem is case-insensitive
+ * @case_preserving: set to true if the filesystem preserves case
+ *
+ * On casefold-capable filesystems the flag lives on the directory,
+ * not on its entries, so for a non-directory @dentry the parent is
+ * queried instead. A directory (including an export root, whose
+ * parent lies outside the export) is queried as-is so its own
+ * contents' lookup behavior is reported.
+ *
+ * When the filesystem does not expose case-folding state (no
+ * ->fileattr_get, or the callback returns -EOPNOTSUPP /
+ * -ENOIOCTLCMD / -ENOTTY / -EINVAL), the outputs are filled with
+ * POSIX defaults (case-sensitive, case-preserving) on the premise
+ * that a filesystem with case-folding support wires up
+ * fileattr_get.
+ *
+ * Other errors propagate unmodified (-EACCES, -EPERM from LSM
+ * hooks; -EIO, -ESTALE, ... from the filesystem). Case-folding
+ * behavior is a property of the exported filesystem, not of the
+ * caller's credentials, so silently substituting defaults would
+ * let the same dentry report POSIX while LSM denies and report
+ * casefolding once LSM allows -- a client could race against
+ * silent name collisions on a case-insensitive export.
+ *
+ * Return: 0 with outputs filled, -EOPNOTSUPP with outputs filled
+ *         to POSIX defaults, or a negative errno with outputs
+ *         unmodified.
+ */
+int
+nfsd_get_case_info(struct dentry *dentry, bool *case_insensitive,
+		   bool *case_preserving)
+{
+	struct file_kattr fa = {};
+	struct dentry *cd;
+	bool put = false;
+	int err;
+
+	if (d_is_dir(dentry)) {
+		cd = dentry;
+	} else {
+		cd = dget_parent(dentry);
+		put = true;
+	}
+	err = vfs_fileattr_get(cd, &fa);
+	if (put)
+		dput(cd);
+	switch (err) {
+	case 0:
+		*case_insensitive = fa.fsx_xflags & FS_XFLAG_CASEFOLD;
+		*case_preserving =
+			!(fa.fsx_xflags & FS_XFLAG_CASENONPRESERVING);
+		return 0;
+	case -EINVAL:
+	case -ENOTTY:
+	case -ENOIOCTLCMD:
+	case -EOPNOTSUPP:
+		/*
+		 * Filesystem does not expose case state.
+		 * Report POSIX defaults.
+		 */
+		*case_insensitive = false;
+		*case_preserving = true;
+		return -EOPNOTSUPP;
+	default:
+		return err;
+	}
+}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 702a844f2106..e09ea04a51b9 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -156,6 +156,9 @@ __be32		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 			     loff_t *, struct readdir_cd *, nfsd_filldir_t);
 __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 				struct kstatfs *, int access);
+int		nfsd_get_case_info(struct dentry *dentry,
+				   bool *case_insensitive,
+				   bool *case_preserving);
 
 __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 				struct dentry *dentry, int acc);
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 522067b7fd75..a7c9714b0b0e 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -209,8 +209,8 @@ struct nfsd3_pathconfres {
 	__u32			p_name_max;
 	__u32			p_no_trunc;
 	__u32			p_chown_restricted;
-	__u32			p_case_insensitive;
-	__u32			p_case_preserving;
+	bool			p_case_insensitive;
+	bool			p_case_preserving;
 };
 
 struct nfsd3_commitres {

-- 
2.53.0


