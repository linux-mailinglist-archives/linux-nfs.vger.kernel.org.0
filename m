Return-Path: <linux-nfs+bounces-16-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5697F3408
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 17:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA50D281385
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F010524A5;
	Tue, 21 Nov 2023 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyMP5EBu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A654F84;
	Tue, 21 Nov 2023 16:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B20C433C7;
	Tue, 21 Nov 2023 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700584841;
	bh=fMAjswW6FaD33f8jFr1R2Mrswv8swYTGjRxSwkpVq7g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KyMP5EBuffCuu0JyyGDlPKop1TTi8XWos6UCJkJ+1YpeK7dav37WvbDdYYqnpPao/
	 EnvW/WwnT8+wPpKL1Qtz7nv0uwsJWb4BxtJB7eRdft+o1BysvfPeISSi1rmHoBpn7N
	 bMYMkCDJ/ZOUDsARYcmGvjncyTBX0KsmuusrHbQg+U5A58IVN+NvixfviZJEP26H48
	 dEOCEm/mZrt0+/tfxaewRIvK/aAU/6L26b1A0ix6pLcdpoczKNEKja9NQaMfuxHsdW
	 ltQwVsOYreo6+o7FfHNcFFIfRDwA/DhOrp7H6AHQZvJ2akMG/owTmJfqak3mXfUv6o
	 L9lZI1HtLqFOA==
Subject: [PATCH v2 5/6] svcrdma: Add an async version of
 svc_rdma_write_info_free()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Tue, 21 Nov 2023 11:40:39 -0500
Message-ID: 
 <170058483977.4504.7623142897967608695.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
References: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
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

DMA unmapping can take quite some time, so it should not be handled
in a single-threaded completion handler. Defer releasing write_info
structs to the recently-added workqueue.

With this patch, DMA unmapping can be handled in parallel, and it
does not cause head-of-queue blocking of Write completions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index e460e25a1d6d..de1ec3220aab 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -227,6 +227,7 @@ struct svc_rdma_write_info {
 	unsigned int		wi_next_off;
 
 	struct svc_rdma_chunk_ctxt	wi_cc;
+	struct work_struct	wi_work;
 };
 
 static struct svc_rdma_write_info *
@@ -248,12 +249,21 @@ svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma,
 	return info;
 }
 
-static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
+static void svc_rdma_write_info_free_async(struct work_struct *work)
 {
+	struct svc_rdma_write_info *info;
+
+	info = container_of(work, struct svc_rdma_write_info, wi_work);
 	svc_rdma_cc_release(&info->wi_cc, DMA_TO_DEVICE);
 	kfree(info);
 }
 
+static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
+{
+	INIT_WORK(&info->wi_work, svc_rdma_write_info_free_async);
+	queue_work(svcrdma_wq, &info->wi_work);
+}
+
 /**
  * svc_rdma_write_done - Write chunk completion
  * @cq: controlling Completion Queue



