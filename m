Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40221DCFD8
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgEUOe2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgEUOe1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:34:27 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C10C061A0E;
        Thu, 21 May 2020 07:34:27 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 79so7669762iou.2;
        Thu, 21 May 2020 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ETA1f6UFmjBQn0duK0wp3dkMLZQ+ZPmkQmCOTXOeD+c=;
        b=j5ueWyPgQAi9bDNmPRWultOryOkgXhHOv3SwYG/0fcvkvjmkA7bkiufMkZqQ10QXOG
         udfibeBIe/WcEhylKli0iGShYS40hsFFzVDnWyUBzP3jAm2uE4+BdGh33SLdBo+KcWrm
         c5In5G3VezZtdcTnjlWZSXcR4/y7y9x+wZoWTtHGggTlx0vr+sdK/hyo1aLnvCsxePpW
         N2SlkepBybCwHs6k7E6gAmen61Xesu0LjdSKIi5sPkcDMOFwgy9yEkuySFCLTtxVgqFv
         i5qYlM3hwItYbgaQ9/HohzOcNejcMfzAxBmPwn5EqYOnqW57qGThlXAMs9iYfK+ABX8A
         6hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ETA1f6UFmjBQn0duK0wp3dkMLZQ+ZPmkQmCOTXOeD+c=;
        b=i7xItNH1njckVic0Tcnl3yEi6bR1wM5pm4beqJwBeuKasdfCiosm3UJ4dPMKSUcnAj
         TC7UOMlUMB2sv2790NzlbeMFeaae6QA09bk3zHbGIuVN8as0pB+lWL4a6JgBMyNl+kda
         P+B8E/CUByL6uD4Hz/Oz46u8rzCm2K9+1HqGyEzER1Z+wEWn4NzLc/behO2+3m9TfC7+
         SFPAiO8ProRQrdsgZUTXW45IjZguf/110P2lHm/b5HuG1JjM++m1eHDIiLHvhXi3hquY
         LCmBFH1jhWWiyTeGfsl6AWUIjMg6IXlrjzWFRYp+0oPezEP+pOzeY+7SqhiUduJjpkC7
         28/Q==
X-Gm-Message-State: AOAM531cg0xHKlnsPENNAW9AFHs7UGzVMmpPkOk69IECAjsjfCRoHBgL
        8Sz7o2uvEFT0rY2BrSqv2uVz7/3u
X-Google-Smtp-Source: ABdhPJwxh5AkVt66/UW5F0EI6kvwCbEfmRrd/4fz+3rrhTD5ivtU7b0kpABa26aReaMLf4qHDVnt/Q==
X-Received: by 2002:a5d:8613:: with SMTP id f19mr7984998iol.173.1590071666902;
        Thu, 21 May 2020 07:34:26 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n65sm3062119ila.69.2020.05.21.07.34.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:34:26 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEYPCK000830;
        Thu, 21 May 2020 14:34:25 GMT
Subject: [PATCH v3 08/32] svcrdma: Rename tracepoints that record header
 decoding errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:34:25 -0400
Message-ID: <20200521143425.3557.4248.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Use a consistent naming convention so that these trace
points can be enabled quickly via a glob.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h          |    5 +++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c046b198072a..53b24c8c7860 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1355,7 +1355,7 @@ TRACE_EVENT(svcrdma_decode_rqst,
 		show_rpcrdma_proc(__entry->proc), __entry->hdrlen)
 );
 
-TRACE_EVENT(svcrdma_decode_short,
+TRACE_EVENT(svcrdma_decode_short_err,
 	TP_PROTO(
 		unsigned int hdrlen
 	),
@@ -1399,7 +1399,8 @@ DECLARE_EVENT_CLASS(svcrdma_badreq_event,
 );
 
 #define DEFINE_BADREQ_EVENT(name)					\
-		DEFINE_EVENT(svcrdma_badreq_event, svcrdma_decode_##name,\
+		DEFINE_EVENT(svcrdma_badreq_event,			\
+			     svcrdma_decode_##name##_err,		\
 				TP_PROTO(				\
 					__be32 *p			\
 				),					\
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index eee7c6478b30..e426fedb9524 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -665,23 +665,23 @@ static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg,
 	return hdr_len;
 
 out_short:
-	trace_svcrdma_decode_short(rq_arg->len);
+	trace_svcrdma_decode_short_err(rq_arg->len);
 	return -EINVAL;
 
 out_version:
-	trace_svcrdma_decode_badvers(rdma_argp);
+	trace_svcrdma_decode_badvers_err(rdma_argp);
 	return -EPROTONOSUPPORT;
 
 out_drop:
-	trace_svcrdma_decode_drop(rdma_argp);
+	trace_svcrdma_decode_drop_err(rdma_argp);
 	return 0;
 
 out_proc:
-	trace_svcrdma_decode_badproc(rdma_argp);
+	trace_svcrdma_decode_badproc_err(rdma_argp);
 	return -EINVAL;
 
 out_inval:
-	trace_svcrdma_decode_parse(rdma_argp);
+	trace_svcrdma_decode_parse_err(rdma_argp);
 	return -EINVAL;
 }
 

