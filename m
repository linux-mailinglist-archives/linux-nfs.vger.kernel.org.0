Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323F61D00BE
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbgELVXm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731308AbgELVXm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:23:42 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2586FC061A0C;
        Tue, 12 May 2020 14:23:42 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f189so9588737qkd.5;
        Tue, 12 May 2020 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5BzQNrQOxWDpb7CbWBXAzsOoSrfajvJCRTfn9EK/+x0=;
        b=QtLn5W1ctHOtlRosAujCCtTvp1Y1S+9wNK+FM4cOpNDtQVwPbxGWmdEgjBubHC9KE/
         RF2I9KwS4xufDY+oEaWtFDNFJ5vbVoD7eQNMyRRjBAwap01eAEspbnVWIMbXx2BjiGa2
         qM9L3b2ekD/WRO30IgjQ45nn3vbK5oE/mGw8FHlRGZ0IAl9Vv0Zc8km5EshQOG04vj+2
         IXRCSxmYKq6JJQidTOj+r4WQ6rGOgjwNeb1Om22M7DHZWLH1mMM/NxsXPp8x5m+jbzWV
         EdlTb8aidC+7sUp0WutYoFvMLrSdpeY+NaozbMlwoJZDPXEagTod/lEob6CUTCeaXQMN
         MXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5BzQNrQOxWDpb7CbWBXAzsOoSrfajvJCRTfn9EK/+x0=;
        b=ZtlBxiDMsoU/e/O4ZimlhbyFIJty3pMxkSC2kh/BT1yhpaliuzGfLWXslBtYC79OZQ
         ybMpAxPAoDbQ1Ha/ndwVA6JqK/6ubizVNFVoqFf5v4Kv2LPbrahQnTxntxRXM3AWY/Eb
         e7OqrDzrrVTfzMi8l6IySBN78PnAaAHhB+E0w83UwQSvBqH+C6t4jS77WYOktFo8WgR/
         OhawSJCS41Hb4HTGHNa7Co+c2pf6bqFck5l3+lZV1qQqK0R7HAjqvT7Vr+2XCXvj1MPj
         csgZPQoYlLNx6fjNs4q2ZLLmFW34p4Z68hPQtjz+SxJks6Yik3d4ItDXe4WEIPthN6KR
         6heg==
X-Gm-Message-State: AGi0PuZ6kHe+Nau10I0f6yf1VOF2xHBUNrg3H6dH82DB42q9lR+LHc2N
        88p3LZZ6okeO7759wczk/JdWrvic
X-Google-Smtp-Source: APiQypLqTDrGM3l1HzLidfUJ/epKZYNAFDWokaAViJ6PkvwjpucQ6BswmN3VY07Up4EI/ojx9HishA==
X-Received: by 2002:a37:668b:: with SMTP id a133mr21769615qkc.488.1589318620981;
        Tue, 12 May 2020 14:23:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o20sm700023qtl.75.2020.05.12.14.23.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:23:40 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLNdCn009930;
        Tue, 12 May 2020 21:23:39 GMT
Subject: [PATCH v2 18/29] SUNRPC: Trace server-side rpcbind registration
 events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:23:39 -0400
Message-ID: <20200512212339.5826.17675.stgit@klimt.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   80 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svc.c              |   19 ++--------
 2 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ed8c991d4f04..6d85bbb7b8b1 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1581,6 +1581,86 @@ DEFINE_CACHE_EVENT(cache_entry_update);
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

