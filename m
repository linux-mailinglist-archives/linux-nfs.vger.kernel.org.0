Return-Path: <linux-nfs+bounces-2605-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B08B895CCE
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45425281145
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 19:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8603515B962;
	Tue,  2 Apr 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu/Ehmbq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0656458
	for <linux-nfs@vger.kernel.org>; Tue,  2 Apr 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086724; cv=none; b=gpaWRK/fvG9xL074PeMbekRnpgHGNKfVe9WkGULrsXgp8DPJpKYOOO/X0loU0jnSZidD5P1BPfvFyiiHNMWZemh5q1Bl399W3+RYANG6K4KKvb5Qrr8DtgOtQXe1iuK7YQmYSjRi2Rz2eDW1cjW/xWIJwi4K2HQO9SOPHkbl2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086724; c=relaxed/simple;
	bh=8ei3sMVHzU89xrTJg4MS9srEbYDxpJn7C8dSxsIhMfI=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=VxefU4LV0t7H8x4NTHjLeFzWOAsdBlLT1ENvI+TUCsB4EtD4C3wEHLiVjujEuQGnoGKXDTEk4eHl0I2SV4TDcq8NW+Jo1RO73NaQdkp6mqMzA3oJs96dhRYvWfHB+cyxGxLmZ0xcTxFR8E8XwU/l7BOXR2HmlKeEBe0LYmFSM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu/Ehmbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02B7C433F1;
	Tue,  2 Apr 2024 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086724;
	bh=8ei3sMVHzU89xrTJg4MS9srEbYDxpJn7C8dSxsIhMfI=;
	h=Subject:From:To:Cc:Date:From;
	b=Cu/EhmbqZ058XeU6hPNo98yZfDCl5QV2P+WhV3V+WgBCcQhIOhvfejNVoMLOXoKQW
	 MnBQYYxn/ybp1aZ9VRSdXOZFPvUNU9AC4+Sm20yacg9jlJ7IGTuCPcMMXqalI9fj88
	 YnK4aLBitmDz44lE/625HbHDnjBxidSMlv3GgskUSckv/tZAoQ8+2CF6z/0AHY8jLu
	 ZbIkxaBnjarN7hPvRN48/Uz9KfRWWDQEuWebWHbCnyEug+ElWA17XLg9dem9Xxdv7M
	 UykKrYx16sser/2F60k6gRJP/36d4U6HeAp+APjCejxg9FEcAlCXmvq2Gojc4h2obr
	 8pygn700Ii32g==
Subject: [PATCH RFC] SUNRPC: Fix a slow server-side memory leak with
 RPC-over-TCP
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jan Schunk <scpcom@gmx.de>, Alexander Duyck <alexander.duyck@gmail.com>,
 Jakub Kacinski <kuba@kernel.org>, David Howells <dhowells@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 02 Apr 2024 15:38:42 -0400
Message-ID: 
 <171208672277.1654.1052289246945629541.stgit@klimt.1015granger.net>
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

Jan Schunk reports that his small NFS servers suffer from memory
exhaustion after just a few days. A bisect shows that commit
e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single
sock_sendmsg() call") is the first bad commit.

That commit assumed that sock_sendmsg() releases all the pages in
the underlying bio_vec array, but the reality is that it doesn't.
svc_xprt_release() releases the rqst's response pages, but the
record marker page fragment isn't one of those, so it was never
released.

This is a narrow fix that can be applied to stable kernels. A
more extensive fix is in the works.

Reported-by: Jan Schunk <scpcom@gmx.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218671
Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call")
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kacinski <kuba@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 545017a3daa4..be6c6ee85c8f 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -130,6 +130,8 @@ static void svc_reclassify_socket(struct socket *sock)
  */
 static void svc_tcp_release_ctxt(struct svc_xprt *xprt, void *ctxt)
 {
+	if (ctxt)
+		page_frag_free(ctxt);
 }
 
 /**
@@ -1237,6 +1239,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 		return -ENOMEM;
 	memcpy(buf, &marker, sizeof(marker));
 	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
+	rqstp->rq_xprt_ctxt = buf;
 
 	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1,
 				ARRAY_SIZE(rqstp->rq_bvec) - 1, &rqstp->rq_res);



