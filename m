Return-Path: <linux-nfs+bounces-12879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF53CAF81A3
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 21:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771001CA2177
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631822FEE28;
	Thu,  3 Jul 2025 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh8/ZLHR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE912FEE23;
	Thu,  3 Jul 2025 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572409; cv=none; b=jCMA7aM0ZS8kkenlOFerzuVmup/xgD3rBu6XqjdKMtjAf0isD2pmSU+NlTqDSSrUAAHgm77xvDlzh8zRLocXmrJMzeYClWckTnotArNl3C+VvuJaeof/wqs/otbQdmTs0I0WK6O9V+znoZFxiIIQc6F91GQZ53uuSClP62jjgUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572409; c=relaxed/simple;
	bh=HKeoW9KtUJiIjEPGllHFJTUrbGUFNAdPHChB/1LE1vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hyGPm8UR7ZWVXvFz13zneOVa/kaKzn3RzPn8M50MaR6LmPlo7CFt1W0ofNAn/Amjd+Wxvoy4YZJcr4Nr5yDa0nwZ8SDQsAsBq6/2EFx90R0f2NC/GCjfv5qhGAi08ss/fLizv6hoMFmAeFhU4sV0ysC8mQezuzKuhcm63I7I8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh8/ZLHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18CCC4CEF2;
	Thu,  3 Jul 2025 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751572408;
	bh=HKeoW9KtUJiIjEPGllHFJTUrbGUFNAdPHChB/1LE1vk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qh8/ZLHRhjh2GWaXBw7kTfLOOTKXHCWg7p6BDI4UkkbeZ/Vqq01YvYP20dHSNYGyn
	 oHOkiX+fL0Oy4NMi9UiVkfccL096WxCPCToLYG1UGBENZAdKsFdWB7ximZumB+wVQK
	 ypBtFKpea0N2g21fur5hi1qbzAkCE9dyDQXp8MaFHKQTKPT1ckgDCjKuJJxlaxETjk
	 xWE6gYSEyMZBRQnNVTbLbFP1pzihFuPmf7/J56V9AyT0Ne7wVdbmwkhOCjxCXfWcBv
	 3yPZN5ZS7csfctMicv7F40rA5ME3fAgEPBlQSEjMNo/9ChkfJ4Pu6kVDDmRLUYa5Kd
	 ozNTOXcKIMdSw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 03 Jul 2025 15:53:12 -0400
Subject: [PATCH RFC 1/2] sunrpc: delay pc_release callback until after
 sending a reply
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-nfsd-testing-v1-1-cece54f36556@kernel.org>
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
In-Reply-To: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HKeoW9KtUJiIjEPGllHFJTUrbGUFNAdPHChB/1LE1vk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoZt+26Q/6FhBph5XRj0g3eQLABzh5R8vxmZX9S
 n62uZwjp6KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaGbftgAKCRAADmhBGVaC
 FdWvD/4t6rSPB5chu3xDcvAo7m9dNqmao7LA1bEsQlq2FkUeLT+KCKgbWg0SHImEXKjRq8SRUr0
 X2mhxKxgsdygQTjlnlmwRyvrfK8Dj8g9tR0guYY4gnQvhFIjIc2SwvVgvK7UoS1K88SgNrBO1lU
 XyI9UPmRv3Q89GyKyz1vx1nCG0WO2nuYh4D6v4F3X8hjIZDtOdmf07IQHvvdx/5eKqOyhfr9WOg
 EYLnV1XL8Ld4m1EIgg7PHSKfkBZx/l8kdni4McqQqliRn0fzIban3eyYC9dl0v7Pbv4PMs/NtyO
 oPll/PBhIKQEbj7saR3CdkDqEEhDGHHa+461x4sgdgMta+ySstsTd6BXnrx6rBFiCkU3VOssnyt
 pnfGCzFyQr7d3Htl+RLX/REzbF5FDmtK6D6vouKkNg/PPTIeA9k5ilTm7FevGHz6cfUZ/mAGO8k
 wx+yVQaS0410iADF4/Gc/KmSvQMC6V/rznoT7SF5rHZYnhBGu60SOCSWIWFq5CEk1hTychPd/Fk
 fVlad6G40lUTWYyhdt7Rvxsfr8NXk7ESwJSIoB+g2soS1vw96F5+AIVa6qTadhYoimqMUvbDv/i
 U2eD/xCwM61CCccq/uNGS1gNm89insTmSLFNxeyY7IYSY9n2wjDMwYppRh/C1X4b8Alzl5vWwXP
 Ix+BdnGTgn1birA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The server-side sunrpc code currently calls pc_release before sending
the reply. A later nfsd patch will change some pc_release callbacks to
do extra work to clean the pagecache. There is no need to delay sending
the reply for this, however.

Change svc_process and svc_process_bc to call pc_release after sending
the reply instead of before.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b1fab3a6954437cf751e4725fa52cfc83eddf2ab..103bb6ba8e140fdccd6cab124e715caeb41bb445 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1426,8 +1426,6 @@ svc_process_common(struct svc_rqst *rqstp)
 
 	/* Call the function that processes the request. */
 	rc = process.dispatch(rqstp);
-	if (procp->pc_release)
-		procp->pc_release(rqstp);
 	xdr_finish_decode(xdr);
 
 	if (!rc)
@@ -1526,6 +1524,14 @@ static void svc_drop(struct svc_rqst *rqstp)
 	trace_svc_drop(rqstp);
 }
 
+static void svc_release_rqst(struct svc_rqst *rqstp)
+{
+	const struct svc_procedure *procp = rqstp->rq_procinfo;
+
+	if (procp && procp->pc_release)
+		procp->pc_release(rqstp);
+}
+
 /**
  * svc_process - Execute one RPC transaction
  * @rqstp: RPC transaction context
@@ -1533,7 +1539,7 @@ static void svc_drop(struct svc_rqst *rqstp)
  */
 void svc_process(struct svc_rqst *rqstp)
 {
-	struct kvec		*resv = &rqstp->rq_res.head[0];
+	struct kvec			*resv = &rqstp->rq_res.head[0];
 	__be32 *p;
 
 #if IS_ENABLED(CONFIG_FAIL_SUNRPC)
@@ -1565,9 +1571,12 @@ void svc_process(struct svc_rqst *rqstp)
 	if (unlikely(*p != rpc_call))
 		goto out_baddir;
 
-	if (!svc_process_common(rqstp))
+	if (!svc_process_common(rqstp)) {
+		svc_release_rqst(rqstp);
 		goto out_drop;
+	}
 	svc_send(rqstp);
+	svc_release_rqst(rqstp);
 	return;
 
 out_baddir:
@@ -1635,6 +1644,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 	if (!proc_error) {
 		/* Processing error: drop the request */
 		xprt_free_bc_request(req);
+		svc_release_rqst(rqstp);
 		return;
 	}
 	/* Finally, send the reply synchronously */
@@ -1648,6 +1658,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 	timeout.to_maxval = timeout.to_initval;
 	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
 	task = rpc_run_bc_task(req, &timeout);
+	svc_release_rqst(rqstp);
 
 	if (IS_ERR(task))
 		return;

-- 
2.50.0


