Return-Path: <linux-nfs+bounces-14773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137C9BA9E45
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 17:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA903C1D6C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C6230C104;
	Mon, 29 Sep 2025 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO4towr5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470430C0EA
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161410; cv=none; b=AHDLRQiQ3EyFGlOPVVyFFRU/VGIeYTl39XchYHgHyB/+pMPWZQePAmpncHYi8aQCOE9AKZLhH0ASgxXPxJgsyjKhsDF9UwTUYy7Hw2M9A4OWyD/RUF14r8k3mYQjZt6SUz3tMvuoAAjprxv7GpNSuPWObbG7h15VtGytMo+yF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161410; c=relaxed/simple;
	bh=j4hUpPdyXfBmCRzj+Krec6A37iS/zH+Xw3gkvTL2s3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7sMTX7Luon2vAFCn2cRWGTsnBvO1Q9RZxEaANxEKuQ82bp51aweJLzChXFzb7/gqhgAtYD47Ezdw0b3rMY1ZtqKU9wbNPc0zMwQPCzZLins1N8JASur2AwmxSImmOqs8xP3MVPFxxe5wjgKmSAluGJCaViTwVsLIY1mUbWx5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO4towr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F143FC4CEF7;
	Mon, 29 Sep 2025 15:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161410;
	bh=j4hUpPdyXfBmCRzj+Krec6A37iS/zH+Xw3gkvTL2s3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AO4towr5vONsVG97R6hkpSSq6HLltk8XxXiqZ4if+YIRiNKJdH+BN2k+5sZFHKrZI
	 1p2DurRPsQqucQZN4Ia4B3bRiZBnRpEZvaGkpepaeQXDg/lDHziNtsUaK/hYj5tfx3
	 BtNTsmIrJSnvbZOmUuGJ4vNseBE6mTXDyirgL8DwUW6f/+zy7OuXVHNpF5ZncRULKR
	 vxu/Cdk0mYvPQsD+yozFnOxT9W+rcF6Vmrt2cgtzw3M27p/inC24Zz4+eAjTVXN5Gv
	 91/HggEQuAjaWB97VXK291QHwL9+HnnRdHYj35t/lpogcVxVSmLzKFuMGPxFFUDEIV
	 S919KaIAu7jIw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 3/6] NFSD: Relocate the xdr_reserve_space_vec() call site
Date: Mon, 29 Sep 2025 11:56:43 -0400
Message-ID: <20250929155646.4818-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929155646.4818-1-cel@kernel.org>
References: <20250929155646.4818-1-cel@kernel.org>
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
index 41f0d54d6e1b..3a5c7a0e2db8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4475,18 +4475,30 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
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


