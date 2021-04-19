Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579FF364969
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbhDSSCW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240433AbhDSSCW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:02:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E621861001;
        Mon, 19 Apr 2021 18:01:51 +0000 (UTC)
Subject: [PATCH v3 02/26] SUNRPC: Remove trace_xprt_transmit_queued
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:01:51 -0400
Message-ID: <161885531111.38598.2643815043255340463.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This tracepoint can crash when dereferencing snd_task because
when some transports connect, they put a cookie in that field
instead of a pointer to an rpc_task.

BUG: KASAN: use-after-free in trace_event_raw_event_xprt_writelock_event+0x141/0x18e [sunrpc]
Read of size 2 at addr ffff8881a83bd3a0 by task git/331872

CPU: 11 PID: 331872 Comm: git Tainted: G S                5.12.0-rc2-00007-g3ab6e585a7f9 #1453
Hardware name: Supermicro SYS-6028R-T/X10DRi, BIOS 1.1a 10/16/2015
Call Trace:
 dump_stack+0x9c/0xcf
 print_address_description.constprop.0+0x18/0x239
 kasan_report+0x174/0x1b0
 trace_event_raw_event_xprt_writelock_event+0x141/0x18e [sunrpc]
 xprt_prepare_transmit+0x8e/0xc1 [sunrpc]
 call_transmit+0x4d/0xc6 [sunrpc]

Fixes: 9ce07ae5eb1d ("SUNRPC: Replace dprintk() call site in xprt_prepare_transmit")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 -
 net/sunrpc/xprt.c             |    2 --
 2 files changed, 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 036eb1f5c133..2f01314de73a 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1141,7 +1141,6 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
 
 DEFINE_WRITELOCK_EVENT(reserve_xprt);
 DEFINE_WRITELOCK_EVENT(release_xprt);
-DEFINE_WRITELOCK_EVENT(transmit_queued);
 
 DECLARE_EVENT_CLASS(xprt_cong_event,
 	TP_PROTO(
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index d616b93751d8..11ebe8a127b8 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1469,8 +1469,6 @@ bool xprt_prepare_transmit(struct rpc_task *task)
 	struct rpc_xprt	*xprt = req->rq_xprt;
 
 	if (!xprt_lock_write(xprt, task)) {
-		trace_xprt_transmit_queued(xprt, task);
-
 		/* Race breaker: someone may have transmitted us */
 		if (!test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate))
 			rpc_wake_up_queued_task_set_status(&xprt->sending,


