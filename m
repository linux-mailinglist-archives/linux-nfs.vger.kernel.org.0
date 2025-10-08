Return-Path: <linux-nfs+bounces-15050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D40EBC5524
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 15:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8533D3E2E73
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D07288500;
	Wed,  8 Oct 2025 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuXxL565"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B02874F1
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931560; cv=none; b=eQTgwCapgqMXqIogYLUtLYaoErHlpzsb+Umtj51k8Sx8QuedXUzJINgwECLFYtTRDSliH+7ZmjStkmWUEjgwws7FmALtvwZq3quczAS0e7dYM6LksaDH2dc5U+70rAIVGoNsuA2F7TrD2DI8/HjRTxFSxIr9PHuYOfVOxiMa8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931560; c=relaxed/simple;
	bh=afdZz1ccrPGArylvdqUNMBewJVhta++3rUO5gJ7ErXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEOEaBjQHyL8yXG2e+vTHUAf8jBo6oZ8o8ea8IGQ7x+HtPH4OfgE8P8O6wuGIC4rks806dY+wbG6IC0KbeoKd7DeMQc9Br5tSPhBj32O0cPLH/FQdA/HP2t8piFPsGg05CSr7SFWttDWA3qWzwfhHrhVTRe0W2xnLLbwvH2YGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuXxL565; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE43C4CEF4;
	Wed,  8 Oct 2025 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759931560;
	bh=afdZz1ccrPGArylvdqUNMBewJVhta++3rUO5gJ7ErXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuXxL565kLvBdjMbD4gbmbdGzKwOgOQhi+bVN0Yc20zLc2NyquF4037XumFLm4fW8
	 wx3moqU7+aSyVOZXO9rK8UDo3oAs7iv8XIwUvoZI/6NKKlKZ4fjtF+0YqAaThGSwM2
	 4PchAw0GQfzVRLY6h7MThCBiSoiLE4vV2UlOJ2VBjK5ef227hoWlrr0o7ZbKDAxavy
	 C+CsyiBk8tvQOBveD5I0BUPIGCYFu5moeQnJUmW8+9eRJU5rWzJtMPLJbAv6DpNncC
	 J4mY5yamVRqj/ioNxZTQAYoSE3JR0yM+cy0duOdiGYfOZoi01eYR6MvglJF/3QY8To
	 xvvxoNmbUwU0Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v6 5/6] NFSD: Relocate the xdr_reserve_space_vec() call site
Date: Wed,  8 Oct 2025 09:52:29 -0400
Message-ID: <20251008135230.2629-6-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008135230.2629-1-cel@kernel.org>
References: <20251008135230.2629-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In order to detect when a direct READ is possible, we need the send
buffer's .page_len to be zero when there is nothing in the buffer's
.pages array yet.

However, when xdr_reserve_space_vec() extends the size of the
xdr_stream to accommodate a READ payload, it adds to the send
buffer's .page_len.

It should be safe to reserve the stream space /after/ the VFS read
operation completes. This is, for example, how an NFSv3 READ works:
the VFS read goes into the rq_bvec, and is then added to the send
xdr_stream later by svcxdr_encode_opaque_pages().

Now that xdr_reserve_space_vec() uses the number of bytes actually
read, the xdr_truncate_encode() call is no longer necessary.

Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index cd3251340b5c..f4a5e102b63a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4473,18 +4473,30 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	__be32 zero = xdr_zero;
 	__be32 nfserr;
 
-	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
-		return nfserr_resource;
-
 	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, read->rd_nf,
 				read->rd_offset, &maxcount, base,
 				&read->rd_eof);
 	read->rd_length = maxcount;
 	if (nfserr)
 		return nfserr;
+
+	/*
+	 * svcxdr_encode_opaque_pages() is not used here because
+	 * we don't want to encode subsequent results in this
+	 * COMPOUND into the xdr->buf's tail, but rather those
+	 * results should follow the NFS READ payload in the
+	 * buf's pages.
+	 */
+	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
+		return nfserr_resource;
+
+	/*
+	 * Mark the buffer location of the NFS READ payload so that
+	 * direct placement-capable transports send only the
+	 * payload bytes out-of-band.
+	 */
 	if (svc_encode_result_payload(resp->rqstp, starting_len, maxcount))
 		return nfserr_io;
-	xdr_truncate_encode(xdr, starting_len + xdr_align_size(maxcount));
 
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + maxcount, &zero,
 			       xdr_pad_size(maxcount));
-- 
2.51.0


