Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4144522E2A9
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jul 2020 22:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGZU7t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Jul 2020 16:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGZU7s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Jul 2020 16:59:48 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF31C0619D2;
        Sun, 26 Jul 2020 13:59:48 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q3so11412011ilt.8;
        Sun, 26 Jul 2020 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6s+NFWVjIrnSt/dV3KbX/od4mms9sT5SPrs9wEmSudY=;
        b=gCp8QjNM8YTU7wCggq2okWIB38vMiOd2uinDWHqwfiJ1mACCTI3V2b2jWRVcWOsdyR
         lhzWUhDRWN63MWKdtUn6pubhPOmgTlQR6L7euuqcWiW2amTxDY102XArf2xwbPcOJGxo
         jO+waCpDDYfVTKY3q63iBKgxOGQvrw9VBNg2mFs+FpF5nScGoNnKihKoIUVtuMM+aA+L
         3Z5yegv6+bl99WZhlYjYbUZuTV9XBA3yItFEFdYEBFEZgIKTJwwkOIVHyrKN0IgRlzHo
         EZnY4WPgW5Idtw/aj3ja7cNuotnxP7NpEbq2r2wWhFPc5B4nOJ7cDJSMVhQydHOXvHRK
         UMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6s+NFWVjIrnSt/dV3KbX/od4mms9sT5SPrs9wEmSudY=;
        b=qPAEJv5UpjWEhpRdlLOo7Ru4bhiaym4uoB96Hd8LG0T0GZPTWsVcWUuFM+IVWFhVol
         McuzDwuf47soiBwu+pSGZNnyQepM4bNO3fji0YXPTYAs6laKXQ9N/xLxIFt7PQvzs3xZ
         uOwkXW3UuFCwyDD418WDQznZhQwHTLrA0UCSFn8n0z2Yruy6AgIx3HlXkpE42+OKxUuY
         zFO31KtxIgjSnRIcVr0NdPcJrvv0ptpcbV+IAaBV9m4d65+qWX2pU2w97vz4fcsAL1+O
         ahzeyZw/Dkgi2PBu/tlaEVKPex0/tADtcvDHH+qoarA7FfRsxMAPEGYhkNUmiMM3J7/v
         qrvg==
X-Gm-Message-State: AOAM533EC9PIAnoKZ/+Ljm6N+S6R1Czg76II+uzuNjqigqRChHCbFwkO
        5khBb2sLV55E/wfoFUP6upoG3zF4D+k=
X-Google-Smtp-Source: ABdhPJyrrpd/Jq592uGVt2AQEExQKsTLDh3PSBbiHlwavzGYTySiMd3eTLw7LhpKGaSzBxCgjNlfDA==
X-Received: by 2002:a05:6e02:14c2:: with SMTP id o2mr20586396ilk.54.1595797187517;
        Sun, 26 Jul 2020 13:59:47 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l17sm7027564ilm.70.2020.07.26.13.59.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2020 13:59:46 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06QKxjeW013834;
        Sun, 26 Jul 2020 20:59:45 GMT
Subject: [PATCH v1 1/3] svcrdma: Fix another Receive buffer leak
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sun, 26 Jul 2020 16:59:45 -0400
Message-ID: <159579718507.2004.16208139278801479272.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

During a connection tear down, the Receive queue is flushed before
the device resources are freed. Typically, all the Receives flush
with IB_WR_FLUSH_ERR.

However, any pending successful Receives flush with IB_WR_SUCCESS,
and the server automatically posts a fresh Receive to replace the
completing one. This happens even after the connection has closed
and the RQ is drained. Receives that are posted after the RQ is
drained appear never to complete, causing a Receive resource leak.
The leaked Receive buffer is left DMA-mapped.

To prevent these late-posted recv_ctxt's from leaking, block new
Receive posting after XPT_CLOSE is set.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index d5ec85cb652c..5bb97b5f4606 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -275,6 +275,8 @@ static int svc_rdma_post_recv(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
 
+	if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
+		return 0;
 	ctxt = svc_rdma_recv_ctxt_get(rdma);
 	if (!ctxt)
 		return -ENOMEM;


