Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0439488BA0
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jan 2022 19:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiAIS0z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jan 2022 13:26:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40666 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiAIS0z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jan 2022 13:26:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C269B80D99
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jan 2022 18:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D865CC36AE3;
        Sun,  9 Jan 2022 18:26:52 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     rostedt@goodmis.org
Subject: [PATCH v1] SUNRPC: Fix sockaddr handling in the svc_xprt_create_error trace point
Date:   Sun,  9 Jan 2022 13:26:51 -0500
Message-Id:  <164175281165.5206.17055902557192579968.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850; h=from:subject:message-id; bh=XbxrKGdmuQ3Owdpcy4NQJb05NYBDRwIULWABV9MajLA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh2yjrCpqH8inEYzmN2Azku7qcsUVoajGrjMtn6Yv9 AG8mRUuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdso6wAKCRAzarMzb2Z/l6XxD/ 4s3hbNKp6Vo1BjyQBi/RiOOTTum+vrqoloski6IJ7of6WEMGQgPgG+L4Lk7z20bx5L9mNWxGaS1lly XISxvZyXhKnmVJO27jzggpL4jK11c7Cpdo2FIfH01As2xJzWVOb2uzHNGZZWVmN1/RH5x5gS1VvIgv OCKTwBMQ6MNtZxooUEQbOOYUw6oHbwk7t6zbhUy+O4dj/tOjjnfcEgCuSD/Y0WpmxN6etIKOs31/Bk yWy2RHtSDlEW7frJV4FSqxLWdpCKoCWyvDE88k7jl0V1z+072MYXvpbRcZB6ICBTL5/DL262f5s3iK 1ZPrKZWjKrVPMpbA80Y1Bo9ElGbCGJF3vEZLVfEj1mG/bNt+uJbPdxB7fHyEWmJRe0v34zlwzceBXU G4V4gtBi0f/Q0GlFXjAFraB2FxFL3p0Wn0wuk9cWsTqlNwAxG+tTQcXqnHvl1sxpcs6tCkwF+UHin4 fbQ1unI4dJlCfM0ZAQ5BspDrTISSuO0GIL6o1iIGA9aOU+r8m4GlDlMefoz6Xt/vtNr/gax8AtGhMV 9bsQr7pHVRQyzW9hXa18GpU6Hzs5oW1KTgObaLnHvBEGyuvZ9tVjntuyxzhjS2q5zuLukz2pcPBpv/ wk43SAuZn6d0OBqw8K6Z8KYaYAe/1aNAPByQB9gXAMEo082pZMn8OkPAZESw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While testing, I got an unexpected KASAN splat:

Jan 08 13:50:27 oracle-102.nfsv4.dev kernel: BUG: KASAN: stack-out-of-bounds in trace_event_raw_event_svc_xprt_create_err+0x190/0x210 [sunrpc]
Jan 08 13:50:27 oracle-102.nfsv4.dev kernel: Read of size 28 at addr ffffc9000008f728 by task mount.nfs/4628

The memcpy() in the TP_fast_assign section copies the size of the
destination buffer in order that the buffer won't be overrun. In
many other trace points, the source buffer is a "struct
sockaddr_storage" so the actual length of the source buffer is
always long enough to prevent reading from uninitialized or
unallocated memory.

However, for this trace point, the source buffer can be as small as
a "struct sockaddr_in". For AF_INET sockaddrs, the memcpy() reads
memory that follows source buffer, which is not always valid memory.

To avoid copying past the end of the passed-in sockaddr, make the
source address's length available to the memcpy(). It would be a
little nicer if the tracing infrastructure was more friendly about
storing socket addresses that are not AF_INET, but I could not find
a way to make "%pIS" work with a dynamic array.

Reported-by: KASAN
Fixes: 4b8f380e46e4 ("SUNRPC: Tracepoint to record errors in svc_xpo_create()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    5 +++--
 net/sunrpc/svc_xprt.c         |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 3a99358c262b..dd4cfd117844 100644
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
index 1e99ba1b9d72..008f1b05a7a9 100644
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
 

