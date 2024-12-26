Return-Path: <linux-nfs+bounces-8789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A69FCBE4
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 17:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F8188310F
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006186252;
	Thu, 26 Dec 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXehzuBv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6194C74
	for <linux-nfs@vger.kernel.org>; Thu, 26 Dec 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735230542; cv=none; b=p+1ygi2t+SmPRNqqzZqiJMZwzlTkn7aEE4Y2IL8d4QxXutdOun6IaygZXSNwKVvVVUEKpQ06lpaEydUdkEkZhQqPJ7RyEutzv6RxE3jBhaRLtFIb+ppu5AYK2O2J//P+GM+FOYYIau55s96fzIN5enRSGTt8+12wqCRAv/W2bV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735230542; c=relaxed/simple;
	bh=t0dHrzz6nCVz5GdSMqgBuHRQMV2JCKRfQ1sMFljOO0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT90xdOSzSn0jgY9qG4XoM0ydespl1uRAAXH4NHeDX+21d4e3QWyQwkf5opsXAqITwO7dxbPwK8A1T3L2COrXJZL2EP7zV7wC3jfz/GEhwfRp41X9wzsZHAHC21Teqst6oOsiGDT+VXNbATsTRzCl+8QtTTL93gZsRMdfGAJdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXehzuBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B916AC4CED2;
	Thu, 26 Dec 2024 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735230541;
	bh=t0dHrzz6nCVz5GdSMqgBuHRQMV2JCKRfQ1sMFljOO0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXehzuBvdXq+J75qVZ+hz+i1s8xeE2lXnHVW5/6uld7ffiV/N9b2BTQwyJmJmZnkq
	 XrxdU9ZVVFvDSj9e8bqCgvMRKvIkKrzw1sFdvnseDNOfaHCXPh+6m6IDY15WkC7ZMo
	 zzW0czbjgcdWYHA5TcBKV34Qx0MrYnuQ55JkXLiKtbDgPiA9n+0oOwaG6xyektcko4
	 N3xGWf6IUFImAON0084nK34KSs6u5aWMCmrxaZkChckgqw9uQT/YhbTGdZgV6w5Fm6
	 mNXyVMfWZuOEO9EreBMQcS4w5QIVtDVXTvJaQer5MJPSJUK+32ihN969AqMD8aoeiD
	 niL0jp5SsFSVA==
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
Subject: [PATCH v3 5/6] NFSD: Insulate nfsd4_encode_fattr4() from page boundaries in the encode buffer
Date: Thu, 26 Dec 2024 11:28:52 -0500
Message-ID: <20241226162853.8940-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241226162853.8940-1-cel@kernel.org>
References: <20241226162853.8940-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Commit ab04de60ae1c ("NFSD: Optimize nfsd4_encode_fattr()") replaced
the use of write_bytes_to_xdr_buf() because it's expensive and the
data items to be encoded are already properly aligned.

However, there's no guarantee that the pointer returned from
xdr_reserve_space() will still point to the correct reserved space
in the encode buffer after one or more intervening calls to
xdr_reserve_space(). It just happens to work with the current
implementation of xdr_reserve_space().

This commit effectively reverts the optimization.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b770225d63dc..d4ee633b01e3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3506,8 +3506,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	struct nfsd4_fattr_args args;
 	struct svc_fh *tempfh = NULL;
 	int starting_len = xdr->buf->len;
-	__be32 *attrlen_p, status;
-	int attrlen_offset;
+	unsigned int attrlen_offset;
+	__be32 attrlen, status;
 	u32 attrmask[3];
 	int err;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
@@ -3627,9 +3627,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		goto out;
 
 	/* attr_vals */
-	attrlen_offset = xdr->buf->len;
-	attrlen_p = xdr_reserve_space(xdr, XDR_UNIT);
-	if (!attrlen_p)
+	attrlen_offset = xdr_stream_pos(xdr);
+	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT)))
 		goto out_resource;
 	bitmap_from_arr32(attr_bitmap, attrmask,
 			  ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
@@ -3639,7 +3638,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (status != nfs_ok)
 			goto out;
 	}
-	*attrlen_p = cpu_to_be32(xdr->buf->len - attrlen_offset - XDR_UNIT);
+	attrlen = cpu_to_be32(xdr_stream_pos(xdr) - attrlen_offset - XDR_UNIT);
+	write_bytes_to_xdr_buf(xdr->buf, attrlen_offset, &attrlen, XDR_UNIT);
 	status = nfs_ok;
 
 out:
-- 
2.47.0


