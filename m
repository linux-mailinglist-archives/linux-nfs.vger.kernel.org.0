Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6720D858
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbgF2Ti1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387448AbgF2Tho (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:37:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDDDC02F017;
        Mon, 29 Jun 2020 07:50:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c139so15424912qkg.12;
        Mon, 29 Jun 2020 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zQeMNl3XW1m0/k9561YNZvuwp+BUiHHSMSMoXCctjAY=;
        b=fteY9yrmObX4mSz+9DAjhBwIQO1aR5+6JXcgsnGcCdSdyscNYokNx0AbzeCDGz41w1
         h3tkrEvNYEpYiO4T8Pa8k+QuP6NE8afZ6vxq+fWlhRrdJoag0+0YFBWMmEV9TCb8qBMG
         Dv0nbM6Y3sBOmVPBIwyg15+hYgFU+4LrsKHBfBhW26q89+ZKd6oRgfl9Rd3SaIwVZtCv
         d0iVpOuMz+fV9EFNhSrAvPnN4adi4boFxdRGS/lBGi5EkO47csJ3RZq6jcnxQEStnbNt
         FWzwL5U+8xinReGz/blY4DU6kH/2u6shQO7vDNYpR9cn2Hnd2u0HA7RMoEkhduC2cNoR
         BOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zQeMNl3XW1m0/k9561YNZvuwp+BUiHHSMSMoXCctjAY=;
        b=d0tLSdw8V7GeMEn0YFy6luNgi3dUFi7xHj9R28I6sxY++jDTe3KnjsCtqwthfccKWK
         Rc7C/NB9kWAoeXKfHDHav8ULtZHKMvixxnZfs8iY86Beo5hr77YIFEQHmRySK6HCf4vF
         Xu9QFQdZrqJfPg7adh9FGO+jsELC2PQWeFyRBUb/4EGY49bQT1BmV3FlfTpJ7YZvr1IO
         JVZjioCPkkc1F5YtHsaJa+mtpDo868HsqaRrR58w0JLChAr2ZdZb2OwFDvEb0aJsn2O8
         RMIKg8UG3JQaM33RKiy9YPQ9q5t8xjsUfSFKqARU1H+IJTCeheumqZgiHj3nkJEGq1Vx
         mvxg==
X-Gm-Message-State: AOAM531k/cZc7gInDuDuHLhJ9HfxnS3bl/q1HjWv0ky95KoQbxLoVVrH
        B/OGnPiEnN7lyNCetXbyNknBJr9v
X-Google-Smtp-Source: ABdhPJy4g8zk+wKpeI1ov7aVSY81UDwBsYsDQ0lf9pPxaWCd6XQ0c10U/gMH6vHEdYUj8D6bQM8Dxg==
X-Received: by 2002:a37:9a01:: with SMTP id c1mr15180277qke.111.1593442225385;
        Mon, 29 Jun 2020 07:50:25 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l67sm54079qkd.7.2020.06.29.07.50.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:50:25 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEoOl8006208;
        Mon, 29 Jun 2020 14:50:24 GMT
Subject: [PATCH v2 5/8] svcrdma: Eliminate return value for
 svc_rdma_send_error_msg()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:50:24 -0400
Message-ID: <20200629145024.15024.2767.stgit@klimt.1015granger.net>
In-Reply-To: <20200629144802.15024.30635.stgit@klimt.1015granger.net>
References: <20200629144802.15024.30635.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Like svc_rdma_send_error(), have svc_rdma_send_error_msg() handle
any error conditions internally, rather than duplicating that
recovery logic at every call site.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 73fe7a213169..fb548b548c4b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -810,10 +810,10 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
  *
  * Remote Invalidation is skipped for simplicity.
  */
-static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
-				   struct svc_rdma_send_ctxt *sctxt,
-				   struct svc_rdma_recv_ctxt *rctxt,
-				   int status)
+static void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
+				    struct svc_rdma_send_ctxt *sctxt,
+				    struct svc_rdma_recv_ctxt *rctxt,
+				    int status)
 {
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
 	__be32 *p;
@@ -825,7 +825,7 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	p = xdr_reserve_space(&sctxt->sc_stream,
 			      rpcrdma_fixed_maxsz * sizeof(*p));
 	if (!p)
-		return -ENOMSG;
+		goto put_ctxt;
 
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
@@ -836,7 +836,7 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	case -EPROTONOSUPPORT:
 		p = xdr_reserve_space(&sctxt->sc_stream, 3 * sizeof(*p));
 		if (!p)
-			return -ENOMSG;
+			goto put_ctxt;
 
 		*p++ = err_vers;
 		*p++ = rpcrdma_version;
@@ -846,7 +846,7 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	default:
 		p = xdr_reserve_space(&sctxt->sc_stream, sizeof(*p));
 		if (!p)
-			return -ENOMSG;
+			goto put_ctxt;
 
 		*p = err_chunk;
 		trace_svcrdma_err_chunk(*rdma_argp);
@@ -855,7 +855,12 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	sctxt->sc_send_wr.num_sge = 1;
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
-	return svc_rdma_send(rdma, &sctxt->sc_send_wr);
+	if (svc_rdma_send(rdma, &sctxt->sc_send_wr))
+		goto put_ctxt;
+	return;
+
+put_ctxt:
+	svc_rdma_send_ctxt_put(rdma, sctxt);
 }
 
 /**
@@ -950,9 +955,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	 * of previously posted RDMA Writes.
 	 */
 	svc_rdma_save_io_pages(rqstp, sctxt);
-	ret = svc_rdma_send_error_msg(rdma, sctxt, rctxt, ret);
-	if (ret < 0)
-		goto err1;
+	svc_rdma_send_error_msg(rdma, sctxt, rctxt, ret);
 	return 0;
 
  err1:

