Return-Path: <linux-nfs+bounces-2630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1138972BC
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 16:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5481C2040E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435173611A;
	Wed,  3 Apr 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbJu9JqE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9EB2F844
	for <linux-nfs@vger.kernel.org>; Wed,  3 Apr 2024 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154987; cv=none; b=OmXC9vApHzRdGIlkLYtac6nbhBoW4/GgrwhOu4EOPSJXEB1E1y3fo4RStKhPXHpeR1Zn2U8MCIR7LnMv59MrhsWgMcx7Rm2kM1jMqEe3ATWiBoF/xFJnRTfb3P9Gwoe+p+bar19xtKU2MtLdI1U3XYgu9eTx1dgLBhew5UgINtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154987; c=relaxed/simple;
	bh=WRcHj9sBw2jWFbMiUlBg5kQiVhGuHxyyjEgIChFpJH4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=WsVL4o4dThMleozpQ0oBi0b+9mPecdxpBaFKQxUxANixuPe/a2HcaZtBTfI/9z8Ccwow5XlIpY7pe3EDob9m7uweiT6rlkxx5W24pXU3vRZqkRhFqfr3kkdBe/EdYRmrSm0REfhIWz4CHhyAmfEhVSTV0gd0/X4GBVDe4TN4kj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbJu9JqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D58CC433C7;
	Wed,  3 Apr 2024 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712154986;
	bh=WRcHj9sBw2jWFbMiUlBg5kQiVhGuHxyyjEgIChFpJH4=;
	h=Subject:From:To:Cc:Date:From;
	b=bbJu9JqEntILeDBR6OEJdE9MHeoCYIF7m66cQS32ROSTO3zP3SE25Ep2G+zSjxo/N
	 KIEHub3kgF8f5uVXupywJXoRch1+OVTmo4KQ8rFVq5DSp3WP2jG0IsopE6Nx0StQ16
	 x80jf58zdXLGy2pWC5Q4zzOf+7sw99OCXDV0y2z+gBMyetCF7r5v9hymevGaziuCKz
	 heohsr4a3FMHF/uRj0h4u4dFCA3HWaWc18HWplxI0ANtwVMRbtMbeLluxTMWWAyqtc
	 Q93CnHzcmvD5RYpcoRXPMBqkgQwnO5MIeP7WnUAY1jArcu8pU0o1EnSKZZ1qfQEShQ
	 9PoOnMr4OKQfA==
Subject: [PATCH 2] SUNRPC: Fix a slow server-side memory leak with
 RPC-over-TCP
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jan Schunk <scpcom@gmx.de>, Alexander Duyck <alexander.duyck@gmail.com>,
 Jakub Kacinski <kuba@kernel.org>, David Howells <dhowells@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>
Date: Wed, 03 Apr 2024 10:36:25 -0400
Message-ID: 
 <171215477898.1643.12386933275741788356.stgit@klimt.1015granger.net>
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
record marker page fragment isn't one of those, so it is never
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
 net/sunrpc/svcsock.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

Changes since RFC:
- It's safe to release the fragment as soon as sock_sendmsg() returns
- Remove the now-stale documenting comment
- Deeper testing has been successful

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 545017a3daa4..6b3f01beb294 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1206,15 +1206,6 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
  * MSG_SPLICE_PAGES is used exclusively to reduce the number of
  * copy operations in this path. Therefore the caller must ensure
  * that the pages backing @xdr are unchanging.
- *
- * Note that the send is non-blocking. The caller has incremented
- * the reference count on each page backing the RPC message, and
- * the network layer will "put" these pages when transmission is
- * complete.
- *
- * This is safe for our RPC services because the memory backing
- * the head and tail components is never kmalloc'd. These always
- * come from pages in the svc_rqst::rq_pages array.
  */
 static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 			   rpc_fraghdr marker, unsigned int *sentp)
@@ -1244,6 +1235,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
 		      1 + count, sizeof(marker) + rqstp->rq_res.len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
+	page_frag_free(buf);
 	if (ret < 0)
 		return ret;
 	*sentp += ret;



