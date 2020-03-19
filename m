Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE018BAEA
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgCSPVK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:21:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46453 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCSPVJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:21:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id t13so2067494qtn.13;
        Thu, 19 Mar 2020 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ONYS8BfGMnS9X+7ErK9RmzTVB4qRV04mWZjkKLMBGTE=;
        b=lN2h8Rkm61tfMYfCo/cfhWV0TZt/hC7GAXz1Wz6qftjFHpIgATb26Dz2HG2r9MBZum
         IawkUhos6mMQO7yvqmWayYDXkb9ACbehgH3/Ay+JlMdM65H2tcJ+j37bDp0Pxv2T/KMo
         B21wD9PuLu1VN436ajsC4PLyk/4uBhZwPbUEMQdEurjaLcVI9KcdFj5mXNynx3nLFU+O
         4wmdKoewFlH0FhStxlWcb6wMrp4t1hDvSzasqC/Ikxd818z0kUoYcGD6DPq9xvIaj+9V
         DDdWCpdu55brQHcCV4EdOoBBaMur+YXUDL5YqcdsE6ooEz8ka9/ZO7k920Al1aaPp5HO
         qIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ONYS8BfGMnS9X+7ErK9RmzTVB4qRV04mWZjkKLMBGTE=;
        b=JH01ihAqcj0TX7z11+b7pRoF3o+hxS41VkaZN5UUJDyaJer7bcNBjgYuLAd/9HlJVL
         pjVN0CL7A9AXJOlaV0F7F1kC63aWTfzIcTxtJr8a8GRMbsSzoYyXW3bZSqnFTV8AH6By
         +xNOpYeWlaqnkerpqA9pNPX3om5J2uR3KwRkQVfrTiVh9JBCkX7sy9lbWCMVhpUbkRvt
         2S1el1BU3HFQhnDqIx1yGZGBq4wQgBDM5SpwHa/jeTg9/XQgg+SrykDSn57bTy6lfkwU
         K4OiDHuEOAPhijJQ7/3OYxYKKcImky0j3g7Y53q9GXyny8fHmBX1pHKuYHg7VXi/SrNI
         uPFw==
X-Gm-Message-State: ANhLgQ31KUWGiUDlOD0Bdo5mS0JmK/hMXAMioc7tbOaPNeN61tLX6Rda
        sjvVkI6ACvsKL2f6PRzg0r79Zc3yygM=
X-Google-Smtp-Source: ADFU+vvhcLZ+qVBYypHZp7aJNo8OVCbR2ABowPmO3d1Df2apAD87CqyJPYU097KrhSnL1sPizw8iHg==
X-Received: by 2002:ac8:3141:: with SMTP id h1mr3512107qtb.108.1584631267414;
        Thu, 19 Mar 2020 08:21:07 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p35sm1773177qtk.2.2020.03.19.08.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:21:06 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFL5jU011169;
        Thu, 19 Mar 2020 15:21:05 GMT
Subject: [PATCH RFC 08/11] svcrdma: Add svc_rdma_skip_payloads()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:21:05 -0400
Message-ID: <20200319152105.16298.14148.stgit@klimt.1015granger.net>
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

We'll need a generic mechanism for processing only the parts of an
egress RPC message that are _not_ a READ payload. This will be used
in subsequent patches.

This is a separate patch to reduce the complexity of subsequent
patches, so that the logic of this new mechanism can be separately
reviewed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    4 ++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   72 +++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 37e4c597dc71..93642a889535 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -195,6 +195,10 @@ extern struct svc_rdma_send_ctxt *
 		svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma);
 extern void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_send_ctxt *ctxt);
+extern int svc_rdma_skip_payloads(const struct xdr_buf *xdr,
+				  const struct svc_rdma_recv_ctxt *rctxt,
+				  int (*actor)(const struct xdr_buf *, void *),
+				  void *data);
 extern int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr);
 extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *sctxt,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 9fe7b0d1e335..85c91d0debb4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -515,6 +515,78 @@ svc_rdma_encode_reply_chunk(const struct svc_rdma_recv_ctxt *rctxt,
 		return svc_rdma_encode_write_chunk(sctxt, &payload);
 }
 
+static inline int
+xdr_buf_process_region(const struct xdr_buf *xdr,
+		       unsigned int offset, unsigned int length,
+		       int (*actor)(const struct xdr_buf *, void *),
+		       void *data)
+{
+	struct xdr_buf subbuf;
+
+	if (!length)
+		return 0;
+	if (xdr_buf_subsegment(xdr, &subbuf, offset, length))
+		return -EMSGSIZE;
+	return actor(&subbuf, data);
+}
+
+/**
+ * svc_rdma_skip_payloads - Call an actor for non-payload regions of @xdr
+ * @xdr: xdr_buf to process
+ * @rctxt: Write and Reply chunks provided by client
+ * @actor: function to invoke on that region
+ * @data: pointer to arguments for @actor
+ *
+ * This mechanism must ignore not only READ payloads that were already
+ * sent via RDMA Write, but also XDR padding for those payloads that
+ * the upper layer has added.
+ *
+ * Assumptions:
+ *  The xdr->len and rp_ fields are aligned to 4-byte multiples.
+ *
+ * Returns:
+ *   On success, zero,
+ *   %-EMSGSIZE on XDR buffer overflow, or
+ *   The return value of @actor
+ */
+int svc_rdma_skip_payloads(const struct xdr_buf *xdr,
+			   const struct svc_rdma_recv_ctxt *rctxt,
+			   int (*actor)(const struct xdr_buf *, void *),
+			   void *data)
+{
+	const unsigned int num_payloads = rctxt ? rctxt->rc_cur_payload : 0;
+	unsigned int offset, length;
+	int i, ret;
+
+	if (likely(!num_payloads))
+		return actor(xdr, data);
+
+	/* Before the first READ payload */
+	offset = 0;
+	length = rctxt->rc_read_payloads[0].rp_offset;
+	ret = xdr_buf_process_region(xdr, offset, length, actor, data);
+	if (ret < 0)
+		return ret;
+
+	/* Any middle READ payloads */
+	for (i = 0; i + 1 < num_payloads; i++) {
+		offset = xdr_align_size(length + rctxt->rc_read_payloads[i].rp_length);
+		length = rctxt->rc_read_payloads[i + 1].rp_offset - offset;
+		ret = xdr_buf_process_region(xdr, offset, length, actor, data);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* After the last READ payload */
+	offset = xdr_align_size(length + rctxt->rc_read_payloads[i].rp_length);
+	length = xdr->len - offset;
+	ret = xdr_buf_process_region(xdr, offset, length, actor, data);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
 				 struct svc_rdma_send_ctxt *ctxt,
 				 struct page *page,

