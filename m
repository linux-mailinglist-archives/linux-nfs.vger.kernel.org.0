Return-Path: <linux-nfs+bounces-8889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20ECA0022F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 02:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C80A3A3959
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 01:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5C153838;
	Fri,  3 Jan 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOgpjnRq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDF214F9F4
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735866006; cv=none; b=cwm0sbN5Gqa1cBb/fYPRtwZMvp4W0QDBjTWJClMp2GxC3PFeWo+2TcBwuDcL3/bamcb1n3ZRPEqzWvejqL2bFEgZMtYQ7SBgRkHlAdiwcDvY5zT/dYuInutCRVlXnT7M4bfmmqhcUUdWVa3sxitl8yrS7GiymNch3qAZaV2in4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735866006; c=relaxed/simple;
	bh=NigUHel74W5sekzb/UR6jksqqUz4wIYjTPl2MGxnXvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjhAZAKTgBauH2UtBGOcxHSozpQTU8fIbgED5+srNBAg2erHYKZBtXFwbFBV9bYRHkKkngf4JAfH5VUS5l7rHqoKTOBc2VTu/kZtsyBhOg5bImjysdrJVFYr/FO2ot6ApVDGbXD2p2u++XATpdVxdnNa1kwUMTs/yKCYUMXU7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOgpjnRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDFBC4CED0;
	Fri,  3 Jan 2025 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735866005;
	bh=NigUHel74W5sekzb/UR6jksqqUz4wIYjTPl2MGxnXvw=;
	h=From:To:Cc:Subject:Date:From;
	b=MOgpjnRq2gUz6yGtxnTOQmsuw4wnEZtoCIEG4eHGqX98tkVdmBhUIKO8i8YwTbJOB
	 erNvg0ktjE79CaVoq+E3Ef75JmFMtWGD9H7qPb3xjiC7aa3GNJON19OJ9R8yHRBElW
	 C/2Uuvl4QvMFwpqHBkWIbOeRH+6A25Jp4RQqlGaZDMPCIqVK8uGQhtKtteXg0ChFYg
	 80AY0mrCCQ10LoBQvKksJt/bh5aYbQyl5+3ACE+fAoDyYG+U41gHk1ztpgZwgMpjMt
	 SB0PUhaepxTjJiiAEEuC3Hp4o3+kQsd/xCup4Aig/WRJYV1ibIFdnKCK9UifP46d69
	 +7bQIC/USEB/g==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v1 1/2] Revert "SUNRPC: Reduce thread wake-up rate when receiving large RPC messages"
Date: Thu,  2 Jan 2025 20:00:01 -0500
Message-ID: <20250103010002.619062-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I noticed that a handful of NFSv3 fstests were taking an
unexpectedly long time to run. Troubleshooting showed that the
server's TCP window closed and never re-opened, which caused the
client to trigger an RPC retransmit timeout after 180 seconds.

The client's recovery action was to establish a fresh connection
and retransmit the timed-out requests. This worked, but it adds a
long delay.

I tracked the problem to the commit that attempted to reduce the
rate at which the network layer delivers TCP socket data_ready
callbacks. Under most circumstances this change worked as expected,
but for NFSv3, which has no session or other type of throttling, it
can overwhelm the receiver on occasion.

I'm sure I could tweak the lowat settings, but the small benefit
doesn't seem worth the bother. Just revert it.

Fixes: 2b877fc53e97 ("SUNRPC: Reduce thread wake-up rate when receiving large RPC messages")
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 95397677673b..cb3bd12f5818 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1083,9 +1083,6 @@ static void svc_tcp_fragment_received(struct svc_sock *svsk)
 	/* If we have more data, signal svc_xprt_enqueue() to try again */
 	svsk->sk_tcplen = 0;
 	svsk->sk_marker = xdr_zero;
-
-	smp_wmb();
-	tcp_set_rcvlowat(svsk->sk_sk, 1);
 }
 
 /**
@@ -1175,17 +1172,10 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		goto err_delete;
 	if (len == want)
 		svc_tcp_fragment_received(svsk);
-	else {
-		/* Avoid more ->sk_data_ready() calls until the rest
-		 * of the message has arrived. This reduces service
-		 * thread wake-ups on large incoming messages. */
-		tcp_set_rcvlowat(svsk->sk_sk,
-				 svc_sock_reclen(svsk) - svsk->sk_tcplen);
-
+	else
 		trace_svcsock_tcp_recv_short(&svsk->sk_xprt,
 				svc_sock_reclen(svsk),
 				svsk->sk_tcplen - sizeof(rpc_fraghdr));
-	}
 	goto err_noclose;
 error:
 	if (len != -EAGAIN)
-- 
2.47.0


