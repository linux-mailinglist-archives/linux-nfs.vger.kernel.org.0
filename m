Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75A62995F6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781686AbgJZSyd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37781 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781485AbgJZSyd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:54:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id z6so9410902qkz.4;
        Mon, 26 Oct 2020 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=G02z9jH3D5SvIJXqLArGLnDX9Qn0gnV9J50q6rxowBc=;
        b=aaPDuk+LpseSAFMloJAolR3bP1M/hgsE1pmR/9VF55/SkdNBwwI5liT+1KMwAXK0Rt
         eBDJkoFmYe8keV1GJa6cMGuL3IUGQP9f0LWTCbYUd0zQ8OwMtslxRyPrXX3XmWdSDz5E
         aIw5t2rIKfbRbLYLOWNAeYujgsHO2z0rHkYVyOn4kUhvPaelIPHnsoqjkvTVijY0R81Y
         CFztISFIpUfI49yElAp+JtYn/YnxEMk9GQ0802VCICvu20t9LnVFUbsXrmw/wHZjeG1V
         kHtz7jLtS+RmPst8OkvQdsv9tT3cpEHoPxxiyLeGPHO81yW2JhD8V4Pl254GfOSHV4Rd
         vv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=G02z9jH3D5SvIJXqLArGLnDX9Qn0gnV9J50q6rxowBc=;
        b=ej4dxhyUFhqjt4BJNQqErdv/9smTel2/H1YtMKsZdW5lCRHlhxb7y+HcO98YSKj7ii
         8FrFgkJoHhhXlIxSkUxV/80mfTZGt+aHwzoZmXub+auX9hBfF9ZQuKq/P/1C+rObgn7e
         ZKU0PghzrtJAtuqCSD06ft1n2toe4yE269l75fvbKRTcr7jd5J0loPfVMDGag4++N+69
         YnqkQPJQeHqMSX6Y6UsIxVWeaEBZ5IVafhvek4HaiCTOPDQ4iaAkTqs9ix9IjCuaG8gS
         Go1FvIWyQuM8ANvmqNBt1Fq7v3OhyTJe2KubYbWxWoaUyxtTj56t//gfehsC/mSGdQlc
         QdBA==
X-Gm-Message-State: AOAM530GikGG5snHl3kpOJvTgFO08bRfOHE7mATVIl+IH44XRKt85uFZ
        Je6nOBDFobZOSvBTeSIJ5+6pEBC7fTI=
X-Google-Smtp-Source: ABdhPJxsJoq21tFAHN8g5yTPkffCClNYI9uRJbiNDh2GFkBBK/eaj67b894Abjs8Zl4lcsTrD74IdA==
X-Received: by 2002:a37:a9cf:: with SMTP id s198mr19012166qke.216.1603738471789;
        Mon, 26 Oct 2020 11:54:31 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t65sm7409334qkc.52.2020.10.26.11.54.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:54:31 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIsUVD013634;
        Mon, 26 Oct 2020 18:54:30 GMT
Subject: [PATCH 07/20] svcrdma: Clean up svc_rdma_encode_reply_chunk()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:54:30 -0400
Message-ID: <160373847013.1886.15364356647550565452.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Match the control flow of svc_rdma_encode_write_list().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |    3 +++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   23 +++++++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index d732785d0380..5f667d964cd6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -633,6 +633,9 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	struct svc_rdma_write_info *info;
 	int consumed, ret;
 
+	if (!rctxt->rc_reply_chunk)
+		return 0;
+
 	info = svc_rdma_write_info_alloc(rdma, rctxt->rc_reply_chunk);
 	if (!info)
 		return -ENOMEM;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index fb6ba1177fd8..3e7ba06788b0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -504,6 +504,9 @@ svc_rdma_encode_reply_chunk(const struct svc_rdma_recv_ctxt *rctxt,
 			    struct svc_rdma_send_ctxt *sctxt,
 			    unsigned int length)
 {
+	if (!rctxt->rc_reply_chunk)
+		return xdr_stream_encode_item_absent(&sctxt->sc_stream);
+
 	return svc_rdma_encode_write_chunk(rctxt->rc_reply_chunk, sctxt,
 					   length);
 }
@@ -898,7 +901,6 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
-	__be32 *rp_ch = rctxt->rc_reply_chunk;
 	struct svc_rdma_send_ctxt *sctxt;
 	__be32 *p;
 	int ret;
@@ -916,25 +918,22 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 			      rpcrdma_fixed_maxsz * sizeof(*p));
 	if (!p)
 		goto err0;
+
+	ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
+	if (ret < 0)
+		goto err2;
+
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
 	*p++ = rdma->sc_fc_credits;
-	*p   = rp_ch ? rdma_nomsg : rdma_msg;
+	*p = rctxt->rc_reply_chunk ? rdma_nomsg : rdma_msg;
 
 	if (svc_rdma_encode_read_list(sctxt) < 0)
 		goto err0;
 	if (svc_rdma_encode_write_list(rctxt, sctxt) < 0)
 		goto err0;
-	if (rp_ch) {
-		ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
-		if (ret < 0)
-			goto err2;
-		if (svc_rdma_encode_reply_chunk(rctxt, sctxt, ret) < 0)
-			goto err0;
-	} else {
-		if (xdr_stream_encode_item_absent(&sctxt->sc_stream) < 0)
-			goto err0;
-	}
+	if (svc_rdma_encode_reply_chunk(rctxt, sctxt, ret) < 0)
+		goto err0;
 
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)


