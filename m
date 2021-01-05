Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA472EAE4A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbhAEPaf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbhAEPaf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:30:35 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F31C061796
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:29:54 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id et9so14814578qvb.10
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HPoTfLOu6jh7S73eQiyM6a8ds1EMrEQwWK7v+DXpuA8=;
        b=kLydSBWKt0VY+PdWCFvmkBDBjMSdCKVpY5xcjFaqr2zcS2rJsdZNTAkrlvpEsTLc3u
         LeoHCM8xXyWwbJiuxe5SQVm5HzjL1J49w26gXCHFeH3zsXbTJZq29R82OyFUVmISBSTm
         tn1487SB/rngTZ83Rsqq+lv3Z1XWoDu37c062ihIznSwIuvmEYJTeEXXEgQqZwoVnCqM
         te5YA7zH0IMtEWtwTNUSabpKZHtjA/TQWnKyAXBP0/Z0jbt+XJBFACeYL9FvQQ34AcyJ
         1HD6rTVdrkQjatGLSNIcdfSuraZclH7BeImBz2tlQNQaAntmMpei7W82v7SFQ4EgcHvZ
         QrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=HPoTfLOu6jh7S73eQiyM6a8ds1EMrEQwWK7v+DXpuA8=;
        b=NgbuXwu+KfN3mdqk33N4/uRUbw1TcIEzSM7v1j146xu012QaoykIgOsmURbQ9tiz+g
         rOZkurqvfPyX+Lu+lq0zhjLQA9PkFHRC0M07Sl/7jrBscdxwo6vTDLzLByRfvxFrtPVu
         izvokquqGVJGcrCuGN3WdaxO0JT4vWvW+dAO32teF2phEfJDvkS6uhsBK6a7IuyK2+LV
         UUvfj+ZxMtn3xrLG7rlflw2e9vyUp4sXtSgnx7VrbVv/na06M0zg1xcya4sq/iaH21zg
         k7UfGh2cWnJlwUv4in9yZozxYx6ligXnZr2Yt62nYVjTg4U0io3610hv2DkNbxNpt2/c
         S5hQ==
X-Gm-Message-State: AOAM532Ek5huX0tXDowCRe3us82YATQmvoUOIRTDPIWi3T0nYqP4jvKe
        VE/guHUw0ZaTWGN5ZeN8SUnfVXFbqj4=
X-Google-Smtp-Source: ABdhPJySNdm3WEs6WySaJcST4iUPl8o+5VdVzd7FMWWZQVAkGsX8jpkkb6hBDby0iXteqVu3SLmgFA==
X-Received: by 2002:ad4:4b21:: with SMTP id s1mr56673878qvw.59.1609860593778;
        Tue, 05 Jan 2021 07:29:53 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y22sm116607qkj.129.2021.01.05.07.29.52
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:29:53 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FTqEH020817
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:29:52 GMT
Subject: [PATCH v1 02/42] SUNRPC: Display RPC procedure names instead of proc
 numbers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:29:52 -0500
Message-ID: <160986059213.5532.17552186357969566215.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make the sunrpc trace subsystem trace events easier to use.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 58994e013022..562f2bb1e3ff 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1556,6 +1556,7 @@ TRACE_EVENT(svc_process,
 		__field(u32, vers)
 		__field(u32, proc)
 		__string(service, name)
+		__string(procedure, rqst->rq_procinfo->pc_name)
 		__string(addr, rqst->rq_xprt ?
 			 rqst->rq_xprt->xpt_remotebuf : "(null)")
 	),
@@ -1565,13 +1566,16 @@ TRACE_EVENT(svc_process,
 		__entry->vers = rqst->rq_vers;
 		__entry->proc = rqst->rq_proc;
 		__assign_str(service, name);
+		__assign_str(procedure, rqst->rq_procinfo->pc_name);
 		__assign_str(addr, rqst->rq_xprt ?
 			     rqst->rq_xprt->xpt_remotebuf : "(null)");
 	),
 
-	TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%u",
+	TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%s",
 			__get_str(addr), __entry->xid,
-			__get_str(service), __entry->vers, __entry->proc)
+			__get_str(service), __entry->vers,
+			__get_str(procedure)
+	)
 );
 
 DECLARE_EVENT_CLASS(svc_rqst_event,
@@ -1827,6 +1831,7 @@ TRACE_EVENT(svc_stats_latency,
 	TP_STRUCT__entry(
 		__field(u32, xid)
 		__field(unsigned long, execute)
+		__string(procedure, rqst->rq_procinfo->pc_name)
 		__string(addr, rqst->rq_xprt->xpt_remotebuf)
 	),
 
@@ -1834,11 +1839,13 @@ TRACE_EVENT(svc_stats_latency,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->execute = ktime_to_us(ktime_sub(ktime_get(),
 							 rqst->rq_stime));
+		__assign_str(procedure, rqst->rq_procinfo->pc_name);
 		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s xid=0x%08x execute-us=%lu",
-		__get_str(addr), __entry->xid, __entry->execute)
+	TP_printk("addr=%s xid=0x%08x proc=%s execute-us=%lu",
+		__get_str(addr), __entry->xid, __get_str(procedure),
+		__entry->execute)
 );
 
 DECLARE_EVENT_CLASS(svc_deferred_event,


