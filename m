Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBA01D00A1
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgELVW3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbgELVW3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:22:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ACCC061A0C;
        Tue, 12 May 2020 14:22:28 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c24so6012670qtw.7;
        Tue, 12 May 2020 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SK3QJDZhRtOH7x7kVsqSB1LJX7VwQFBUigHKiDxq+fw=;
        b=nOZYK+I4NrtI1BR6QI1o3anunsbskNf4PBFuRvBJbyKAriC80fy2WWrvtGD8TaCUXB
         PYh/6rVYL1rzaOixMrKA9XY2FZibbS3LsqjUG5A86XU88bHr87Qai3oPB+mh3/Ina9c4
         wxv9+2Ogj1ZLd1foNdm1r4vG7Ti/u+RP4mz8rdrYT5avta3FULI/Li7rLLE2ZyBVc9zj
         DtvkxVfNaN4/ae+fXuwZ6tABqAn0NFM5MNF25eKeeTKD3f5Pdvhuxv9wuYjQAIBoKVJB
         S+1ej4jC43/BWDE0AMU/EzKVFXL/6I1I0D5xNguBX48euCtRs9EQc6bOJoUYUqwf+PPU
         Hrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SK3QJDZhRtOH7x7kVsqSB1LJX7VwQFBUigHKiDxq+fw=;
        b=UHpe2oqosfsC/tlCBk1YiyBZXTQwbR/AKjWfU/DqrPYRb+IQlJeBBpmPEdfGhKC+me
         leO2up7xwNbD4yak/9uEtUYHCfPghq6YQ9O6DsJSsURdWdF5tKuc+DGPkJ8YwhIoKlC4
         RzvSs4m1EM7VAsjI0+zVeEHbFWdx1yJ2Mj5lQLDdKIApBSwOj+6ZG0fWBcMIrR/pxiqa
         /nLj67tzcgIBJISvQQZOZW1VGkgPNatCCL+oFAz+llOqW+8AHkoaf5HrWRCV6n1TBQO8
         kXBIW3qoLLBgQNEpjO1+k19QVGQaWYeQIg70imkBQHbpCSpI/oXCNuU86hVeTpQyYMLz
         o/sQ==
X-Gm-Message-State: AGi0PuahvJNk7x/5byRVIw3coygwh37uJB8sNMdE3brjhiFwHjp7Mpip
        Sjsve9G8yxzSXbuUzrEoVyFRicr1
X-Google-Smtp-Source: APiQypJ1PNDNEUb89RPfrUndFk3/m3FbgvzkTjOidoVhWmeoS2U5wktXWNMMsKexPiseZz4iNvSW3w==
X-Received: by 2002:ac8:699a:: with SMTP id o26mr23258177qtq.92.1589318547857;
        Tue, 12 May 2020 14:22:27 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j83sm11610207qke.7.2020.05.12.14.22.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:22:26 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLMPTY009885;
        Tue, 12 May 2020 21:22:25 GMT
Subject: [PATCH v2 04/29] svcrdma: Trace page overruns when constructing
 RDMA Reads
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:22:25 -0400
Message-ID: <20200512212225.5826.17442.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
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
index aca9d0f3d769..d6da6b8d521d 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1637,6 +1637,34 @@ TRACE_EVENT(svcrdma_no_rwctx_err,
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
 

