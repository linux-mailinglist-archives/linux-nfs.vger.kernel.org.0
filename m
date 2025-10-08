Return-Path: <linux-nfs+bounces-15061-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6266BC6640
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 20:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B58674E7B48
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 18:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BE52C1596;
	Wed,  8 Oct 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB+5YdEC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2EB2C1584;
	Wed,  8 Oct 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949951; cv=none; b=IDYKR8SorNJ5tLv5ULCnOujh0VQHWBgUEQd7q0N0WKNZXpHegRP2xkfNKUE7pQ46EgymDr6pr+K18BrVxsrf6/En33dV50IlEtDK81kdnEoZylaLoJonCMcpJu+3QuF30wlAEmvVtbcvPyo1RIcz+lFTwVjLw1C7w/5P7wLdE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949951; c=relaxed/simple;
	bh=DbK+CIg0XXjUCRkiskVCTpZVzWdUCTlE60U/2rfFy0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjDPsIkjAiLdonzKIO4k7gLV0Yu7xO8ZhTbPgDnl1Dz8ZK4a4w+QCK3nkWk41lNGa7p0xaGozNkhUtPOOMrV+ur1pTNKKYjkmtEdI/6ef3xfrNOjd6VI71Y/BAXSdlHGCdGPl5tkSL7QPhPgxO8O9kVruioFA5AWnzfjaP7cJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB+5YdEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B46C116C6;
	Wed,  8 Oct 2025 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759949950;
	bh=DbK+CIg0XXjUCRkiskVCTpZVzWdUCTlE60U/2rfFy0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eB+5YdECfGAOdnn4YIf9i1vOBkflrj4xkZEl+yjb7laOHijnoEes+BTNfd+vOalJI
	 1FAHZ/zDb1XgRn7bjlLOoP7mCu7W0BaAm1xRXnjTkNnnz/ypqZazrUAOv8noT4fO4l
	 6TxjnGqs/o3R/9Ei08eRQB206GXpgQukdp9cYte+5opliCTSQlmST+EozibCOOXFMB
	 AXBYrTGB6SyACi0R7dpkFswG13bIleV3emtGueSAGEqKp5McRWFaR/XhYVca/Czl0s
	 j18r4jLf4jsYxXu+ywiqKxxfyRk7dGD90F79+G5565r6vlI58y4t6JdLD/Lk/z7nUz
	 EHgSclaWIdc8A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 08 Oct 2025 14:58:52 -0400
Subject: [PATCH 1/2] sunrpc: account for TCP record marker in rq_bvec array
 when sending
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-rq_bvec-v1-1-7f23d32d75e5@kernel.org>
References: <20251008-rq_bvec-v1-0-7f23d32d75e5@kernel.org>
In-Reply-To: <20251008-rq_bvec-v1-0-7f23d32d75e5@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DbK+CIg0XXjUCRkiskVCTpZVzWdUCTlE60U/2rfFy0o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo5rR5VFVBXczHRcyAVGGHY0Qkzg8k1XxJ02S8i
 HqpDYIR396JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaOa0eQAKCRAADmhBGVaC
 FVZkEACrFmZ3hyn6YV1mvXsKfZkU+yY+0AiNrDrKgtyJfCpL8KP4HnltbI5rpm0YApeyxFyBfAf
 VsSHpse5B8viPGXS5te6m/p8E4RvnQK9iYdxBNFNYDNKVex/OUcg1YLpiFWXpXH8rRm9LKVHe89
 PYzOdKStow2PSzLo/QfsgVrFjt45btFAqZqv2YCJupp7QwQUgsH8YbNuDfwraFcgr1qsYpNo1Na
 F5QH2H1YNtzzu3fsCP19MQE2dwM8Mhc5lHJyU+p7Q/XqECgdQgOBYo+jplk61Kmrkr/rpHcPtvQ
 LDElBV+JLPFtLaWfekXIJxn3xNgFoqIXLnQxYogeWoOzQrpjZM3F4p/JycowZPGklV/yx9tlvaU
 KwyIjOZFMh2UoAd1FP/+DDxKNQLk2meH79673ZjgUwXhPU9YGW6tdzFys1L0XMhshEH9o9ZlT5U
 MuWfzq/19u3b9wRaQDPWx+wGbNYH7edduTVBxKA4pZYiZpHChFeQWoelEF+8xp5zsYQHFLErv8z
 wG5LToqzirdZu5k5yFrnYvgLylv+owTTiHKBShs6Cv1xlxLsxTTdEW6gJuyxhVdbD4Vk5+WB7IF
 ftnWOwOEfH2DOddZT2GglqfPkFp7uIp0JeEksWWT8uOuIUHv06DGDGIN+WRObnE9axwuETDbA9H
 V+hNza0o6444/TQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The call to xdr_buf_to_bvec() in svc_tcp_sendto() passes in the second
slot to the bvec array as the starting slot, but doesn't decrease the
length of the array by one.

Fixes: 59cf7346542b ("sunrpc: Replace the rq_bvec array with dynamically-allocated memory")
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


