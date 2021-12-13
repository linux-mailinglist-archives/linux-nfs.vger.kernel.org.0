Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134E34722C7
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 09:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhLMIjE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 03:39:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230198AbhLMIjB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 03:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639384739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MC6PhOhzyAWel18CMB5k4w0y1BBwQhFcaDtNxNx1FpA=;
        b=e5NvlCSaUpDxQYstEID6iBSV3vaQgbqcQRtraNLplrfdWtjt4KdmtFZc2+RRyx3mwgZkRF
        BF3RJDj5jjDY9HXGoqTT/dwlAX9fIwJVMt7BdWDAegx8k4riO8EFErZMFWM5WMKttcG9e4
        wWF+jC6+g6rv8VsRE4Npmsx33vE8eU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-OB6CZRmHOSic9_RHVL497Q-1; Mon, 13 Dec 2021 03:38:54 -0500
X-MC-Unique: OB6CZRmHOSic9_RHVL497Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBC79801ADC;
        Mon, 13 Dec 2021 08:38:51 +0000 (UTC)
Received: from plambri-desk.redhat.com (unknown [10.33.36.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BF265ED33;
        Mon, 13 Dec 2021 08:38:50 +0000 (UTC)
From:   Pierguido Lambri <plambri@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Subject: [PATCH v2] SUNRPC: Add source address/port to rpc_socket* traces
Date:   Mon, 13 Dec 2021 08:38:48 +0000
Message-Id: <20211213083848.43930-1-plambri@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The rpc_socket* traces now show also the source address
and port. An example is:

kworker/u17:1-951   [005] 134218.925343: rpc_socket_close:
   socket:[46913] srcaddr=192.168.100.187:793 dstaddr=192.168.100.129:2049
   state=4 (DISCONNECTING) sk_state=7 (CLOSE)
kworker/u17:0-242   [006] 134360.841370: rpc_socket_connect:
   error=-115 socket:[56322] srcaddr=192.168.100.187:769
   dstaddr=192.168.100.129:2049 state=2 (CONNECTING) sk_state=2 (SYN_SENT)
       <idle>-0     [006] 134360.841859: rpc_socket_state_change: socket:[56322]
   srcaddr=192.168.100.187:769 dstaddr=192.168.100.129:2049 state=2 (CONNECTING)
   sk_state=1 (ESTABLISHED)

Signed-off-by: Pierguido Lambri <plambri@redhat.com>
---
 include/trace/events/sunrpc.h | 52 +++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 3a99358c262b..a6af347c935d 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -794,6 +794,9 @@ RPC_SHOW_SOCKET
 
 RPC_SHOW_SOCK
 
+
+#include <trace/events/net_probe_common.h>
+
 /*
  * Now redefine the EM() and EMe() macros to map the enums to the strings
  * that will be printed in the output.
@@ -816,27 +819,32 @@ DECLARE_EVENT_CLASS(xs_socket_event,
 			__field(unsigned int, socket_state)
 			__field(unsigned int, sock_state)
 			__field(unsigned long long, ino)
-			__string(dstaddr,
-				xprt->address_strings[RPC_DISPLAY_ADDR])
-			__string(dstport,
-				xprt->address_strings[RPC_DISPLAY_PORT])
+			__array(__u8, saddr, sizeof(struct sockaddr_in6))
+			__array(__u8, daddr, sizeof(struct sockaddr_in6))
 		),
 
 		TP_fast_assign(
 			struct inode *inode = SOCK_INODE(socket);
+			const struct sock *sk = socket->sk;
+			const struct inet_sock *inet = inet_sk(sk);
+
+			memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+			memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+
+			TP_STORE_ADDR_PORTS(__entry, inet, sk);
+
 			__entry->socket_state = socket->state;
 			__entry->sock_state = socket->sk->sk_state;
 			__entry->ino = (unsigned long long)inode->i_ino;
-			__assign_str(dstaddr,
-				xprt->address_strings[RPC_DISPLAY_ADDR]);
-			__assign_str(dstport,
-				xprt->address_strings[RPC_DISPLAY_PORT]);
+
 		),
 
 		TP_printk(
-			"socket:[%llu] dstaddr=%s/%s "
+			"socket:[%llu] srcaddr=%pISpc dstaddr=%pISpc "
 			"state=%u (%s) sk_state=%u (%s)",
-			__entry->ino, __get_str(dstaddr), __get_str(dstport),
+			__entry->ino,
+			__entry->saddr,
+			__entry->daddr,
 			__entry->socket_state,
 			rpc_show_socket_state(__entry->socket_state),
 			__entry->sock_state,
@@ -866,29 +874,33 @@ DECLARE_EVENT_CLASS(xs_socket_event_done,
 			__field(unsigned int, socket_state)
 			__field(unsigned int, sock_state)
 			__field(unsigned long long, ino)
-			__string(dstaddr,
-				xprt->address_strings[RPC_DISPLAY_ADDR])
-			__string(dstport,
-				xprt->address_strings[RPC_DISPLAY_PORT])
+			__array(__u8, saddr, sizeof(struct sockaddr_in6))
+			__array(__u8, daddr, sizeof(struct sockaddr_in6))
 		),
 
 		TP_fast_assign(
 			struct inode *inode = SOCK_INODE(socket);
+			const struct sock *sk = socket->sk;
+			const struct inet_sock *inet = inet_sk(sk);
+
+			memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+			memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+
+			TP_STORE_ADDR_PORTS(__entry, inet, sk);
+
 			__entry->socket_state = socket->state;
 			__entry->sock_state = socket->sk->sk_state;
 			__entry->ino = (unsigned long long)inode->i_ino;
 			__entry->error = error;
-			__assign_str(dstaddr,
-				xprt->address_strings[RPC_DISPLAY_ADDR]);
-			__assign_str(dstport,
-				xprt->address_strings[RPC_DISPLAY_PORT]);
 		),
 
 		TP_printk(
-			"error=%d socket:[%llu] dstaddr=%s/%s "
+			"error=%d socket:[%llu] srcaddr=%pISpc dstaddr=%pISpc "
 			"state=%u (%s) sk_state=%u (%s)",
 			__entry->error,
-			__entry->ino, __get_str(dstaddr), __get_str(dstport),
+			__entry->ino,
+			__entry->saddr,
+			__entry->daddr,
 			__entry->socket_state,
 			rpc_show_socket_state(__entry->socket_state),
 			__entry->sock_state,
-- 
2.33.1

