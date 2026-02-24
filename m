Return-Path: <linux-nfs+bounces-19194-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cENEKzz7nWmeSwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19194-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:25:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E9318C0AC
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C213113F46
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908273ACA6C;
	Tue, 24 Feb 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud58ZXPu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB683ACA5E
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961089; cv=none; b=kHnE25p0Z3mgJPUD9QtqB/qMaDoE8PmZ2SjGGI0e1vUBdbd+dbyVC2NHLdoP7zMEc/V1IfKHrk78lJypiEh94eP9Z1YAk2z/txMlMnEuWf8+Fk06XIjhyaEk526N9M2n4E298QR7Jkuoo9fydsmtmpFG/SORf05EJkeRHvUEl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961089; c=relaxed/simple;
	bh=wABcBndEmvyVwNqb/VZnzCqtKIUm2ybjDoVE24MUu+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ij6E7je1mZxcBk4bG68spSw1hayTWbSd3pIY8+1hawvWI79CjVfDZ+XbVKpNbVuN85zhfsIiBuQ5XgXfSj9VNMZLD7fUxVuwWFYYBvafqX3ZmBpyCW5V4jYkQQwY/5LGfqxgMoHbj104NSNbsLsrrrGzGPU0ug0W5aUJ8ChYk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud58ZXPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC2CC19422;
	Tue, 24 Feb 2026 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771961089;
	bh=wABcBndEmvyVwNqb/VZnzCqtKIUm2ybjDoVE24MUu+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ud58ZXPul0BTGN0I5MToIBx6NqNOn/B2UGywNP9qvcVR0mlBhp73j4MdakhiElDpq
	 v810aafjbukLTLZH+2c7dDstJ7df63XIbojO7IG62IjEkFvGQyg+wzNFLqcshV/O4x
	 Ix3aMsSLCiIPg/NavYt4238RprnZtybxkCGDIRGfjnQ2HrdFhQAxVIRYopuKKz8UIZ
	 aFyLsW9+alh+Z/IpuIHCL+CKwlYRWHyvBB5jOphcLhONnOqWQK+tgpihlUwmBHjv1x
	 UD9gKSOuSv40JId7mhxB3+ttABWHmtGyhj0+Hl5KkrHWUp+zOyizXh0O9RXOh+L2MI
	 jLoSzMKNcu6tQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 07/11] NFSD: add NFS4ACL_DACL and NFS4ACL_SACL passthru support
Date: Tue, 24 Feb 2026 14:24:34 -0500
Message-ID: <20260224192438.25351-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260224192438.25351-1-snitzer@kernel.org>
References: <20260224192438.25351-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19194-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 59E9318C0AC
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

This 4.1 DACL and SACL support is confined to NFSD's NFS reexport case
(e.g. when NFSD 4.1 reexports NFS 4.2).

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfsd/nfs4proc.c |  3 +++
 fs/nfsd/nfs4xdr.c  | 49 ++++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/nfsd.h     |  5 +++--
 3 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d05ac00f934e..4a43e5052deb 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -91,6 +91,9 @@ check_attr_support(struct nfsd4_compound_state *cstate, u32 *bmval,
 		return nfserr_attrnotsupp;
 	if ((bmval[0] & FATTR4_WORD0_ACL) && !nfsd_supports_nfs4_acl(dentry))
 		return nfserr_attrnotsupp;
+	if ((bmval[1] & (FATTR4_WORD1_DACL | FATTR4_WORD1_SACL)) &&
+	    !nfsd_supports_nfs4_acl(dentry))
+		return nfserr_attrnotsupp;
 	if ((bmval[2] & (FATTR4_WORD2_POSIX_DEFAULT_ACL |
 					FATTR4_WORD2_POSIX_ACCESS_ACL)) &&
 					!IS_POSIXACL(d_inode(dentry)))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 80d2e7ea8cc9..99db768ad97e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -315,7 +315,13 @@ __be32 nfsd4_decode_nfs4_acl_passthru(struct nfsd4_compoundargs *argp,
 		goto out;
 	}
 
-	(*acl)->type = NFS4ACL_ACL;
+	if (bmval[0] & FATTR4_WORD0_ACL)
+		(*acl)->type = NFS4ACL_ACL;
+	else if (bmval[1] & FATTR4_WORD1_DACL)
+		(*acl)->type = NFS4ACL_DACL;
+	else if (bmval[1] & FATTR4_WORD1_SACL)
+		(*acl)->type = NFS4ACL_SACL;
+
 	(*acl)->len = acl_len;
 	(*acl)->pgbase = pgbase;
 
@@ -571,7 +577,8 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		iattr->ia_size = size;
 		iattr->ia_valid |= ATTR_SIZE;
 	}
-	if (bmval[0] & FATTR4_WORD0_ACL) {
+	if (bmval[0] & FATTR4_WORD0_ACL ||
+	    (bmval[1] & (FATTR4_WORD1_DACL | FATTR4_WORD1_SACL))) {
 		status = nfsd4_decode_acl(argp, acl, attrlist4_count);
 		if (status)
 			return status;
@@ -3253,8 +3260,12 @@ static __be32 nfsd4_encode_fattr4_supported_attrs(struct xdr_stream *xdr,
 	u32 supp[3];
 
 	memcpy(supp, nfsd_suppattrs[minorversion], sizeof(supp));
-	if (!nfsd_supports_nfs4_acl(args->dentry))
-		supp[0] &= ~FATTR4_WORD0_ACL;
+	if (!nfsd_supports_nfs4_acl(args->dentry)) {
+		if (supp[0] & FATTR4_WORD0_ACL)
+			supp[0] &= ~FATTR4_WORD0_ACL;
+		else if ((supp[1] & (FATTR4_WORD1_DACL | FATTR4_WORD1_SACL)))
+			supp[1] &= ~(FATTR4_WORD1_DACL | FATTR4_WORD1_SACL);
+	}
 	if (!args->contextsupport)
 		supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 
@@ -3689,8 +3700,12 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 	u32 supp[3];
 
 	memcpy(supp, nfsd_suppattrs[resp->cstate.minorversion], sizeof(supp));
-	if (!nfsd_supports_nfs4_acl(args->dentry))
-		supp[0] &= ~FATTR4_WORD0_ACL;
+	if (!nfsd_supports_nfs4_acl(args->dentry)) {
+		if (supp[0] & FATTR4_WORD0_ACL)
+			supp[0] &= ~FATTR4_WORD0_ACL;
+		else if ((supp[1] & (FATTR4_WORD1_DACL | FATTR4_WORD1_SACL)))
+			supp[1] &= ~(FATTR4_WORD1_DACL | FATTR4_WORD1_SACL);
+	}
 	if (!args->contextsupport)
 		supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 
@@ -3879,8 +3894,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_MOUNTED_ON_FILEID]	= nfsd4_encode_fattr4_mounted_on_fileid,
 	[FATTR4_DIR_NOTIF_DELAY]	= nfsd4_encode_fattr4__noop,
 	[FATTR4_DIRENT_NOTIF_DELAY]	= nfsd4_encode_fattr4__noop,
-	[FATTR4_DACL]			= nfsd4_encode_fattr4__noop,
-	[FATTR4_SACL]			= nfsd4_encode_fattr4__noop,
+	[FATTR4_DACL]			= nfsd4_encode_fattr4_acl,
+	[FATTR4_SACL]			= nfsd4_encode_fattr4_acl,
 	[FATTR4_CHANGE_POLICY]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_FS_STATUS]		= nfsd4_encode_fattr4__noop,
 
@@ -4067,6 +4082,24 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 			goto out;
 		} else if (err != 0)
 			goto out_nfserr;
+	} else if (attrmask[1] & FATTR4_WORD1_DACL) {
+		err = nfsd4_get_nfs4_acl(rqstp, dentry, NFS4ACL_DACL, &args.acl);
+		if (err == -EOPNOTSUPP)
+			attrmask[1] &= ~FATTR4_WORD1_DACL;
+		else if (err == -EINVAL) {
+			status = nfserr_attrnotsupp;
+			goto out;
+		} else if (err != 0)
+			goto out_nfserr;
+	} else if (attrmask[1] & FATTR4_WORD1_SACL) {
+		err = nfsd4_get_nfs4_acl(rqstp, dentry, NFS4ACL_SACL, &args.acl);
+		if (err == -EOPNOTSUPP)
+			attrmask[1] &= ~FATTR4_WORD1_SACL;
+		else if (err == -EINVAL) {
+			status = nfserr_attrnotsupp;
+			goto out;
+		} else if (err != 0)
+			goto out_nfserr;
 	}
 
 	args.contextsupport = false;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 7c009f07c90b..0f2aaabf4f8c 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -447,7 +447,8 @@ enum {
 	NFSD4_SUPPORTED_ATTRS_WORD0
 
 #define NFSD4_1_SUPPORTED_ATTRS_WORD1 \
-	(NFSD4_SUPPORTED_ATTRS_WORD1	| PNFSD_SUPPORTED_ATTRS_WORD1)
+	(NFSD4_SUPPORTED_ATTRS_WORD1	| PNFSD_SUPPORTED_ATTRS_WORD1 | \
+	 FATTR4_WORD1_DACL | FATTR4_WORD1_SACL)
 
 #define NFSD4_1_SUPPORTED_ATTRS_WORD2 \
 	(NFSD4_SUPPORTED_ATTRS_WORD2	| PNFSD_SUPPORTED_ATTRS_WORD2 | \
@@ -540,7 +541,7 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 #define NFSD_WRITEABLE_ATTRS_WORD1 \
 	(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP \
 	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_CREATE \
-	| FATTR4_WORD1_TIME_MODIFY_SET)
+	| FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WORD1_DACL | FATTR4_WORD1_SACL)
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 #define MAYBE_FATTR4_WORD2_SECURITY_LABEL \
 	FATTR4_WORD2_SECURITY_LABEL
-- 
2.44.0


