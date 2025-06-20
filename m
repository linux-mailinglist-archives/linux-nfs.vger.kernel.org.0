Return-Path: <linux-nfs+bounces-12589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F1AE1AC8
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322F316D5D8
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 12:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7528BAA8;
	Fri, 20 Jun 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE9uf9Or"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF228BA9A;
	Fri, 20 Jun 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421787; cv=none; b=NUjJsKFr7bJy7U5jlnFk6l9dRumLSCYBRd9pHltLMxNzPRxUQ2ExWI+P+4TDuLMjHrql6n4wVReMuzXyhSu3QExaIfoekbpB8UjI41Z2LsOT84t178lLTsnCyRJyjoJ5oAEZuvSf89tYbmLDGYbS4covxJti7BvDkPC4IlnaRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421787; c=relaxed/simple;
	bh=oNgszznr2KqoXJ7xUI50gbvBuN4NLNMjt7UJRfxDNqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkZpIuWWfp4z39Ojo0v+N+SokTewverj+neddMM0TwM06RCzrF3d4n//E7PwPjbOIyQyCk8bW6kuydOR1lvCKR9Er5gJ+bYrSFAz/N9sY4BrLbitiMJozzpHMG4a9iK36V0X6UjLLKLvkk+T68PLyIKV59fY2/htdZmjGyTK1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE9uf9Or; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E85AC4CEF0;
	Fri, 20 Jun 2025 12:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750421786;
	bh=oNgszznr2KqoXJ7xUI50gbvBuN4NLNMjt7UJRfxDNqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KE9uf9Ort9knDAhF+YxxHr74jwrVuqATWVU3kYgZ6I1SJ81d/nVCoTgCljTlYGNAK
	 qAlhMdtCsQ/bmdBdHYxUgP7VYwxJTw4eSYRisv/oV0Yk/YpTxYROxs6Ia7YEOrKVjV
	 hhrWXiYu/SQ/PNKzDCCu3kPLngSDJywVSHpp1WPGSeymMvfmGvO6h0DuBN+NFAptCj
	 m/E9rvHFdCoV4UMrTlkXoym4nDIDhvpixjrQhHPKCbE63BbdMdd6TQFh6djlTs5A1R
	 eoMA8DwdhiHAGxkE+V7O7w2xBSLSrAo8vs6JopkiGuN+O21mgTWh6HUipth0XMngNg
	 PEs/LjSob5vqA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 20 Jun 2025 08:16:03 -0400
Subject: [PATCH 3/6] sunrpc: reset rq_accept_statp when starting a new RPC
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-rpc-6-17-v1-3-a309177d713b@kernel.org>
References: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
In-Reply-To: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oNgszznr2KqoXJ7xUI50gbvBuN4NLNMjt7UJRfxDNqI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoVVEWiPuSHaYEhDYms+HTDATGjRe/SzPVbSavK
 uLCU9XDGBqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFVRFgAKCRAADmhBGVaC
 FYtzD/wKNvglorlkzs3kqUsGRkIB225hUEb0o3G+xgY3Um4aJP9MfUJ8WII200htwxhmZCCVOMp
 1hmI0h7VGbzeYvIsxHJCq87Ya60a6sISag/FLhvif1qAPXZh1GBs2qoYDrlx+PvLsYkHJkNFA1H
 4QONf0DaW3CPNolK5SSjplevqlhn4mSIXJZAO/odN0YvQumSa1pC9lRpNh9V0T8thrRX9omVQc5
 92artEETOjgt/oc2zwnQkDlZ81/aI/4Gdtqj+XQibx7PKhiKPlTg1ASALxR3lwgzKHeIH/l5vIm
 sgKCfpE3kIXqdVUBeRjCGN6Y7+Gf3qh4L7No13sD/XhHOJwK2mJqaHEasSKi0qLw2FWtYfUbAVG
 HvW9HyNy8k8J9gAT08RVTt8RzOIg8e9mCboAkC5Egp8CTSMVkx2wKUaApP6ticaoFX6diMjFUih
 0mC7vQbUN5nmktMqF0nC+hl2BohFZaxO/Cewc2Disnr4rJZPwqPb6eWoEHEhPwcy9zoSr2aj8WI
 3WInFAX1+lzxiZ/5U4lXE1+yU5IaB/DWVKucH0+gh/TmdJTGRlXynElEAVm0gs8ZuDDbMALz2vf
 NAp5o4bCG6k1IVKYG6JzL//3pGLVhGGB2EBNiFsCWTVhp3VIvfHOoENdZrZX6DRcMUAa3t9H/ld
 y8KnhZgYvuaJyHg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

rq_accept_statp should point to the location of the accept_status in the
reply. This field is not reset between RPCs so if svc_authenticate or
pg_authenticate return SVC_DENIED without setting the pointer, it could
result in the status being written to the wrong place.

This pointer starts its lifetime as NULL. Reset it on every iteration
so we get consistent behavior if this happens.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index c6ceacedae28e2aafd15edd170a27cdaa84ec47f..b1fab3a6954437cf751e4725fa52cfc83eddf2ab 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1334,6 +1334,9 @@ svc_process_common(struct svc_rqst *rqstp)
 	int			pr, rc;
 	__be32			*p;
 
+	/* Reset the accept_stat for the RPC */
+	rqstp->rq_accept_statp = NULL;
+
 	/* Will be turned off only when NFSv4 Sessions are used */
 	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
 	clear_bit(RQ_DROPME, &rqstp->rq_flags);

-- 
2.49.0


