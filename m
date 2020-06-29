Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666C420D109
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 20:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgF2SiB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgF2Sh6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 14:37:58 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB8C02F02A;
        Mon, 29 Jun 2020 07:58:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c139so15452877qkg.12;
        Mon, 29 Jun 2020 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SlLdg/AxBKDnOkOKmPG0sqgDs2TJoeR6GghamvyHDyM=;
        b=n2hIFfOIFlX1saSoQEMhWt03/tDzjE3gn51zDiC0P+lMMeZczb65lIz2u6eRw5NMIG
         TZfLb2FST8lBac8QyorYTy+6GM9y1EMLV0haBq3ANaRhogXYhV1aAjLKlw1pWqBvAzDj
         spvtVe8rWTTbhFDVjfRDwwj+AILVa1ZTuDqLVB7HQbAco7ckbtRL4ypot3K/AdY1gHQL
         klnhwXJv/C5SQmCEbvjADvItCX80tSniDHwieDY7A50NuT1A47Vlx1USqCm6hVqE+Gcq
         myiDOlZmJUzHBDNDpoqELlN5uBat6YMmKdY2rMoX48y+hNqs4ku7yuwoLczxQy9o6aXx
         +kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SlLdg/AxBKDnOkOKmPG0sqgDs2TJoeR6GghamvyHDyM=;
        b=VHq5HGD/D+xmjIvYGXyiny7PvyflSofxtHPgrWS5uolxLvTzmcNaPbQ4sHKFX3XEmO
         VDDzRhKwCxTZor49ErJ9eWiVwwFMYHKOtIB2C00uc/YuYL13GO0Gr9Tr24bMkyr/4+T+
         CMxTsDYa8V9dPyrDxc5nw79w5SpYrpt5Ybih/lwaysLA5Ry5UMbSGDRtIGY1Z1o8EOfF
         d0frPnt/oa55RYvQ/u0HUlOk4eaEr3qbP3YSgfX36baYZm6ugSmfdbVvNxdRbz1oM/3N
         9hgWt+gSMzNxZJjm8VYA3PLSksaaslRi1DukB3wF5q/hdhCrTlgdbwaE3FFg64wJMhC3
         EbPQ==
X-Gm-Message-State: AOAM531rSOvruq8IYMQQSP8GIC5YEPoqwt3zBwrTS85yjzANJJgwIIG+
        cLAvCwvOkvcTWSx7gTJtaosSu7Sb
X-Google-Smtp-Source: ABdhPJzDZAB6YXAQwXMUYYguHvwcy8JU39pfPYhTUxrMNLI/sldK2PMZi3OgSZFaK358n0tJFff2Hw==
X-Received: by 2002:a37:4d97:: with SMTP id a145mr14959490qkb.380.1593442720430;
        Mon, 29 Jun 2020 07:58:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e25sm19154410qtc.93.2020.06.29.07.58.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:58:40 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEwdOe006242;
        Mon, 29 Jun 2020 14:58:39 GMT
Subject: [PATCH v1 1/6] svcrdma: Introduce infrastructure to support
 completion IDs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:58:39 -0400
Message-ID: <20200629145839.15100.91731.stgit@klimt.1015granger.net>
In-Reply-To: <20200629145528.15100.77805.stgit@klimt.1015granger.net>
References: <20200629145528.15100.77805.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The goal is to replace CQE kernel memory addresses in completion-
related tracepoints.

Each completion ID matches an incoming Send or Receive completion
to a Completion Queue and to a previous ib_post_*(). The ID can
then be displayed in an error message or recorded in a trace
record.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/rpc_rdma_cid.h |   24 ++++++++++++++++++++
 include/trace/events/rpcrdma.h      |   43 +++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 include/linux/sunrpc/rpc_rdma_cid.h

diff --git a/include/linux/sunrpc/rpc_rdma_cid.h b/include/linux/sunrpc/rpc_rdma_cid.h
new file mode 100644
index 000000000000..be24ab2baa6a
--- /dev/null
+++ b/include/linux/sunrpc/rpc_rdma_cid.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#ifndef RPC_RDMA_CID_H
+#define RPC_RDMA_CID_H
+
+/*
+ * The rpc_rdma_cid struct records completion ID information. A
+ * completion ID matches an incoming Send or Receive completion
+ * to a Completion Queue and to a previous ib_post_*(). The ID
+ * can then be displayed in an error message or recorded in a
+ * trace record.
+ *
+ * This struct is shared between the server and client RPC/RDMA
+ * transport implementations.
+ */
+struct rpc_rdma_cid {
+	u32			ci_queue_id;
+	int			ci_completion_id;
+};
+
+#endif	/* RPC_RDMA_CID_H */
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 0eff80dee066..70ab989aa3b7 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -11,6 +11,7 @@
 #define _TRACE_RPCRDMA_H
 
 #include <linux/scatterlist.h>
+#include <linux/sunrpc/rpc_rdma_cid.h>
 #include <linux/tracepoint.h>
 #include <trace/events/rdma.h>
 
@@ -18,6 +19,48 @@
  ** Event classes
  **/
 
+DECLARE_EVENT_CLASS(rpcrdma_completion_class,
+	TP_PROTO(
+		const struct ib_wc *wc,
+		const struct rpc_rdma_cid *cid
+	),
+
+	TP_ARGS(wc, cid),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
+		__field(unsigned long, status)
+		__field(unsigned int, vendor_err)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
+		__entry->status = wc->status;
+		if (wc->status)
+			__entry->vendor_err = wc->vendor_err;
+		else
+			__entry->vendor_err = 0;
+	),
+
+	TP_printk("cq.id=%u cid=%d status=%s (%lu/0x%x)",
+		__entry->cq_id, __entry->completion_id,
+		rdma_show_wc_status(__entry->status),
+		__entry->status, __entry->vendor_err
+	)
+);
+
+#define DEFINE_COMPLETION_EVENT(name)					\
+		DEFINE_EVENT(rpcrdma_completion_class, name,		\
+				TP_PROTO(				\
+					const struct ib_wc *wc,		\
+					const struct rpc_rdma_cid *cid	\
+				),					\
+				TP_ARGS(wc, cid))
+
+DEFINE_COMPLETION_EVENT(dummy);
+
 DECLARE_EVENT_CLASS(xprtrdma_reply_event,
 	TP_PROTO(
 		const struct rpcrdma_rep *rep

