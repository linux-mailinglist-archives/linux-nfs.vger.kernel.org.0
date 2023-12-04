Return-Path: <linux-nfs+bounces-282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA238037C7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E9A1F211D0
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ABC28DD8;
	Mon,  4 Dec 2023 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqADawyO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15EA28DB6;
	Mon,  4 Dec 2023 14:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59177C433C7;
	Mon,  4 Dec 2023 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701824;
	bh=QXSHxX6W+41O/OUYSiflmN0ADl66DnEAVimf+dZzOls=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kqADawyOzx8JHyIbMjoBRqBe37+0BX8+hV35Q3/2LTmCvW/QaH8C1VfEQ7YskdalS
	 exg6dQYvZVntDXPAQeX/xvI3qdS8SpE4Y1Lb5E7GGC6tE2HfH4YHn1sicddXqBYdyb
	 QPsoUOSBUlkxnocGwvMtdAD7wzQE25Mbh59uxrHjoG3k7faaSdcLCBghp9rY1Gde8A
	 btqVP0cTEJKfkEZhzcvl0ApBHIt158QyxkcnnicrfGFrnZdf43vJOYqpUpSduTig9w
	 /bNRpWkBKUceK++oTqEMD/5WFQpp10zYvrs0v/Yl5ZPyMGKaXwxyuex9Boce/4Bk8c
	 iYjMGOCdSfjrA==
Subject: [PATCH v1 07/21] svcrdma: Remove the svc_rdma_chunk_ctxt::cc_rdma
 field
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:57:03 -0500
Message-ID: 
 <170170182343.54779.7395369832863601805.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
References: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
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

In every instance, the pointer address in that field is now
available by other means.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 7676b9df024b..cfa5973c9277 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -157,7 +157,6 @@ static int svc_rdma_rw_ctx_init(struct svcxprt_rdma *rdma,
 struct svc_rdma_chunk_ctxt {
 	struct rpc_rdma_cid	cc_cid;
 	struct ib_cqe		cc_cqe;
-	struct svcxprt_rdma	*cc_rdma;
 	struct list_head	cc_rwctxts;
 	ktime_t			cc_posttime;
 	int			cc_sqecount;
@@ -176,7 +175,6 @@ static void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 			     struct svc_rdma_chunk_ctxt *cc)
 {
 	svc_rdma_cc_cid_init(rdma, &cc->cc_cid);
-	cc->cc_rdma = rdma;
 
 	INIT_LIST_HEAD(&cc->cc_rwctxts);
 	cc->cc_sqecount = 0;



