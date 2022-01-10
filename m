Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7596489CE7
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 16:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiAJP5H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 10:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJP5G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 10:57:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F63C06173F;
        Mon, 10 Jan 2022 07:57:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 417BDB81677;
        Mon, 10 Jan 2022 15:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD19C36AE9;
        Mon, 10 Jan 2022 15:57:03 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-trace-devel@vger.kernel.org
Subject: [PATCH v2 2/2] SUNRPC: Fix sockaddr handling in svcsock_accept_class trace points
Date:   Mon, 10 Jan 2022 10:57:02 -0500
Message-Id:  <164183022277.8391.1083419823331230990.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net>
References:  <164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; h=from:subject:message-id; bh=ja0nADCa3nUGGRXNbkKexM5qP3x7p0I6awbUhaLYkKw=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh3FdOeE/o8HEW7gz1Iws5oS8ke5XhGVE9ZIen5STo PTWzL7OJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdxXTgAKCRAzarMzb2Z/l3NtD/ 4mwxlvRMckCmFuPWEWWxG8nLpiPMIzqYHKQNk9al0PDaM4NFVTNbHSpBnwvvUg8siTjK8bHr0tYGv0 cvPdLmdPOFTjVYxJ3XBViqtEjmlWJejCFsOEj3ekg1HuEyH1pyzZiKcGsJJB3Qk8dzup1Ug9BDezlm zpc52MWus9/3Gpv7dVl25J5cp4DcJi5t98E77CDUYSodFpj0XGkiw+3x4vP/SIuWGKw5akGKdZNxT3 chg0zWotTzfqQwK5R8AVrp9qEQcJ6jovbSN+9O24Hbi+6CvyC2OLH5VRlLfKhkJKxJrRbOrNx7XMGl EVtEGhdnvT9W583ypQt2IH5+LL6Qxeyzw2l7m7S2LffC6j47x6/4JsGC6LM4mN96LCiuyYCyD/gIhC mcXYwJSVypBT7YG6zX5nfuq2Y+Mym8lz/p62y0P2xJ1RgellwVzow1Dcq10NVE+CaMbzCbJ9by/bl+ ksaZqqqD1igPO6gDnjeH7cPaFz93Z8KGqhgw4HlRriKOWiMwEXNXYbtUhERiivyj1XZbK3S4XzLHE8 u911UOyEnVobTc2pOG2vQox7AnpJC6ka58DFVqlpeI1KrjTutKfefut71XxP9yMDUfEiQlsAT8E0ph erXJJthiwhoBBDh+YUhI77Fv2k6ugAf6SwSwu2zJ0dAr1LURr9KHorjZIgng==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Avoid potentially hazardous memory copying and the needless use of
"%pIS" -- in the kernel, an RPC service listener is always bound to
ANYADDR. Having the network namespace is helpful when recording
errors, though.

Fixes: a0469f46faab ("SUNRPC: Replace dprintk call sites in TCP state change callouts")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 8ee03c9fdfdf..81fcc662f80b 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2125,17 +2125,17 @@ DECLARE_EVENT_CLASS(svcsock_accept_class,
 	TP_STRUCT__entry(
 		__field(long, status)
 		__string(service, service)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__field(unsigned int, netns_ino)
 	),
 
 	TP_fast_assign(
 		__entry->status = status;
 		__assign_str(service, service);
-		memcpy(__entry->addr, &xprt->xpt_local, sizeof(__entry->addr));
+		__entry->netns_ino = xprt->xpt_net->ns.inum;
 	),
 
-	TP_printk("listener=%pISpc service=%s status=%ld",
-		__entry->addr, __get_str(service), __entry->status
+	TP_printk("addr=listener service=%s status=%ld",
+		__get_str(service), __entry->status
 	)
 );
 

