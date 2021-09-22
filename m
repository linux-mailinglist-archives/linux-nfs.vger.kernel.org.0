Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5306D414E9D
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 19:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbhIVRDn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 13:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236833AbhIVRDm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 Sep 2021 13:03:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81A4B6120F
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 17:02:12 +0000 (UTC)
Subject: [PATCH v1 2/2] SUNRPC: Capture value of xdr_buf::page_base
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 22 Sep 2021 13:02:11 -0400
Message-ID: <163233013183.3021.1228582610765814581.stgit@klimt.1015granger.net>
In-Reply-To: <163233012580.3021.10461133723714855809.stgit@klimt.1015granger.net>
References: <163233012580.3021.10461133723714855809.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This value is usually zero, but will be non-zero more often in the
future. Knowing its value can be important diagnostic information.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index fb016308c185..9ea59959a2fe 100644
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
 
@@ -1496,6 +1500,7 @@ DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 		__field(size_t, head_len)
 		__field(const void *, tail_base)
 		__field(size_t, tail_len)
+		__field(unsigned int, page_base)
 		__field(unsigned int, page_len)
 		__field(unsigned int, msg_len)
 	),
@@ -1506,14 +1511,17 @@ DECLARE_EVENT_CLASS(svc_xdr_buf_class,
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
 


