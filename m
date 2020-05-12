Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C0C1D00B4
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbgELVXQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbgELVXP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:23:15 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A928EC061A0C;
        Tue, 12 May 2020 14:23:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g16so11678948qtp.11;
        Tue, 12 May 2020 14:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=x9bL/Iqx8u9/y33FYLTD6gAy1N032CHzoVQnLll7ihc=;
        b=CZ/QjaF+YHrKTPQP/W2jR2bRx6g9OaKgdWXXz3pXFziGH7njDVNg/TWQsQbYj5Suof
         jivb6x2rMk9TW74FBoWkqkqQF+1N1OLto9Fp+HhBQ1iA/IHIhWevOvriu60DkswV4MNb
         xzpfNsh4cei/D8tNsNhcGhb1Djldzs60VoRwII0BGjAkd95T8OPXAuCcqxbk5H3Jxtp3
         NAbnTTvt4BcB7zypc85JcNsIl2uh7tLpxQTZWo3d8iAAtsfx50/RoGInNhFFDEbv/fFP
         jKfcOwX6C/7EbGePWCBWWtwr0mKc5/JoMPCKJYXyk8t0WcvTNKPUVKxq7lOIPaaJSVwN
         MK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=x9bL/Iqx8u9/y33FYLTD6gAy1N032CHzoVQnLll7ihc=;
        b=UfkkqZ5EfO4Aoo+VjZwtOwJg8SNfBr4pAhl92LI5Nx673Qbd8nQnULBmXBWy7VmNb2
         +I2PN2MNYgYE27HpMU1VFaKmnzz1j//UD0GKdSb6pC79qfyfUW2Ft14iB8Yg1CT2lJMb
         6AXqXMw0TT9CtWL7aGhRaCk+3fd0qtxPgfI4XzImXEnPMqImkcsj0aMD1BORqccnbWqo
         Xp8ha67Hx/JErBUQ40gtZ7FTPMNWOuhtCAF2DB811BBVbEFFg9Y2gRCpa0dMIqPubL0V
         IySPMhu8gNmMrrxHGX2vmb6S/0P6n1MWF9i1uUTwbP7H2+CE9c2AmSwY2vAq9q4rzJ2w
         07Tg==
X-Gm-Message-State: AGi0PubZiaRDZ5Wmkfof7rUPb+Az9gmCpZ6RSS0pAjqAhFlWfVBYasLu
        DwnEuBXw5izYnC0rsoRDsEYy0/gR
X-Google-Smtp-Source: APiQypK7uRinI6wYPYDf7RqXnls0oPpUD9pDIqayrowTEW5Li57VyNQudHN9Oj+DJF6SbfIFF1SAJw==
X-Received: by 2002:ac8:342a:: with SMTP id u39mr14702761qtb.80.1589318594727;
        Tue, 12 May 2020 14:23:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v46sm10401700qtj.74.2020.05.12.14.23.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:23:14 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLNDmX009913;
        Tue, 12 May 2020 21:23:13 GMT
Subject: [PATCH v2 13/29] SUNRPC: Tracepoint to record errors in
 svc_xpo_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:23:13 -0400
Message-ID: <20200512212313.5826.1908.stgit@klimt.1015granger.net>
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

