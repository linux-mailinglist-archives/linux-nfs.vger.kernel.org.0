Return-Path: <linux-nfs+bounces-17699-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E675BD0B424
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED51E306FADD
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0DC36165A;
	Fri,  9 Jan 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT4iWSre"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7B272803
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975713; cv=none; b=uUdRgSe2KTGY4OwuFP6u9yvcu7CSyTAhEYg/DYxkq59zHRuvyQzF1PO7dXIUJgf+emf0QaPvG5jc9/1WR1/RN7eoV1hKj0ae9VBW8BEQjRgTp4grww1k6ALNyxLNjqoJk4ZkJT1hNnvH6y4eKAaAbZ+XBYfXDJj4zOWZzehBM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975713; c=relaxed/simple;
	bh=Ux8zpFkbHVyqSsBWlPDwjcViTpQMwJ3k3uRZQMOz0IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBgOPutCk8ZLE5g9fuNzLUD8XIvLiVChFl1HIfjgvaIA3e0yRk8JS5p6PenOO6tFSyDGYKnKCEt+oSRLFf3tkCu3YA5wrXaLN36JFgwL3eAOOAryiGX1sFvDCSmiYbgErX6s5RrUst2KoglNP1/m7WTK7M/JdZiLTM9mSIa8wM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT4iWSre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAB9C4CEF7;
	Fri,  9 Jan 2026 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975713;
	bh=Ux8zpFkbHVyqSsBWlPDwjcViTpQMwJ3k3uRZQMOz0IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZT4iWSre0yDp42kDAD2Ko40XHq6/lku9bq3bVCtCLcytP+rM4U5/sX4urz7E3EWLd
	 2g1BduhYNkptOwp425z/73dprscvZC1C4iGNJD1m7fyeJ10TMAvf04fDtISBNbrQun
	 sh2r0g616IKUU0qSO9pz7GWGJIRbgE/cx+klm6wMLzczF31CROelUIl2K5bu25xnRv
	 KKQqNBM1eeSWQ2f3AMf/mRsXxjkQ90+rQ7YT4mvIr3Agyw11GEooZQw+FMsb5zKMlU
	 NqjhUPqovkw7kX8HsPUlWgYJDRCyKuVAuma8Akq7KlElizm07UBPbatHBbd9m26ozt
	 uk0+GhM4BUwHg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v3 05/13] NFSD: Add nfsd4_encode_fattr4_acl_trueform_scope
Date: Fri,  9 Jan 2026 11:21:34 -0500
Message-ID: <20260109162143.4186112-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109162143.4186112-1-cel@kernel.org>
References: <20260109162143.4186112-1-cel@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


