Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28D11C1C16
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgEARkp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARkp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:40:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C4C061A0C;
        Fri,  1 May 2020 10:40:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b188so9922605qkd.9;
        Fri, 01 May 2020 10:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bQ1GsoV6mL/QdiU1sTMcePB/ArTRzgDahu4Tj8VCGOE=;
        b=Nf8KUTFi3sMZDpmkQ0JpH+ureZnyfoeOr2VmDuOuy8FHyI1WiEZMPuwDIE490T+7Q2
         5QAC+3sthE6+WHkXbjgVz8TJcVxzbUBpFRniY1LmIZVg8A4+/oNWUokXSs2VkogVy3y4
         rbjwdaAtC2zxEXrfLRXDbzegVLoDUT0Re3luHmpJzHyMxepRAKiXNU/J+ozQx8ZszQnZ
         lVmltOlYUuSNDSAC7RXJI35a1pM3PLkBwqRpJCjY1zgGpfXIIs/c4dzZXVURa2v8l+0q
         yMKWUQcI5qF95u8rJQhkoh+GQDNJHeEaeAOMuhLUudkj/DKCb1bzNOfgSCw+52QZRu29
         fl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bQ1GsoV6mL/QdiU1sTMcePB/ArTRzgDahu4Tj8VCGOE=;
        b=JeekNOYB0wWGU70fGVs32QZbbkIWp6Fw+I08PTTBG8ueJN9TxIZQHtvnLJsAkKQiK0
         FQlsf6bJCz6NleV365McTJmQk+mtVTxdBfiVaOGFoWI5Joo2JvmK9LpO2NErjGorKjS/
         R8IWasQcgNy8frP9QceDcgc2SIiq9mrDOh6TwyPtDu8dtdt2yAwYmY7ctxc6MJ1XGSQY
         DVClLHzbYMCGHx6QqhbXciYkIvYnMDCMTvJugU++6Zyrg2wzFscBejcymXkbSZ5LXySb
         BFghfmu2mq02aYUXbuP+l1eNiYsml5KKrRjJYa5MRAkOTm9QmGoaR8kewHIrlpnlYCNA
         p3zA==
X-Gm-Message-State: AGi0PuY7Z0tJ+uN76VcxipkZp7YZb2Cgm2VjdUlmug+EXMQtbpj/8JIE
        wMQmuAZfW2rrLXM56PsQ4FcjPums
X-Google-Smtp-Source: APiQypKHncCoHbHCRfh4b+u+AbhQUu4PAyuOdkpEAq+c995Ai5xD6IhiTP0u3y3vIcrcZaMyljESJg==
X-Received: by 2002:a05:620a:13e1:: with SMTP id h1mr4750796qkl.10.1588354844058;
        Fri, 01 May 2020 10:40:44 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o43sm3066347qtc.23.2020.05.01.10.40.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:40:43 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HegEv026771;
        Fri, 1 May 2020 17:40:42 GMT
Subject: [PATCH v1 3/7] svcrdma: Trace page overruns when constructing RDMA
 Reads
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:40:42 -0400
Message-ID: <20200501174042.3899.51707.stgit@klimt.1015granger.net>
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

Clean up: Replace a dprintk call site with a tracepoint.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   28 ++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index a2fc5f3fb7d9..15dc1e852a0c 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1645,6 +1645,34 @@ TRACE_EVENT(svcrdma_no_rwctx_err,
 	)
 );
 
+TRACE_EVENT(svcrdma_page_overrun_err,
+	TP_PROTO(
+		const struct svcxprt_rdma *rdma,
+		const struct svc_rqst *rqst,
+		unsigned int pageno
+	),
+
+	TP_ARGS(rdma, rqst, pageno),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, pageno)
+		__field(u32, xid)
+		__string(device, rdma->sc_cm_id->device->name)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->pageno = pageno;
+		__entry->xid = __be32_to_cpu(rqst->rq_xid);
+		__assign_str(device, rdma->sc_cm_id->device->name);
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s device=%s xid=0x%08x pageno=%u", __get_str(addr),
+		__get_str(device), __entry->xid, __entry->pageno
+	)
+);
+
 TRACE_EVENT(svcrdma_send_pullup,
 	TP_PROTO(
 		unsigned int len
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index c2d49f607cfe..17098a11d2ad 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -676,7 +676,7 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 	return 0;
 
 out_overrun:
-	dprintk("svcrdma: request overruns rq_pages\n");
+	trace_svcrdma_page_overrun_err(cc->cc_rdma, rqstp, info->ri_pageno);
 	return -EINVAL;
 }
 

