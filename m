Return-Path: <linux-nfs+bounces-17512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2074CFA704
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9EA8305C438
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0B352F83;
	Tue,  6 Jan 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZTqHLEf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D7352946;
	Tue,  6 Jan 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726012; cv=none; b=p5/QQs3qGYK0nQHll/1CxWHXgG7yRb2mWfz4TzingAbIT/njeBD/qMi/twELUvRq4Hx8BB/vZEuTHPwl3t19oz14kczMvXjxHtAIdrjKClJf4yohXAKsehlROLl1ltWT4JSTi4sYUs8G24KYINRiGqV2YDO4momJIvMX1hMnMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726012; c=relaxed/simple;
	bh=5sZRIM6uVCxgSPiE76gxdVbbPjV/rC5PVE7KFlgIs9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMV169CJ7b1KeNYRfpsAIM7P0ZPz8coegtam280Qbkl7iYDHRsa7zIFLqo/ZsLJEQh7pTJbAT9WPPZhjjoLK2G00TPyJn6kw6GeKJXvTlEFQF/lNyyTiWfx5ejlzYwrjEKLfwn/eupEpFFm62brqoJrclMNKYhZIzLKf8MhvIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZTqHLEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41142C19425;
	Tue,  6 Jan 2026 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726012;
	bh=5sZRIM6uVCxgSPiE76gxdVbbPjV/rC5PVE7KFlgIs9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kZTqHLEfeq0I9+DmIZMy+xogiKhohVjAIYjyM5J5LyuKERouhAObH+Y6TQQZMH9Q+
	 TXjUPRmrtWMrkptlXLKkT+4jgTOifnPGp9hk6rkRUjNBzJY86gYM8KtYfqG321x9to
	 SQ4EpcAp0+44iOR9mRh4Bw7h7pI9SFo7k56zdeNWNSciLlptIOYSIDJAlMCjDvo8TC
	 0px3qET7zngru7GU7rhyYXVmZ/SwWlOv/4qkxgGlhG44qluT4KOtNTjfcgkTvTvQsb
	 nfoW0s6TlZgxqSm4dXkQFfxKRihlm4a08sWIdGm43z4XUqyGU7YkeXgcPEBDhmvgfe
	 zsFElg63WiY3g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Jan 2026 13:59:47 -0500
Subject: [PATCH v2 5/8] sunrpc: split new thread creation into a separate
 function
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-nfsd-dynathread-v2-5-416e5f27b2b6@kernel.org>
References: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
In-Reply-To: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3513; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5sZRIM6uVCxgSPiE76gxdVbbPjV/rC5PVE7KFlgIs9I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXVu06OcpEj7fU7DiIGp9GuN9SZr5iasisyPeU
 foIbwbR6piJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV1btAAKCRAADmhBGVaC
 FVlZD/9zxlkKw4V7geMKqmQ57MEdCYQIGW4iL3jF1lljNbj7x8eUjMsHjboR6XmkjppTCOnPvOD
 qnmVbnQyQQ1VSejsSRvrYCQvtxB0MLBKwuPaOAgJ08/0ADl6mMCSXuCj9iUYadCy2g4rD6/upli
 S7Czu2rLCRxOWCUd8Vqo0cfy18zOHODSTfRTK6JpwcXbV9SyC0eIo821JCmRLzJifrhSu+I2fFl
 SEI+yA8ggSAbs+nkau2ksul11VT0LcVLh0EklJvgmotpPZygmkgSRWitdeQBMMMo2dzsJsOheDI
 Ye9vvrnVluYpkiAH+ZzKLYZTRRRseJKdkVakffji7uP0R/2yQroPx70RQEE7mYp934UQMvW5obi
 ZPEVaBGcnpPg853Nw9/omOirUcxpSkRdcteb6YOW9mwSLB+q4RTbLiFd4VHB8SrWqKbr7LkPcfm
 ZbaY7EOCYN49CeB8ZLRi3zf3cCOmZ72c/86pqciQBgXvrKWYzqxOMRIUQgarJcSW+2Hp34m5Jv5
 ex480YUIMI70aJfnSCgKPk0sPC9ZOArC/Po2piv0SxgdamlCaAJ14gz0E3WXBvgh4xdtDHZ6/GK
 Yb6+sokKylzPI1Rx6IamjUM5CxOecms8+5fkJtHJf3qrEqavWwdxxPvdXpNyU/bgs7fsIczOxBP
 Ye7ewt6TKcOVMuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Break out the part of svc_start_kthreads() that creates a thread into
svc_new_thread(), as a new exported helper function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svc.h |  1 +
 net/sunrpc/svc.c           | 72 +++++++++++++++++++++++++++-------------------
 2 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 8fd511d02f3b36a614db5595c3b88afe9fce92a2..b55ed8404a9e9863cecfe1f29d79fcc426d6f31c 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -442,6 +442,7 @@ struct svc_serv *svc_create(struct svc_program *, unsigned int,
 bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
+int		   svc_new_thread(struct svc_serv *serv, struct svc_pool *pool);
 void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *prog,
 				     unsigned int nprog,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 54b32981a8bcf0538684123f73a81c5fa949b55c..bb1b5db42bcce51747a12b901b15d4cd4f5fcdd3 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -763,44 +763,58 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
-static int
-svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
+/**
+ * svc_new_thread - spawn a new thread in the given pool
+ * @serv: the serv to which the pool belongs
+ * @pool: pool in which thread should be spawned
+ *
+ * Create a new thread inside @pool, which is a part of @serv.
+ * Returns 0 on success, or -errno on failure.
+ */
+int svc_new_thread(struct svc_serv *serv, struct svc_pool *pool)
 {
 	struct svc_rqst	*rqstp;
 	struct task_struct *task;
 	int node;
-	int err;
+	int err = 0;
 
-	do {
-		nrservs--;
-		node = svc_pool_map_get_node(pool->sp_id);
-
-		rqstp = svc_prepare_thread(serv, pool, node);
-		if (!rqstp)
-			return -ENOMEM;
-		task = kthread_create_on_node(serv->sv_threadfn, rqstp,
-					      node, "%s", serv->sv_name);
-		if (IS_ERR(task)) {
-			svc_exit_thread(rqstp);
-			return PTR_ERR(task);
-		}
+	node = svc_pool_map_get_node(pool->sp_id);
 
-		rqstp->rq_task = task;
-		if (serv->sv_nrpools > 1)
-			svc_pool_map_set_cpumask(task, pool->sp_id);
+	rqstp = svc_prepare_thread(serv, pool, node);
+	if (!rqstp)
+		return -ENOMEM;
+	task = kthread_create_on_node(serv->sv_threadfn, rqstp,
+				      node, "%s", serv->sv_name);
+	if (IS_ERR(task)) {
+		err = PTR_ERR(task);
+		goto out;
+	}
 
-		svc_sock_update_bufs(serv);
-		wake_up_process(task);
+	rqstp->rq_task = task;
+	if (serv->sv_nrpools > 1)
+		svc_pool_map_set_cpumask(task, pool->sp_id);
 
-		wait_var_event(&rqstp->rq_err, rqstp->rq_err != -EAGAIN);
-		err = rqstp->rq_err;
-		if (err) {
-			svc_exit_thread(rqstp);
-			return err;
-		}
-	} while (nrservs > 0);
+	svc_sock_update_bufs(serv);
+	wake_up_process(task);
 
-	return 0;
+	wait_var_event(&rqstp->rq_err, rqstp->rq_err != -EAGAIN);
+	err = rqstp->rq_err;
+out:
+	if (err)
+		svc_exit_thread(rqstp);
+	return err;
+}
+EXPORT_SYMBOL_GPL(svc_new_thread);
+
+static int
+svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
+{
+	int err = 0;
+
+	while (!err && nrservs--)
+		err = svc_new_thread(serv, pool);
+
+	return err;
 }
 
 static int

-- 
2.52.0


