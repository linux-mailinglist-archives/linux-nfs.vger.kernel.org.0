Return-Path: <linux-nfs+bounces-3833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B8908D42
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B480128C0AC
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9711BD517;
	Fri, 14 Jun 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZ3P+UZW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C81D512
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374770; cv=none; b=LJHPFkA0MC/nJVb2iPahI+9dVfSMxRtUwqr+MGQGfylfTWqPS/dawTyDTSBmtJmOtWMXXKdqE/t9bNBEyK8A8eOMToAjpjzZc2A3L4ZCTFjZDY7+vaW2LzroDiGFsCOqgKl0nw8wGyjqr+6g1iDnKaPGNTvihFygXugFeG/c+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374770; c=relaxed/simple;
	bh=eSDBSr/EaYKpNMi3hhE/g/edcuDifrgfFEUx/Zrnmks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJzEZBRJu7bi2xklWOfAYgYDiM6Yf8THfKsWsU8ZFBeDS1G9B3s3HSeX2HsEzHcJuu46x7/RdNuJY91HV/Q7O4A81+ryCJCbGtuAMQ4iBk6YiYMA7XD8bw6TZ8E6DbB0tX/Pr2Viw0bwcLmmV+lVoydI11rJIZ3TQubTJiZRAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZ3P+UZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB87C2BD10;
	Fri, 14 Jun 2024 14:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718374770;
	bh=eSDBSr/EaYKpNMi3hhE/g/edcuDifrgfFEUx/Zrnmks=;
	h=From:To:Cc:Subject:Date:From;
	b=qZ3P+UZWpBfJFHK9Xs218BBX+5fCcRaK3HQqvb96iuEW1vKfxSaMiYSIaaRFRaDFM
	 9wJlKwdVIlMnLh3xE0q4Sft+rKOfbnk4cKWz1vrSY/ak97r2TQoj6C9uhRCynhJN5p
	 e6qVZtZtwwzfyVs5oUnF+vdPIINK9HLuqgR9ZFpv5kIP/Spa3lDSk1YODj1RJlhIRu
	 H1qi7gV1C8AYufJT0BNYpOoydQPyxx2K2dFq379k4OGJ937PaO/nR9bYF4Vq7N8ixv
	 IZ2rfPveHjzoQ/jtZ5kL6SFCPGpzlaS0vJN7pqe3RSxl4MD2nTl6XKTMdHX45pgzGu
	 rzefd9NQzCBdw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Ben Coddington <bcodding@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] SUNRPC: Fix backchannel reply, again
Date: Fri, 14 Jun 2024 10:18:52 -0400
Message-ID: <20240614141851.97723-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=chuck.lever@oracle.com; h=from:subject; bh=fUlbM7hR/tbigRrPaZ38O21Nzt9ECq1EqnVEzCtgw4k=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmbFFLz3yPv9/I1Jovjk+DliEOSkgjRpPhLCH0S awq+K5mJDmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZmxRSwAKCRAzarMzb2Z/ l/tREACDGDFbP1HSCJLEQZfWQuL/UDmGTf3OwiW6RM/5BejlC5V8OtpkVdrfEIO27rPUfNrB+2a Ir6CG7+iICUI5+LiRWHgqKvQR6YLFRtmPEHM7DhehWK5opPqNzVdXLGkprqpTGcSg4cGktXrAsc i7ZAjLPCZbbE0/NxQuicyD0wnzxizcxqoDfzqR2dgjqoCNnEhEEyi5MnCaKajI5sKG06sBoUCgP qSWamy95uiHq4O9nfRrsRHBYJixOZZ+FfOJYE/wNTXzsbEIjZ/3s65/Aw4VzC0RBKHRkaTwyw9A DUcL6osFXZNvhC8h+AoHX5g+wb16ovKT+cojEszD/W1TnvHFiz4K7tEKXlcSSG7qZx/T6h6ZNxV 6QBv56TBsm5iRRG9qDUfzg0UTyU31gUACBIVuvLcm/8amrd92UkKefZXOWOwJYqWuO6+7ohwuXQ Jb2t7j3OCvDXtBwBr0oLBie8niBBJvwlSMl9mvoHcurX6VNd/LohrJgzjdGeUSfv9uTeb2DtXZv mnCgGtGgkqk11LUt3Sx1Tvcz4qLN90xXjLOawHiGo8qnNaui7uGcjneaHpdbTZTcs+CjCsYlDo2 +TjVPdvpTr8hPxWlm/nWFQXBCL/qJ+soUZ4WUflTFFu7ezPIRkd/wn7y8zDUaq6P8B9duEMxN7F WLlxQmiE7RsnsEw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I still see "RPC: Could not send backchannel reply error: -110"
quite often, along with slow-running tests. Debugging shows that the
backchannel is still stumbling when it has to queue a callback reply
on a busy transport.

Note that every one of these timeouts causes a connection loss by
virtue of the xprt_conditional_disconnect() call in that arm of
call_cb_transmit_status().

I found that setting to_maxval is necessary to get the RPC timeout
logic to behave whenever to_exponential is not set.

Fixes: 57331a59ac0d ("NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 965a27806bfd..f4ddb2961042 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1643,6 +1643,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 		timeout.to_initval = req->rq_xprt->timeout->to_initval;
 		timeout.to_retries = req->rq_xprt->timeout->to_retries;
 	}
+	timeout.to_maxval = timeout.to_initval;
 	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
 	task = rpc_run_bc_task(req, &timeout);
 
-- 
2.45.1


