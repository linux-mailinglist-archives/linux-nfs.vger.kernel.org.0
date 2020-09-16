Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F926CE9C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIPWXC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgIPWXB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:01 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F69AC061A31
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:02 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q4so280312ils.4
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bW7kaAmFj1OUzAjwtLAMPfTEPk6vdsjTzCFky6yUkPo=;
        b=Ba6F+JLIe5mmz431TCM1qPqVN3MkpQsCUkpRo3CJ8cOYnL3jOVzpu5XbGVTAyXf9dG
         R69fXYceSGC7ByVoZxWwr4FIU537KOdVhSKbBOgPmpTVxoxlp010fgQla+oP1g933lry
         JP7OxtN5aSAab2b2VcNlTjdWlfGoIK5KRvgw5njni8BkkTVe+sbjxbEXfvhUWOtXkD/m
         4xJ+rheqfHcMl1N5nryS9U+Hp9klhnM0zdtwlvbcPsoo+25ckl5/Hl/p9IfiNC461Mlk
         Vra/vCibVSHy4cupiQxdER5VpUhyWlrlNppz+cM0tf1zwhlxT6jnS8xnbCNxNu/bqU3a
         WhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bW7kaAmFj1OUzAjwtLAMPfTEPk6vdsjTzCFky6yUkPo=;
        b=aIfNcTQME2pg9u29f2laW/xSX/7faNIa9kWZGKacEj0AzAi55FSCbC91Vwl0gEuyDY
         Eegc+chVFaJY5YamoLpVBcZwOAN1BlLGyebQ0PKMOtKxavfiDB0O1nXlUgh+NpEU5+hY
         2IOKSzqmzPNFUbm4MPTfbs5mpVHdHPxtD83FWZLU1Gzf+6sWpI0k9L5WuFUMoyC8TtTB
         t4NTp6apga8Oqo2InG2nGnUcnnqvNz3f6c6sbOBLZwaDr788XnRnmqKxJx8r6vYTgTw9
         /Ct2GOgX8+l+oZofNWXYDBW9GIeB31JTaYW0LSQ1RfQ94p899qu9QM0gEB9ROUl0vIUF
         gdeg==
X-Gm-Message-State: AOAM53073xAEC1+fix3lBFROR3H329ERU5vAiCros7mQGJDGm6HDPuuy
        SySvrOmUD2rMlquayQPSI4A=
X-Google-Smtp-Source: ABdhPJyL42ETurmrqSSlhXBPsl09FZa1QrEY2X5pujQ68662BzAIJge+/iEHVxIaGccmaZz6i8JlHA==
X-Received: by 2002:a05:6e02:11:: with SMTP id h17mr3051569ilr.300.1600292582036;
        Wed, 16 Sep 2020 14:43:02 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a21sm9673145ioh.12.2020.09.16.14.43.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:01 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLh0CQ023005;
        Wed, 16 Sep 2020 21:43:00 GMT
Subject: [PATCH RFC 09/21] NFSD: nfsd_compound_status tracepoint should record
 XID
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:00 -0400
Message-ID: <160029258039.29208.16002360772459794781.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The two tracepoints, nfsd_compound and nfsd_compound_status, should
provide matching information, to enable the records to be bracketed
correctly. So, for example:

nfsd-1034  [000]   165.191371: nfsd4_compound:       xid=0xe62d9610 opcnt=4
nfsd-1034  [000]   165.191516: nfsd4_compound_status: xid=0xe62d9610 op=1/4 OP_PUTFH status=0
nfsd-1034  [000]   165.191637: nfsd4_compound_status: xid=0xe62d9610 op=2/4 OP_CREATE status=0
nfsd-1034  [000]   165.191639: nfsd4_compound_status: xid=0xe62d9610 op=3/4 OP_GETFH status=0
nfsd-1034  [000]   165.191680: nfsd4_compound_status: xid=0xe62d9610 op=4/4 OP_GETATTR status=0

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    6 +++---
 fs/nfsd/trace.h    |   29 ++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index eaf50eafa935..3d6ca1bfb730 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2371,7 +2371,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 	rqstp->rq_lease_breaker = (void **)&cstate->clp;
 
-	trace_nfsd_compound(rqstp, args->opcnt);
+	trace_nfsd4_compound(rqstp, args->opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
 		op = &args->ops[resp->opcnt++];
 
@@ -2450,8 +2450,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			status = op->status;
 		}
 
-		trace_nfsd_compound_status(args->opcnt, resp->opcnt, status,
-					   nfsd4_op_name(op->opnum));
+		trace_nfsd4_compoundstatus(rqstp, args->opcnt, resp->opcnt,
+					   status, nfsd4_op_name(op->opnum));
 
 		nfsd4_cstate_clear_replay(cstate);
 		nfsd4_increment_op_stats(op->opnum);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4167726fe835..f58e43b5aa98 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -102,42 +102,49 @@ NFSD_PERMISSION_LIST
 
 #define show_perm_flags(val)	__print_flags(val, "|", NFSD_PERMISSION_LIST)
 
-TRACE_EVENT(nfsd_compound,
-	TP_PROTO(const struct svc_rqst *rqst,
-		 u32 args_opcnt),
-	TP_ARGS(rqst, args_opcnt),
+TRACE_EVENT(nfsd4_compound,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		 u32 args_opcnt
+	),
+	TP_ARGS(rqstp, args_opcnt),
 	TP_STRUCT__entry(
 		__field(u32, xid)
 		__field(u32, args_opcnt)
 	),
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
 		__entry->args_opcnt = args_opcnt;
 	),
 	TP_printk("xid=0x%08x opcnt=%u",
 		__entry->xid, __entry->args_opcnt)
 )
 
-TRACE_EVENT(nfsd_compound_status,
-	TP_PROTO(u32 args_opcnt,
+TRACE_EVENT(nfsd4_compoundstatus,
+	TP_PROTO(
+		 const struct svc_rqst *rqstp,
+		 u32 args_opcnt,
 		 u32 resp_opcnt,
 		 __be32 status,
-		 const char *name),
-	TP_ARGS(args_opcnt, resp_opcnt, status, name),
+		 const char *name
+	),
+	TP_ARGS(rqstp, args_opcnt, resp_opcnt, status, name),
 	TP_STRUCT__entry(
+		__field(u32, xid)
 		__field(u32, args_opcnt)
 		__field(u32, resp_opcnt)
 		__field(int, status)
 		__string(name, name)
 	),
 	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
 		__entry->args_opcnt = args_opcnt;
 		__entry->resp_opcnt = resp_opcnt;
 		__entry->status = be32_to_cpu(status);
 		__assign_str(name, name);
 	),
-	TP_printk("op=%u/%u %s status=%d",
-		__entry->resp_opcnt, __entry->args_opcnt,
+	TP_printk("xid=0x%08x op=%u/%u %s status=%d",
+		__entry->xid, __entry->resp_opcnt, __entry->args_opcnt,
 		__get_str(name), __entry->status)
 )
 


