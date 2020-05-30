Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B141E919C
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgE3N3r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3N3q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:29:46 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFC3C03E969;
        Sat, 30 May 2020 06:29:46 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s18so2330691ioe.2;
        Sat, 30 May 2020 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4r/jeRNeIMzGD5K2ShKLNq8WDzACqt7Z742c0xfjm2w=;
        b=dPTK3cv2MX94J6XZ0jHIjDuF4NM+6e3lmoRl78c1k1WQ65MX7y8Br+hKnFlxCZHLut
         9TFa0Wj4EdFxHtfmMRHfSEFWY/AR+li/7DmFHDJdl1Bac7WDVa5XYRBdUI0q7ngGxFVl
         RHSaiJWlxw6DhZt8GOsmxnFzVSvbDBLzuGneKJfeXhcJ9Aj9rYLvkcCZEQPEwhAiX9j2
         E3s7RMzguReFgjuuKr5ahZxzrAXRS1VduhTBaojJvLJj6RUZf5qci5T25GofMS2w9nvP
         B5E1sNKa5SPShdCWqaZlCX4+LJheei68huiispI4jI5DkBV5KioJNsWuFQUCAqfCaHcU
         mbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=4r/jeRNeIMzGD5K2ShKLNq8WDzACqt7Z742c0xfjm2w=;
        b=JD3O1duUSk7P+mnxsolUxHIjRKX71IOtyGup+n1Ecn1x/i2Rmt5+Q99dg2ILpQHi3o
         63jB4LhQkyCh5MPJSM2rjxNkIZI5GTPofIbDtpGzxAPKwwBZgrbSOyBjW9HlXPchDGxg
         nW+tF1ifcJd3HI0Z0Pww4Yvue88fvYrQh1ZqMkRzn+egWKF+1yyzIXjpo4AwDQBcensH
         d4RSmKtTktq1DcLUmwxuQL9JtrUBC8xrQ5i+43N21LkPd0HNJfcPj+hirOVsLQ/4PKdd
         9p73ZoYM0DVs4x/Thwa8YiTHhWy5jsqMzZHxY9ZNBjusKWCAHFNkFsfMii49f1+6CZ0x
         YN3g==
X-Gm-Message-State: AOAM530eii/th5huKmROfIe9TfbP0b59VuXFnClyYaQsqevwsTOGkddn
        jogZcxa3VAi0wLFUOOQzsZSbp9Wr
X-Google-Smtp-Source: ABdhPJyZKF7eI0tq4UcV5HjKR8dhSxEpbN1QlPiOc6T4D63VGRNAG4zp907AhB/2J6AipVoxUPxUZg==
X-Received: by 2002:a5d:8613:: with SMTP id f19mr11221308iol.173.1590845385407;
        Sat, 30 May 2020 06:29:45 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o18sm6264058ils.30.2020.05.30.06.29.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:29:44 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDTiH4001441;
        Sat, 30 May 2020 13:29:44 GMT
Subject: [PATCH v4 19/33] SUNRPC: Trace server-side rpcbind registration
 events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:29:44 -0400
Message-ID: <20200530132944.10117.8782.stgit@klimt.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   80 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svc.c              |   19 ++--------
 2 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 8691fbeaff17..a2e197c0d2f9 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1600,6 +1600,86 @@ DEFINE_CACHE_EVENT(cache_entry_update);
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
index 9ed3126600ce..3e74d61ca7da 100644
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
 
@@ -1024,11 +1020,8 @@ int svc_generic_rpcbind_set(struct net *net,
 		return 0;
 
 	if (vers->vs_hidden) {
-		dprintk("svc: svc_register(%sv%d, %s, %u, %u)"
-			" (but not telling portmap)\n",
-			progp->pg_name, version,
-			proto == IPPROTO_UDP?  "udp" : "tcp",
-			port, family);
+		trace_svc_noregister(progp->pg_name, version, proto,
+				     port, family, 0);
 		return 0;
 	}
 
@@ -1106,8 +1099,7 @@ static void __svc_unregister(struct net *net, const u32 program, const u32 versi
 	if (error == -EPROTONOSUPPORT)
 		error = rpcb_register(net, program, version, 0, 0);
 
-	dprintk("svc: %s(%sv%u), error %d\n",
-			__func__, progname, version, error);
+	trace_svc_unregister(progname, version, error);
 }
 
 /*
@@ -1132,9 +1124,6 @@ static void svc_unregister(const struct svc_serv *serv, struct net *net)
 				continue;
 			if (progp->pg_vers[i]->vs_hidden)
 				continue;
-
-			dprintk("svc: attempting to unregister %sv%u\n",
-				progp->pg_name, i);
 			__svc_unregister(net, progp->pg_prog, i, progp->pg_name);
 		}
 	}

