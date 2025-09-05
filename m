Return-Path: <linux-nfs+bounces-14092-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C297B466CD
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 00:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9135C5AAE
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 22:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523B2882BE;
	Fri,  5 Sep 2025 22:45:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C727F003
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112318; cv=none; b=tfHrkSp8BgAEkjlJ5Lv41P6P3ppHjej+WM/QOQYpDnJsMMj+1EBt6FD9iZkQVgb1BH9FykxrcsWJZ/32XiD/S4ujyOs9uUNZYAwX2VGoMJYshJejOaDnC5R6LDQ+kgSVCs0CF6vcZagW2qJhewrpNtaZcNZQjSueF27chmbKKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112318; c=relaxed/simple;
	bh=oyBA+AtJ1q10AYl/a9r/C4aTVHETO3laxSG8rdpNc+M=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lf9x8N6l1D664gjfE/koPxoHvTKnkWwzQyYjVWYHpxPqWj83k8xqaIZ2aK4RY6B4um6x96rlkIPgVhftZTRNcJK8aGLFFJMWLmjebIDXSw6v8pl8I7mznR5RlGkZ3fVOi4SegzdA61BrBPJQCF3DbGdA/KemlNW0ZVEh7GiP9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uufB2-008TY7-LP;
	Fri, 05 Sep 2025 22:45:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Trond Myklebust" <trondmy@kernel.org>
Cc: "Harshvardhan Jha" <harshvardhan.j.jha@oracle.com>,
 "Anna Schumaker" <anna@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: don't fail immediately in rpc_wait_bit_killable()
In-reply-to: <3e558c7f675b1f2e87098e58ef06c6f45ecf0a58.camel@kernel.org>
References: <3e558c7f675b1f2e87098e58ef06c6f45ecf0a58.camel@kernel.org>
Date: Sat, 06 Sep 2025 08:45:04 +1000
Message-id: <175711230465.2850467.14720425360212114773@noble.neil.brown.name>

On Sat, 06 Sep 2025, Trond Myklebust wrote:
> On Thu, 2025-08-28 at 18:12 +0530, Harshvardhan Jha wrote:
> > Is it possible to get this merged in 6.17? I have tested this and the
> > LTP tests pass.
> 
> After much thought, I think I'd rather just revert the commit that
> caused the issue. I'll work on an alternative for the 6.18 timeframe
> instead.

That seems reasonable - thanks.  I'd be curious to know what the
original issue was.  I'm guess it was CLOSE blocking ??

If you do revert, would you consider the following?  I wrote it a while
ago but it became irrelevant with the patch that you might now revert.

I wonder if it would make sense for some part of bit_wait() (or
rpc_wait_bit_killable()) to warn if waiting in TASK_KILLABLE when
PF_EXITING is set.

Thanks,
NeilBrown


From: NeilBrown <neil@brown.name>
Date: Fri, 27 Sep 2024 12:53:52 +1000
Subject: [PATCH] sunrpc: discard rpc_wait_bit_killable()

rpc_wait_bit_killable() currently differs from bit_wait() in the it returns
-ERESTARTSYS rather then -EINTR.  The sunrpc and nfs code never really
care about the difference.  The error could get up to user-space but it
is only generated when a process is being killed, in which case there is
no user-space to see the difference.

Signed-off-by: NeilBrown <neil@brown.name>
---
 net/sunrpc/sched.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 9b45fbdc90ca..247e48641d91 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -274,14 +274,6 @@ void rpc_destroy_wait_queue(struct rpc_wait_queue *queue)
 }
 EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
 
-static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
-{
-	schedule();
-	if (signal_pending_state(mode, current))
-		return -ERESTARTSYS;
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 static void rpc_task_set_debuginfo(struct rpc_task *task)
 {
@@ -343,7 +335,7 @@ static int rpc_complete_task(struct rpc_task *task)
 int rpc_wait_for_completion_task(struct rpc_task *task)
 {
 	return out_of_line_wait_on_bit(&task->tk_runstate, RPC_TASK_ACTIVE,
-			rpc_wait_bit_killable, TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+			bit_wait, TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 }
 EXPORT_SYMBOL_GPL(rpc_wait_for_completion_task);
 
@@ -983,12 +975,12 @@ static void __rpc_execute(struct rpc_task *task)
 		/* sync task: sleep here */
 		trace_rpc_task_sync_sleep(task, task->tk_action);
 		status = out_of_line_wait_on_bit(&task->tk_runstate,
-				RPC_TASK_QUEUED, rpc_wait_bit_killable,
+				RPC_TASK_QUEUED, bit_wait,
 				TASK_KILLABLE|TASK_FREEZABLE);
 		if (status < 0) {
 			/*
 			 * When a sync task receives a signal, it exits with
-			 * -ERESTARTSYS. In order to catch any callbacks that
+			 * -EINTR. In order to catch any callbacks that
 			 * clean up after sleeping on some queue, we don't
 			 * break the loop here, but go around once more.
 			 */
-- 
2.50.0.107.gf914562f5916.dirty


