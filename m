Return-Path: <linux-nfs+bounces-8853-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAADD9FEBE4
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 01:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7517A1674
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 00:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6EDF59;
	Tue, 31 Dec 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4+L4Fuq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2FDDDC
	for <linux-nfs@vger.kernel.org>; Tue, 31 Dec 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735604951; cv=none; b=ZAT1ryHNpvPmoWVXKKXraS6bqCRsfucAXy/AugJpJYmZxn9Fk6RYvYkorIHM7pDzEGS8NHPlKTMHphiTLd04+CceOLkgnccPOd+6VWekHT+/Fg0Xo3HR3inHQxhsuG0vseii0xU95Y/JGPFukBw4QPsGfsRCn5Tlzk8t/gMmo0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735604951; c=relaxed/simple;
	bh=GTVzmyjVHGd/GZrLH23lLZR88MjBbXOX8m9pVYNp8eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGBg3tyN9KKxgjh7gRGuP5qw/ct/Kq0wYJ75+PbPJT72zrCCL2A0aAD+/HPC6/Qqik5Y0KHxPIqCgysdjb7JMxyqZM/V7BIczS+YXMDf/CAEObNZ17p325qhVmMeNrRo1JmcYnkTeY01d0ZjtyOm9MVkmWLvNyWrAUYK2wXqAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4+L4Fuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45DBC4CED7;
	Tue, 31 Dec 2024 00:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735604951;
	bh=GTVzmyjVHGd/GZrLH23lLZR88MjBbXOX8m9pVYNp8eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4+L4FuqDVN71I3QaIS4tr1C9MUV6VYbrmw90aPGS/+WRCvHv7hNBm3EBaUKhj5QY
	 jWpVkyxsmwqtacw2bXEIvEa39eUHwOu1YPgvOaYG5dS9DN7hogjnUm/rdbkBTPEQ3i
	 fpuh+S1WKAc/xAWfYvFXdegWRlt0yiUwwPI+f0vPRgCa7yI1qfswwja3/IUoecbaIO
	 /OiFSsxGfjK2t6FrwRL3ERHeK04VcEkDBVWWPp9iWWxifIGGSxyWjoBaIb57ODtdAz
	 lQutK6J4hUe7u1MGcrf/gh9oB882WP7S29qgiEZjBDKiaTKpQUvoCOWEDzRVekRmOf
	 E5yRDKjBjbIow==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>,
	j.david.lists@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 6/9] NFSD: Insulate nfsd4_encode_readlink() from page boundaries in the encode buffer
Date: Mon, 30 Dec 2024 19:28:57 -0500
Message-ID: <20241231002901.12725-7-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241231002901.12725-1-cel@kernel.org>
References: <20241231002901.12725-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

There's no guarantee that the pointer returned from
xdr_reserve_space() will still point to the correct reserved space
in the encode buffer after one or more intervening calls to
xdr_reserve_space(). It just happens to work with the current
implementation of xdr_reserve_space().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d4ee633b01e3..1afe5fe41f22 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4449,25 +4449,21 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr,
 		      union nfsd4_op_u *u)
 {
 	struct nfsd4_readlink *readlink = &u->readlink;
-	__be32 *p, *maxcount_p, zero = xdr_zero;
+	__be32 *p, wire_count, zero = xdr_zero;
 	struct xdr_stream *xdr = resp->xdr;
-	int length_offset = xdr->buf->len;
+	unsigned int length_offset;
 	int maxcount, status;
 
-	maxcount_p = xdr_reserve_space(xdr, XDR_UNIT);
-	if (!maxcount_p)
+	/* linktext4.count */
+	length_offset = xdr_stream_pos(xdr);
+	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT)))
 		return nfserr_resource;
-	maxcount = PAGE_SIZE;
 
+	/* linktext4.data */
+	maxcount = PAGE_SIZE;
 	p = xdr_reserve_space(xdr, maxcount);
 	if (!p)
 		return nfserr_resource;
-	/*
-	 * XXX: By default, vfs_readlink() will truncate symlinks if they
-	 * would overflow the buffer.  Is this kosher in NFSv4?  If not, one
-	 * easy fix is: if vfs_readlink() precisely fills the buffer, assume
-	 * that truncation occurred, and return NFS4ERR_RESOURCE.
-	 */
 	nfserr = nfsd_readlink(readlink->rl_rqstp, readlink->rl_fhp,
 						(char *)p, &maxcount);
 	if (nfserr == nfserr_isdir)
@@ -4480,7 +4476,9 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr,
 		nfserr = nfserrno(status);
 		goto out_err;
 	}
-	*maxcount_p = cpu_to_be32(maxcount);
+
+	wire_count = cpu_to_be32(maxcount);
+	write_bytes_to_xdr_buf(xdr->buf, length_offset, &wire_count, XDR_UNIT);
 	xdr_truncate_encode(xdr, length_offset + 4 + xdr_align_size(maxcount));
 	write_bytes_to_xdr_buf(xdr->buf, length_offset + 4 + maxcount, &zero,
 			       xdr_pad_size(maxcount));
-- 
2.47.0


