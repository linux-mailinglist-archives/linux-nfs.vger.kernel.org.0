Return-Path: <linux-nfs+bounces-1491-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2902483E0CC
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF181C224A2
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A49208B9;
	Fri, 26 Jan 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFm7nDf6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2C208BA
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291125; cv=none; b=aGFaA0Wpz/Er/yH92ZYuBh2bJQRQ90G5FHy1qf7zHaB5yCQP5gTlWtaVmBdi/HHhzfSCPIhRzMkievYb3BwXIlqHn29w2qTsyxEdQfj2LGSmhM/6RGOZlaQnfm8aG2ictlNhma63HLtEGSpSxfX1lTkLhWm/NzeFNI5AKnfNcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291125; c=relaxed/simple;
	bh=fvaiBK3PyaNdQ/1DEAZsRSMGJZ0XyMNPJw/0OTMTGMM=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDOjvCI+nFnaPOHOZYHONiN7gwKbXl7noxsx+nEgLChUXb1hdEU3769gIbWOV8MCL42tTie9G2j1WsW0GxFMjejNlB/wUmZ9ZyZuupK9x7y207A4bkrOgttZv2j3SrVXmFSTHuWbfJbr1V+XjVx0fXvv9hEUvaCYNgmHFovoe0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFm7nDf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DD7C43394
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291124;
	bh=fvaiBK3PyaNdQ/1DEAZsRSMGJZ0XyMNPJw/0OTMTGMM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=ZFm7nDf6tP+fOUCTD/uG/z7pAEzazRUHH84zZSJS6Y6CCylvDwEHbVEUpBKC6T6Y1
	 6fswHhXQcash8jnBbGQxTiGYjMVmTFIQk/ZX8vx72rfC6JgmnHGoZjRAEzbruBvOX2
	 hEDjF7auo+/lCk409Ce9f17TzQh06fTQaQ9C9uRGYm1ZFKRZRg6UQK5GEmD9HBw1km
	 pC7Lb6EQVEGQ/7lpru6GWDTHd7K2O3lqcEqnVNWsheQJiWmLxefGLPx75Y+evYwZ8z
	 iYI9epuRI1+AYmRTqGpzqWLq5I7jmNAYG3gXJgYTokduuWO817V++exe+PDPA/R1Kf
	 l/T+DZARw5qQQ==
Subject: [PATCH 2 02/14] NFSD: Convert the callback workqueue to use
 delayed_work
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:45:23 -0500
Message-ID: 
 <170629112325.20612.15691160218281370004.stgit@manet.1015granger.net>
In-Reply-To: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
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

Normally, NFSv4 callback operations are supposed to be sent to the
client as soon as they are queued up.

In a moment, I will introduce a recovery path where the server has
to wait for the client to reconnect. We don't want a hard busy wait
here -- the callback should be requeued to try again in several
milliseconds.

For now, convert nfsd4_callback from struct work_struct to struct
delayed_work, and queue with a zero delay argument. This should
avoid behavior changes for current operation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    6 +++---
 fs/nfsd/state.h        |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 43b0a34a5d5b..1ed2512b3648 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -887,7 +887,7 @@ static struct workqueue_struct *callback_wq;
 
 static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 {
-	return queue_work(callback_wq, &cb->cb_work);
+	return queue_delayed_work(callback_wq, &cb->cb_work, 0);
 }
 
 static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
@@ -1370,7 +1370,7 @@ static void
 nfsd4_run_cb_work(struct work_struct *work)
 {
 	struct nfsd4_callback *cb =
-		container_of(work, struct nfsd4_callback, cb_work);
+		container_of(work, struct nfsd4_callback, cb_work.work);
 	struct nfs4_client *clp = cb->cb_clp;
 	struct rpc_clnt *clnt;
 	int flags;
@@ -1415,7 +1415,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_msg.rpc_argp = cb;
 	cb->cb_msg.rpc_resp = cb;
 	cb->cb_ops = ops;
-	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
+	INIT_DELAYED_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_seq_status = 1;
 	cb->cb_status = 0;
 	cb->cb_need_restart = false;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 41bdc913fa71..87c4372ba36a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -68,7 +68,7 @@ struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
 	struct rpc_message cb_msg;
 	const struct nfsd4_callback_ops *cb_ops;
-	struct work_struct cb_work;
+	struct delayed_work cb_work;
 	int cb_seq_status;
 	int cb_status;
 	bool cb_need_restart;



