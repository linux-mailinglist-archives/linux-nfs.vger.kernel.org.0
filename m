Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A81E9192
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgE3N3U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgE3N3U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:29:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07047C03E969;
        Sat, 30 May 2020 06:29:20 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d7so2311664ioq.5;
        Sat, 30 May 2020 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zMvRiknOjEfVdzV6yWNkgFPidvdltHyFTQrPuUwXsHg=;
        b=ZQx/xNm5MR/XKTa9iUQ1VGO06wcH/CnoLSq9D/ZJcIl6hNzVZxSV+ayeHDPrPEJZp1
         IIKmnUPZcZKSkIwj5WVkviJ33Gfd+EAusZJzl3ruq8i20t53rsUXHsCqB/rvWKQfUWxQ
         D94bvOMP5p/WP4Tgulce76l2UvqmIXYkLJx3gU2WV1b3C/enTd9mN0reHxlbxE2ozpcl
         EjsgNxDPeDrXQzAM3eQyS4n3L4XLOS3MRACWdvYlKsLV9f5zIO4RvnmHJTO6pIGM3Eod
         pveON3EqK1mWTFnmSCJ9ogIHiQLWAra+76PKNpOEmTyFDnsHLPvIRIHo4Q2WAhHZufNo
         8vEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zMvRiknOjEfVdzV6yWNkgFPidvdltHyFTQrPuUwXsHg=;
        b=hEvIhYxvMfZj/kyGGaJHePxTI/Ny1+kS5nOFDrPURDL5xXQlQGHruuNxZtkvZ3Oc15
         Gm2IRsoYfqCrU4j/5JNTHDZzlRUKvraOOlFxoFOJEA4d+Ak6jptDzrvPS3xQO7uZ02dO
         lJf+KJ5cE0lDkP0nZYdysIFIIoGrpyBl+7oZeUZKHPZhO4Kt03N/m0jTHI4HJ8qyaZWw
         5stpcVkx49KD38XFT97DJm+i/j+EEat1RUbiDr2d0Xw0/VI6tZ0rFEKBwBZ7aCqgPoAK
         PSadxG9fGoiC+VilXulZfmF50Sr+IN/LbklozCwU/oJ/WfBJwZzRhWJOtgif07BqGMND
         9G4w==
X-Gm-Message-State: AOAM533waGQr/vkc6OLi0F0wWNMUBayxeJzSno7g25znVIrTJsVdO76H
        69Jwea2FuHOj1jExQCAKDda3BLNm
X-Google-Smtp-Source: ABdhPJwYDlrCktcZ/xXKzB/PJXjgMcXJ2Yp0ym7Ge7ibOGDoZPUd/4gEpR/xo6vBzxHCo93ZE3P7Aw==
X-Received: by 2002:a6b:b489:: with SMTP id d131mr11181527iof.73.1590845359096;
        Sat, 30 May 2020 06:29:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h71sm6726698ili.43.2020.05.30.06.29.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:29:18 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDTHao001426;
        Sat, 30 May 2020 13:29:17 GMT
Subject: [PATCH v4 14/33] SUNRPC: Tracepoint to record errors in
 svc_xpo_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:29:17 -0400
Message-ID: <20200530132917.10117.85728.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
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
index 9b5a36422141..80625602f9b2 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1186,6 +1186,35 @@ DEFINE_EVENT(svc_rqst_status, svc_send,
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
index 7ad37ff56ff7..33619fa09d83 100644
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

