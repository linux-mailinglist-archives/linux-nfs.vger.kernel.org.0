Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FEF950FB
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfHSWmH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:42:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39654 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbfHSWmH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:42:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id b1so3232875otp.6;
        Mon, 19 Aug 2019 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/m0hsTGit+/kYdO/kQGAejffnizn6DrsEepbXnB8zzE=;
        b=F9MR4XMj87DV3uiuvwdY9mykbjbw9jpvwGwNBvsmcqisp+c9V6JpNqwEPv1JOvgQ24
         RSia5daJQl7Ch+vKH27g/NowKxwaPixP+k3290igh4QAm2SQRDHQTgvPEEJ97/7GpPiT
         +f/0WtPX+X7mb2idUxP+HDetZflU8iitWDhCrZYNzjHOyHipj+OtmEqYIxzTwNqih5Lw
         DgSU+VP5bI8KKoklgdyTZLCNqKn7XI+CFSJHxJt/0+eLupNHqUwOq+VlNKVkjgEyyZO7
         K7L58E7gkTt4Cdt+UEg9xzM9Z4j2BMOmZ1eKIAh/3vBSeO8yhF5vXrSLMKWRiaAA9s7A
         1e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/m0hsTGit+/kYdO/kQGAejffnizn6DrsEepbXnB8zzE=;
        b=g/zVMUU2rWYpUjRfufV0Cb5hIgH3p+cuv3yoylYVSqry9ryjKblhFyY1ufJzaDkfKs
         KgDDZNNzeujvhCTV3lOfOhHzXrNmGb59DwLwrmUue5qlmi7btzQ4rSsbjqwH9Bp3nqPH
         XABL6uFEGnJW3IKQYmwAJjpd8wkDKZyXCvCmGoPYt6u3b9SQpg9U7k9D/eYp0bAs+Ds5
         Cusgl8UVEuzCcO/dEFasFN5weNWdzWfnPOr7vIwkInlPLFQyW/3Ju84sev9We+U80fWA
         cPTxr62ZiMIO85dCACzcrGrQXjNNv+JHo4dPUj713kpM33sye+h2tnS9ELIfWwyACy2u
         Hb+w==
X-Gm-Message-State: APjAAAVH/wrC3WFvnqCXy3KSFbxF77Wr/CuHfx5OCO29MCMXN7wPg1BR
        sm2ZIFBlrXFqnZYkaxqVzVYrWaOu
X-Google-Smtp-Source: APXvYqzd7sS9BJpdXNmrPV0z5cdCxCXX1U01H4Z39wgjNaI45FJu35oy67+UKjRM3f2gSCH5f8Cvjg==
X-Received: by 2002:a05:6830:2055:: with SMTP id f21mr19256117otp.53.1566254526015;
        Mon, 19 Aug 2019 15:42:06 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id p2sm5617047otl.59.2019.08.19.15.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:42:05 -0700 (PDT)
Subject: [PATCH v2 08/21] xprtrdma: Rename CQE field in Receive trace points
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:41:44 -0400
Message-ID: <156625448455.8161.8551241541431387600.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make the field name the same for all trace points that handle
pointers to struct rpcrdma_rep. That makes it easy to grep for
matching rep points in trace output.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   21 +++++++++++----------
 net/sunrpc/xprtrdma/verbs.c    |    2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index f6a4eaa85a3e..6e6055eb67e7 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -623,21 +623,21 @@ TRACE_EVENT(xprtrdma_post_send,
 
 TRACE_EVENT(xprtrdma_post_recv,
 	TP_PROTO(
-		const struct ib_cqe *cqe
+		const struct rpcrdma_rep *rep
 	),
 
-	TP_ARGS(cqe),
+	TP_ARGS(rep),
 
 	TP_STRUCT__entry(
-		__field(const void *, cqe)
+		__field(const void *, rep)
 	),
 
 	TP_fast_assign(
-		__entry->cqe = cqe;
+		__entry->rep = rep;
 	),
 
-	TP_printk("cqe=%p",
-		__entry->cqe
+	TP_printk("rep=%p",
+		__entry->rep
 	)
 );
 
@@ -715,14 +715,15 @@ TRACE_EVENT(xprtrdma_wc_receive,
 	TP_ARGS(wc),
 
 	TP_STRUCT__entry(
-		__field(const void *, cqe)
+		__field(const void *, rep)
 		__field(u32, byte_len)
 		__field(unsigned int, status)
 		__field(u32, vendor_err)
 	),
 
 	TP_fast_assign(
-		__entry->cqe = wc->wr_cqe;
+		__entry->rep = container_of(wc->wr_cqe, struct rpcrdma_rep,
+					    rr_cqe);
 		__entry->status = wc->status;
 		if (wc->status) {
 			__entry->byte_len = 0;
@@ -733,8 +734,8 @@ TRACE_EVENT(xprtrdma_wc_receive,
 		}
 	),
 
-	TP_printk("cqe=%p %u bytes: %s (%u/0x%x)",
-		__entry->cqe, __entry->byte_len,
+	TP_printk("rep=%p %u bytes: %s (%u/0x%x)",
+		__entry->rep, __entry->byte_len,
 		rdma_show_wc_status(__entry->status),
 		__entry->status, __entry->vendor_err
 	)
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index e639ea0faf19..3c275a7a4e4c 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1531,7 +1531,7 @@ rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
 			goto release_wrs;
 
-		trace_xprtrdma_post_recv(rep->rr_recv_wr.wr_cqe);
+		trace_xprtrdma_post_recv(rep);
 		++count;
 	}
 

