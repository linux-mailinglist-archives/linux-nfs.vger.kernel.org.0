Return-Path: <linux-nfs+bounces-12592-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF1AE1AD0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 14:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854625A3091
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF5828DF39;
	Fri, 20 Jun 2025 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKHOTJc8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AD28DF2D;
	Fri, 20 Jun 2025 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421790; cv=none; b=KRfHmi0hwJK2pbi9UeHjkO8Gc3lAvpqrAUuUvEc9AEwGoXiw77cBPplpWDGTRBH5vOaMOimRtaHBBWw8kU9j9h4D7JDYFzUYttBugh4uvAlxx07kX+Lbpg8K0n48Epy9V/IbUrRTsXFtk1fkf1kjL/qLZNw3yxQpli+UrXzgFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421790; c=relaxed/simple;
	bh=pWP3awNGNqNzs2Jc1fgQrbrmUVdGOnDCHnAUtdTgQA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NMUZbcnCR/Ssdt0BaXJMTuYdnqCu++/T/VUoXv3gL46c1ggWObPCDzQYkGZzBIHd+nEXH/PY9f1o93t+KVBJ4PLvG2nZfZHBy8P9RFCnWDyoZTlSvFYm7HeeZTK507hFriBqpFE0DT0uxYX660D4ZfYMoYec3R0bz+To/YrBUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKHOTJc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1601CC4CEF1;
	Fri, 20 Jun 2025 12:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750421789;
	bh=pWP3awNGNqNzs2Jc1fgQrbrmUVdGOnDCHnAUtdTgQA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JKHOTJc8pZ6wYgeTmlP247h3ltTbC124gHeAL8gUoXYSMzzATq45slvZa3dqukAuy
	 lE1I87Taj9TMorFZjBvZhDA950iXrmEiGuNg/kyInjL/5G8K7pk4pFPMZ6ETX+/v82
	 kB6gsHuovsCDgRdIYmVjBcHjEK8tCEYzll+jcmX5zI+vxtnY/RpI8eMCm4ZoPMy1BU
	 ehFm3Ost23xvR3p4IgLyCGrLL0PjOxttRLpuxbLYGb7COYTaYUwQLU6SKi3eRP51oo
	 mqmXSsKUpy8m/1Rl3/yfnjGridLvqM0dDojOLZulFB3I7452vgGsU0AJGQV1XmBkWA
	 4ebdbDI0Fzm4Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 20 Jun 2025 08:16:06 -0400
Subject: [PATCH 6/6] sunrpc: make svc_tcp_sendmsg() take a signed sentp
 pointer
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-rpc-6-17-v1-6-a309177d713b@kernel.org>
References: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
In-Reply-To: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pWP3awNGNqNzs2Jc1fgQrbrmUVdGOnDCHnAUtdTgQA4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoVVEWkIR8ZjAdi3/ACXz3eHnVV+XOTwjHzUWKN
 5oRJsT59DiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFVRFgAKCRAADmhBGVaC
 FT1/EACfBu4ZnoPCGgD/wNFboovwWST2gmiiPQ6QfDvfGt48wbXxqlbUPz0FyS3VBfr0bxML8V3
 RUS3oe5jW0UjLbHHwM6HJrgWlz6pua2O1sLuyAH+sSYhySKp/7kXBMiOpc5kIVQ49mLDlTLvOPV
 eEvCJfeBjTFjFAlCeuqx0T8Y/iJC3I0BZ/wi03v3bkTyX2PRfbrXo+V+wJt4ibafgpXx7+4B8rs
 eb747i/qLStDXDYXaAr7KmTxGdNo7oLo1JUhK/YM5URtESoNjPN5Ez56zM0LpVnpuwFzMj8Tgu2
 3Vc+Kyqxml3VDKl7NL/8tjGqQqv0TZoevLZFk1IpmYczTNQhUMPdf7t3kzrXnvSyMi5NOjeAWvU
 Q4mWschx5Ltux+1kIgUwnOuwF+imFa1UjH0DEc528KoWgjFQxlxVMebIFD6/5k5c5kXRp0osUZb
 5dPA8NFfHMdVfBlvcT7/TDleisDHUlXHHOIk6OPC60nia2vuLoLyuxlg6Hb8g6zFPYbjFiLNbsX
 Joel5d35ifTr6pRZ33ytmZpcBITroMqMeIG2kEEBnZU92PRsmn9t8IvndmzT4Je+09zDn18XaJL
 DT9+1uG+cTjB5r0CV3sfcoZpv7Av6WjT616iq8DAysfW5PWZ+9255jzVoT7DabrigpVujF29HlU
 OujS26nJ0YIsZbw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The return value of sock_sendmsg() is signed, and svc_tcp_sendto() wants
a signed value to return.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svcsock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e1c85123b445bf387e09565c025d8dd815187a07..46c156b121db43c1bd1806a08a3a9bf08b332699 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1197,7 +1197,7 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
  * that the pages backing @xdr are unchanging.
  */
 static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
-			   rpc_fraghdr marker, unsigned int *sentp)
+			   rpc_fraghdr marker, int *sentp)
 {
 	struct msghdr msg = {
 		.msg_flags	= MSG_SPLICE_PAGES,
@@ -1247,8 +1247,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	struct xdr_buf *xdr = &rqstp->rq_res;
 	rpc_fraghdr marker = cpu_to_be32(RPC_LAST_STREAM_FRAGMENT |
 					 (u32)xdr->len);
-	unsigned int sent;
-	int err;
+	int sent, err;
 
 	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
 	rqstp->rq_xprt_ctxt = NULL;

-- 
2.49.0


