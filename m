Return-Path: <linux-nfs+bounces-6532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4097B2C8
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 18:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C07285E98
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5F17AE11;
	Tue, 17 Sep 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7sM2E/7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4045717DFF3
	for <linux-nfs@vger.kernel.org>; Tue, 17 Sep 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589725; cv=none; b=FZBS7xzmSLQTsXEGLurVcpeosYDn/9d8W5dDgPmZJ1ib7B95XP5avXtvBCmrQP2LSn986miKtZKnOLE/ROl19fPDH+csWchShZP4RXX1dXyYCH7XNm2MzXRKJwRDY+p1FbmLYRlkbJnZEpLMWN3qXot2qFdurj15mDvJzcgzGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589725; c=relaxed/simple;
	bh=RCBJeCfu8TUY3qa0vitq8eMplZ8sXuNIQbJ3eBBRoKs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxDYWVdvur6rL2TKrUuaX5ACgceiyi7Fgl7/pCtbZMJZRECl2BJRRfvKi2I/JXuW6d4FjU+vIzL7jdj0YJO41hDpWGrwi804hZT1827GqCWqQnup944bKyDksXnTCbxM4I0H69nYv7YBTIaK7NPrqfrMkiDS0SLwyf+O4kVykZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7sM2E/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D2EC4CEC5;
	Tue, 17 Sep 2024 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726589724;
	bh=RCBJeCfu8TUY3qa0vitq8eMplZ8sXuNIQbJ3eBBRoKs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=V7sM2E/7NM99uZnLTt8ZuTBK1tK4ln0Z+4rj+sUDPLCHy3M7hXJ3tOY3yQtARIhGr
	 tW89mqWH4FHD3jWWuEesjGSSswKjSLjo6yOY3f/ro15ZekPA2B3miQ3+oF/o0WN6UQ
	 627RVqGH4YtJ/7lS4Xf6eM/f+pG/1muyZnPsGPSZYS9NS1vnNaKdRsOFPeYf89KO+J
	 tqzoaCLlV1JwIPyde59xX/tlhpFnjdowg45SizZisIjmZlOUp1X7umX7UhJshmNFMA
	 cMqjesrWGsmhGZdNRfmoS1CHnRRn/K8B7qSR7UROOH2KTMaFipwvzqBdZ3mayLkoTe
	 hXOZ35p7O16TA==
Subject: [PATCH 1/2] NFSD: Prevent a potential integer overflow
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: dan.carpenter@linaro.org
Date: Tue, 17 Sep 2024 12:15:23 -0400
Message-ID: 
 <172658972371.2454.15715383792386404543.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
In-Reply-To: 
 <172658941960.2454.16533800561565430909.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
References: 
 <172658941960.2454.16533800561565430909.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

If the tag length is >= U32_MAX - 3 then the "length + 4" addition
can result in an integer overflow. Address this by splitting the
decoding into several steps so that decode_cb_compound4res() does
not have to perform arithmetic on the unsafe length value.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 43b8320c8255..dffb8fea3a31 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -311,17 +311,17 @@ static int decode_cb_compound4res(struct xdr_stream *xdr,
 	u32 length;
 	__be32 *p;
 
-	p = xdr_inline_decode(xdr, 4 + 4);
+	p = xdr_inline_decode(xdr, XDR_UNIT);
 	if (unlikely(p == NULL))
 		goto out_overflow;
-	hdr->status = be32_to_cpup(p++);
+	hdr->status = be32_to_cpup(p);
 	/* Ignore the tag */
-	length = be32_to_cpup(p++);
-	p = xdr_inline_decode(xdr, length + 4);
-	if (unlikely(p == NULL))
+	if (xdr_stream_decode_u32(xdr, &length) < 0)
+		goto out_overflow;
+	if (xdr_inline_decode(xdr, length) == NULL)
+		goto out_overflow;
+	if (xdr_stream_decode_u32(xdr, &hdr->nops) < 0)
 		goto out_overflow;
-	p += XDR_QUADLEN(length);
-	hdr->nops = be32_to_cpup(p);
 	return 0;
 out_overflow:
 	return -EIO;



