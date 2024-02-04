Return-Path: <linux-nfs+bounces-1757-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EBA849184
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5763E1F21D1C
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2871854;
	Sun,  4 Feb 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6wD4lS3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C19D26B;
	Sun,  4 Feb 2024 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088631; cv=none; b=Pd5F0HKvZCPr4rjB33joimsTQ/IufFaNohuUV+qoxvkBALl4Jj9KViCtqW0fdCTIUi+bnO/5AwTS3DWQTx9xYrsch8Hp33jXrVMa+qdx0AlCitBgR0Il40K9uiij89x5OfupMwhLhyuY+e0bU1AH7/a1Gnt2L+93/8PGS2NOQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088631; c=relaxed/simple;
	bh=Q8M+ZV8AwjWJN106yxlomJOUg4m9WT4jLLZhalyAC+0=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qS3fo8VkAfzTmuVewQRxNM5ttm0vu2IL2XeXZVWh8n6s/ZaBUhrZTpHmRaf2gaczcIGLltj321TQssm+KxMqL1AWBif7D63CePKFvPY/dVccW3heFDWRmtgQc1q3VzEiIfe6nqD0+8p8KBg5Zq04TAPGj4bXsRHteBTSSgeT76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6wD4lS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E6FC433C7;
	Sun,  4 Feb 2024 23:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088630;
	bh=Q8M+ZV8AwjWJN106yxlomJOUg4m9WT4jLLZhalyAC+0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=g6wD4lS3OawgAmTkiVVgqp3YK9EZ7F9uFjWslDLr+F0qWeAdSaCex55PTBEzIlhj6
	 pYUAWpsMYDHZDx2nATKIb0NwlQg5LBjZDFZBrGk5jAGH1krKaAiLFfTKTTGjzVXxiC
	 zZcg48CxitlgnzpstxhAbCvKds+0TQ2bQY5VKuJbE30hjTpmcy476n10pH8xQCuyxK
	 AxYzkyxF5Oa5PF6Gdp0PY31OQIksMKpjQ4X/PKcgi7Msg78O5VBepFwrTaCKBrHnOw
	 aSXbyFeAMOaUrmUXtZgXukqgahRjLdxLJAzaChVAc4HSdSM2EjA/rofe+gHFTXCE5m
	 SSTrLIxI8kmSQ==
Subject: [PATCH v2 06/12] svcrdma: Prevent a UAF in svc_rdma_send()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:17:09 -0500
Message-ID: 
 <170708862961.28128.4635466330893173032.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170708844422.28128.2979813721958631192.stgit@bazille.1015granger.net>
References: 
 <170708844422.28128.2979813721958631192.stgit@bazille.1015granger.net>
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

In some error flow cases, svc_rdma_wc_send() releases @ctxt. Copy
the sc_cid field in @ctxt to a stack variable in order to guarantee
that the value is available after the ib_post_send() call.

In case the new comment looks a little strange, this will be done
with at least one more field in a subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index f1f5c7b58fce..b6fc9299b472 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -316,12 +316,17 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
  * @rdma: transport on which to post the WR
  * @ctxt: send ctxt with a Send WR ready to post
  *
+ * Copy fields in @ctxt to stack variables in order to guarantee
+ * that these values remain available after the ib_post_send() call.
+ * In some error flow cases, svc_rdma_wc_send() releases @ctxt.
+ *
  * Returns zero if the Send WR was posted successfully. Otherwise, a
  * negative errno is returned.
  */
 int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 {
 	struct ib_send_wr *wr = &ctxt->sc_send_wr;
+	struct rpc_rdma_cid cid = ctxt->sc_cid;
 	int ret;
 
 	might_sleep();
@@ -337,12 +342,12 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 		if ((atomic_dec_return(&rdma->sc_sq_avail) < 0)) {
 			svc_rdma_wake_send_waiters(rdma, 1);
 			percpu_counter_inc(&svcrdma_stat_sq_starve);
-			trace_svcrdma_sq_full(rdma, &ctxt->sc_cid);
+			trace_svcrdma_sq_full(rdma, &cid);
 			wait_event(rdma->sc_send_wait,
 				   atomic_read(&rdma->sc_sq_avail) > 0);
 			if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
 				return -ENOTCONN;
-			trace_svcrdma_sq_retry(rdma, &ctxt->sc_cid);
+			trace_svcrdma_sq_retry(rdma, &cid);
 			continue;
 		}
 
@@ -353,7 +358,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 		return 0;
 	}
 
-	trace_svcrdma_sq_post_err(rdma, &ctxt->sc_cid, ret);
+	trace_svcrdma_sq_post_err(rdma, &cid, ret);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
 	svc_rdma_wake_send_waiters(rdma, 1);
 	return ret;



