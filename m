Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2730B1C1BF5
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgEARiK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729040AbgEARiJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:38:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5946AC061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:38:09 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id k81so7234794qke.5
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=j0961NufbplOY1PjHPKeEZy3fMqEqoB5Z/dSp67mIHs=;
        b=Wr2ScTnxcJadagI5gkoQGtjgsmqRYIa2vHzZcRyamWp+mdR0Q7FP80V04RMW0b1jFG
         HKdHjNi++dnJ7GCzO8l8q6EG1fSl7alcez00DjC+uXUwZdQc09v+NiWdFy3DuY2SK35H
         lgJwxycjY7cvktBmpMbuTcGxfsZ32COrBkqlsR6neEVEa+w4lw9QRwPplFJ29KxpNabe
         mKBJidISfOCKIGMWzSVz6qhs8gm1inlegpgWv6MOjkMPgsfY4n8voyD6xsQOWcMXmCqp
         rcnUAcgAxcJ3/CBYGMaR7u+BlYlUeJEmMFSpqCh/1yGbORrDAG9QMhwgQCU3fnGeqCB+
         PBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=j0961NufbplOY1PjHPKeEZy3fMqEqoB5Z/dSp67mIHs=;
        b=h0URgr1jtV37e8A3S3G7PbjeyXYV2fSmWmxx6q2tdmpxq3eozctioleBEvmmfCNsM3
         QcaxpBUv/J3aVpLiEd4yJJBZnP0l1zZw2djCOeVJssQqkakSQ7dSe6KpoGKZgnEO2xEy
         vaUwTBRFBwVzu72BIOX5AL0dxB9iIDulJ++Wq0zL6VejiwkaLRzDeMRCoAZ1g9ZPqcwQ
         l7eia3hU2tgBnEg8bfQbishzu1MriLehedTS2ndGuXh09Xe960Jus4sbbUNvZoIyaLqn
         F1AKCkUsL1Wks1d6bHe7EDM3EVP/D8BbufT7lEAl0GRPfgLycAmy/zDqlZromtKS3mW5
         mZQA==
X-Gm-Message-State: AGi0PuYoY5g/HQdBmhyQhWTu/jrZQZrmiw7DH3d5zkn5iCbW/LxyaJm1
        rM2D2AA53iI6rhDe80N3zp/X7DXo
X-Google-Smtp-Source: APiQypJTvFlWvlL6a1QR0hxIO6K8UaSo3KXZML3qbJ0eluC169Ufgdi2+EyDNtyZeCwN2/vqh5HH3Q==
X-Received: by 2002:a37:9344:: with SMTP id v65mr2261619qkd.366.1588354688184;
        Fri, 01 May 2020 10:38:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u17sm2976201qtv.56.2020.05.01.10.38.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:38:07 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041Hc6n4026737
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:38:06 GMT
Subject: [PATCH v1 4/8] SUNRPC: Trace server-side rpcbind registration events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:38:06 -0400
Message-ID: <20200501173806.3868.85854.stgit@klimt.1015granger.net>
In-Reply-To: <20200501173526.3868.96971.stgit@klimt.1015granger.net>
References: <20200501173526.3868.96971.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   80 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svc.c              |   15 ++------
 2 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index cb839ceba89e..32200745f1b8 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1597,6 +1597,86 @@ DEFINE_CACHE_EVENT(cache_entry_update);
 DEFINE_CACHE_EVENT(cache_entry_make_negative);
 DEFINE_CACHE_EVENT(cache_entry_no_listener);
 
+DECLARE_EVENT_CLASS(register_class,
+	TP_PROTO(
+		const char *program,
+		const u32 version,
+		const int family,
+		const unsigned short protocol,
+		const unsigned short port,
+		int error
+	),
+
+	TP_ARGS(program, version, family, protocol, port, error),
+
+	TP_STRUCT__entry(
+		__field(u32, version)
+		__field(unsigned long, family)
+		__field(unsigned short, protocol)
+		__field(unsigned short, port)
+		__field(int, error)
+		__string(program, program)
+	),
+
+	TP_fast_assign(
+		__entry->version = version;
+		__entry->family = family;
+		__entry->protocol = protocol;
+		__entry->port = port;
+		__entry->error = error;
+		__assign_str(program, program);
+	),
+
+	TP_printk("program=%sv%u proto=%s port=%u family=%s error=%d",
+		__get_str(program), __entry->version,
+		__entry->protocol == IPPROTO_UDP ? "udp" : "tcp",
+		__entry->port, rpc_show_address_family(__entry->family),
+		__entry->error
+	)
+);
+
+#define DEFINE_REGISTER_EVENT(name) \
+	DEFINE_EVENT(register_class, svc_##name, \
+			TP_PROTO( \
+				const char *program, \
+				const u32 version, \
+				const int family, \
+				const unsigned short protocol, \
+				const unsigned short port, \
+				int error \
+			), \
+			TP_ARGS(program, version, family, protocol, \
+				port, error))
+
+DEFINE_REGISTER_EVENT(register);
+DEFINE_REGISTER_EVENT(noregister);
+
+TRACE_EVENT(svc_unregister,
+	TP_PROTO(
+		const char *program,
+		const u32 version,
+		int error
+	),
+
+	TP_ARGS(program, version, error),
+
+	TP_STRUCT__entry(
+		__field(u32, version)
+		__field(int, error)
+		__string(program, program)
+	),
+
+	TP_fast_assign(
+		__entry->version = version;
+		__entry->error = error;
+		__assign_str(program, program);
+	),
+
+	TP_printk("program=%sv%u error=%d",
+		__get_str(program), __entry->version, __entry->error
+	)
+);
+
 #endif /* _TRACE_SUNRPC_H */
 
 #include <trace/define_trace.h>
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9ed3126600ce..61473fcde92b 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -991,6 +991,7 @@ static int __svc_register(struct net *net, const char *progname,
 #endif
 	}
 
+	trace_svc_register(progname, version, protocol, port, family, error);
 	return error;
 }
 
@@ -1000,11 +1001,6 @@ int svc_rpcbind_set_version(struct net *net,
 			    unsigned short proto,
 			    unsigned short port)
 {
-	dprintk("svc: svc_register(%sv%d, %s, %u, %u)\n",
-		progp->pg_name, version,
-		proto == IPPROTO_UDP?  "udp" : "tcp",
-		port, family);
-
 	return __svc_register(net, progp->pg_name, progp->pg_prog,
 				version, family, proto, port);
 
@@ -1024,11 +1020,7 @@ int svc_generic_rpcbind_set(struct net *net,
 		return 0;
 
 	if (vers->vs_hidden) {
-		dprintk("svc: svc_register(%sv%d, %s, %u, %u)"
-			" (but not telling portmap)\n",
-			progp->pg_name, version,
-			proto == IPPROTO_UDP?  "udp" : "tcp",
-			port, family);
+		trace_svc_noregister(progp->pg_name, version, proto, port, family, 0);
 		return 0;
 	}
 
@@ -1106,8 +1098,7 @@ static void __svc_unregister(struct net *net, const u32 program, const u32 versi
 	if (error == -EPROTONOSUPPORT)
 		error = rpcb_register(net, program, version, 0, 0);
 
-	dprintk("svc: %s(%sv%u), error %d\n",
-			__func__, progname, version, error);
+	trace_svc_unregister(progname, version, error);
 }
 
 /*

