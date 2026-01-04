Return-Path: <linux-nfs+bounces-17440-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC5CF11EF
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02D3A3007228
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD278126F0A;
	Sun,  4 Jan 2026 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apm8Tvcm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E14400
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543027; cv=none; b=XocqpO169dTgFaPNy+oKwBcp7S/6oDoNRVHBZnVv98Ip7m4n3guEoXU3kcH/SQRfIlXQAfG46rlXIIjw4PTJzFp0he9+XflaQOpkiiZsIpepsJjLCu9NZjFBLclRkVE2gJLrZsISJtnZxVPD4Xi6MZ0iaFRshdfdS+AcVQ86Gww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543027; c=relaxed/simple;
	bh=QSyeToJc6+vTWcPxN5p5Z4D5Ia3GysZRaLNEK9IjdhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+NFDU44eESx+4lGcUelH6KQKxm2jBsh01ggb25pJcswWOQ7Wf5akSWoaVtI7aUHO55yJN5+3Lh/AePJidNRFqP5mGgoxLmGiC5k9Yaq/gD/+7rLPa0bLPkoBD4JeJWRc9wwfHjOvPW3p2t2NFQZy8AQlAvn6CoPTINwBdQNN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apm8Tvcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982A9C4CEF7;
	Sun,  4 Jan 2026 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543027;
	bh=QSyeToJc6+vTWcPxN5p5Z4D5Ia3GysZRaLNEK9IjdhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Apm8Tvcmt6qhaSBNd5EKE0z6UHOl9ecdwisnvoc2XTXrozZwR0KQgtSwcMNdtpWln
	 wIFpQaB5kk+moO/vB+EvlOvY5+X5zWgoCsR7F5rDwNcY3po4CRoby7mq5MjKQ0mArL
	 rh4obqsLBpRsN1IO7UlEfFiQJqO21ypDRY6oMN8QSJPt5qTxEdf/cTaW/QPBoDo2gp
	 OIMiaHCU27PpbpMRqLNlWfFSPmqB/UMYqazcOZzHfBIYjNAe2w/BY53SwxplGHYMEz
	 45t8T7aSrqjvrTsThKqglBDp/DhpOH1u2V6G3UWi3KKDJjeJopNx5aBOAfS3LXBEJr
	 yeABQzMGQtXJw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 06/12] NFSD: Add nfsd4_encode_fattr4_posix_access_acl
Date: Sun,  4 Jan 2026 11:10:16 -0500
Message-ID: <20260104161019.3404489-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104161019.3404489-1-cel@kernel.org>
References: <20260104161019.3404489-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

The POSIX ACL extension to NFSv4 defines FATTR4_POSIX_ACCESS_ACL
for retrieving the access ACL of a file or directory. This patch
adds the XDR encoder for that attribute.

The access ACL is retrieved via get_inode_acl(). If the filesystem
provides no explicit access ACL, one is synthesized from the file
mode via posix_acl_from_mode(). Each entry is encoded as a
posixace4: tag type, permission bits, and principal name (empty
for structural entries, resolved via idmapping for USER/GROUP
entries).

Unlike the default ACL encoder which applies only to directories,
this encoder handles all inode types and ensures an access ACL is
always available through mode-based synthesis when needed.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 781f662d8918..358fa014be15 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3016,6 +3016,7 @@ struct nfsd4_fattr_args {
 #endif
 #ifdef CONFIG_NFSD_V4_POSIX_ACLS
 	struct posix_acl	*dpacl;
+	struct posix_acl	*pacl;
 #endif
 	u32			rdattr_err;
 	bool			contextsupport;
@@ -3585,6 +3586,12 @@ static __be32 nfsd4_encode_fattr4_posix_default_acl(struct xdr_stream *xdr,
 	return nfsd4_encode_posixacl(xdr, args->rqstp, args->dpacl);
 }
 
+static __be32 nfsd4_encode_fattr4_posix_access_acl(struct xdr_stream *xdr,
+						   const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_posixacl(xdr, args->rqstp, args->pacl);
+}
+
 #endif /* CONFIG_NFSD_V4_POSIX_ACLS */
 
 static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
@@ -3699,10 +3706,12 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_ACL_TRUEFORM]		= nfsd4_encode_fattr4_acl_trueform,
 	[FATTR4_ACL_TRUEFORM_SCOPE]	= nfsd4_encode_fattr4_acl_trueform_scope,
 	[FATTR4_POSIX_DEFAULT_ACL]	= nfsd4_encode_fattr4_posix_default_acl,
+	[FATTR4_POSIX_ACCESS_ACL]	= nfsd4_encode_fattr4_posix_access_acl,
 #else
 	[FATTR4_ACL_TRUEFORM]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_ACL_TRUEFORM_SCOPE]	= nfsd4_encode_fattr4__noop,
 	[FATTR4_POSIX_DEFAULT_ACL]	= nfsd4_encode_fattr4__noop,
+	[FATTR4_POSIX_ACCESS_ACL]	= nfsd4_encode_fattr4__noop,
 #endif
 };
 
@@ -3746,6 +3755,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 #endif
 #ifdef CONFIG_NFSD_V4_POSIX_ACLS
 	args.dpacl = NULL;
+	args.pacl = NULL;
 #endif
 
 	/*
@@ -3877,6 +3887,29 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 			}
 		}
 	}
+	if (attrmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL) {
+		struct inode *inode = d_inode(dentry);
+		struct posix_acl *pacl;
+
+		pacl = get_inode_acl(inode, ACL_TYPE_ACCESS);
+		if (!pacl)
+			pacl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
+		if (IS_ERR(pacl)) {
+			switch (PTR_ERR(pacl)) {
+			case -EOPNOTSUPP:
+				attrmask[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
+				break;
+			case -EINVAL:
+				status = nfserr_attrnotsupp;
+				goto out;
+			default:
+				err = PTR_ERR(pacl);
+				goto out_nfserr;
+			}
+		} else {
+			args.pacl = pacl;
+		}
+	}
 #endif /* CONFIG_NFSD_V4_POSIX_ACLS */
 
 	/* attrmask */
@@ -3905,6 +3938,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 #ifdef CONFIG_NFSD_V4_POSIX_ACLS
 	if (args.dpacl)
 		posix_acl_release(args.dpacl);
+	if (args.pacl)
+		posix_acl_release(args.pacl);
 #endif /* CONFIG_NFSD_V4_POSIX_ACLS */
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 	if (args.context.context)
-- 
2.52.0


