Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912751DCFE5
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgEUOe4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgEUOe4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:34:56 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31AC061A0E;
        Thu, 21 May 2020 07:34:54 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id n11so7302127ilj.4;
        Thu, 21 May 2020 07:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=x9bL/Iqx8u9/y33FYLTD6gAy1N032CHzoVQnLll7ihc=;
        b=Sc0DAZ/yuSy/YRi7DtI8WPQMe79K1a/3/NO5TQc1wJWt5trlMTQD815jjY1v3hEj4Q
         dKLYE/nGJ9Rm8dMxtZQBa9Fv01tjEX2QvRAQez4IYdmGVvMUmcoSW0Ga6LtFSORE660L
         TxIWBz3IP8a4x+4xdr1SLtsSErRY/1p+YpKedelzFYIW8cKMF0p+qmbs/eqSl/+Jz18a
         E22fbrdTVFnyxSobBUji6PVvXE42op1ytRlQE+5A5pNplWSJv/1xkEBTkii+EuD+nVBP
         2pmgoGEH/vw2N2S/s6rcUb/RecIRhOwrsclc+dpu/0SUSJY5vO0vHdD/A36mgkqmnMRk
         nBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=x9bL/Iqx8u9/y33FYLTD6gAy1N032CHzoVQnLll7ihc=;
        b=TcCo2LYyVB3SlbAHyfTZMgT/tYI2cdS4L66Hv9364vpka38CRAgZiYOzEyV0i2wpfg
         Zywacas/KwXHF8ttiz0VpfSrkvDo57RvlSV2G8ZfsWy0jj65MTyWFYbzdf5SRjg5jw3L
         5R8fNCxjtislkdlQjIYICnFr7jCAO2pqymrpD3JlewpabAJKNqZbxJIG+7lgZKxszeP/
         jBktfZhHDcwsNp8LL/iJbgbVNiNFvmwTXaUpjhZTzyQqcf9reAtnD6T4J6+GdxcKuKgx
         bI60XiUrrXbOOZwn4EFZDHxSRj41opBvRqAWp2vE6gxFaoKB+gijN1KOFAthcjZP/ADb
         KbFQ==
X-Gm-Message-State: AOAM530qd3BfKs0yJ1PTh6J4wbpETxll/um64NlFfZ9cbq7k3+ruelM6
        izFDsj3h4Cw+NKCGTbXjKKQnbmuo
X-Google-Smtp-Source: ABdhPJyUj08VUodR997wPnR4BIDshWKEdJ1nMOJ4oNZbl3grET+bJCL5YNz0sUU8+NXuvKxEYIcusw==
X-Received: by 2002:a92:d183:: with SMTP id z3mr9465298ilz.102.1590071693980;
        Thu, 21 May 2020 07:34:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f15sm3077690ill.58.2020.05.21.07.34.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:34:52 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEYpYW000860;
        Thu, 21 May 2020 14:34:51 GMT
Subject: [PATCH v3 13/32] SUNRPC: Tracepoint to record errors in
 svc_xpo_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:34:51 -0400
Message-ID: <20200521143451.3557.45960.stgit@klimt.1015granger.net>
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

Capture transport creation failures.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   29 +++++++++++++++++++++++++++++
 net/sunrpc/svc_xprt.c         |    7 ++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 53f2461cf552..f3296ed2b753 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1167,6 +1167,35 @@ DEFINE_EVENT(svc_rqst_status, svc_send,
 		{ (1UL << XPT_KILL_TEMP),	"XPT_KILL_TEMP"},	\
 		{ (1UL << XPT_CONG_CTRL),	"XPT_CONG_CTRL"})
 
+TRACE_EVENT(svc_xprt_create_err,
+	TP_PROTO(
+		const char *program,
+		const char *protocol,
+		struct sockaddr *sap,
+		const struct svc_xprt *xprt
+	),
+
+	TP_ARGS(program, protocol, sap, xprt),
+
+	TP_STRUCT__entry(
+		__field(long, error)
+		__string(program, program)
+		__string(protocol, protocol)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->error = PTR_ERR(xprt);
+		__assign_str(program, program);
+		__assign_str(protocol, protocol);
+		memcpy(__entry->addr, sap, sizeof(__entry->addr));
+	),
+
+	TP_printk("addr=%pISpc program=%s protocol=%s error=%ld",
+		__entry->addr, __get_str(program), __get_str(protocol),
+		__entry->error)
+);
+
 TRACE_EVENT(svc_xprt_do_enqueue,
 	TP_PROTO(struct svc_xprt *xprt, struct svc_rqst *rqst),
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 07cdbf7d5764..f89e04210a48 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -206,6 +206,7 @@ static struct svc_xprt *__svc_xpo_create(struct svc_xprt_class *xcl,
 		.sin6_port		= htons(port),
 	};
 #endif
+	struct svc_xprt *xprt;
 	struct sockaddr *sap;
 	size_t len;
 
@@ -224,7 +225,11 @@ static struct svc_xprt *__svc_xpo_create(struct svc_xprt_class *xcl,
 		return ERR_PTR(-EAFNOSUPPORT);
 	}
 
-	return xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
+	xprt = xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
+	if (IS_ERR(xprt))
+		trace_svc_xprt_create_err(serv->sv_program->pg_name,
+					  xcl->xcl_name, sap, xprt);
+	return xprt;
 }
 
 /*

