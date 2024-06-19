Return-Path: <linux-nfs+bounces-4070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33AF90EF64
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 15:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E3A1C210F8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2BB13DDAF;
	Wed, 19 Jun 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dICwc4fP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884914F9D5
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805088; cv=none; b=SgkoM6FVbFAMlEE4ilKfpwYORgm6DC16KVH7Q0Q8Y5hnDh3FoT3NTK/a7wa5c/O5F6brwhDbCHJa0B3v0RJhjok6BG9iw/6sMYssPbTmY5OPYpZmZlQYesqH/nt9icIAF9kvlO0sNOnjIPt92Nwnw0QFpfjB7ZI8ciX+KdRxcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805088; c=relaxed/simple;
	bh=b7ABFFZ5nAUuamom4PJzWLleKUnBaH+Q+J+iYoufHIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNJQJ+1JUgWtVaIhsqigFxfVX8bCfW6TgcBkH+3tiF5694eGt6UQc5huObu7uc47moVAJKpVPwEXr6cYXGWURd5WCtEBneJzge+hux8AMggFafad/CodBRDC9/XtfYqJKQfKMIiD8YBK5YEHoPPSS+MDi95Kg4i/hwtNF7rWHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dICwc4fP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2163C4AF09;
	Wed, 19 Jun 2024 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805088;
	bh=b7ABFFZ5nAUuamom4PJzWLleKUnBaH+Q+J+iYoufHIg=;
	h=From:To:Cc:Subject:Date:From;
	b=dICwc4fPf3plptUeh5BeGAKzhuR07BRZZR636xPgMczrNBoq9yZQRVgJbcsdoYYZP
	 bosXvnkTPGGjwQJKBkDhC066UIaOE0WjDtmIhrbgsBS7rZ26SNZYlcFBzvC2HlBitX
	 Jm4nJijNV15YUyYjf0nU6sHyPwYo17/X5pzcltyfCm2RGIyU/1V/4WZw9P3DkOfZJZ
	 2TctiFrU0H8FKeht6VkyUewcFRIq0l6hn76HsCiQN2WlR6LOL/LclRFOkauSUtgoty
	 AMBUH9aW717KpbtxoPjuRrvvVKqTAVOox+roqXK4Zqre1vTMFjNkBuJa//LaVTWeGn
	 n1gIGxBNyLRpA==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2] SUNRPC: Fix backchannel reply, again
Date: Wed, 19 Jun 2024 09:51:08 -0400
Message-ID: <20240619135107.176384-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=chuck.lever@oracle.com; h=from:subject; bh=19OSGCofoksAVVgZNBNzDTYes0dMSbWN3njGESOhk+8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmcuJLYpSn1xEAIpwqcFlLAUtcrj5Hb+eN3bTU+ ByfSUDtpCWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnLiSwAKCRAzarMzb2Z/ l+3ZD/9ZYviJB+X4g68fFh0BIfK7ZnyLJgv1wnhCXiEaRmgyRhv30hBPdOqWPzcLxow2QjtkK2p +3m5NB3wfpko1vUcW1htfxOun19ioMc2VgpgU0l8iXMSE3uBP/luYDF3b8fIR4tdh9i62GwA+qp PRyMnjwFi62SsnNgG/QrTiNmJRq9wN0MlduCBHexHP7qkKFIf5HhKXuF1hx+SFl1MjeuAmU7TbC o9p9PlWMOu9pPRsdh0Eho/ErsPPU1p8RAdznCwYAIiHIFp4mxU6wwc1Qi8fh9JqpOdpHuDWTx1t y4Pn/NNaA3kU99oZB43V1UMkbVyeQsGGI+mKlknc38OY350HG1pibV7D4EbSBQ5lfmZi3K2MCJu DnILIBjCaOk3V3TBlVXjocgU956T90h9zY/UtgMNI2bCrPfcn/yHYrgIqKexNOq3xgw/9CyDIck k960sSG7qN2Pv9uezTF1BC7fmne3KHn8pmVEy1YEwEUTMXmNn3tURKJKsaaARG0HunzJfdi3i1o nBHXPhqSJKiXxvnFw7qTzcnsGy8yyCyQ0fj1JWMLdmDR71l6Uwll8O3Gpmlc6LOANENSz9ReEVz aauRpIHWEvL4iWfE26W1na4g5NUmGUD+1BijuTBEwKpLS892ZVoj73OBQo7RrMEP7Vq7pQgDgvG h1CTOm41Wa7FJ9A==
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
 net/sunrpc/svc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 965a27806bfd..e03f14024e47 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1588,9 +1588,11 @@ void svc_process(struct svc_rqst *rqstp)
  */
 void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 {
+	struct rpc_timeout timeout = {
+		.to_increment		= 0,
+	};
 	struct rpc_task *task;
 	int proc_error;
-	struct rpc_timeout timeout;
 
 	/* Build the svc_rqst used by the common processing routine */
 	rqstp->rq_xid = req->rq_xid;
@@ -1643,6 +1645,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 		timeout.to_initval = req->rq_xprt->timeout->to_initval;
 		timeout.to_retries = req->rq_xprt->timeout->to_retries;
 	}
+	timeout.to_maxval = timeout.to_initval;
 	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
 	task = rpc_run_bc_task(req, &timeout);
 
-- 
2.45.1


