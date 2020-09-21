Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D174A2731A3
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIUSMG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgIUSMG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:06 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A3EC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:06 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r25so16497186ioj.0
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gfY6aVRNrVV5QUUxMxvz1pf2jGskVSQrggbPLvMUfbQ=;
        b=eUpscz7hajixEuADxo88cVbmVnseee0VhhWrwWEDDSMM+3GN/QmNiNgeTY5t+/CR8Y
         P052GCPq09eAHaawtvNtWb82lUbzuCZ9tZye/QERTdSU6X0nOsmkZPyw3NRaPxj+T8w6
         Uc2M56ioPQ9Kz9cACCZvAeMFZpf7UJfOmIkgpq/VWWALWtwve+fPnNqoxS3IK9B94Wd5
         65nuJF29rmp2qaPjIKjt26b+adOWJ0fBHgdbO1MKgiWqg1lPFyCXPdgXhEAxZJfysTjM
         vzkZlgy4q6+VTJ1H6blo7lVeg0zgAQ3xUTPbMf3tDM7nKgXznyhua6Q59/+w/qDzLnGT
         ZPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=gfY6aVRNrVV5QUUxMxvz1pf2jGskVSQrggbPLvMUfbQ=;
        b=f291/9sFHictcH46pB46lLqYIRYS/+5FutX2PUlyC8VXuM9ShRczCfb6V8LHH/6k3t
         0V7fmPZh6YxueEkMnSXF8O/PPZcj6fT7SnGE+yZ3qSNi+KnqRSRrU8q8Ad0oJF1PAIhX
         mCt520UM3EJVbVaK6oGSKU5zyYb2x1gsR4HCHnGaQoKcoIQs2/2DiWilBfMfIAGKg3b1
         NRacNL0kpYbU2e6fNXp2vUy47JNrLEVvxziop5bOeK/j+TQsNWGiBHGlhFm0HTQtKOVZ
         0WmOMWssddQLfgTVS1VuAs89Qwv6O6eXf98rHM4kwPA+AdJGv+Hihgyzh4puJSems9/2
         eLnQ==
X-Gm-Message-State: AOAM533Y41678ZZ7zCZFNlroULbS0OAKGb/N72C6lksqabfspYnLXl60
        nSZ7/x3IgGQS9qN9oXbCfos=
X-Google-Smtp-Source: ABdhPJzwGZir6HVfv7fUuw8EZ+7FjsdwD2oFfaEH7OYlro2/Kb6Z016hn1ffSZzZYvR9v20wHrBh9A==
X-Received: by 2002:a6b:ec04:: with SMTP id c4mr496119ioh.179.1600711925363;
        Mon, 21 Sep 2020 11:12:05 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j10sm5619975ilr.33.2020.09.21.11.12.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:04 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIC38I003884;
        Mon, 21 Sep 2020 18:12:03 GMT
Subject: [PATCH v2 14/27] NFSD: nfsd_compound_status tracepoint should record
 XID
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:03 -0400
Message-ID: <160071192365.1468.5120570739589347009.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
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
nfsd-1034  [000]   165.191516: nfsd4_compound_status: xid=0xe62d9610 op=1/4 OP_PUTFH status=OK
nfsd-1034  [000]   165.191637: nfsd4_compound_status: xid=0xe62d9610 op=2/4 OP_CREATE status=OK
nfsd-1034  [000]   165.191639: nfsd4_compound_status: xid=0xe62d9610 op=3/4 OP_GETFH status=OK
nfsd-1034  [000]   165.191680: nfsd4_compound_status: xid=0xe62d9610 op=4/4 OP_GETATTR status=OK

Also, report the status code symbolically instead of numerically for
faster readability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    6 ++--
 fs/nfsd/trace.h    |   86 ++++++++++++++++++++++++++++------------------------
 2 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e89a51ed2bbf..17a627f97766 100644
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
index 15b97275b3b4..afcb3bcf13f2 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -98,45 +98,6 @@ TRACE_EVENT(nfsd_setattr_args,
 	)
 );
 
-TRACE_EVENT(nfsd_compound,
-	TP_PROTO(const struct svc_rqst *rqst,
-		 u32 args_opcnt),
-	TP_ARGS(rqst, args_opcnt),
-	TP_STRUCT__entry(
-		__field(u32, xid)
-		__field(u32, args_opcnt)
-	),
-	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
-		__entry->args_opcnt = args_opcnt;
-	),
-	TP_printk("xid=0x%08x opcnt=%u",
-		__entry->xid, __entry->args_opcnt)
-)
-
-TRACE_EVENT(nfsd_compound_status,
-	TP_PROTO(u32 args_opcnt,
-		 u32 resp_opcnt,
-		 __be32 status,
-		 const char *name),
-	TP_ARGS(args_opcnt, resp_opcnt, status, name),
-	TP_STRUCT__entry(
-		__field(u32, args_opcnt)
-		__field(u32, resp_opcnt)
-		__field(int, status)
-		__string(name, name)
-	),
-	TP_fast_assign(
-		__entry->args_opcnt = args_opcnt;
-		__entry->resp_opcnt = resp_opcnt;
-		__entry->status = be32_to_cpu(status);
-		__assign_str(name, name);
-	),
-	TP_printk("op=%u/%u %s status=%d",
-		__entry->resp_opcnt, __entry->args_opcnt,
-		__get_str(name), __entry->status)
-)
-
 DECLARE_EVENT_CLASS(nfsd_fh_err_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
@@ -333,6 +294,53 @@ DEFINE_EVENT(nfsd_err_class, nfsd_##name,	\
 DEFINE_NFSD_ERR_EVENT(read_err);
 DEFINE_NFSD_ERR_EVENT(write_err);
 
+TRACE_EVENT(nfsd4_compound,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		 u32 args_opcnt
+	),
+	TP_ARGS(rqstp, args_opcnt),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, args_opcnt)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->args_opcnt = args_opcnt;
+	),
+	TP_printk("xid=0x%08x opcnt=%u",
+		__entry->xid, __entry->args_opcnt)
+)
+
+TRACE_EVENT(nfsd4_compoundstatus,
+	TP_PROTO(
+		 const struct svc_rqst *rqstp,
+		 u32 args_opcnt,
+		 u32 resp_opcnt,
+		 __be32 status,
+		 const char *name
+	),
+	TP_ARGS(rqstp, args_opcnt, resp_opcnt, status, name),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, args_opcnt)
+		__field(u32, resp_opcnt)
+		__field(int, status)
+		__string(name, name)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->args_opcnt = args_opcnt;
+		__entry->resp_opcnt = resp_opcnt;
+		__entry->status = be32_to_cpu(status);
+		__assign_str(name, name);
+	),
+	TP_printk("xid=0x%08x op=%u/%u %s status=%s",
+		__entry->xid, __entry->resp_opcnt, __entry->args_opcnt,
+		__get_str(name), show_nfs4_status(__entry->status)
+	)
+)
+
 #include "state.h"
 #include "filecache.h"
 #include "vfs.h"


