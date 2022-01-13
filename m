Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3B48DCCB
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jan 2022 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiAMRUk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 12:20:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42580 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiAMRUk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jan 2022 12:20:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31F33B8230C
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jan 2022 17:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6123C36AEB;
        Thu, 13 Jan 2022 17:20:37 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] SUNRPC: Don't dereference xprt->snd_task if it's a cookie
Date:   Thu, 13 Jan 2022 12:20:36 -0500
Message-Id:  <164209443651.12592.15374416779588678611.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164209428615.12592.12164353310787172940.stgit@morisot.1015granger.net>
References:  <164209428615.12592.12164353310787172940.stgit@morisot.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; h=from:subject:message-id; bh=mktTV+jXSU4foMjfWFQa847cQjBq3wKZb0bhXly+FDg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh4F9kn1M8aiGndG3ZR3qOlo2LPHdMRp5qR0YiorZ0 I5chmzmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYeBfZAAKCRAzarMzb2Z/l1tOEA C0S79QCAi+6LvHtyINi/h+xvSstqAXGjLa8Ki1dqGftd74afldaYocvJ0ckt0j37GAYu5Objda0qSp 4NHsPZPibbFbppAINVI64aRJiJ6F1F8afzzSRTEHZxr0IDfDb7iF2sHxhDoZ8Vrm9D4rAqJiW9+yT2 Hh01DYxFW3/W7WAkWDks9ZbGUZspS8TPhzcaLyW2Jr/3VaPqXLw6PDZ9QKfuSmL5O7dwLi504gGYJ/ tBoWW4td89lLX0vxaaJwkzYFttfRO4TM37Yp7vGGQAjNXulZnvdj/mzhAVoriYWkC4VM7kaATN0iwQ 1pBkZyOAxzsctq/5ZPxyNHy5akALdNyVhljxUFZnEoW9h0PSboHLOUw0e1JJkF3mSj9oCv7yLgquXf HZhlKgvzQvkmkDVDYe3uvyQ+TkbsGxY65Sk4zM58ss9fyfM+p5zh1yOHTQk81C13gvgAEgkYhFW3aC 7nqtIeEyi8QL8Zt0PDV51halL7kmQyVBETVfRgGo0xU00+NCFfm330VOjP5MA6hkGI7lL21yHyE04R E1tPHU7cM3cttCfa7yfqqZNl6fEqi1LKrCJKHAwlm8imDNW1HGqGBaKWsuWORSzVFC2/wzZKbMkBPf DWlVGvoNDv9ejp8wJ4O9fbjtMPuldyRD6sZ1AgeRtQ0iK1wvUQv8FmN1/EVg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes: e26d9972720e ("SUNRPC: Clean up scheduling of autoclose")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 3a99358c262b..28433c9f3306 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -953,7 +953,8 @@ TRACE_EVENT(rpc_socket_nospace,
 		{ BIT(XPRT_REMOVE),		"REMOVE" },		\
 		{ BIT(XPRT_CONGESTED),		"CONGESTED" },		\
 		{ BIT(XPRT_CWND_WAIT),		"CWND_WAIT" },		\
-		{ BIT(XPRT_WRITE_SPACE),	"WRITE_SPACE" })
+		{ BIT(XPRT_WRITE_SPACE),	"WRITE_SPACE" },	\
+		{ BIT(XPRT_SND_IS_COOKIE),	"SND_IS_COOKIE" })
 
 DECLARE_EVENT_CLASS(rpc_xprt_lifetime_class,
 	TP_PROTO(
@@ -1150,8 +1151,11 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
 			__entry->task_id = -1;
 			__entry->client_id = -1;
 		}
-		__entry->snd_task_id = xprt->snd_task ?
-					xprt->snd_task->tk_pid : -1;
+		if (xprt->snd_task &&
+		    !test_bit(XPRT_SND_IS_COOKIE, &xprt->state))
+			__entry->snd_task_id = xprt->snd_task->tk_pid;
+		else
+			__entry->snd_task_id = -1;
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
@@ -1196,8 +1200,12 @@ DECLARE_EVENT_CLASS(xprt_cong_event,
 			__entry->task_id = -1;
 			__entry->client_id = -1;
 		}
-		__entry->snd_task_id = xprt->snd_task ?
-					xprt->snd_task->tk_pid : -1;
+		if (xprt->snd_task &&
+		    !test_bit(XPRT_SND_IS_COOKIE, &xprt->state))
+			__entry->snd_task_id = xprt->snd_task->tk_pid;
+		else
+			__entry->snd_task_id = -1;
+
 		__entry->cong = xprt->cong;
 		__entry->cwnd = xprt->cwnd;
 		__entry->wait = test_bit(XPRT_CWND_WAIT, &xprt->state);

