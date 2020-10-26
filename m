Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80692995FF
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781434AbgJZSyq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35106 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781703AbgJZSyo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:54:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id 140so9396038qko.2;
        Mon, 26 Oct 2020 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/UwfH7nwiffhdnewCAuG5LcH0M5Ze2QoaFOiJ4vkAGQ=;
        b=GBpz6QiHNuUHhtu9jal0pfqfn0x5ftum7RuLlwsbDmSzypODAfqU4eAEjgT8TbqSoF
         k2jLiGFyish0Si6OhYZ0t1+OKHbG9CIO5PT998fS5e8BVhFTmsUA/2fw908KWFHwHnNg
         CLmSdF9AXijla0EraAwGuI5eqbh+VO8Ij51UPdh3Uuk6+xGNKRaM2WrzPaG8NDpoCs84
         gDYsoh0GCJef7snAJ6oryXrw2fuDTt5cnJQ42WBtX7QhsWOf8et3M0qRVjy1b/ZeAMIN
         IIw4R8NSgb8T4N9CTvZAwBQlybEPbor4O5m//H0awsl/Zwyt2n1AWCDuHEy6QwEYK7SJ
         y3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/UwfH7nwiffhdnewCAuG5LcH0M5Ze2QoaFOiJ4vkAGQ=;
        b=n0eq2OO8JS3we+OkkRaoX2DWhVgGanfCfF1Pyr8Em7/gSGDD+lLAwhbsixx8vujd7f
         F2GuuwfnYmwSDRHBhxfWCF0dmCF4fvQVYJxo6PJ7upwRmn9qow0ztrK5EyYlNOFCtqAT
         FkRGl4VYOZvdFD7QXiZDyexpFo/L93sNlDRC6LMIX4ODGQIwroR5wBfQs4+cd6YYL9AG
         ClXzJTav6QWc5RAULFVCTixV2p0xC9aqtr3tbcCNhDny8zjCo0LMF7GEN+166OiZRZtS
         7T17SkAm5PF2E7R0hkZPL3FuwMkncWfcRauY6oVX71uOnqxvzxZ5wAzRoa9rdIbwFnLk
         hXWQ==
X-Gm-Message-State: AOAM532UlCyoU7QcwsK3xgWLYK1ifv3jI9c2yxui6IlyoX037Oky1CjL
        tR0A1keoGidPcSwejz4KK2MhzKBD2IM=
X-Google-Smtp-Source: ABdhPJwr3WKwafdpycABxgXEQlAv5YzgpY1TY1SVUGV4QAh1PCpg1Ui+0dtC/jSe9MCogZCkc5zoJg==
X-Received: by 2002:a05:620a:12ea:: with SMTP id f10mr17113719qkl.480.1603738482597;
        Mon, 26 Oct 2020 11:54:42 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s3sm7103631qkj.27.2020.10.26.11.54.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:54:42 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIseIH013640;
        Mon, 26 Oct 2020 18:54:40 GMT
Subject: [PATCH 09/20] svcrdma: Use parsed chunk lists to derive the inv_rkey
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:54:40 -0400
Message-ID: <160373848080.1886.5015616032132594298.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Don't duplicate header decoding smarts here. Instead, use
the new parsed chunk lists.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   67 ++++++++++++++-----------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index ec9d259b149c..2755ca178b09 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -586,60 +586,53 @@ static bool xdr_check_reply_chunk(struct svc_rdma_recv_ctxt *rctxt)
  *
  * If there is exactly one distinct R_key in the received transport
  * header, set rc_inv_rkey to that R_key. Otherwise, set it to zero.
- *
- * Perform this operation while the received transport header is
- * still in the CPU cache.
  */
 static void svc_rdma_get_inv_rkey(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_recv_ctxt *ctxt)
 {
-	__be32 inv_rkey, *p;
-	u32 i, segcount;
+	struct svc_rdma_segment *segment;
+	struct svc_rdma_chunk *chunk;
+	u32 inv_rkey;
 
 	ctxt->rc_inv_rkey = 0;
 
 	if (!rdma->sc_snd_w_inv)
 		return;
 
-	inv_rkey = xdr_zero;
-	p = ctxt->rc_recv_buf;
-	p += rpcrdma_fixed_maxsz;
-
-	/* Read list */
-	while (xdr_item_is_present(p++)) {
-		p++;	/* position */
-		if (inv_rkey == xdr_zero)
-			inv_rkey = *p;
-		else if (inv_rkey != *p)
-			return;
-		p += 4;
+	inv_rkey = 0;
+	pcl_for_each_chunk(chunk, &ctxt->rc_call_pcl) {
+		pcl_for_each_segment(segment, chunk) {
+			if (inv_rkey == 0)
+				inv_rkey = segment->rs_handle;
+			else if (inv_rkey != segment->rs_handle)
+				return;
+		}
 	}
-
-	/* Write list */
-	while (xdr_item_is_present(p++)) {
-		segcount = be32_to_cpup(p++);
-		for (i = 0; i < segcount; i++) {
-			if (inv_rkey == xdr_zero)
-				inv_rkey = *p;
-			else if (inv_rkey != *p)
+	pcl_for_each_chunk(chunk, &ctxt->rc_read_pcl) {
+		pcl_for_each_segment(segment, chunk) {
+			if (inv_rkey == 0)
+				inv_rkey = segment->rs_handle;
+			else if (inv_rkey != segment->rs_handle)
 				return;
-			p += 4;
 		}
 	}
-
-	/* Reply chunk */
-	if (xdr_item_is_present(p++)) {
-		segcount = be32_to_cpup(p++);
-		for (i = 0; i < segcount; i++) {
-			if (inv_rkey == xdr_zero)
-				inv_rkey = *p;
-			else if (inv_rkey != *p)
+	pcl_for_each_chunk(chunk, &ctxt->rc_write_pcl) {
+		pcl_for_each_segment(segment, chunk) {
+			if (inv_rkey == 0)
+				inv_rkey = segment->rs_handle;
+			else if (inv_rkey != segment->rs_handle)
 				return;
-			p += 4;
 		}
 	}
-
-	ctxt->rc_inv_rkey = be32_to_cpu(inv_rkey);
+	pcl_for_each_chunk(chunk, &ctxt->rc_reply_pcl) {
+		pcl_for_each_segment(segment, chunk) {
+			if (inv_rkey == 0)
+				inv_rkey = segment->rs_handle;
+			else if (inv_rkey != segment->rs_handle)
+				return;
+		}
+	}
+	ctxt->rc_inv_rkey = inv_rkey;
 }
 
 /**


