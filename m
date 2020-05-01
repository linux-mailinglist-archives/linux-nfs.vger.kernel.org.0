Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB821C1BD4
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgEAReR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730229AbgEARdu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:33:50 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B258FC08E859;
        Fri,  1 May 2020 10:33:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e17so8451154qtp.7;
        Fri, 01 May 2020 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mN34Y6mlei8qRJsOn3ab5qgvrc/s/iI5ogq9M2gjqQs=;
        b=PsTcrLSPxEpJld6ThNTd9ShWJRA1il58CyKyjhMZPrs4U1yJgd7Z4h58y9JkT4tPzf
         rDhiHUexgCbUAJSzgca316cqm+WvqlW0NgzXBLZO52s7mjigCbfCHj5ey8Rs5z6v6bbV
         0SEOw05Cggj6UiHyamaCYFSPS6F2AUqcvQcK7czMpIVNFjmuj2a3TG4qR2GAw1DIlTf/
         iC33J9oVqhhWfAn7vgE9Stj56m4cG+zj6hT+aDTsp9SNcXbGULPYUNTlggRuMpHXbYhh
         10O0YXJ2LkF33GF1RA7vCxN3dlhqZAuHkNWv7OD6NCudhROb+yZ89XhGx1FeSia/1vFf
         zMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=mN34Y6mlei8qRJsOn3ab5qgvrc/s/iI5ogq9M2gjqQs=;
        b=XPlQRIlVN1/OLAI2j5RtbkJuPMDhs78lpUuD/ZjR++UpERvdkY/vuZmi8M7JYNXDU2
         kObKLl30B6eNfWk8oqnO1fSFVU+OlUAFcCSq7Ue5+CWhTy/ahlk+4M1KAle/dIQqHTuK
         /SI2TowVsbb3PmW3cNjp+EOpPhe9oX8ekcbk+ej+/+lbnFG0FPVcYCPDkt1NvxqZfJ0T
         Ob6rBwbBbIbj9r0KmK2oQb3PVxT+CMq0VjuQ1rPGiBYfowxiKF/BQcQ0Km7+Jwq25BQu
         jV7tXNDveaszQNH1Csq7B5SkoWTrMWo0Ipv7/MF7b2JMxaEHreNiPwyZQb7HTAOcsKPF
         gd0A==
X-Gm-Message-State: AGi0Pubes6S9A/ZC7Erdk5vLLGPJWj7tvC1W2Kw16Xv38sh2XJwct3H/
        VNeDXEgtLu2sR9tJ6C3veuLcmpLv
X-Google-Smtp-Source: APiQypLqWoRwjWaTllW3gPA3dHrhF3NLbjKoMl4GJ9rGMgf3ZOjS6rbpoGwSo7HhVH8iCVpoGsSX4g==
X-Received: by 2002:ac8:7581:: with SMTP id s1mr4865751qtq.260.1588354429722;
        Fri, 01 May 2020 10:33:49 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i5sm2920366qtw.97.2020.05.01.10.33.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:33:49 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HXmXB026715;
        Fri, 1 May 2020 17:33:48 GMT
Subject: [PATCH v1 5/7] SUNRPC: Tracepoint to record errors in
 svc_xpo_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 01 May 2020 13:33:48 -0400
Message-ID: <20200501173348.3798.89598.stgit@klimt.1015granger.net>
In-Reply-To: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
References: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This enables capture of failures for an audit log.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   29 +++++++++++++++++++++++++++++
 net/sunrpc/svc_xprt.c         |    7 ++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 282f703b3976..5bcc0089e9a5 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1178,6 +1178,35 @@ DEFINE_EVENT(svc_rqst_status, svc_send,
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
index e8092225e784..c444c01c6b6b 100644
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

