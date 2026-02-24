Return-Path: <linux-nfs+bounces-19189-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH6bDAD7nWmeSwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19189-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:24:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E4618C043
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53AB8303717B
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0583A782E;
	Tue, 24 Feb 2026 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODvlw7sA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9372F3620
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961082; cv=none; b=IhFcuZ0eFnzp45xfVTrcCDxczmM9D2W3tRlWBVoiDx0ks2t0yA5F22rssKtbXKU4nAmBBvMCD0vctKQhmuUggN+/kh0VUWeuocrifEJK9ixEAr6rPSJdnYN1TPsVuUARHw6GnlAo8ap45ryjhdCmz/zQlcvZPj8/RTA/1QF/37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961082; c=relaxed/simple;
	bh=/T47owM2wlodILpXJTFcAMFFaajuLPF0qIMnQi3Xk+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvNk6J4C4RhUelUXzLayPu3EOKk1ascLNaj8EQlpuIpQme3IYjLB5ziQObeT01qC8t0SbIbVdATePpS9OFK76AV/CCaH/g6jzXLk0iHxNFKMBCkWGNHyE3qc8ySFogIE7pt78eJLB6dB1TWUrQwmy44BxtnqXEFMKQMX0QXPsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODvlw7sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EBFC116D0;
	Tue, 24 Feb 2026 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771961082;
	bh=/T47owM2wlodILpXJTFcAMFFaajuLPF0qIMnQi3Xk+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODvlw7sAlCdvn7AriNBpoYj2U5U0XrAsWcSSZdUMOG31O3E6Hzv1sxwmPXHW8+R0F
	 +E01FjEY2JGeWjcKy9df+AUFWTOXXhdll2h0EgnRSOdt2sCzwSaP8RVTQlnj3klh3L
	 FsMZeqNWzP692ePN36q739afPDxqcg5QhJ/t1smfhS/xKoooFap/+U2ZuCZILK9Evd
	 nTmThIB1eVISdwZrLKfJpXM5XAB9bklHQMYHACQtGDVyb+M+yM/uCA/qlg+rRqMGVP
	 V232cEJ19jsGNUJjyCd6ba50DBvcvev2CLGFOJ9Xj06jIjP/gdgJ8C1VBpLuBTFP+q
	 sqCzHjDoCEbXQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 02/11] NFSD: factor out nfsd_supports_nfs4_acl() to nfsd/acl.h
Date: Tue, 24 Feb 2026 14:24:29 -0500
Message-ID: <20260224192438.25351-3-snitzer@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19189-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: C6E4618C043
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
index 85e94c30285a..bd847db8b8b4 100644
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
index 07c48b74c559..e7793c53d214 100644
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


