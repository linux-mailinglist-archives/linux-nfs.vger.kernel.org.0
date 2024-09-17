Return-Path: <linux-nfs+bounces-6533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9C97B2CA
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 18:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90371C21A9A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66F714AA9;
	Tue, 17 Sep 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJV5ldJB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255A17839C
	for <linux-nfs@vger.kernel.org>; Tue, 17 Sep 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589731; cv=none; b=Vc2iXFScAXYTDz6iXYLyDK/tCE9eVVVh/LMGcgzxcJdVerclYFeAA+pZTxZp+E159/1cXLyv68gfPJ2HvYEVaUgtJo96Rgx0MG0lI0SGD9izA+/XjRdYqo4oQ8OxVdwYMapu4LsUiDX/A1oNrBMumKeKLIiLWmru6M+NH4i9O+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589731; c=relaxed/simple;
	bh=wEHddu2w4/1Sq3ne8+XDN7KJUqNCQB7tF0sOsXQNCiI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddLgOtjs8Rp/Xasiir8U0u0pcuIg7p7AoNhaPYxnlFZCzu7b1Ye6Dg/nZsq7vPJj4ffhAa+iYa5ENn5TWI96XLKKEcwnv8lzT7RGR3azKfzIWf2n21EKFw1/p9apgVZgrrE71OUFcRvCTnNuzInOEl+Ml7XbBtFG5fRlY4NmogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJV5ldJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278AFC4CEC5;
	Tue, 17 Sep 2024 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726589730;
	bh=wEHddu2w4/1Sq3ne8+XDN7KJUqNCQB7tF0sOsXQNCiI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mJV5ldJBi9OXYiTIYD1O70sIj/64pe7unr+5qfZ/AaZaKlF2tx3qPSuQjgJcET+bj
	 jPZMb/fBTC/vfz6QcMx9gj+Mxu9hjrfZgG3yOSumjEn+FahVALx7yt+9RJhM1I68Zc
	 nhQcqNEvdaMwET0c9jcHj6WtbGEzyHIojoYzRjlbodQvKDF/Z+n2QATk5dxAwZq8h8
	 Kq5iLBeyg1tdLKBx70trCMKQ733F3rDNAGGcpJDRLAOzQjPsva9FY7+sYo+mRisHHG
	 R7Ak+ZpnbK7BkNRKofzYFFjse7ialn+poyWyEANI4ALMckOsmxSCC+hGaYVju2CyqK
	 joUd0t9MuLxtg==
Subject: [PATCH 2/2] svcrdma: Address an integer overflow
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: dan.carpenter@linaro.org
Date: Tue, 17 Sep 2024 12:15:29 -0400
Message-ID: 
 <172658972948.2454.1618005255141213668.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
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

Dan Carpenter reports:
> Commit 78147ca8b4a9 ("svcrdma: Add a "parsed chunk list" data
> structure") from Jun 22, 2020 (linux-next), leads to the following
> Smatch static checker warning:
>
> 	net/sunrpc/xprtrdma/svc_rdma_recvfrom.c:498 xdr_check_write_chunk()
> 	warn: potential user controlled sizeof overflow 'segcount * 4 * 4'
>
> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>    488 static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
>    489 {
>    490         u32 segcount;
>    491         __be32 *p;
>    492
>    493         if (xdr_stream_decode_u32(&rctxt->rc_stream, &segcount))
>                                                              ^^^^^^^^
>
>    494                 return false;
>    495
>    496         /* A bogus segcount causes this buffer overflow check to fail. */
>    497         p = xdr_inline_decode(&rctxt->rc_stream,
> --> 498                               segcount * rpcrdma_segment_maxsz * sizeof(*p));
>
>
> segcount is an untrusted u32.  On 32bit systems anything >= SIZE_MAX / 16 will
> have an integer overflow and some those values will be accepted by
> xdr_inline_decode().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 78147ca8b4a9 ("svcrdma: Add a "parsed chunk list" data structure")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index d72953f29258..037c037fab88 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -493,7 +493,13 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	if (xdr_stream_decode_u32(&rctxt->rc_stream, &segcount))
 		return false;
 
-	/* A bogus segcount causes this buffer overflow check to fail. */
+	/* Before trusting the segcount value enough to perform
+	 * computation with it, perform a simple range check. This
+	 * is an arbitrary but sensible limit (ie, not architectural).
+	 */
+	if (unlikely(segcount > RPCSVC_MAXPAGES))
+		return false;
+
 	p = xdr_inline_decode(&rctxt->rc_stream,
 			      segcount * rpcrdma_segment_maxsz * sizeof(*p));
 	return p != NULL;



