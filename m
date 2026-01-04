Return-Path: <linux-nfs+bounces-17438-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3841ECF11F2
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 814FB300E140
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322DA26F291;
	Sun,  4 Jan 2026 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETXk3Vtu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BE26E6F4
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543026; cv=none; b=iGeLuzKs9D8O6nFKYIPj/fx1mxokNSOaCmjva3luJ++8Xr2xyltuvh8qp2g5yw9HGDCUGXe8GW9bTHqOzBHEqdvAk/u9+YH0kdJVYmttUcO5/n9ev62QV0X67JzTjEkb1IGrrNDHxQpU35/g9pnsokmSmjjwAt3yFGmFOsUdKYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543026; c=relaxed/simple;
	bh=394FQS1GzkKsWj6KStwgxd5Qjw5K6ICG0ycORtSNlK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2T3RBkhpuPT2arOQsTMVaYnFxm2ddPq6rH95wITwVY3XjV7/rA5h/WRwdeyYIAjmohv6nqYkrz9M7htIhj1rnUgtSwNeF7Oa2dyzc3i2Wdnae9BMnzpJIJ3rgHBEci9b2o2bgJw7EBSoO6RruYLQlESKXDJo9rmTVETsYE2SvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETXk3Vtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F693C4CEF7;
	Sun,  4 Jan 2026 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543025;
	bh=394FQS1GzkKsWj6KStwgxd5Qjw5K6ICG0ycORtSNlK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETXk3Vtu1vp9kCOvHu7EJ8yn0YeZX9zk1RXLtAxRZa+LUQJoVwa13KB4zrMkgaGqa
	 pSBcrX1WXSZbcMOzO1fEPEQ6HgbhUt/7vitIZAVWzfxOIVtV/PKukCTHuzC469zDp3
	 CFZeP63A1zdCV/VwiMBoWUKg6QLNpZVmFUyFqvWMjGVlCteLu4iy3IiToi4DpETH9g
	 6rKTlL9j1yqn+ifq9r88KNgX6AV/8h741DACqEJLcISZK5ZQboCUO4wGjP0FA/7vS3
	 xOAna82Nnai/JxhC1f/cfpb67cononUOnZ529J1Q9E6OdvwE7zgegJcmmjCUWMNGLh
	 /dqy8d88jhBIA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 04/12] NFSD: Add nfsd4_encode_fattr4_acl_trueform_scope
Date: Sun,  4 Jan 2026 11:10:14 -0500
Message-ID: <20260104161019.3404489-5-cel@kernel.org>
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

The FATTR4_ACL_TRUEFORM_SCOPE attribute indicates the granularity at
which the ACL model can vary: per file object, per file system, or
uniformly across the entire server.

In Linux, the ACL model is determined by the SB_POSIXACL superblock
flag, which applies uniformly to all files within a file system.
Different exported file systems can have different ACL models, but
individual files cannot differ from their containing file system.
ACL_SCOPE_FILE_SYSTEM accurately reflects this behavior.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9b47cf17ddde..63295cff23ed 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3484,6 +3484,14 @@ static __be32 nfsd4_encode_fattr4_acl_trueform(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_acl_trueform_scope(struct xdr_stream *xdr,
+						     const struct nfsd4_fattr_args *args)
+{
+	if (!xdrgen_encode_aclscope4(xdr, ACL_SCOPE_FILE_SYSTEM))
+		return nfserr_resource;
+	return nfs_ok;
+}
+
 #endif /* CONFIG_NFSD_V4_POSIX_ACLS */
 
 static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
@@ -3596,8 +3604,10 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 
 #ifdef CONFIG_NFSD_V4_POSIX_ACLS
 	[FATTR4_ACL_TRUEFORM]		= nfsd4_encode_fattr4_acl_trueform,
+	[FATTR4_ACL_TRUEFORM_SCOPE]	= nfsd4_encode_fattr4_acl_trueform_scope,
 #else
 	[FATTR4_ACL_TRUEFORM]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_ACL_TRUEFORM_SCOPE]	= nfsd4_encode_fattr4__noop,
 #endif
 };
 
-- 
2.52.0


