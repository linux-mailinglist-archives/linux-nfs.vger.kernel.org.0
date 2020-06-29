Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE47A20D86D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgF2Ti7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387436AbgF2Thn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:37:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A32C02F01A;
        Mon, 29 Jun 2020 07:50:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so15463459qkc.6;
        Mon, 29 Jun 2020 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LWt5VMn1ZcxMt7yWNpPg3kaN13riF8TpEU0Yu+hqL4g=;
        b=ccjyw880bYOMUMlLYUJASpm7Uk5pS9wnGKxzE+DbQa40GfqrGPpTRszSPNkXa8b/YC
         OaYvt1onN5YcGk1nPbyE7a5Qejultg5eh7U2ETBkutilyNVSjQgj72p5CcC/BCuKD34G
         d9nsBg6pu5S70U2E426HJUPV/OHUmO4DGnXehISUJmdaqdojuLoPBW8KfnFU+pFYJbrM
         WVE4CFseNL5ELKqAvP9EL3Z+q/Sb07y1sWOBkSi+8bl0ykUSxUQSsZZy0SaACtpUjc4W
         kbqEfiWvrSn43srFDw620704IvfZzQlYZElZT49ecN7t53y9X1BSqCs9Af0/vRHBxqOM
         mAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=LWt5VMn1ZcxMt7yWNpPg3kaN13riF8TpEU0Yu+hqL4g=;
        b=WLAqYG2u9K0h7+BviTM9D6uhPNncabasUheE2cxGqWR+058YRc+xZnv/QSklwnTFSi
         yVRpoYgvNP8YoRCWhj24RWHZWtzjVxsRPE/n0rdDm4HgU3SAlkYlDqSw4L6kuiZs8ISa
         Zdw5bz/YvLCm8nzwatyHX5JM+oYXRnATHJ+937Br+B0N8UuAec0oWaRFj+4Ye8ohhfHT
         +g73NS39WFZoMYHtlpAeaKEF/6qkJLuFHZZgUR6ujq4JJ9J2EynmuioP5gTbVaHfs3DH
         XuuYE2tH8HGw91VC7HBOTLPH296lsOX+eVm2EeqROKIPpt/Rj+3eKPeS4Rvr2e3OtbL6
         lC4Q==
X-Gm-Message-State: AOAM533jneX5IlQ2aSmoL+ynFR4uPLdPUphe7ygXMXu9WV8FSWQQ8/S3
        jN89fTkdgg0VLeCscdDWBZyHfoi0
X-Google-Smtp-Source: ABdhPJyeI9bYwpLT95splv3y7nUwweZcX52raR3yvgz164QAerGqzsI08DlQyoTcU27H3U0O+8Oz+Q==
X-Received: by 2002:ae9:c113:: with SMTP id z19mr15283187qki.355.1593442240871;
        Mon, 29 Jun 2020 07:50:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x26sm17078453qtr.4.2020.06.29.07.50.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:50:40 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEodhA006217;
        Mon, 29 Jun 2020 14:50:39 GMT
Subject: [PATCH v2 8/8] svcrdma: Clean up trace_svcrdma_send_failed()
 tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:50:39 -0400
Message-ID: <20200629145039.15024.6023.stgit@klimt.1015granger.net>
In-Reply-To: <20200629144802.15024.30635.stgit@klimt.1015granger.net>
References: <20200629144802.15024.30635.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

- Use the _err naming convention instead
- Remove display of kernel memory address of the controlling xprt

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |    7 ++-----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 0f05a6e2b9cb..0eff80dee066 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1716,7 +1716,7 @@ TRACE_EVENT(svcrdma_send_pullup,
 	TP_printk("len=%u", __entry->len)
 );
 
-TRACE_EVENT(svcrdma_send_failed,
+TRACE_EVENT(svcrdma_send_err,
 	TP_PROTO(
 		const struct svc_rqst *rqst,
 		int status
@@ -1727,19 +1727,16 @@ TRACE_EVENT(svcrdma_send_failed,
 	TP_STRUCT__entry(
 		__field(int, status)
 		__field(u32, xid)
-		__field(const void *, xprt)
 		__string(addr, rqst->rq_xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
 		__entry->status = status;
 		__entry->xid = __be32_to_cpu(rqst->rq_xid);
-		__entry->xprt = rqst->rq_xprt;
 		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
 	),
 
-	TP_printk("xprt=%p addr=%s xid=0x%08x status=%d",
-		__entry->xprt, __get_str(addr),
+	TP_printk("addr=%s xid=0x%08x status=%d", __get_str(addr),
 		__entry->xid, __entry->status
 	)
 );
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 57041298fe4f..f985f548346a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -971,7 +971,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
  err1:
 	svc_rdma_send_ctxt_put(rdma, sctxt);
  err0:
-	trace_svcrdma_send_failed(rqstp, ret);
+	trace_svcrdma_send_err(rqstp, ret);
 	set_bit(XPT_CLOSE, &xprt->xpt_flags);
 	return -ENOTCONN;
 }

