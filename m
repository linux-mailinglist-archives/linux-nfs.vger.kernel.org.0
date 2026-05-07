Return-Path: <linux-nfs+bounces-21430-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC0sBF5U/GlOOAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21430-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 10:59:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E304E55AB
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 10:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D712F300F5DD
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807FC3B6C1E;
	Thu,  7 May 2026 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rz21vbS1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD49E39902B;
	Thu,  7 May 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144099; cv=none; b=C888FIlD1IWZy8txcdHWxqPeqtpWcLtSW6rGEQ3rbNlBUCwoLubpGMDJonKHpvZh9eI9mjMvqvOExXigwFSY5k/U6gFk2KnlEYTV2m9gzZaHhSZyRO78Q2ouDIVL7Cum8LeGhySjimfywLXtq2l7aHEY6bTkhGR6D3gYz9q0AzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144099; c=relaxed/simple;
	bh=2NSf4+7qlZ+vT9eKp/7+cdSDZGq8xAtKJ25Ppiig/ZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYvgmkqymSIw+CnLtjNMgx+eVQqQU1ClXBL/hygM3aTcqOefb9fX5ptLDZ3fK2GmJhWCvlLuOHVsSOoXXjt1+LqsLZxZq4i8RF8iCive2Zxtj3YpWeIJw0gIigZEaIZbSEECgAilITejac6afDkqlTWVatooDidRY7iIdLr2eGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rz21vbS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578EEC2BCB8;
	Thu,  7 May 2026 08:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144099;
	bh=2NSf4+7qlZ+vT9eKp/7+cdSDZGq8xAtKJ25Ppiig/ZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rz21vbS1Dzn21SPmuV2qO235tZA708gsw+xwkomBOle62yk0tt7cYzAApb3F/Mqp+
	 7srcgcnavL7JG/QHhtKrg2Byu0i21OoPcYmkeqt+GTXSNVpT/5+ChKlsi6YaB0I12B
	 9kexGMxMU1G3r+u9mB6znKU5SsZSvK1IUjxN2ooilV+PSdGda1T1ZEG4Fywgc0qu1Z
	 QLGwv4qYSN5W5QbQXb3PefB3Df+J57P2jUFIF4kyPnxluYFcnUzYddGAeqQS97Cvyl
	 T8YKeHh3//3cfaU4HB9zqao9b4Hk0508UiyGGtWjHzYIBCYo57mEKBM9sb/kJw4Ofr
	 K0a81VLKrw+8g==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 07 May 2026 04:53:06 -0400
Subject: [PATCH v14 13/15] nfsd: Report export case-folding via NFSv3
 PATHCONF
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-case-sensitivity-v14-13-e62cc8200435@oracle.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8373;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=2cQdKL/iRcH0yK5lMh63TGELmX0w6vyxoFnTaE/H7eE=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL2cglHZ34suSkVQ1UwIwIr+9Gx/j2X5+9dY
 WpTJ8buvAyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9gAKCRAzarMzb2Z/
 lw+PEACafZrSIhJkaCK6hyJDlTikfWz0YTeSmzU35RhiI/FyHYWjw2VR9z5yy6+wyISbKHzK7rm
 nW60h1vWMoA7e09pIfjhSjVZlAXEj5ojeXWWwhkTkNyB1A0WRii5pBjsbueS9SnukPC7fnDBtjA
 GbU4MUbgAutvhTTTaJ4R6Vy3sq2r7mjM3CdLHgSJy5V7LF0iCr3XHxnEgyu3x8QA/4ZrieOMvke
 +4cvoIdm4dVE+Yi/C+gNFv7CM60gqm4W0Tj1TyQTAvDMC7+MgBRZ9g7YVssLKjKPl2o57/IUg94
 /nu4mIBrm5sRRKWGnHZdlMovTxwI14wy3kGQEWeuIppYdZ7ce8b/grXgK/qvU3dyVmBNxKDIYQ/
 q0Lfr/j6laKFwo/ADYBNZetCYapj59vx+EgpY3Ht+1+W3cwp704XzJxcq2whsbnf2ii1sgpvvNn
 2AUHmgOp6TnW+2MC7TYbDQvPM4LyRplNLorCdqhBIxVOFSTay5fBuaSNlVmvIfN5Ytt5RRCdT4m
 BRJhuCA/mdtOqqEtMYMhpEMFK3wqyLJg9ZrO4njJAgGFwbYmyvENapJwvLZpGAkWnlTttAG6jV6
 31sFZuA6CiK1CQYFgshTi9UxOOMRxUAvd0X1dAIpszpwPPufzKy2Ot8MshKKOr0o9oLtKwviymU
 VwYYPvJQgbra0Rg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: A1E304E55AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21430-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

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

Case-folding is a per-directory property, so
nfsd_get_case_info() queries the parent dentry for
non-directory filehandles. Three inherent corner cases follow:
a single-file export's parent lies outside the exported
subtree, so the LSM hook evaluates against an unexported
directory; a disconnected dentry from fh_verify() has
d_parent == itself, so the file's own attributes are reported
until the dentry connects; and a hardlinked file resolves
through the alias the dcache currently holds, so when the
inode is linked into both case-folded and case-sensitive
directories the reported value tracks whichever parent is
active. These limitations are not addressable without
redefining the protocol attribute as per-parent rather than
per-object.

RFC 1813 restricts PATHCONF errors to NFS3ERR_STALE,
NFS3ERR_BADHANDLE, and NFS3ERR_SERVERFAULT. When an LSM hook
denies the case-folding query on the parent, NFS3ERR_STALE is
the only correct mapping: NFS3ERR_SERVERFAULT misrepresents a
working server as broken, and NFS3ERR_BADHANDLE implies a
decoding failure that did not occur. A client purging the
filehandle on receipt is the desired outcome, since the server
has refused to read attributes through it. Substituting POSIX
defaults instead would let the same handle report
casefold=false now and casefold=true once policy permits,
opening a silent name-collision window on case-insensitive
exports.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 36 +++++++++++++++++-----
 fs/nfsd/vfs.c      | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h      |  3 ++
 fs/nfsd/xdr3.h     |  4 +--
 4 files changed, 121 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 42adc5461db0..12b9172c6be1 100644
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
index eafdf7b7890f..85ff418127c7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -32,6 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/security.h>
 #include <linux/sunrpc/xdr.h>
+#include <linux/fileattr.h>
 
 #include "xdr3.h"
 
@@ -2891,3 +2892,90 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+/**
+ * nfsd_get_case_info - get case sensitivity info for a dentry
+ * @dentry: dentry to query
+ * @case_insensitive: set to true if name comparison ignores case
+ * @case_preserving: set to true if case is preserved on disk
+ *
+ * On casefold-capable filesystems the flag lives on the directory,
+ * not on its entries, so for a non-directory @dentry the parent is
+ * queried instead. A directory (including an export root, whose
+ * parent lies outside the export) is queried as-is so its own
+ * contents' lookup behavior is reported. NFSD advertises
+ * fattr4_homogeneous as FALSE, so per-directory answers may differ
+ * within an export.
+ *
+ * The probe runs with kernel credentials. case_insensitive and
+ * case_preserving describe the directory's structural lookup
+ * behavior, not the caller's identity; running under the calling
+ * client's mapped credentials would let per-client MAC policy on
+ * the parent directory turn this query into NFS4ERR_ACCESS even
+ * though the underlying property is the same for every client.
+ *
+ * When the filesystem does not expose case-folding state (no
+ * ->fileattr_get, or the callback returns -EOPNOTSUPP /
+ * -ENOIOCTLCMD / -ENOTTY / -EINVAL), the outputs are filled with
+ * POSIX defaults (case-sensitive, case-preserving) on the premise
+ * that a filesystem with case-folding support wires up
+ * fileattr_get.
+ *
+ * Return: 0 with outputs filled, -EOPNOTSUPP with outputs filled
+ *         to POSIX defaults, or a negative errno (e.g., -EIO,
+ *         -ESTALE, -ENOMEM) with outputs unmodified.
+ */
+int
+nfsd_get_case_info(struct dentry *dentry, bool *case_insensitive,
+		   bool *case_preserving)
+{
+	struct file_kattr fa = {};
+	const struct cred *saved;
+	struct cred *probe;
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
+
+	probe = prepare_creds();
+	if (!probe) {
+		err = -ENOMEM;
+		goto out;
+	}
+	probe->fsuid = GLOBAL_ROOT_UID;
+	probe->fsgid = GLOBAL_ROOT_GID;
+	saved = override_creds(probe);
+
+	err = vfs_fileattr_get(cd, &fa);
+
+	put_cred(revert_creds(saved));
+out:
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


