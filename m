Return-Path: <linux-nfs+bounces-11580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5DAAE378
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5143B1B17
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37C0289811;
	Wed,  7 May 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvXU7Rfc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADDA2153C9;
	Wed,  7 May 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629118; cv=none; b=t/0wgbWAb/LSiXmYtE3QpkdzQLfjHPDujsxPWcKqbKLfOjm3BlQD0bl9gQCEhoec6DEhkLkVhFZy6yqUGneUlX+Cb+Z6pCWDF5vmhODyq2U2N0fglcszMI8ssOgHLJ75e+JDE7LsuKc//AaTpWV7vLUAPv7xQZ3Ye8YrFxnht+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629118; c=relaxed/simple;
	bh=5/vox8SkxtP8WaAcZbuuT52799a84BSzW/YOX8NP9UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5ry3/s8v+iy1uypC4O0vguT6/a+ThF7471eP9udzG2+hujHgms24MK6RXaOQRO4QxKuC1aFAaT3xM7hv/+GrM3AthsrXJBMXQwFMHnjLhPBaN7C4e5yo+fOGXmuRenVZExT4XEhsOMSrb1t1WEoVIIFHvcuH1yXAOHkz4AK690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvXU7Rfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F4EC4CEE9;
	Wed,  7 May 2025 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746629118;
	bh=5/vox8SkxtP8WaAcZbuuT52799a84BSzW/YOX8NP9UU=;
	h=From:To:Cc:Subject:Date:From;
	b=GvXU7RfcmhJ5RxakNeznV6pxC+vKKr9PJ8JCQF6qpukh7T2xtOObuXkoXhb16L/IZ
	 Wij9sp+K9UDwHE5hw3QEbswO5XFVJTU/AaUAXm4H9NSaIj8fKRTdUXL/hKCvq0HdM5
	 7JNUdJkUZ2UiGD045dbRkD8jer+3ig7ltxepw0CRO6QXmwwM3+XpiOS1k+AfE7oQkw
	 U5IcV5omX5DTO84vhZyQP25S7zYExhGwZKTz9tnpXCSW8j2HRlgAqkvzMz4cocF8WK
	 mW41gXb+hMbExrTbIbxFiz5CJ1DCdC0yrBeFrFshV0Hu/v72WZif1DH3hejrTjuP/g
	 aUQoZOOv1cx5A==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Roland Mainz <roland.mainz@nrubsig.org>,
	Christoph Hellwig <hch@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH v3] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
Date: Wed,  7 May 2025 10:45:15 -0400
Message-ID: <20250507144515.6864-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 states that if an NFS server implements a CLONE operation,
it MUST also implement FATTR4_CLONE_BLKSIZE. NFSD implements CLONE,
but does not implement FATTR4_CLONE_BLKSIZE.

Note that in Section 12.2, RFC 7862 claims that
FATTR4_CLONE_BLKSIZE is RECOMMENDED, not REQUIRED. Likely this is
because a minor version is not permitted to add a REQUIRED
attribute. Confusing.

We assume this attribute reports a block size as a count of bytes,
as RFC 7862 does not specify a unit.

Reported-by: Roland Mainz <roland.mainz@nrubsig.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e67420729ecd..9eb8e5704622 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3391,6 +3391,23 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 	return nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
 }
 
+/*
+ * Copied from generic_remap_checks/generic_remap_file_range_prep.
+ *
+ * These generic functions use the file system's s_blocksize, but
+ * individual file systems aren't required to use
+ * generic_remap_file_range_prep. Until there is a mechanism for
+ * determining a particular file system's (or file's) clone block
+ * size, this is the best NFSD can do.
+ */
+static __be32 nfsd4_encode_fattr4_clone_blksize(struct xdr_stream *xdr,
+						const struct nfsd4_fattr_args *args)
+{
+	struct inode *inode = d_inode(args->dentry);
+
+	return nfsd4_encode_uint32_t(xdr, inode->i_sb->s_blocksize);
+}
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
 					    const struct nfsd4_fattr_args *args)
@@ -3545,7 +3562,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_MODE_SET_MASKED]	= nfsd4_encode_fattr4__noop,
 	[FATTR4_SUPPATTR_EXCLCREAT]	= nfsd4_encode_fattr4_suppattr_exclcreat,
 	[FATTR4_FS_CHARSET_CAP]		= nfsd4_encode_fattr4__noop,
-	[FATTR4_CLONE_BLKSIZE]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_CLONE_BLKSIZE]		= nfsd4_encode_fattr4_clone_blksize,
 	[FATTR4_SPACE_FREED]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_CHANGE_ATTR_TYPE]	= nfsd4_encode_fattr4__noop,
 
-- 
2.49.0


