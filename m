Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5990818BAE5
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCSPU7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:20:59 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44814 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgCSPU7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:20:59 -0400
Received: by mail-qv1-f66.google.com with SMTP id w5so1171040qvp.11;
        Thu, 19 Mar 2020 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Gp44ocBSq1NN/nreEQ4cJNlnHwu6GLp98VU98gHXy44=;
        b=jkopDnI8MWukOdIxSpNzZzZRP89skf3IqE739QmiQA2HC2+Pf1N+GT/uuB5Yvuq0pX
         trKQxR3isUBopQC8Z6PXVMgZxGUUACKGxdPTzZGA+oSWH6pNKJQL8aO/GdDMoC8Qe5MC
         4Laa33i9osWfEtuCb/R1tx3ejI54pMSUHGEh9R7rDmPADA+KiX3V3JC+vxh1dK0jMxBp
         9AfMSK4w7gHTwQC5SvqZQCsdObnwMI4VsE+mnEPkjuM/ZdRqSAzjE/RNQvgy+46Tveb1
         J0wC0+N6V/KBgPxHMtufASpzgdVjLthPRD1Xrs9KFnq4KyLNheKUOSQ9EuBdGW4BfXZW
         kBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Gp44ocBSq1NN/nreEQ4cJNlnHwu6GLp98VU98gHXy44=;
        b=nhIzYCr66s0v074vWF6lwh3zFeZMtAuOqnYxyQ+hDAek9aaAd5f/k3gqLURV2RfWWw
         aj+rE1n5zziUQbLdSjJEROJXJNMLUs7kh32LJsPH3Vi4+W+v+iTtBUoYoZwJwLfsDmaR
         piJLgw/ih6lwjiYNlnAfFf3/3B7BxILcK87AqAIadYqZcgCLSiAp9Iz1jE2enL2Spj+K
         s9K6IctPbV553eRGp8RR7oMfS7hdzclUGKbog1Ekkee4iVPiLbid9DaGPU8MSllxrQD3
         vJqDoIGl3uMhhXmZ39ydEebbi4N1SQnaX9p6yPWNUJt7RyS/5Vvsrck6KhC5rEqbjTdZ
         ZUQA==
X-Gm-Message-State: ANhLgQ1iYkjdPse/aixRe4Izvb8JZdF+H1pupAcyg+fz0ciManspyJkJ
        mB16ZMNvK1iwS0ImR25RNPx4IUvO6Jo=
X-Google-Smtp-Source: ADFU+vuliig09J3014NpS0KWbBuVggf/a7WDeo/uL1oqImCRC5F0B0onja1jkJowtlgRJ4Izv39DJg==
X-Received: by 2002:ad4:4c81:: with SMTP id bs1mr3542525qvb.2.1584631256687;
        Thu, 19 Mar 2020 08:20:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q15sm1783277qtj.83.2020.03.19.08.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:20:56 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFKtMq011163;
        Thu, 19 Mar 2020 15:20:55 GMT
Subject: [PATCH RFC 06/11] svcrdma: Cache number of Write chunks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:20:55 -0400
Message-ID: <20200319152055.16298.10403.stgit@klimt.1015granger.net>
In-Reply-To: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
References: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Have the Call header decoder count the number of Write chunks it
finds and cache that count for use in the Send path. Currently,
the Linux NFS server implementation accepts only zero or one, but
a subsequent patch will allow it to handle more than one.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    2 ++
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |    2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |   10 +++++-----
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 49864264a9a5..9af9d4dff330 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -147,6 +147,7 @@ struct svc_rdma_recv_ctxt {
 	u32			rc_inv_rkey;
 	struct svc_rdma_payload rc_read_payload;
 	__be32			*rc_reply_chunk;
+	unsigned int		rc_num_write_chunks;
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 3e02dfa351ff..95b88f68f8ca 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -194,6 +194,7 @@ svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 out:
 	ctxt->rc_page_count = 0;
 	ctxt->rc_read_payload.rp_length = 0;
+	ctxt->rc_num_write_chunks = 0;
 	return ctxt;
 
 out_empty:
@@ -488,6 +489,7 @@ static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 		if (!p)
 			return false;
 	}
+	rctxt->rc_num_write_chunks = chcount;
 	if (!chcount)
 		rctxt->rc_read_payload.rp_chunk = NULL;
 	return chcount < 2;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 080a55456911..8ad137c7e6a0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -625,7 +625,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	/* Send the page list in the Reply chunk only if the
 	 * client did not provide Write chunks.
 	 */
-	if (!rctxt->rc_read_payload.rp_chunk && xdr->page_len) {
+	if (!rctxt->rc_num_write_chunks && xdr->page_len) {
 		ret = svc_rdma_pages_write(info, xdr, xdr->head[0].iov_len,
 					   xdr->page_len);
 		if (ret < 0)
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 89bc8db0289e..b6dd5ae2ad76 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -467,7 +467,7 @@ svc_rdma_encode_write_list(const struct svc_rdma_recv_ctxt *rctxt,
 	ssize_t len, ret;
 
 	len = 0;
-	if (rctxt->rc_read_payload.rp_chunk) {
+	if (rctxt->rc_num_write_chunks) {
 		ret = svc_rdma_encode_write_chunk(sctxt,
 						  &rctxt->rc_read_payload);
 		if (ret < 0)
@@ -564,7 +564,7 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 				    const struct svc_rdma_recv_ctxt *rctxt,
 				    struct xdr_buf *xdr)
 {
-	bool read_payload_present = rctxt && rctxt->rc_read_payload.rp_chunk;
+	bool read_payload_present = rctxt && rctxt->rc_num_write_chunks;
 	int elements;
 
 	/* For small messages, copying bytes is cheaper than DMA mapping.
@@ -628,7 +628,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 
 	tailbase = xdr->tail[0].iov_base;
 	taillen = xdr->tail[0].iov_len;
-	if (rctxt && rctxt->rc_read_payload.rp_chunk) {
+	if (rctxt && rctxt->rc_num_write_chunks) {
 		u32 xdrpad;
 
 		xdrpad = xdr_pad_size(xdr->page_len);
@@ -713,7 +713,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	 * have added XDR padding in the tail buffer, and that
 	 * should not be included inline.
 	 */
-	if (rctxt && rctxt->rc_read_payload.rp_chunk) {
+	if (rctxt && rctxt->rc_num_write_chunks) {
 		base = xdr->tail[0].iov_base;
 		len = xdr->tail[0].iov_len;
 		xdr_pad = xdr_pad_size(xdr->page_len);
@@ -952,7 +952,7 @@ int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 	struct xdr_buf uninitialized_var(subbuf);
 	struct svcxprt_rdma *rdma;
 
-	if (!rctxt->rc_read_payload.rp_chunk || !length)
+	if (!rctxt->rc_num_write_chunks || !length)
 		return 0;
 
 	/* XXX: Just one READ payload slot for now, since our

