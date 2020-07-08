Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7DE21913B
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgGHUKn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUKm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:42 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A3C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:42 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so35566106qtv.8
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wh2BiRquw1J3rSiXwRzYwUcBw4WbgO07RqEwJ2K67P8=;
        b=vej/+TLVsgYJa6Skrjo8VdS8xRnZESQY33/H0yca8M2AcljoOSejety5izffPgRiDs
         Aep0h3suw5exXE7/ItxJti4TQsKGCXCfj9/f7Jch3GBHNSIJyxw7yt7Dr/zzJXGdxPuL
         Uo3LDeU5mwJ6Om2au9yPsDDag0wXThimIpRRWDjBOygOgWwXQg3gYQCOBcyYZP7+ktzq
         tCsfLFTyl7p/9pptHe1cci/PG6hd7rYKBSLW2s9qR7c2QBaCKgJk+fBMNpRz5fXiWUXV
         eMRSvFUKbkdoDGiUApZlxF+gj7okTc05yM1rjee8HoVz2GYQQ95jaCSEU02eK3GE9g4m
         PDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=wh2BiRquw1J3rSiXwRzYwUcBw4WbgO07RqEwJ2K67P8=;
        b=s4cNnYyQ5X5gEPFbEKREnOlWAHTANjYjJ5Gqkm85HrgYI5bfaY2l7KbAMJ7LGjNAit
         If2OyFQ6xYRgzM1ih5EwbB5siqRaD0qQy23pqutt6KTIbWPFqrqlcOOWemv49m5EUQd+
         Vunolv7aal8ZimLDwqAh41FD9AnLvzFwXoaRuXDx/VS8wLXwMvd+P/TzHMva+RPJB3/+
         X2dlopDQh2gsko2K/l+1hZ/BbArXk7o6m6+EgEgvmT+sUW28kzvQKLBLR05lkh5hwqAh
         g6zQjA4bA205ItQaR3roLNBvhNhgfXsQ83HEENs1gJtkzg7tJ6hEI8iCfgXFfnU34QVm
         GfGg==
X-Gm-Message-State: AOAM531QIw+kfOsIbmdW7fHVh2Q9nv7wNAxA9kBXJIx7teIWTrcU57AB
        QCTDXrAjpbBf9Ja/AE4AGhLEQ9NE
X-Google-Smtp-Source: ABdhPJw6tQ/y2XYIfyovqn45iPyfHKtbUUWXbJ75ugN7Zo/w81rWCvyF2TSuSnLD0ECE9VwtsxFSnw==
X-Received: by 2002:ac8:75c4:: with SMTP id z4mr60879724qtq.371.1594239041596;
        Wed, 08 Jul 2020 13:10:41 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i35sm756514qtd.96.2020.07.08.13.10.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:41 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KAedP006130
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:40 GMT
Subject: [PATCH v1 19/22] SUNRPC: Replace rpcbind dprintk call sites with
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:40 -0400
Message-ID: <20200708201040.22129.3056.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In many cases, tracepoints already report these errors. In others,
the dprintks were mainly useful when this code was less mature.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   86 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/rpcb_clnt.c        |   24 ++---------
 2 files changed, 90 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 946bb73afc95..9177520b55a8 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1334,6 +1334,92 @@ TRACE_EVENT(rpcb_setport,
 	)
 );
 
+TRACE_EVENT(pmap_register,
+	TP_PROTO(
+		u32 program,
+		u32 version,
+		int protocol,
+		unsigned short port
+	),
+
+	TP_ARGS(program, version, protocol, port),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, program)
+		__field(unsigned int, version)
+		__field(int, protocol)
+		__field(unsigned int, port)
+	),
+
+	TP_fast_assign(
+		__entry->program = program;
+		__entry->version = version;
+		__entry->protocol = protocol;
+		__entry->port = port;
+	),
+
+	TP_printk("program=%u version=%u protocol=%d port=%u",
+		__entry->program, __entry->version,
+		__entry->protocol, __entry->port
+	)
+);
+
+TRACE_EVENT(rpcb_register,
+	TP_PROTO(
+		u32 program,
+		u32 version,
+		const char *addr,
+		const char *netid
+	),
+
+	TP_ARGS(program, version, addr, netid),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, program)
+		__field(unsigned int, version)
+		__string(addr, addr)
+		__string(netid, netid)
+	),
+
+	TP_fast_assign(
+		__entry->program = program;
+		__entry->version = version;
+		__assign_str(addr, addr);
+		__assign_str(netid, netid);
+	),
+
+	TP_printk("program=%u version=%u addr=%s netid=%s",
+		__entry->program, __entry->version,
+		__get_str(addr), __get_str(netid)
+	)
+);
+
+TRACE_EVENT(rpcb_unregister,
+	TP_PROTO(
+		u32 program,
+		u32 version,
+		const char *netid
+	),
+
+	TP_ARGS(program, version, netid),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, program)
+		__field(unsigned int, version)
+		__string(netid, netid)
+	),
+
+	TP_fast_assign(
+		__entry->program = program;
+		__entry->version = version;
+		__assign_str(netid, netid);
+	),
+
+	TP_printk("program=%u version=%u netid=%s",
+		__entry->program, __entry->version, __get_str(netid)
+	)
+);
+
 DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 	TP_PROTO(
 		const struct svc_rqst *rqst,
diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index af2882c62a3b..38fe2ce8a5aa 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -35,10 +35,6 @@
 
 #include "netns.h"
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-# define RPCDBG_FACILITY	RPCDBG_BIND
-#endif
-
 #define RPCBIND_SOCK_PATHNAME	"/var/run/rpcbind.sock"
 
 #define RPCBIND_PROGRAM		(100000u)
@@ -444,9 +440,7 @@ int rpcb_register(struct net *net, u32 prog, u32 vers, int prot, unsigned short
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 	bool is_set = false;
 
-	dprintk("RPC:       %sregistering (%u, %u, %d, %u) with local "
-			"rpcbind\n", (port ? "" : "un"),
-			prog, vers, prot, port);
+	trace_pmap_register(prog, vers, prot, port);
 
 	msg.rpc_proc = &rpcb_procedures2[RPCBPROC_UNSET];
 	if (port != 0) {
@@ -472,11 +466,6 @@ static int rpcb_register_inet4(struct sunrpc_net *sn,
 
 	map->r_addr = rpc_sockaddr2uaddr(sap, GFP_KERNEL);
 
-	dprintk("RPC:       %sregistering [%u, %u, %s, '%s'] with "
-		"local rpcbind\n", (port ? "" : "un"),
-			map->r_prog, map->r_vers,
-			map->r_addr, map->r_netid);
-
 	msg->rpc_proc = &rpcb_procedures4[RPCBPROC_UNSET];
 	if (port != 0) {
 		msg->rpc_proc = &rpcb_procedures4[RPCBPROC_SET];
@@ -503,11 +492,6 @@ static int rpcb_register_inet6(struct sunrpc_net *sn,
 
 	map->r_addr = rpc_sockaddr2uaddr(sap, GFP_KERNEL);
 
-	dprintk("RPC:       %sregistering [%u, %u, %s, '%s'] with "
-		"local rpcbind\n", (port ? "" : "un"),
-			map->r_prog, map->r_vers,
-			map->r_addr, map->r_netid);
-
 	msg->rpc_proc = &rpcb_procedures4[RPCBPROC_UNSET];
 	if (port != 0) {
 		msg->rpc_proc = &rpcb_procedures4[RPCBPROC_SET];
@@ -524,9 +508,7 @@ static int rpcb_unregister_all_protofamilies(struct sunrpc_net *sn,
 {
 	struct rpcbind_args *map = msg->rpc_argp;
 
-	dprintk("RPC:       unregistering [%u, %u, '%s'] with "
-		"local rpcbind\n",
-			map->r_prog, map->r_vers, map->r_netid);
+	trace_rpcb_unregister(map->r_prog, map->r_vers, map->r_netid);
 
 	map->r_addr = "";
 	msg->rpc_proc = &rpcb_procedures4[RPCBPROC_UNSET];
@@ -598,6 +580,8 @@ int rpcb_v4_register(struct net *net, const u32 program, const u32 version,
 	if (address == NULL)
 		return rpcb_unregister_all_protofamilies(sn, &msg);
 
+	trace_rpcb_register(map.r_prog, map.r_vers, map.r_addr, map.r_netid);
+
 	switch (address->sa_family) {
 	case AF_INET:
 		return rpcb_register_inet4(sn, address, &msg);

