Return-Path: <linux-nfs+bounces-2972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BC8AFD45
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 02:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D6CB216BF
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D8D7FF;
	Wed, 24 Apr 2024 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5HtykLd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7237EF
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918009; cv=none; b=ujylyotdAdUbtbXt2IHEWEQeCt3F8tg7WIze/yMFqO0Xs5zaDgrePB1g28Vhsy2K2n+Qm8VLVnE8cf3725Cy5TUTDKHx7tsgUlCpLUCBiT+d/Cnm6K216LtCsl82ZZSmSRWnvnchAMF4BEAKNralROPhi65+MA8SHl/bxrNx0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918009; c=relaxed/simple;
	bh=TNUmONbsXgwdI8lXRxiSNutmUSx36X9bNyjths3t8dI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNccl12Py+S9J2vATXZdyaSx+JqilfKOPC6W4v8VOJPHCCgv05oiaDuUGDwh0IxESivXh47cV7qadygChiNAJD3z6TgBc3t0BqMxSc83GzPUnYdoxCpdjFcRVRdbpab0UE5NubHpYL8nmiGUx/uMZQ7Dd1ouOfxl/ObR+Lp657E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5HtykLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB2DC116B1;
	Wed, 24 Apr 2024 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713918009;
	bh=TNUmONbsXgwdI8lXRxiSNutmUSx36X9bNyjths3t8dI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R5HtykLdO/Fypw9MRRZn18Qp1bEPdB8xtZlOpG8T93dkFhUCxG6tFta5g4zvjinwN
	 RgrifciWrBrsl0/3ggkZpPrEZKicWCU9FplrMYYNnTtPeu7g6UkdwTepOCa7Aebyoj
	 bZHoV6CrPcl4YDKCbAnh2U8tnW6SyIX7YpXLtxS0PJhpA+o7bWblJVttujs8a5LAlJ
	 lP1pf3ztJxK+hoRdflemqHMD5/mNVIvFhXtgImRhjidAV8amktOBsStP7HYaRku1+E
	 WDFuL7wRxzjaEPa5CEYO+kwRj4/nKCpuTl7dAiZGFYMImBZKYGBD75EDsw1td2a/oA
	 Vn6K7NXmcSNYg==
Subject: [PATCH 2/2] Revert "NFSD: Convert the callback workqueue to use
 delayed_work"
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 23 Apr 2024 20:20:08 -0400
Message-ID: 
 <171391800819.101038.12426618606693057125.stgit@klimt.1015granger.net>
In-Reply-To: 
 <171391782806.101038.14694256680827795210.stgit@klimt.1015granger.net>
References: 
 <171391782806.101038.14694256680827795210.stgit@klimt.1015granger.net>
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

This commit was a pre-requisite for commit c1ccfcf1a9bf ("NFSD:
Reschedule CB operations when backchannel rpc_clnt is shut down"),
which has already been reverted.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    6 +++---
 fs/nfsd/state.h        |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d153af81f406..6aff46701aa1 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -983,7 +983,7 @@ static struct workqueue_struct *callback_wq;
 static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 {
 	trace_nfsd_cb_queue(cb->cb_clp, cb);
-	return queue_delayed_work(callback_wq, &cb->cb_work, 0);
+	return queue_work(callback_wq, &cb->cb_work);
 }
 
 static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
@@ -1482,7 +1482,7 @@ static void
 nfsd4_run_cb_work(struct work_struct *work)
 {
 	struct nfsd4_callback *cb =
-		container_of(work, struct nfsd4_callback, cb_work.work);
+		container_of(work, struct nfsd4_callback, cb_work);
 	struct nfs4_client *clp = cb->cb_clp;
 	struct rpc_clnt *clnt;
 	int flags;
@@ -1528,7 +1528,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_msg.rpc_argp = cb;
 	cb->cb_msg.rpc_resp = cb;
 	cb->cb_ops = ops;
-	INIT_DELAYED_WORK(&cb->cb_work, nfsd4_run_cb_work);
+	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_status = 0;
 	cb->cb_need_restart = false;
 	cb->cb_holds_slot = false;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 01c6f3445646..2ed0fcf879fd 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -68,7 +68,7 @@ struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
 	struct rpc_message cb_msg;
 	const struct nfsd4_callback_ops *cb_ops;
-	struct delayed_work cb_work;
+	struct work_struct cb_work;
 	int cb_seq_status;
 	int cb_status;
 	bool cb_need_restart;



