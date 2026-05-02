Return-Path: <linux-nfs+bounces-21359-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHD6NFcJ9mlPRwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21359-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:25:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E54B27C6
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F7E03028032
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B244933D6EE;
	Sat,  2 May 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNZllbqz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3602820AC;
	Sat,  2 May 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731750; cv=none; b=mEJeU0gNvOnXciOYtC+Xwau/6c0hgEuT3NkI1qGfnUNqdZDZ4Y1GqV2yWAyCgyn16bog5SdFogSzVzJRjbj28jWru4ARDD6fo40ZgWhoUDsJFKk6wD1mr7ptVCC2iHj/h/+1QEU1qx9as3tXu9TmBHrEzAotL8Up3GKttC71Bac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731750; c=relaxed/simple;
	bh=sdRAbA0hLtQN2RnAbozuOhOqbFqQox7bou91/njDoms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqcfCMsS/OzneAQKZVPjKCrX5fBTbIA9li5g+3FqkcMfWuMpsGP0MCRR+SKbu6pQcm2LA90DYc0bIeYQIeqzk2MECblWrEE8Qr18GyBh/X9CwZQWVxuChOsGOnaSvQOZj1vLiiUiqr/48rG2SWKR1Q68YLB4pEGMR2MNaavzaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNZllbqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E2C2BCC7;
	Sat,  2 May 2026 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731750;
	bh=sdRAbA0hLtQN2RnAbozuOhOqbFqQox7bou91/njDoms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FNZllbqzVoBbR0NGwnoBBjRU7xSequIG890TkXVb1EEiRLncFALEZe7JrhiR3J8e/
	 cF1wqx1GS/EqMtVt3utsN9hY6yEE8XbSgJ6sQBgyx7Uw4OuL5jhTY1G7M/du+02oSe
	 OCWHkHLG+erjA4/ggppUs6auQIvRTknjYqzFCZOxhXqMGCi/yi39DVM+u9grnXiOF+
	 U/sRlcZX9iNagm9qlUL7amDa8glHU99q6SPpfTMMPCTfYGanAZkwlw7ia7BOzpvn5z
	 nqdKBMXcXDFuOVVB1gmWmLOrJOcfdBq4zv0ltqACLoA8xozbu2NmPUCkGttcEybf0v
	 9CKsfOQHGkt5w==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 02 May 2026 10:20:58 -0400
Subject: [PATCH v13 13/15] nfsd: Report export case-folding via NFSv3
 PATHCONF
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-case-sensitivity-v13-13-aa853140311f@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8016;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=gPgHxk6J/l08HbE/ArroIs8LMtbWr6iWpYFW4djvm3Q=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghRQxUjJJQkvR+X7w7b6YrZQNg3OE28iDeC6
 mUj9RPXpwmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUQAKCRAzarMzb2Z/
 lxOxEACBWOesoo4+9RI1Cg2aP3tI9x6cOs/Zj6Ez6E85J1/5y+dXj9NnJJKO4/0VgsSSqogI6CZ
 nR35sTkyP/JvKojGnCj4qN9i1T+wSd/IYzdXH0SwgcjNhrmSys5LajScny0DTkLr8gIc91WQE+0
 GOE9ToI1jKW4GpM2PfZISNNATU79nepS/CgRUYaUZWBHfgYSJfg2cS/0xEFZhlY9BusmyrKzN2x
 MVmh4MLWkrD1Sq8V7hdfpwsjAholAjf7Dykk6ojNDbBhv2rsLRAOx/MSek+/mXzp38qR+Oc5nJ3
 12Lm0YpYoCSCB48YPf5m8Ud4grsAEliKfhTKD5QUWOMO4OrTVPMLsKtXh1OBpd7XMbIfq2ni+1G
 vr6PWmie4yozJejru+TXS4+m21iIwI1e0asi3eA1JmGcoKnCSSaZQBSi4Wc7D8/q+WJszKb/jaX
 clZZblUEukmqNZfev1Bx+KhwFzmfZDnJUw7Oxom+i+fOqm9BRuUqfFfExvaqid1GO7eMz4yu7wn
 ejRVSRhhB1/5dcw6yqscukyMdOrw0oDwG0emMcmYRWRwiCf5C2eB0s/8GE+23d0bjZVQCfBkeQI
 P7hxi+Ble1sDnSesQT8/iyvk0hw0rTkFuq6n7lKa/2/dWgGKccUiel5sR2wJae4CQKSdVTkwgL9
 vXZg0c5a5WyhnNA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 320E54B27C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21359-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,nrubsig.org:email]

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


