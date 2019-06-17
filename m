Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5099848743
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFQPcf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:32:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46286 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPcf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:32:35 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so21991663iol.13;
        Mon, 17 Jun 2019 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y5KfP+82Q2G+FSMMy0+NWol6P6fdC5jPKgFtk+jfHFo=;
        b=NIEBtpWFIDirMdWnLAvvsGAcr1V78INqCjDMMrlFcR8YTUalW+NkcbY8AiVPbjrivn
         Pc56D0JTZ+vbAqBEKCejcB+uS93U0262pfm01SJMOwIymJYbNsxwyz5uDrWDldIVC/Yw
         IT/yooVBmd68A3BEU28kOVUaS6tTep8qzQnfEQAT8SXGTaq+2yM4EJhI9KWki+/S+52Y
         sDwAzphxQHGRmvC5xsr8ucnYgKEkmD1sQ0bRy+d/f1IkJtTeHanScGx7a7tmp7fBlKLm
         HVmyQKuubq39w3TxhHjIx3JZTD+u8uxKiOfhZKbA+spQukRdIb+8hPGRmMDI07Np++Gp
         SXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y5KfP+82Q2G+FSMMy0+NWol6P6fdC5jPKgFtk+jfHFo=;
        b=WIBeldjIUg0LbKohSc9dIW+OwLqwyhJ7Iy90/993SC/32dVCLmJgxLq0taMXLSlu3q
         KmZvxRKGs7Fq2VEpia6G6G5aE8RycuiPZnFi0kRd3OnPum2x1tMcDiJQOMkEZXfiTF/e
         0TR5g2sGGl6PXkGB2bkE0EXdJ0+Wk07/xzZdccTu/SjorDzrgHolk2Sp7Ux2BOlG1Kl4
         YHQ5ampdtgWVuQqo6/eBdI3nDryNYMZ1l8amtCiK+9RENOS11K31c4ii0u8rPnahAwQp
         FUjG3rIyNWEnH1574B55NfXZyFRmPOTyKlvsFSlE1jTZy3M78RsOOrnxzlhrFmBA9jK+
         HGLA==
X-Gm-Message-State: APjAAAVCFGchTcT5KmptHahs2G35FIFb0P9I2I5czPO/COKg7/RwNOgx
        mYjgFJIe7aB8PGoRIQvEWgk=
X-Google-Smtp-Source: APXvYqxUUb6SzdG6IMEATcJkwUV1qB9p90OMzBx+RLLDyCzW4TLc8rMrdo01NJAs+TSoioa/iUHBpQ==
X-Received: by 2002:a6b:8b8b:: with SMTP id n133mr30791264iod.183.1560785554854;
        Mon, 17 Jun 2019 08:32:34 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k8sm13127774iob.78.2019.06.17.08.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:32:34 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFWXZ8031221;
        Mon, 17 Jun 2019 15:32:33 GMT
Subject: [PATCH v3 12/19] xprtrdma: Refactor chunk encoding
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:32:33 -0400
Message-ID: <20190617153233.12090.98775.stgit@manet.1015granger.net>
In-Reply-To: <20190617152657.12090.11389.stgit@manet.1015granger.net>
References: <20190617152657.12090.11389.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

Move the "not present" case into the individual chunk encoders. This
improves code organization and readability.

The reason for the original organization was to optimize for the
case where there there are no chunks. The optimization turned out to
be inconsequential, so let's err on the side of code readability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index caf0b19..d3515d3 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -366,6 +366,9 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	unsigned int pos;
 	int nsegs;
 
+	if (rtype == rpcrdma_noch)
+		goto done;
+
 	pos = rqst->rq_snd_buf.head[0].iov_len;
 	if (rtype == rpcrdma_areadch)
 		pos = 0;
@@ -389,7 +392,8 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 		nsegs -= mr->mr_nents;
 	} while (nsegs);
 
-	return 0;
+done:
+	return encode_item_not_present(xdr);
 }
 
 /* Register and XDR encode the Write list. Supports encoding a list
@@ -417,6 +421,9 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	int nsegs, nchunks;
 	__be32 *segcount;
 
+	if (wtype != rpcrdma_writech)
+		goto done;
+
 	seg = req->rl_segments;
 	nsegs = rpcrdma_convert_iovs(r_xprt, &rqst->rq_rcv_buf,
 				     rqst->rq_rcv_buf.head[0].iov_len,
@@ -451,7 +458,8 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	/* Update count of segments in this Write chunk */
 	*segcount = cpu_to_be32(nchunks);
 
-	return 0;
+done:
+	return encode_item_not_present(xdr);
 }
 
 /* Register and XDR encode the Reply chunk. Supports encoding an array
@@ -476,6 +484,9 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	int nsegs, nchunks;
 	__be32 *segcount;
 
+	if (wtype != rpcrdma_replych)
+		return encode_item_not_present(xdr);
+
 	seg = req->rl_segments;
 	nsegs = rpcrdma_convert_iovs(r_xprt, &rqst->rq_rcv_buf, 0, wtype, seg);
 	if (nsegs < 0)
@@ -859,28 +870,13 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 	 * send a Call message with a Position Zero Read chunk and a
 	 * regular Read chunk at the same time.
 	 */
-	if (rtype != rpcrdma_noch) {
-		ret = rpcrdma_encode_read_list(r_xprt, req, rqst, rtype);
-		if (ret)
-			goto out_err;
-	}
-	ret = encode_item_not_present(xdr);
+	ret = rpcrdma_encode_read_list(r_xprt, req, rqst, rtype);
 	if (ret)
 		goto out_err;
-
-	if (wtype == rpcrdma_writech) {
-		ret = rpcrdma_encode_write_list(r_xprt, req, rqst, wtype);
-		if (ret)
-			goto out_err;
-	}
-	ret = encode_item_not_present(xdr);
+	ret = rpcrdma_encode_write_list(r_xprt, req, rqst, wtype);
 	if (ret)
 		goto out_err;
-
-	if (wtype != rpcrdma_replych)
-		ret = encode_item_not_present(xdr);
-	else
-		ret = rpcrdma_encode_reply_chunk(r_xprt, req, rqst, wtype);
+	ret = rpcrdma_encode_reply_chunk(r_xprt, req, rqst, wtype);
 	if (ret)
 		goto out_err;
 

