Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7641C1C13
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgEARkv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARku (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:40:50 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56916C061A0C;
        Fri,  1 May 2020 10:40:50 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id q2so5086616qvd.1;
        Fri, 01 May 2020 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3Dub4iiczZWPgOci9+rLFCeI0KKy+abSYTnIWDORjBI=;
        b=akGLCr5Jer31o1RtQ/54wWkGoWTROmSluVJdJCeeLtwFDK7HeHAyeEGwtqCwY6+WHv
         ZW1OrKwiy+YXDAQK5jbl3adJkkQeuIG+1twkSFHAHe6D1hgp5Gf6iRo+31RGhVFGK6SZ
         DAPdwL6lWdo7amsga+2tfEk2vdluOGQHBZXKlWJ7/gyUfl+NefZuIiNqh//P9WgiTizl
         ZKo+jiUmv69IpKMoAKUAKV3qXKVQmu4SR7YYI1+T0AHOCQiry6kJqgFYkgEATxKIhgjW
         LvrA7cIHk6nUNFJmD+DI0LRq4om27iOfUNyTTXFX1lRE0/eaY+wR1JMa66rMetc7Src3
         XTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=3Dub4iiczZWPgOci9+rLFCeI0KKy+abSYTnIWDORjBI=;
        b=IcQbei2Lypqs74Qd0DBOsjvYG1kzAdUr9o4+2rL/41GvuSV2K/2H90Kw53z9KR54dQ
         9KJDwYJzCX/V4QsCRvboiW+uK5WdZwvHRB3pSWxNrIdMl0fxiI9cdHm4GgU3VaS/K4tn
         jyUYhMpv4mi/hfxWqgoZukg0ELgkMGiYwnAgdMW0dtwcbCay4+ClK6O5ZBKOcIKpdRYb
         XrBejerweKgvsUcVFAiuSRP2bM5UgXw3VOtUHrIGqujS5zr906JXHs8TUT3R61h0BKtO
         UutpBzoquAjy29aQazEN11T+XV2UMm7WiaU6PY1O4k9YcvrwgvgigouiBZ4/AzaBdWog
         emXw==
X-Gm-Message-State: AGi0PuakWFTxFk34X9P9FfL0kL5xhoMEdlfMQFtk/DTDHMESvgkO2jT5
        SMl29jv8ApeorJoP5uqdmWbznusR
X-Google-Smtp-Source: APiQypJxiME2jfh8PT6j62BqeuOrTGrnGdV/kO6b6rBYf3ls22OXrTM97rM60mOUB4Yny3OqQdlDhA==
X-Received: by 2002:ad4:54c3:: with SMTP id j3mr5131857qvx.241.1588354849456;
        Fri, 01 May 2020 10:40:49 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h13sm3134843qti.32.2020.05.01.10.40.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:40:48 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HelKU026774;
        Fri, 1 May 2020 17:40:47 GMT
Subject: [PATCH v1 4/7] svcrdma: trace undersized Write chunks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:40:47 -0400
Message-ID: <20200501174047.3899.79731.stgit@klimt.1015granger.net>
In-Reply-To: <20200501173903.3899.31567.stgit@klimt.1015granger.net>
References: <20200501173903.3899.31567.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: replace a dprintk call site

This is the last remaining dprintk call site in svc_rdma_rw.c, so
remove the dprintk infrastructure as well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   32 ++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    7 ++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 15dc1e852a0c..3390dd12a8dc 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1673,6 +1673,38 @@ TRACE_EVENT(svcrdma_page_overrun_err,
 	)
 );
 
+TRACE_EVENT(svcrdma_small_wrch_err,
+	TP_PROTO(
+		const struct svcxprt_rdma *rdma,
+		unsigned int remaining,
+		unsigned int seg_no,
+		unsigned int num_segs
+	),
+
+	TP_ARGS(rdma, remaining, seg_no, num_segs),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, remaining)
+		__field(unsigned int, seg_no)
+		__field(unsigned int, num_segs)
+		__string(device, rdma->sc_cm_id->device->name)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->remaining = remaining;
+		__entry->seg_no = seg_no;
+		__entry->num_segs = num_segs;
+		__assign_str(device, rdma->sc_cm_id->device->name);
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s device=%s remaining=%u seg_no=%u num_segs=%u",
+		__get_str(addr), __get_str(device), __entry->remaining,
+		__entry->seg_no, __entry->num_segs
+	)
+);
+
 TRACE_EVENT(svcrdma_send_pullup,
 	TP_PROTO(
 		unsigned int len
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 17098a11d2ad..5eb35309ecef 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -9,13 +9,10 @@
 
 #include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/svc_rdma.h>
-#include <linux/sunrpc/debug.h>
 
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-#define RPCDBG_FACILITY	RPCDBG_SVCXPRT
-
 static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc);
 static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc);
 
@@ -484,8 +481,8 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 	return 0;
 
 out_overflow:
-	dprintk("svcrdma: inadequate space in Write chunk (%u)\n",
-		info->wi_nsegs);
+	trace_svcrdma_small_wrch_err(rdma, remaining, info->wi_seg_no,
+				     info->wi_nsegs);
 	return -E2BIG;
 }
 

