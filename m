Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8820D866
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbgF2Tit (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbgF2Tho (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:37:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BB8C02F016;
        Mon, 29 Jun 2020 07:50:23 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e11so15485025qkm.3;
        Mon, 29 Jun 2020 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=O0yZJkvLrK6LFmPqzu5suqBMbRhXZtym0DCUxXeWW9I=;
        b=vaH66BxMgK0O4Y+rCJXDQOGW1r0zbOxCd2jicRBaN2ceRK8W5yuKyyrrCCfRuvWG6r
         RsaLlx1pxeS81XWWnRWpiVvUXUMpr3DZIPg+XhKsnh+Yh71UoRmhpRHGCSmZdHYgXij8
         Axwlsqs+RwF2tLH/OUn2KNSuG5LHzZmsMMGvnt9KMfHv9i5zPBWWKjorwDtRYHF+6yE7
         8ZntkLMGARkJje/OmPVinRJuQCtwyxpMf3rHJ9y+bTeoWO4uzSrxpcCkkoQWIE6HOdcg
         /SMkJ5lB39z3Lap6ToXJBtczGEQGNKw0gVtKKU68Vl/EIPDU9/fSo8J/wMj/EjONE1oB
         WJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=O0yZJkvLrK6LFmPqzu5suqBMbRhXZtym0DCUxXeWW9I=;
        b=jss7EcvFoM3Gz3Xfgf4fFmOqJXcA/4xyFtpqbmLvitRceYP6FN5Aqierf5tgVfyd4d
         Obztktt5OxAtghkEhmrCI4MhcD9xGj6HXC60esRMAz8F4Z8yq26qid5o7/QxeuJh52ZC
         CJhY0L3+AGNq4yweHSnyrKPioWucXbuyO5xH7pTvAqxLumk4uuw8SULfC7nh44HRlbZX
         XE/j80HHSBJqFmkOoG2+c3bmExYSBhV6JNuyA6pwNfmH44TWklKqyGe2N2C90ngYdEn4
         dYemc2/ND5ana1PS2aB9BYzOXtZR1IijcEpOfrNhO8pI5xm2IDJGhOXHKdWlSIROstFZ
         GZkw==
X-Gm-Message-State: AOAM5315YG31DeSx0ewflv/OT2JZf2bkMLuzvs502RXHllxWtugDSBWc
        SXLqcJBmuYLaZGNynPtHIPyxXtCi
X-Google-Smtp-Source: ABdhPJwQ5Caa0kCJ6l3RnaKYN49m4Zu+NmTqPCxDeL4n3fIP/EbP6GAwdhcbb/3uJZaBqoPpwg1BtA==
X-Received: by 2002:a37:9c8f:: with SMTP id f137mr15694536qke.63.1593442220350;
        Mon, 29 Jun 2020 07:50:20 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x14sm21226qki.65.2020.06.29.07.50.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:50:19 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEoJFF006205;
        Mon, 29 Jun 2020 14:50:19 GMT
Subject: [PATCH v2 4/8] svcrdma: Add a @status parameter to
 svc_rdma_send_error_msg()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:50:19 -0400
Message-ID: <20200629145019.15024.1404.stgit@klimt.1015granger.net>
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

The common "send RDMA_ERR" function should be in svc_rdma_sendto.c,
since that is where the other Send-related functions are located.
So from here, I will beef up svc_rdma_send_error_msg() and deprecate
svc_rdma_send_error().

A generic svc_rdma_send_error_msg() will need to handle both
ERR_CHUNK and ERR_VERS. Copy that logic from svc_rdma_send_error()
to svc_rdma_send_error_msg().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 47ada61411c3..73fe7a213169 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -812,7 +812,8 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
  */
 static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_send_ctxt *sctxt,
-				   struct svc_rdma_recv_ctxt *rctxt)
+				   struct svc_rdma_recv_ctxt *rctxt,
+				   int status)
 {
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
 	__be32 *p;
@@ -821,16 +822,35 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	xdr_init_encode(&sctxt->sc_stream, &sctxt->sc_hdrbuf,
 			sctxt->sc_xprt_buf, NULL);
 
-	p = xdr_reserve_space(&sctxt->sc_stream, RPCRDMA_HDRLEN_ERR);
+	p = xdr_reserve_space(&sctxt->sc_stream,
+			      rpcrdma_fixed_maxsz * sizeof(*p));
 	if (!p)
 		return -ENOMSG;
 
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
 	*p++ = rdma->sc_fc_credits;
-	*p++ = rdma_error;
-	*p   = err_chunk;
-	trace_svcrdma_err_chunk(*rdma_argp);
+	*p = rdma_error;
+
+	switch (status) {
+	case -EPROTONOSUPPORT:
+		p = xdr_reserve_space(&sctxt->sc_stream, 3 * sizeof(*p));
+		if (!p)
+			return -ENOMSG;
+
+		*p++ = err_vers;
+		*p++ = rpcrdma_version;
+		*p = rpcrdma_version;
+		trace_svcrdma_err_vers(*rdma_argp);
+		break;
+	default:
+		p = xdr_reserve_space(&sctxt->sc_stream, sizeof(*p));
+		if (!p)
+			return -ENOMSG;
+
+		*p = err_chunk;
+		trace_svcrdma_err_chunk(*rdma_argp);
+	}
 
 	sctxt->sc_send_wr.num_sge = 1;
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
@@ -930,7 +950,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	 * of previously posted RDMA Writes.
 	 */
 	svc_rdma_save_io_pages(rqstp, sctxt);
-	ret = svc_rdma_send_error_msg(rdma, sctxt, rctxt);
+	ret = svc_rdma_send_error_msg(rdma, sctxt, rctxt, ret);
 	if (ret < 0)
 		goto err1;
 	return 0;

