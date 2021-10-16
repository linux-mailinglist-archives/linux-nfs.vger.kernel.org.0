Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0745F430524
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbhJPWEs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244675AbhJPWEr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:04:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16C3360EE9;
        Sat, 16 Oct 2021 22:02:39 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 3/7] SUNRPC: Use BIT() macro in rpc_show_xprt_state()
Date:   Sat, 16 Oct 2021 18:02:38 -0400
Message-Id:  <163442175797.1585.4544033531964902715.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
References:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; h=from:subject:message-id; bh=1EiWbj6QUPzM5ywUkYTzPyLkzpq9RCePMcHQI1S/3zw=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha0v+2o3BYOPkz/YgQaS6dYvBHfXOXvPuZGLNDYF2 ehYVBj+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtL/gAKCRAzarMzb2Z/l7LoD/ 9MvfKuCo1+ZAfAAMqJxlKlPQg+f5CZob+byZxXDSG9lJYYwCjqxB/oiryMhQPRjGCyNs9HyKdQBpKC z0dBOsiFha/uLk01aqIIXmXz337aLtJ1O5YWu6S5M5avy4x5IGrhmpwAUCFCWmazLxMHzazZb3IsNN XYwTsnDQQjnE3vFqnkzbsFgMk8P9Xas4EtfGi4Z1MAm+JeDr68KGkdVFdhZJxpaLfEePLvvpY68m4K rplX76DV7/f374GbSiB9e7/QG9z7JAjErZJ+B1DyLMxPauBFwDJv+HYHssqpRy4iAMW62rMcw33pM5 HwlnygiQMMC36wE/eGFSumZbwdTVp6s6vRhoPqJd1c/utt8DK6c9AF5piKCrfVfsgXMqCKsZAFiYSO Xnb9Jytn6N34g5jVVWvKHQahAlyY71o/pXXJBvqBKbB1KiQvLYwhVBqRQ2jfSn2rZ2vFe1TX0bA8mF 4Aogj2C8Dr18e9SXI473Z+CexmYbp6BFKUo3Hrj8T+XqM+5xizSfb9egQ1E1dGwHDrJpukq9bM2EaY AJtQ/qEKAoOcBnpu7+SeOjFtxpmnH+AfxNRTJtgSgLBKxsU6HWzuKVSdC3B8yS6/Ji3sohJ7xiHnSd 8r1szkC+stjQRSPsNyx123yhrfgpWyQL2b/aH/qB7JJs7FWYZSKQQJsXZS9g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
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

