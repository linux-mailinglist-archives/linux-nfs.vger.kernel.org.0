Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45703CD72F
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbhGSOLg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 10:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241312AbhGSOI2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Jul 2021 10:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA78061002;
        Mon, 19 Jul 2021 14:48:16 +0000 (UTC)
Subject: [PATCH v2 3/6] SUNRPC: Remove unneeded TRACE_DEFINE_ENUMs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 19 Jul 2021 10:48:16 -0400
Message-ID: <162670609624.468132.3915475444727749215.stgit@manet.1015granger.net>
In-Reply-To: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
References: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: TRACE_DEFINE_ENUM is needed only for enums, not for
C macros.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 861f199896c6..ea6340129b1b 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -295,21 +295,6 @@ TRACE_EVENT(rpc_request,
 		)
 );
 
-TRACE_DEFINE_ENUM(RPC_TASK_ASYNC);
-TRACE_DEFINE_ENUM(RPC_TASK_SWAPPER);
-TRACE_DEFINE_ENUM(RPC_TASK_NULLCREDS);
-TRACE_DEFINE_ENUM(RPC_CALL_MAJORSEEN);
-TRACE_DEFINE_ENUM(RPC_TASK_ROOTCREDS);
-TRACE_DEFINE_ENUM(RPC_TASK_DYNAMIC);
-TRACE_DEFINE_ENUM(RPC_TASK_NO_ROUND_ROBIN);
-TRACE_DEFINE_ENUM(RPC_TASK_SOFT);
-TRACE_DEFINE_ENUM(RPC_TASK_SOFTCONN);
-TRACE_DEFINE_ENUM(RPC_TASK_SENT);
-TRACE_DEFINE_ENUM(RPC_TASK_TIMEOUT);
-TRACE_DEFINE_ENUM(RPC_TASK_NOCONNECT);
-TRACE_DEFINE_ENUM(RPC_TASK_NO_RETRANS_TIMEOUT);
-TRACE_DEFINE_ENUM(RPC_TASK_CRED_NOREF);
-
 #define rpc_show_task_flags(flags)					\
 	__print_flags(flags, "|",					\
 		{ RPC_TASK_ASYNC, "ASYNC" },				\
@@ -327,14 +312,6 @@ TRACE_DEFINE_ENUM(RPC_TASK_CRED_NOREF);
 		{ RPC_TASK_NO_RETRANS_TIMEOUT, "NORTO" },		\
 		{ RPC_TASK_CRED_NOREF, "CRED_NOREF" })
 
-TRACE_DEFINE_ENUM(RPC_TASK_RUNNING);
-TRACE_DEFINE_ENUM(RPC_TASK_QUEUED);
-TRACE_DEFINE_ENUM(RPC_TASK_ACTIVE);
-TRACE_DEFINE_ENUM(RPC_TASK_NEED_XMIT);
-TRACE_DEFINE_ENUM(RPC_TASK_NEED_RECV);
-TRACE_DEFINE_ENUM(RPC_TASK_MSG_PIN_WAIT);
-TRACE_DEFINE_ENUM(RPC_TASK_SIGNALLED);
-
 #define rpc_show_runstate(flags)					\
 	__print_flags(flags, "|",					\
 		{ (1UL << RPC_TASK_RUNNING), "RUNNING" },		\
@@ -945,17 +922,6 @@ TRACE_EVENT(rpc_socket_nospace,
 	)
 );
 
-TRACE_DEFINE_ENUM(XPRT_LOCKED);
-TRACE_DEFINE_ENUM(XPRT_CONNECTED);
-TRACE_DEFINE_ENUM(XPRT_CONNECTING);
-TRACE_DEFINE_ENUM(XPRT_CLOSE_WAIT);
-TRACE_DEFINE_ENUM(XPRT_BOUND);
-TRACE_DEFINE_ENUM(XPRT_BINDING);
-TRACE_DEFINE_ENUM(XPRT_CLOSING);
-TRACE_DEFINE_ENUM(XPRT_CONGESTED);
-TRACE_DEFINE_ENUM(XPRT_CWND_WAIT);
-TRACE_DEFINE_ENUM(XPRT_WRITE_SPACE);
-
 #define rpc_show_xprt_state(x)						\
 	__print_flags(x, "|",						\
 		{ (1UL << XPRT_LOCKED),		"LOCKED"},		\


