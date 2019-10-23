Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0534E1D99
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 16:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfJWOCH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 10:02:07 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45841 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406291AbfJWOCG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 10:02:06 -0400
Received: by mail-il1-f194.google.com with SMTP id u1so18986755ilq.12;
        Wed, 23 Oct 2019 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fe6PoQR4vzNs/NXT6G+Xd8x9a/ZGdlBluhjyqqcewDo=;
        b=cR4ji3vy4xu/ivLJexOt64eoZjR2/wQf5YxjruQA50s7yOg5/4VpGBcv67VB2JLGWv
         JL88SBIzcQomeQY9Cxbl07F6O0M9iqiO4/wYVY97pcCyllxb27k4iU8Cqno3UfDnsPFg
         +PkmW0dlP212BrZXQv7BD5S5MtxwmLg2SAaga3ePGEGuyWF7Wnc74w97EpoaQYa4USPn
         ff/rXWJgp1eehYj6xcPdu+AfMWT9jrKdCJ9+VHndDzm3DNnYLGNiCcvmw833JnYtmM1G
         +kjHfibhj0e+aa7/M+4GHCwN6a8Dx79OnFfGtTN2WUKNuubmKkjm1Cxoe9pwG66VmS0o
         0IxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=fe6PoQR4vzNs/NXT6G+Xd8x9a/ZGdlBluhjyqqcewDo=;
        b=FT/EdipGrRnwOxFHc7co69OqZ8eBXgakY/jKgUOm04DMWsYeyY9bR86t62HK21JLCa
         0urSNEHrY4BQdI5YZrx1OwKUQAosjg3M2CZ6baLSyJF2zTp5slkLIt/lktBV+gGNbtxz
         IpqIsz8sx/X4JVU61gcTIuFWRyUaKdK74o8xQIkzM7teJUnTuvkTuvu1IZGRSfAXiL4d
         1MDSzIEG5vCNt6TjvOstM5eCoYJDQVsPlSALOJ9m0O1554pYueaKBh4mtKhIV1SN8kFV
         C5dGD1rTfZDth+d0q013ruTnH9o5xvEJoIK1lSf5mevetgxgixG2jBtDG4n8pb4kiIoO
         9qeA==
X-Gm-Message-State: APjAAAVNaMSFm08FEmtW9sIRzUnzyY9375hphphdQQl96NirV28UZtaL
        /FsW1shyB0VC8DQlvRfYN7jpVPWY
X-Google-Smtp-Source: APXvYqwcPnI9rhtKtg2QZkizvq2pOIfa6wQTnTLq6bgxfJ/Ks/g3gH7ao28TtbUGxj6j3xlnS7Z23g==
X-Received: by 2002:a92:d0a:: with SMTP id 10mr39527275iln.238.1571839325575;
        Wed, 23 Oct 2019 07:02:05 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 26sm9038485ilx.47.2019.10.23.07.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 07:02:04 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9NE233B012548;
        Wed, 23 Oct 2019 14:02:03 GMT
Subject: [PATCH v1 3/5] xprtrdma: Refine trace_xprtrdma_fixup
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 23 Oct 2019 10:02:03 -0400
Message-ID: <20191023140203.3992.946.stgit@manet.1015granger.net>
In-Reply-To: <20191023135907.3992.69010.stgit@manet.1015granger.net>
References: <20191023135907.3992.69010.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Slightly reduce overhead and display more useful information.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   60 +++++++++-------------------------------
 net/sunrpc/xprtrdma/rpc_rdma.c |    5 +--
 2 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 201623c..465c1b0 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1084,66 +1084,32 @@
 TRACE_EVENT(xprtrdma_fixup,
 	TP_PROTO(
 		const struct rpc_rqst *rqst,
-		int len,
-		int hdrlen
+		unsigned long fixup
 	),
 
-	TP_ARGS(rqst, len, hdrlen),
+	TP_ARGS(rqst, fixup),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, task_id)
 		__field(unsigned int, client_id)
-		__field(const void *, base)
-		__field(int, len)
-		__field(int, hdrlen)
-	),
-
-	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
-		__entry->base = rqst->rq_rcv_buf.head[0].iov_base;
-		__entry->len = len;
-		__entry->hdrlen = hdrlen;
-	),
-
-	TP_printk("task:%u@%u base=%p len=%d hdrlen=%d",
-		__entry->task_id, __entry->client_id,
-		__entry->base, __entry->len, __entry->hdrlen
-	)
-);
-
-TRACE_EVENT(xprtrdma_fixup_pg,
-	TP_PROTO(
-		const struct rpc_rqst *rqst,
-		int pageno,
-		const void *pos,
-		int len,
-		int curlen
-	),
-
-	TP_ARGS(rqst, pageno, pos, len, curlen),
-
-	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
-		__field(const void *, pos)
-		__field(int, pageno)
-		__field(int, len)
-		__field(int, curlen)
+		__field(unsigned long, fixup)
+		__field(size_t, headlen)
+		__field(unsigned int, pagelen)
+		__field(size_t, taillen)
 	),
 
 	TP_fast_assign(
 		__entry->task_id = rqst->rq_task->tk_pid;
 		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
-		__entry->pos = pos;
-		__entry->pageno = pageno;
-		__entry->len = len;
-		__entry->curlen = curlen;
+		__entry->fixup = fixup;
+		__entry->headlen = rqst->rq_rcv_buf.head[0].iov_len;
+		__entry->pagelen = rqst->rq_rcv_buf.page_len;
+		__entry->taillen = rqst->rq_rcv_buf.tail[0].iov_len;
 	),
 
-	TP_printk("task:%u@%u pageno=%d pos=%p len=%d curlen=%d",
-		__entry->task_id, __entry->client_id,
-		__entry->pageno, __entry->pos, __entry->len, __entry->curlen
+	TP_printk("task:%u@%u fixup=%lu xdr=%zu/%u/%zu",
+		__entry->task_id, __entry->client_id, __entry->fixup,
+		__entry->headlen, __entry->pagelen, __entry->taillen
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 4ad8889..26d334c 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1086,7 +1086,6 @@ void rpcrdma_reset_cwnd(struct rpcrdma_xprt *r_xprt)
 	curlen = rqst->rq_rcv_buf.head[0].iov_len;
 	if (curlen > copy_len)
 		curlen = copy_len;
-	trace_xprtrdma_fixup(rqst, copy_len, curlen);
 	srcp += curlen;
 	copy_len -= curlen;
 
@@ -1106,8 +1105,6 @@ void rpcrdma_reset_cwnd(struct rpcrdma_xprt *r_xprt)
 			if (curlen > pagelist_len)
 				curlen = pagelist_len;
 
-			trace_xprtrdma_fixup_pg(rqst, i, srcp,
-						copy_len, curlen);
 			destp = kmap_atomic(ppages[i]);
 			memcpy(destp + page_base, srcp, curlen);
 			flush_dcache_page(ppages[i]);
@@ -1139,6 +1136,8 @@ void rpcrdma_reset_cwnd(struct rpcrdma_xprt *r_xprt)
 		rqst->rq_private_buf.tail[0].iov_base = srcp;
 	}
 
+	if (fixup_copy_count)
+		trace_xprtrdma_fixup(rqst, fixup_copy_count);
 	return fixup_copy_count;
 }
 

