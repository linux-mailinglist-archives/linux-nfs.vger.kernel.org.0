Return-Path: <linux-nfs+bounces-14696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E65B9BC5F
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 21:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93C6326930
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 19:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2782417E6;
	Wed, 24 Sep 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0erk3l5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926521CA03
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743491; cv=none; b=O08yNPffdCARhin8Lz9uRpG9Ckxokq8guCyW7+2dQYxZj5oKsVKFGTniOjbJXHkDAv2HkwuGFtF4wD3JTsYXhHle7mSH/MjSN/m9oRtOd93aKu9QyLervwzeFXeBjHJJ7lxtoXEQCX8kQI47sXlSkX59rSxOVZshnEbat7oxJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743491; c=relaxed/simple;
	bh=T0tn7/6OehIrXb8/LtFz8KxU19eIHJKAYAUkWLkpqb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fb2iDA2n6OyVnCNUaj48ECcB2iGIlmAaoB5gk3P70x00iR5RMz1Sh5Qq6w8qXqILc6pAOVzuYpTu3vbli3nkDUkKbMED2xHPwbCP//bCDEYdpg59SruiBvAdVR+wzrY3cOKPj6vypK3sGCqgy3z2q2lI51O4d6j2AE+B3+68vFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0erk3l5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98721C4CEE7;
	Wed, 24 Sep 2025 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758743490;
	bh=T0tn7/6OehIrXb8/LtFz8KxU19eIHJKAYAUkWLkpqb8=;
	h=From:To:Cc:Subject:Date:From;
	b=N0erk3l5X9G7YVdlzggOfH/PeFoSRtazRPX3f/QKB7ajtHbOZvs+cwlGDeJvxGeWW
	 EcBbE+I2912+bnoFDsCYgRYeNfOoI1UG1FATXUpRojTEtPUAGVcNOO4ZUc2YP4C72v
	 fo0szn9ZvaUlZwLRHD7HlLYDV0ToyXUGMUV0h+Ze7evMwepYmThF8lG2UIMyZlvirb
	 KF8vm/Gc5qVeP7X9ZiWjkJdBt4nYTG2oeSzion1BWPWW2BmRqQjVfaiLulChNiQ08/
	 zWiq4+BiyKlBRRhVzdkY0cTGuyVI38EHmmF4bkH6TXgmUTJtlBWZB608cW7HGJMfze
	 PNVdUphg02gWA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] NFSD: Relocate the xdr_reserve_space_vec() call site
Date: Wed, 24 Sep 2025 15:51:28 -0400
Message-ID: <20250924195128.2002-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
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

Nit: we could probably get rid of the xdr_truncate_encode(), now
that maxcount reflects the actual count of bytes returned by the
file system.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

Here's a brain-dead idea.


diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 41f0d54d6e1b..e3efc7d24aa5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4475,19 +4475,32 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
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
 
+	xdr_truncate_encode(xdr, starting_len + xdr_align_size(maxcount));
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + maxcount, &zero,
 			       xdr_pad_size(maxcount));
 	return nfs_ok;
-- 
2.51.0


