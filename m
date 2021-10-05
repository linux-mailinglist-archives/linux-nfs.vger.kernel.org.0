Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A46422ED9
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 19:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhJERQJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 13:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhJERQI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Oct 2021 13:16:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4F1D611CA
        for <linux-nfs@vger.kernel.org>; Tue,  5 Oct 2021 17:14:17 +0000 (UTC)
Subject: [PATCH RFC 3/5] SUNRPC: Use BIT() macro in rpc_show_xprt_state()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Oct 2021 13:14:17 -0400
Message-ID: <163345405711.524558.2963950177861059909.stgit@morisot.1015granger.net>
In-Reply-To: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
References: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: BIT() is preferred over open-coding the shift.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 4fd6299bc907..9caf4533366e 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -921,18 +921,18 @@ TRACE_EVENT(rpc_socket_nospace,
 
 #define rpc_show_xprt_state(x)						\
 	__print_flags(x, "|",						\
-		{ (1UL << XPRT_LOCKED),		"LOCKED"},		\
-		{ (1UL << XPRT_CONNECTED),	"CONNECTED"},		\
-		{ (1UL << XPRT_CONNECTING),	"CONNECTING"},		\
-		{ (1UL << XPRT_CLOSE_WAIT),	"CLOSE_WAIT"},		\
-		{ (1UL << XPRT_BOUND),		"BOUND"},		\
-		{ (1UL << XPRT_BINDING),	"BINDING"},		\
-		{ (1UL << XPRT_CLOSING),	"CLOSING"},		\
-		{ (1UL << XPRT_OFFLINE),	"OFFLINE"},		\
-		{ (1UL << XPRT_REMOVE),		"REMOVE"},		\
-		{ (1UL << XPRT_CONGESTED),	"CONGESTED"},		\
-		{ (1UL << XPRT_CWND_WAIT),	"CWND_WAIT"},		\
-		{ (1UL << XPRT_WRITE_SPACE),	"WRITE_SPACE"})
+		{ BIT(XPRT_LOCKED),		"LOCKED" },		\
+		{ BIT(XPRT_CONNECTED),		"CONNECTED" },		\
+		{ BIT(XPRT_CONNECTING),		"CONNECTING" },		\
+		{ BIT(XPRT_CLOSE_WAIT),		"CLOSE_WAIT" },		\
+		{ BIT(XPRT_BOUND),		"BOUND" },		\
+		{ BIT(XPRT_BINDING),		"BINDING" },		\
+		{ BIT(XPRT_CLOSING),		"CLOSING" },		\
+		{ BIT(XPRT_OFFLINE),		"OFFLINE" },		\
+		{ BIT(XPRT_REMOVE),		"REMOVE" },		\
+		{ BIT(XPRT_CONGESTED),		"CONGESTED" },		\
+		{ BIT(XPRT_CWND_WAIT),		"CWND_WAIT" },		\
+		{ BIT(XPRT_WRITE_SPACE),	"WRITE_SPACE" })
 
 DECLARE_EVENT_CLASS(rpc_xprt_lifetime_class,
 	TP_PROTO(


