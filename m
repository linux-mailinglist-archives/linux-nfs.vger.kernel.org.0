Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814CF7C859A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 14:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjJMMW2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjJMMW2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 08:22:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231A3CC
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 05:22:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E990C433C9;
        Fri, 13 Oct 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697199746;
        bh=5ieBfpexugpxeu6obseg8XR8H+4XnON/7uNfVF/VKbk=;
        h=Subject:From:To:Cc:Date:From;
        b=StWwC2NWuopW0LuEK0guqGpt7O+Cy6NZIX6Dw4Jop9AbAy2TB3eAMracjA2jVdROl
         0kaFawa3VB0nUw4wUdaNGZ7LDM/wNGNIruh2gLfxeMH9d/2GafaEEawqqvKMY/Wks9
         ehnpsn2uWWRJP5dBWr7TupvR1v/nauKVSn8bfCRFMznfTMtRwpfTEm6M+t+YS3RjtW
         AfQT4HkJFn3EhiwLsmOzOreH5deRlypOih0kpdlJZkaEPI29ZCMmTtJQvvjPbAbjMt
         z7X3KJtI73Zep46MVGP688Ux11iQ0cU+d3n5zsM9opZFI1855Qck70+BKnK96/8PD+
         oVsmN5k+GXSAA==
Subject: [PATCH] svcrdma: Fix tracepoint printk format
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 13 Oct 2023 08:22:24 -0400
Message-ID: <169719969566.6999.18083178189502993580.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Other tracepoints use "cq.id=" rather than "cq_id=". Let's make it
more reliable to grep for the CQ restracker ID.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

One more trivial fix to svcrdma for 6.7.

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index f8069ef2ee0f..718df1d9b834 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1667,7 +1667,7 @@ TRACE_EVENT(svcrdma_encode_wseg,
 		__entry->offset = offset;
 	),
 
-	TP_printk("cq_id=%u cid=%d segno=%u %u@0x%016llx:0x%08x",
+	TP_printk("cq.id=%u cid=%d segno=%u %u@0x%016llx:0x%08x",
 		__entry->cq_id, __entry->completion_id,
 		__entry->segno, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle
@@ -1703,7 +1703,7 @@ TRACE_EVENT(svcrdma_decode_rseg,
 		__entry->offset = segment->rs_offset;
 	),
 
-	TP_printk("cq_id=%u cid=%d segno=%u position=%u %u@0x%016llx:0x%08x",
+	TP_printk("cq.id=%u cid=%d segno=%u position=%u %u@0x%016llx:0x%08x",
 		__entry->cq_id, __entry->completion_id,
 		__entry->segno, __entry->position, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle
@@ -1740,7 +1740,7 @@ TRACE_EVENT(svcrdma_decode_wseg,
 		__entry->offset = segment->rs_offset;
 	),
 
-	TP_printk("cq_id=%u cid=%d segno=%u %u@0x%016llx:0x%08x",
+	TP_printk("cq.id=%u cid=%d segno=%u %u@0x%016llx:0x%08x",
 		__entry->cq_id, __entry->completion_id,
 		__entry->segno, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle
@@ -1959,7 +1959,7 @@ TRACE_EVENT(svcrdma_send_pullup,
 		__entry->msglen = msglen;
 	),
 
-	TP_printk("cq_id=%u cid=%d hdr=%u msg=%u (total %u)",
+	TP_printk("cq.id=%u cid=%d hdr=%u msg=%u (total %u)",
 		__entry->cq_id, __entry->completion_id,
 		__entry->hdrlen, __entry->msglen,
 		__entry->hdrlen + __entry->msglen)
@@ -2014,7 +2014,7 @@ TRACE_EVENT(svcrdma_post_send,
 					wr->ex.invalidate_rkey : 0;
 	),
 
-	TP_printk("cq_id=%u cid=%d num_sge=%u inv_rkey=0x%08x",
+	TP_printk("cq.id=%u cid=%d num_sge=%u inv_rkey=0x%08x",
 		__entry->cq_id, __entry->completion_id,
 		__entry->num_sge, __entry->inv_rkey
 	)


