Return-Path: <linux-nfs+bounces-19045-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IwcCTmLl2n/0AIAu9opvQ
	(envelope-from <linux-nfs+bounces-19045-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B721630FE
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF49303B4E4
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AC32DB79E;
	Thu, 19 Feb 2026 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdtV2Z2K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028981DE3B5
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539237; cv=none; b=CWJgNoxPQzQ47i+d6c1hdSFzIAG38x52e/tmw88mmpfYjbRZSx1CIPsE8UotPMgqWPA3SDDBXthoJ2BLmevWzMvvTZkx6r/JacW6dzk4OMXRYFyS8464/rH9dQpydq799yrqEfy2Xtgsf5OquSk7e0qI6ZquqVpAw0rvrr7IYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539237; c=relaxed/simple;
	bh=MiPX/YdEHSHEomqdh9JhFI3hEfEmd/f8lUiYQHtQCJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eS3XXso5ZysbiCXq3+cWIGkTlXneDBRlQ6dwlg3Ys8ZCTl5F+s2h/ZpCI1Q730qt1NWq6X3Cb51DiWc2tqg8wBTLmngG1wZRLtKB8/+uo0+/96DpNu91RHqm/7FvS+3Sx1T/OgIfXXqpWSxt8WMe6rVuOFNN2WMs2CcMtQufJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdtV2Z2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DEBC4CEF7;
	Thu, 19 Feb 2026 22:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539236;
	bh=MiPX/YdEHSHEomqdh9JhFI3hEfEmd/f8lUiYQHtQCJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdtV2Z2KTnJStNgqAWG0YtESHbFqXsttbe7k/4bvYJXccwMllQOKlEosNRX9dylk6
	 +O/Pcq7k5SVHy9is1iKcHbMCZu6JYCGKCGRYMrCC4/5BJrwIi6+jAf9pgYGZ+4fiIP
	 P1C3AdlYy7G3P4e6dEKv/KrpdrYBo/SJ9YlMbsif+TYW4vE2r18LQRSy2yi9tsn/tY
	 nlgaCqmno74KrtMccrS0NT4DRNRQXfZp04KIfc03QI3PM7aRhTSFHm11PoCDYpiIaE
	 L3OOuaRucRtxXiSAGTnJkRXlBvU9dWt5XyePtsyrz6qyAttJEgjUAFeI9liilYZKT1
	 8gqdBVlr7EC3Q==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 02/11] NFSD: factor out nfsd_supports_nfs4_acl() to nfsd/acl.h
Date: Thu, 19 Feb 2026 17:13:43 -0500
Message-ID: <20260219221352.40554-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260219221352.40554-1-snitzer@kernel.org>
References: <20260219221352.40554-1-snitzer@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19045-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 63B721630FE
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

Check both IS_POSIXACL() and exportfs_may_passthru_nfs4acl() to
prepare for passing through nfs4_acl directly to NFSv4 filesystem
(NFSv4 will set EXPORT_OP_NFSV4_ACL_PASSTHRU flag in later commit).

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfsd/acl.h      | 8 ++++++++
 fs/nfsd/nfs4proc.c | 2 +-
 fs/nfsd/nfs4xdr.c  | 6 +++---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
index 2003523d0e65..699a3b19bdb8 100644
--- a/fs/nfsd/acl.h
+++ b/fs/nfsd/acl.h
@@ -35,6 +35,8 @@
 #ifndef LINUX_NFS4_ACL_H
 #define LINUX_NFS4_ACL_H
 
+#include <linux/exportfs.h>
+
 struct nfs4_acl;
 struct svc_fh;
 struct svc_rqst;
@@ -51,4 +53,10 @@ __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
 			 struct nfsd_attrs *attr);
 void sort_pacl_range(struct posix_acl *pacl, int start, int end);
 
+static inline bool nfsd_supports_nfs4_acl(struct dentry *dentry)
+{
+	return IS_POSIXACL(d_inode(dentry)) ||
+		exportfs_may_passthru_nfs4acl(dentry->d_sb->s_export_op);
+}
+
 #endif /* LINUX_NFS4_ACL_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 293d149332e4..9a21e94a4215 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -89,7 +89,7 @@ check_attr_support(struct nfsd4_compound_state *cstate, u32 *bmval,
 
 	if (!nfsd_attrs_supported(cstate->minorversion, bmval))
 		return nfserr_attrnotsupp;
-	if ((bmval[0] & FATTR4_WORD0_ACL) && !IS_POSIXACL(d_inode(dentry)))
+	if ((bmval[0] & FATTR4_WORD0_ACL) && !nfsd_supports_nfs4_acl(dentry))
 		return nfserr_attrnotsupp;
 	if ((bmval[2] & (FATTR4_WORD2_POSIX_DEFAULT_ACL |
 					FATTR4_WORD2_POSIX_ACCESS_ACL)) &&
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index aca3a1906f40..f048245b8592 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3195,7 +3195,7 @@ static __be32 nfsd4_encode_fattr4_supported_attrs(struct xdr_stream *xdr,
 	u32 supp[3];
 
 	memcpy(supp, nfsd_suppattrs[minorversion], sizeof(supp));
-	if (!IS_POSIXACL(d_inode(args->dentry)))
+	if (!nfsd_supports_nfs4_acl(args->dentry))
 		supp[0] &= ~FATTR4_WORD0_ACL;
 	if (!args->contextsupport)
 		supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
@@ -3328,7 +3328,7 @@ static __be32 nfsd4_encode_fattr4_aclsupport(struct xdr_stream *xdr,
 	u32 mask;
 
 	mask = 0;
-	if (IS_POSIXACL(d_inode(args->dentry)))
+	if (nfsd_supports_nfs4_acl(args->dentry))
 		mask = ACL4_SUPPORT_ALLOW_ACL | ACL4_SUPPORT_DENY_ACL;
 	return nfsd4_encode_uint32_t(xdr, mask);
 }
@@ -3600,7 +3600,7 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 	u32 supp[3];
 
 	memcpy(supp, nfsd_suppattrs[resp->cstate.minorversion], sizeof(supp));
-	if (!IS_POSIXACL(d_inode(args->dentry)))
+	if (!nfsd_supports_nfs4_acl(args->dentry))
 		supp[0] &= ~FATTR4_WORD0_ACL;
 	if (!args->contextsupport)
 		supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
-- 
2.44.0


