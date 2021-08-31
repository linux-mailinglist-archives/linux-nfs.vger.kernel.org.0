Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3643FCD75
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhHaTGO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 15:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240182AbhHaTGM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Aug 2021 15:06:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99E3061041;
        Tue, 31 Aug 2021 19:05:16 +0000 (UTC)
Subject: [PATCH RFC 1/6] SUNRPC: Capture value of xdr_buf::page_base
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 31 Aug 2021 15:05:15 -0400
Message-ID: <163043671590.1415.2588181016845773403.stgit@klimt.1015granger.net>
In-Reply-To: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
References: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This value will be non-zero more often, after subsequent patches are
applied. Knowing its value can be important diagnostic information.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index d323f5a049c8..f13de06b7c1d 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -62,6 +62,7 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
 		__field(size_t, head_len)
 		__field(const void *, tail_base)
 		__field(size_t, tail_len)
+		__field(unsigned int, page_base)
 		__field(unsigned int, page_len)
 		__field(unsigned int, msg_len)
 	),
@@ -74,14 +75,17 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
 		__entry->head_len = xdr->head[0].iov_len;
 		__entry->tail_base = xdr->tail[0].iov_base;
 		__entry->tail_len = xdr->tail[0].iov_len;
+		__entry->page_base = xdr->page_base;
 		__entry->page_len = xdr->page_len;
 		__entry->msg_len = xdr->len;
 	),
 
-	TP_printk("task:%u@%u head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+	TP_printk("task:%u@%u head=[%p,%zu] page=%u(%u) tail=[%p,%zu] len=%u",
 		__entry->task_id, __entry->client_id,
-		__entry->head_base, __entry->head_len, __entry->page_len,
-		__entry->tail_base, __entry->tail_len, __entry->msg_len
+		__entry->head_base, __entry->head_len,
+		__entry->page_len, __entry->page_base,
+		__entry->tail_base, __entry->tail_len,
+		__entry->msg_len
 	)
 );
 
@@ -1525,6 +1529,7 @@ DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 		__field(size_t, head_len)
 		__field(const void *, tail_base)
 		__field(size_t, tail_len)
+		__field(unsigned int, page_base)
 		__field(unsigned int, page_len)
 		__field(unsigned int, msg_len)
 	),
@@ -1535,14 +1540,17 @@ DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 		__entry->head_len = xdr->head[0].iov_len;
 		__entry->tail_base = xdr->tail[0].iov_base;
 		__entry->tail_len = xdr->tail[0].iov_len;
+		__entry->page_base = xdr->page_base;
 		__entry->page_len = xdr->page_len;
 		__entry->msg_len = xdr->len;
 	),
 
-	TP_printk("xid=0x%08x head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+	TP_printk("xid=0x%08x head=[%p,%zu] page=%u(%u) tail=[%p,%zu] len=%u",
 		__entry->xid,
-		__entry->head_base, __entry->head_len, __entry->page_len,
-		__entry->tail_base, __entry->tail_len, __entry->msg_len
+		__entry->head_base, __entry->head_len,
+		__entry->page_len, __entry->page_base,
+		__entry->tail_base, __entry->tail_len,
+		__entry->msg_len
 	)
 );
 


