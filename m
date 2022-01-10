Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52D489CE6
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 16:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiAJP5D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 10:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiAJP5A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 10:57:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ADFC06173F;
        Mon, 10 Jan 2022 07:57:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFC37B811EC;
        Mon, 10 Jan 2022 15:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBECC36AE9;
        Mon, 10 Jan 2022 15:56:57 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-trace-devel@vger.kernel.org
Subject: [PATCH v2 1/2] SUNRPC: Fix sockaddr handling in the svc_xprt_create_error trace point
Date:   Mon, 10 Jan 2022 10:56:56 -0500
Message-Id:  <164183021625.8391.3829842030116717221.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net>
References:  <164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2916; h=from:subject:message-id; bh=2GPu2tFeLxWrelSIIh7moOgCw6IiZaJc6NeACytsrRE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh3FdIx6aBGP+9WzUN2Pc517qEfer4K+3gJs7SXwL4 vFMxDlCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdxXSAAKCRAzarMzb2Z/l4bYD/ 0dT2Uiu1V/1OY2f6OJ0jM5HGZFl7YGa1OmmbKubqDZeFfltNc0Q7ECFbcKZaR7t3gqF+zuIyr4ME0d Dd9JEEipCcK3faGGDFwph6yjIbkhVcIRveYxIds5fSd35uFiy2uU3MAt9YngzrG6OGX1JqvUAYy+5i r7hwRTOPKuvMQPIkr5YoR4zyAkudao9Lrh7AOANJ989fTr6c00SSl1vj7Z36TRgeP2W9PyuA/cnsOM DiVs5XsmPGwLJOmC+ZYCLiPy4JhbOOeEDr08zck6OYXfFhMWdLfmEZvpra0S4IRB37emvEyjskFhqI ghyWP2Dyw/pBO9Y2sMQcPwe+xl9DLdLSiq21fkXjyVNzCalYOHJkVUOHLGulj8SgHDJtYTkc0bU+Is go6RN1ckIQv7Nqdc/6d3og0XzvEl7wUqo4t7v+9CaJvl5NugLGUyNIrhX6zZlJo51vrevX3NfbHdVe R0xG0IlbUI/GHv/RIpdosZWS1AcE3adrSNGzX640kAklShGtAIUuIrRYdmmyCryXElM1Befj0Tfpmy kzdbGWZ6PxZFYcdW9583Sm3Lp5eN5M34ISLXC+UK8dXDPwQw4OKOjINeXGjMGVRbAdrirIHl6begdD mAL/Or2zPaWrPTJNPWUuhAVWUWselBn3u2lfhpzFlpDGT2lNhbcexhhMfw0g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While testing, I got an unexpected KASAN splat:

Jan 08 13:50:27 oracle-102.nfsv4.dev kernel: BUG: KASAN: stack-out-of-bounds in trace_event_raw_event_svc_xprt_create_err+0x190/0x210 [sunrpc]
Jan 08 13:50:27 oracle-102.nfsv4.dev kernel: Read of size 28 at addr ffffc9000008f728 by task mount.nfs/4628

The memcpy() in the TP_fast_assign section of this trace point
copies the size of the destination buffer in order that the buffer
won't be overrun.

In other similar trace points, the source buffer for this memcpy is
a "struct sockaddr_storage" so the actual length of the source
buffer is always long enough to prevent the memcpy from reading
uninitialized or unallocated memory.

However, for this trace point, the source buffer can be as small as
a "struct sockaddr_in". For AF_INET sockaddrs, the memcpy() reads
memory that follows the source buffer, which is not always valid
memory.

To avoid copying past the end of the passed-in sockaddr, make the
source address's length available to the memcpy(). It would be a
little nicer if the tracing infrastructure was more friendly about
storing socket addresses that are not AF_INET, but I could not find
a way to make printk("%pIS") work with a dynamic array.

Reported-by: KASAN
Fixes: 4b8f380e46e4 ("SUNRPC: Tracepoint to record errors in svc_xpo_create()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    5 +++--
 net/sunrpc/svc_xprt.c         |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 684cc0e322fa..8ee03c9fdfdf 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1744,10 +1744,11 @@ TRACE_EVENT(svc_xprt_create_err,
 		const char *program,
 		const char *protocol,
 		struct sockaddr *sap,
+		size_t saplen,
 		const struct svc_xprt *xprt
 	),
 
-	TP_ARGS(program, protocol, sap, xprt),
+	TP_ARGS(program, protocol, sap, saplen, xprt),
 
 	TP_STRUCT__entry(
 		__field(long, error)
@@ -1760,7 +1761,7 @@ TRACE_EVENT(svc_xprt_create_err,
 		__entry->error = PTR_ERR(xprt);
 		__assign_str(program, program);
 		__assign_str(protocol, protocol);
-		memcpy(__entry->addr, sap, sizeof(__entry->addr));
+		memcpy(__entry->addr, sap, min(saplen, sizeof(__entry->addr)));
 	),
 
 	TP_printk("addr=%pISpc program=%s protocol=%s error=%ld",
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b1744432489e..1d8fc9d8da09 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -243,7 +243,7 @@ static struct svc_xprt *__svc_xpo_create(struct svc_xprt_class *xcl,
 	xprt = xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
 	if (IS_ERR(xprt))
 		trace_svc_xprt_create_err(serv->sv_program->pg_name,
-					  xcl->xcl_name, sap, xprt);
+					  xcl->xcl_name, sap, len, xprt);
 	return xprt;
 }
 

