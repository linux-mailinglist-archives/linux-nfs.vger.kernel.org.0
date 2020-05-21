Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4001DCFF9
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEUOfW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbgEUOfV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:35:21 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03322C061A0E;
        Thu, 21 May 2020 07:35:21 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id o5so7641587iow.8;
        Thu, 21 May 2020 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5BzQNrQOxWDpb7CbWBXAzsOoSrfajvJCRTfn9EK/+x0=;
        b=WSx7Y9auRBMndGnGjwzz1r6cWNODnwG7feO/L+YuPFS84QL1vVzNq24KfcLtbE/32g
         AxXENnga2o2fKmBmXz6vC+Cvwug9B5TuC9bLXNLE5KOHAWfKHJNFfH9RT822tRa4e0Jv
         d5VG+ir9IgElxDX/EueK/AYENOSDf+G5Rr7OlGjOxQ+BTL1BJXJo4woN+MGdVdBVVA2C
         rW6zLgdHQD+g5Xrn7cyBKPQlf6iH2dps0WgAu0D+gTLcY0xetX3HSevbMMGFbKw9xxOQ
         nNIk8yEPm3rwCJ7WV39zrAb68P+CRnsfmkno1uIiYOxBWtIZdAjpjpAgq/O6YeejvH1u
         UgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5BzQNrQOxWDpb7CbWBXAzsOoSrfajvJCRTfn9EK/+x0=;
        b=NeSqhZJ8hgPw6sywYGpLvK6/HOJEOHYX1RMwW17nZr1mDw0aEfMCq5xo8EF3TZ/ae6
         dLXMtgRJfDq8qOIj2yOd0LYFWHd2In1FsUuY/wTGVCVVnpKJXuVNwoIEcZwYTvKJ6uQo
         qORomtWfDFw8SoZ4KkkfLhClgg5s9tFAco9mXrOnAfDvWx5r1g10PROqzxSXEfCebhGw
         nbnpyuDh9wL3AvcHQQUxWi6D9/xRu32QAmFJHjRMH6SgGyTUKXmrdlYg8XoAjEhOKjUA
         moT0Lqd5KmSB2ZZkFInRn9yke2+4USPFDaYfxP+mlJ8/KT1HkqdIi5zXlbA0FxD8efri
         Q1Cg==
X-Gm-Message-State: AOAM532dHu1YruSRANP70Tnr9afTNbpxPTCnluxwd5c5vQYQuHuskJ7d
        miiy0SUvkCFFUp0rdQU1RT62+Til
X-Google-Smtp-Source: ABdhPJznE6eX+cHQKEayoEI2n6AF2N605lCr5njVfEYpPLSTQqOxX3Ef0tRpPD49ggMQoeBYBrGZxQ==
X-Received: by 2002:a05:6602:44b:: with SMTP id e11mr7941412iov.62.1590071719533;
        Thu, 21 May 2020 07:35:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r20sm2139666ilk.44.2020.05.21.07.35.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:35:18 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEZIdw000881;
        Thu, 21 May 2020 14:35:18 GMT
Subject: [PATCH v3 18/32] SUNRPC: Trace server-side rpcbind registration
 events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:35:18 -0400
Message-ID: <20200521143518.3557.1254.stgit@klimt.1015granger.net>
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

