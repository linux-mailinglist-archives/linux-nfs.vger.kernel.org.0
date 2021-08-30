Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277683FBA69
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhH3QyB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbhH3QyA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 12:54:00 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B80C06175F
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 09:53:06 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x5so16819326ill.3
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewb94CFZBoEcv6BEq/49r+UCZ4fce92HK1wsFrtTC3s=;
        b=EU0LZ8jkh9tjyQEAzrvUK+DU7pOUiVmkJCA2PDlFW6rx00dgA5jTYdGaRvyZOREvry
         xNCedB/QvRMiGY/msgDSDcqXhOm0W+lEb0C0CcvSjbveFMrZxKPsoeoZ4rcrvaG7l9Jm
         93ZFQ3Rs2xUH+SiE3UTUv5sbCmx2+7LZA7DH2045vokJoy2tVcGCJmOdf3fGM9FQOjDQ
         nmCtNU0EI7Q4lYJdWZF9gMOHZEzrqVWJ+by8LAiWAid+gEWr+hV5s+ElvtQsBMUs7r7W
         JTIcJ3wSttTdlNMUYSq2smC/nBNhcBSFFLZ0uAZBnPjO6CWPMxUioq1g09Av9cEbZE8o
         FrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewb94CFZBoEcv6BEq/49r+UCZ4fce92HK1wsFrtTC3s=;
        b=X/oOBFkvdY8+alovSG7GkFRCDQfeKHF8aM5Y/ZAB2PjDRhvVWzDHdGmav/B6HmTEOg
         rgDPB0ulySO1rWQLDom6JkoKlFkEUzhnTg5ZvJ8/JgAanJUpCJHMmWPGdGRaFpIpjBx2
         ghUhxWT4+/SgmUijoG13uEsbafdMLSM2mEQNW09CV1h4P1hFgkEp+9TNR+K/KVB3R8tF
         srV0dL+WU4FP8jD7Ec/hsA53nmR3Xq06xktrENvt9C7YDgd6CjnvLCEIdJB3b/t6ZDrb
         /U20tJwv3Nkd69MrR4qjTcZdmj4xXshJUaY650cSb8P8ZIE5c5kNlzcq0jmBLuIMPguo
         sZhA==
X-Gm-Message-State: AOAM533qcJXjAvl+whTgapfyvtCHOnbjEV0+7E5kgb9JYYCPocY2h5ha
        xYKdLzDnsgm0DW5B5NU647I=
X-Google-Smtp-Source: ABdhPJzDfw4y4c5A193QArrtzUPwhW/yDnDazXof9q5Lv8Dv+/AWiGi/xDX37XjgRpKQFTnJXqlC3g==
X-Received: by 2002:a05:6e02:174c:: with SMTP id y12mr17548315ill.35.1630342385671;
        Mon, 30 Aug 2021 09:53:05 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:852f:17ae:ef64:bc7])
        by smtp.gmail.com with ESMTPSA id j13sm8579841ile.85.2021.08.30.09.53.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Aug 2021 09:53:05 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Date:   Mon, 30 Aug 2021 12:53:01 -0400
Message-Id: <20210830165302.60225-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Given the patch "Always provide aligned buffers to the RPC read layers",
RPC over RDMA doesn't need to look at the tail page and add that space
to the write chunk.

For the RFC 8166 compliant server, it must not write an XDR padding
into the write chunk (even if space was provided). Historically
(before RFC 8166) Solaris RDMA server has been requiring the client
to provide space for the XDR padding and thus this client code has
existed.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index c335c1361564..2c4146bcf2a8 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -255,21 +255,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
 		page_base = 0;
 	}
 
-	if (type == rpcrdma_readch)
-		goto out;
-
-	/* When encoding a Write chunk, some servers need to see an
-	 * extra segment for non-XDR-aligned Write chunks. The upper
-	 * layer provides space in the tail iovec that may be used
-	 * for this purpose.
-	 */
-	if (type == rpcrdma_writech && r_xprt->rx_ep->re_implicit_roundup)
-		goto out;
-
-	if (xdrbuf->tail[0].iov_len)
-		rpcrdma_convert_kvec(&xdrbuf->tail[0], seg, &n);
-
-out:
 	if (unlikely(n > RPCRDMA_MAX_SEGS))
 		return -EIO;
 	return n;
-- 
2.27.0

