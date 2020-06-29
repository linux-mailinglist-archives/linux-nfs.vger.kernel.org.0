Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499A720D8F4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbgF2Tm7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387991AbgF2Tmo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:42:44 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B47C02F01F;
        Mon, 29 Jun 2020 07:53:41 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id u8so7730147qvj.12;
        Mon, 29 Jun 2020 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oe6zXUAJrbLb+gNvG1GakCXoc4L58mZhZKOCT91wgh8=;
        b=TYpjDjYNw3a15m7xNt46+gkB87BlQ0wwC1k9uO9QwwQ7K9szlMOjDM3KuDhewfRNas
         +P0JUR0HyHT6TCkr2aOBMCWi0XYHEHvI+ykxNLvu/W2VxFS9aO+4Cyinn4Q7n3uP4YRC
         ttTsyJGVN1JX+pOET8/GamuiRMzt3MXpuBvxifDCzKLa8gdEXpqetSRqUE0fB1lZ5sAT
         u40xF7OQGuipNQPL+qO+IBUWnz9c8HAt1DsK91QdFWQZWaZYCCc3sxH2O0/ktQPGg2QZ
         /HKsowtWKq/htWeDToIy3a1I8Oz06rX4vUimRJeCeWJmMsNUTS+lXpv5QL+MWUYMmA6p
         FBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=oe6zXUAJrbLb+gNvG1GakCXoc4L58mZhZKOCT91wgh8=;
        b=S0lZNAj4ORwKjl+Hb8Ty13AwkUowajCJK9qI7UUdJt4BlGOiug9Mnc2hqfo3QkTH1t
         Wc4hvy4o5orZjRC7Md4z3diQOnXr4KZtdccAYo11cP3kfKiXE3DRZcQzAmtwK/2mcAxP
         SzX+YjMQv/hlfEhVzY7onN5WyRie2jCV65sHsfK18U1kYhxWhRnwzg70w+3IIqtTQdrE
         mOxI6Kir9rIizylce9M8sv2X5ijNhjXssJJdwFMziyYX9sOa4GTLq0NqcILKsYZH4ZSm
         +uqWCpeCthXeU+B1iWpP1oT1/ugEn+xUMG62oBoh7SNgQVtViCj7iK5iTyIS9QpLLYAY
         rAlQ==
X-Gm-Message-State: AOAM532xhciqowzFZjbRse/3VA6Z8HUhq2PiurPh7GPvT2lohCpJaBMK
        e0eDJkOUtwwAqeENle/6QHCfX7Sc
X-Google-Smtp-Source: ABdhPJx30d90jisGmE+iUWR9URV4UM0VhjCxCW4DcvbohC9eX7n37yaiVhSArF0gjxYG69DhS4VzVg==
X-Received: by 2002:a0c:9ad7:: with SMTP id k23mr2627036qvf.173.1593442419906;
        Mon, 29 Jun 2020 07:53:39 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t57sm15022328qtc.91.2020.06.29.07.53.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:53:39 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TErcGu006227;
        Mon, 29 Jun 2020 14:53:38 GMT
Subject: [PATCH v1 2/4] SUNRPC: Add helpers for decoding list discriminators
 symbolically
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:53:38 -0400
Message-ID: <20200629145338.15063.29487.stgit@klimt.1015granger.net>
In-Reply-To: <20200629145150.15063.29447.stgit@klimt.1015granger.net>
References: <20200629145150.15063.29447.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use these helpers in a few spots to demonstrate their use.

The remaining open-coded discriminator checks in rpcrdma will be
addressed in subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h              |   26 ++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c          |   12 ++++++------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   17 ++++++++---------
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 22c207b2425f..5a6a81b7cd9f 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -474,6 +474,32 @@ xdr_stream_encode_uint32_array(struct xdr_stream *xdr,
 	return ret;
 }
 
+/**
+ * xdr_item_is_absent - symbolically handle XDR discriminators
+ * @p: pointer to undecoded discriminator
+ *
+ * Return values:
+ *   %true if the following XDR item is absent
+ *   %false if the following XDR item is present
+ */
+static inline bool xdr_item_is_absent(const __be32 *p)
+{
+	return *p == xdr_zero;
+}
+
+/**
+ * xdr_item_is_present - symbolically handle XDR discriminators
+ * @p: pointer to undecoded discriminator
+ *
+ * Return values:
+ *   %true if the following XDR item is present
+ *   %false if the following XDR item is absent
+ */
+static inline bool xdr_item_is_present(const __be32 *p)
+{
+	return *p != xdr_zero;
+}
+
 /**
  * xdr_stream_decode_u32 - Decode a 32-bit integer
  * @xdr: pointer to xdr_stream
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 935bbef2f7be..feecd1f55f18 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1133,11 +1133,11 @@ rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
 	p = xdr_inline_decode(xdr, 0);
 
 	/* Chunk lists */
-	if (*p++ != xdr_zero)
+	if (xdr_item_is_present(p++))
 		return false;
-	if (*p++ != xdr_zero)
+	if (xdr_item_is_present(p++))
 		return false;
-	if (*p++ != xdr_zero)
+	if (xdr_item_is_present(p++))
 		return false;
 
 	/* RPC header */
@@ -1215,7 +1215,7 @@ static int decode_read_list(struct xdr_stream *xdr)
 	p = xdr_inline_decode(xdr, sizeof(*p));
 	if (unlikely(!p))
 		return -EIO;
-	if (unlikely(*p != xdr_zero))
+	if (unlikely(xdr_item_is_present(p)))
 		return -EIO;
 	return 0;
 }
@@ -1234,7 +1234,7 @@ static int decode_write_list(struct xdr_stream *xdr, u32 *length)
 		p = xdr_inline_decode(xdr, sizeof(*p));
 		if (unlikely(!p))
 			return -EIO;
-		if (*p == xdr_zero)
+		if (xdr_item_is_absent(p))
 			break;
 		if (!first)
 			return -EIO;
@@ -1256,7 +1256,7 @@ static int decode_reply_chunk(struct xdr_stream *xdr, u32 *length)
 		return -EIO;
 
 	*length = 0;
-	if (*p != xdr_zero)
+	if (xdr_item_is_present(p))
 		if (decode_write_chunk(xdr, length))
 			return -EIO;
 	return 0;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index c072ce61b393..5e78067889f3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -419,7 +419,7 @@ static bool xdr_check_read_list(struct svc_rdma_recv_ctxt *rctxt)
 
 	len = 0;
 	first = true;
-	while (*p != xdr_zero) {
+	while (xdr_item_is_present(p)) {
 		p = xdr_inline_decode(&rctxt->rc_stream,
 				      rpcrdma_readseg_maxsz * sizeof(*p));
 		if (!p)
@@ -500,7 +500,7 @@ static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 	if (!p)
 		return false;
 	rctxt->rc_write_list = p;
-	while (*p != xdr_zero) {
+	while (xdr_item_is_present(p)) {
 		if (!xdr_check_write_chunk(rctxt, MAX_BYTES_WRITE_CHUNK))
 			return false;
 		++chcount;
@@ -532,12 +532,11 @@ static bool xdr_check_reply_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 	if (!p)
 		return false;
-	rctxt->rc_reply_chunk = p;
-	if (*p != xdr_zero) {
+	rctxt->rc_reply_chunk = NULL;
+	if (xdr_item_is_present(p)) {
 		if (!xdr_check_write_chunk(rctxt, MAX_BYTES_SPECIAL_CHUNK))
 			return false;
-	} else {
-		rctxt->rc_reply_chunk = NULL;
+		rctxt->rc_reply_chunk = p;
 	}
 	return true;
 }
@@ -568,7 +567,7 @@ static void svc_rdma_get_inv_rkey(struct svcxprt_rdma *rdma,
 	p += rpcrdma_fixed_maxsz;
 
 	/* Read list */
-	while (*p++ != xdr_zero) {
+	while (xdr_item_is_present(p++)) {
 		p++;	/* position */
 		if (inv_rkey == xdr_zero)
 			inv_rkey = *p;
@@ -578,7 +577,7 @@ static void svc_rdma_get_inv_rkey(struct svcxprt_rdma *rdma,
 	}
 
 	/* Write list */
-	while (*p++ != xdr_zero) {
+	while (xdr_item_is_present(p++)) {
 		segcount = be32_to_cpup(p++);
 		for (i = 0; i < segcount; i++) {
 			if (inv_rkey == xdr_zero)
@@ -590,7 +589,7 @@ static void svc_rdma_get_inv_rkey(struct svcxprt_rdma *rdma,
 	}
 
 	/* Reply chunk */
-	if (*p++ != xdr_zero) {
+	if (xdr_item_is_present(p++)) {
 		segcount = be32_to_cpup(p++);
 		for (i = 0; i < segcount; i++) {
 			if (inv_rkey == xdr_zero)

