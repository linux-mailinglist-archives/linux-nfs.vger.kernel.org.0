Return-Path: <linux-nfs+bounces-15090-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07621BC9911
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 16:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19352188FE2D
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2792EBB90;
	Thu,  9 Oct 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWh7W3nn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23072EB848;
	Thu,  9 Oct 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020828; cv=none; b=NvmITUnMTS8W17p5WAiBeDtdoygl8EMGq5f4nKlzh3e+n0n8AXt1+NLEuX+VcsrmLtTfj4o2OCwwhF8S1D+Sl9iOrq+nkwkoY4aOWFg9iaNT5kYm+yS6xdC6ImFX3X+7RXFIBlaK57TPpJZ7fHE5YjloDLIBjJNk+rli+JYem5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020828; c=relaxed/simple;
	bh=YZPJIIBNKIncT0F3Hg/ORGJWPeWo71eur34aUGFe3yM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLa9GDdm/km+czBa80GtDb2BObQuiwf+gUzIM5RzrJmIXs5FLgLPcq7yQeWxNVrDLUZOBJzD1b8T0s5Z2PidjWiYr0NpPDj1VxVW+A+AqV1xLTnh0wMANNcboa/tlzYey/37s7Gj5CByRGIw9lL94FqRATPvxYehQmwWo9l+Ihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWh7W3nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62609C4CEF5;
	Thu,  9 Oct 2025 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760020826;
	bh=YZPJIIBNKIncT0F3Hg/ORGJWPeWo71eur34aUGFe3yM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eWh7W3nnd9P2P3JHCNYvM06uH1iU8WFnVB+rDbl3Aw/mTAoAwHW5POqWr4YxYvkkd
	 SN6faoK+1trjnsoGpltrcf41SfCkQANEg6Z35bOVrksx3CRRmnRgWJ4npDRe4wG6P9
	 3mPmc42vzHVWE9q3Qp1uMnlP0TLo45xhUU7TMZq7oct9j/GAivdqb0hJD6D2JyD75C
	 2DOEBbteoBvG/L8Jvon4H8vzJjswqNqaJlAG2rKAAYH7herhCMGfu1U9e8yKA+EE3G
	 VXQYxARnRTpiln95s9xV5D8D18quvw3Q7vqcbjhrgEtG286SERcj3Y4fdDiyWmObUH
	 exdcv7763w2oA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Oct 2025 10:40:10 -0400
Subject: [PATCH v3 1/2] sunrpc: account for TCP record marker in rq_bvec
 array when sending
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-rq_bvec-v3-1-57181360b9cb@kernel.org>
References: <20251009-rq_bvec-v3-0-57181360b9cb@kernel.org>
In-Reply-To: <20251009-rq_bvec-v3-0-57181360b9cb@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>
Cc: Brandon Adams <brandona@meta.com>, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YZPJIIBNKIncT0F3Hg/ORGJWPeWo71eur34aUGFe3yM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo58lVC1tDjoaKwgMEoQfbYO5v3WQ7LA8aaBjPQ
 Eh6RLWa1faJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaOfJVQAKCRAADmhBGVaC
 FfF+EACEsfvq4klrTrktIw0iVvyO33FAgLBr213qCOrJGBsIdeQi7XwjKWLDejw5Z+0fLGiCOPH
 2P2L642MNpOeX/xhAx2Ix144LNbGvdlw3ST8vVGRDdMXYk/Tmjsmee+Ty1HMECgbd3vIR51ClT+
 txzvaI7nQFiJvuJ7K2WWUfCtk/0yQEwDa79P3QD8WXuCk9RiMStPWMUKCeBJPs6vntijLuA9C55
 MvvvZIq2XmRgSdGh706tJaVJuvZ1wcdYWtdv5VfSkD5tbBTYcRsFgppaCyr25l6fiUA+JYNbi6f
 /jfgwgYZUcQVoHZg40F1K1uKiu48MP0C4lsLMsCfGn+GsLTo0jsmQNqnpHGPyIDNv/U/qVgIRUI
 VLVclhO5zKg1w+PzlG+EBeYy+IdrzWocCsGMZ0zJ6Om0gW9eCEwYbg54CU5l32O+ii/TsjFvFRH
 Kz9YvcMO1YTusWwXOoPoLlVpti653I9YjXk13UQUb1v4Xq8+wrGbQKHACmfgRECv9ihObP4k5XL
 SXuQDNX38dBCXPi0GPl9ttiCAjIiFjFQJPNNYnXuQBmy3blX2lTwFXL64WnkNA4lpiG0/RscVwO
 1KdS/c1Nw/0e2ygY09ojfn7kMKCsVB6P7QciBghR1CXqzZHrmasCclhLmXqCPv4HpfBK68Zqq5g
 ZyiC/G15oUeF9LA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The call to xdr_buf_to_bvec() in svc_tcp_sendto() passes in the second
slot to the bvec array as the starting slot, but doesn't decrease the
length of the array by one.

Fixes: 59cf7346542b ("sunrpc: Replace the rq_bvec array with dynamically-allocated memory")
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svcsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 7b90abc5cf0ee1520796b2f38fcb977417009830..377fcaaaa061463fc5c85fc09c7a8eab5e06af77 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1244,7 +1244,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	memcpy(buf, &marker, sizeof(marker));
 	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages,
+	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages - 1,
 				&rqstp->rq_res);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,

-- 
2.51.0


