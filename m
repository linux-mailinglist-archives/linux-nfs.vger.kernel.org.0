Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD07C3FBA6B
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbhH3QyC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhH3QyA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 12:54:00 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F6C061575
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 09:53:07 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r6so16758265ilt.13
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUymIy8jaYcXTYVWTHJj5AxoYKBoTruEAY+cyYhjSjc=;
        b=cFYbuw/AGNvTuUlyIaTKZYUrLdvGT/CS6fFsdN08Z9q0g/BW+1EdGkSuq3GznqCP7w
         JT3bd0xru6B0IVhwfBn5/wrZzmcTRnwk+xbRfNJ1fs8ADGGRVsJmf49eNuF5RquZlpuu
         ZglW20cAwUhykDhlIWo1YOWxEbg48rrUQkertt4/k6QZFSyOQhV8ZtpDBSbFHKPAETlJ
         vRq0GdSwziOy+lNyalHXnC1eKkNwttiCTiRPmFGyJ1t5Rw2RpYaDdFO1T7pBMCXXsWIZ
         86tUwmhdhHiWdobHmmGQ2bTrpah2FOq/ody+0RoOwVtyT5cVXPVqgu2lTahVOm9He/L8
         eqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUymIy8jaYcXTYVWTHJj5AxoYKBoTruEAY+cyYhjSjc=;
        b=eJjO2BB42ie66hcFHzEYRE6bL8xV2gzOukJzDnvlW9bZhOuFk1OkcN3UuzY851vIBW
         vwqmKv+abGsWF9z5NizqimiPhkx7eK/ekPGl0CglTm3vWzLL443lFH3Qt50SlAZQiLKX
         YcHvfeoa8wKVYsij3Wg30icO7+PaSIRLTpkLaSUm9oY2qMPuAoImJPYCVgry11kSimM2
         kY93S/Azjz3XVYEkj0zh9mM+RxaLqp1lMZz3tLB1x/7BAzJPHKNmiT4IbCf5ZTOzLzvJ
         jaaDIh5kODs3GtkfzgiSEkPyGTukwdqx59Buay7LCRVbxmr1IlY7coIvLsvIlHwHsxgM
         ulgw==
X-Gm-Message-State: AOAM5327sqexOzzsWFfCWwqoKpIbH/JcUkOnMGpTqx3N18teOwpSmq0X
        2HgzPubAulBgaVebUNm0YzE=
X-Google-Smtp-Source: ABdhPJxdAMkTXJXh8y5l5PavtRD0UrE7d7K/6g1Z/zd+4cd4+8yp+pHwY09T+hNz3j+MNnaag5Yz/A==
X-Received: by 2002:a92:d1c6:: with SMTP id u6mr16814335ilg.263.1630342386643;
        Mon, 30 Aug 2021 09:53:06 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:852f:17ae:ef64:bc7])
        by smtp.gmail.com with ESMTPSA id j13sm8579841ile.85.2021.08.30.09.53.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Aug 2021 09:53:06 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC 2/2] xprtrdma: remove re_implicit_roundup xprt_rdma_pad_optimize
Date:   Mon, 30 Aug 2021 12:53:02 -0400
Message-Id: <20210830165302.60225-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Since RPC over RDMA layer no longer needs to manage XDR padding,
remove existing code that managed whether or not client included
extra space for the XDR padding.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/xprtrdma/transport.c | 8 --------
 net/sunrpc/xprtrdma/verbs.c     | 2 --
 net/sunrpc/xprtrdma/xprt_rdma.h | 6 ------
 3 files changed, 16 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 16e5696314a4..e7b9d88f4483 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -72,7 +72,6 @@ static unsigned int xprt_rdma_slot_table_entries = RPCRDMA_DEF_SLOT_TABLE;
 unsigned int xprt_rdma_max_inline_read = RPCRDMA_DEF_INLINE;
 unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
 unsigned int xprt_rdma_memreg_strategy		= RPCRDMA_FRWR;
-int xprt_rdma_pad_optimize;
 static struct xprt_class xprt_rdma;
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
@@ -134,13 +133,6 @@ static struct ctl_table xr_tunables_table[] = {
 		.extra1		= &min_memreg,
 		.extra2		= &max_memreg,
 	},
-	{
-		.procname	= "rdma_pad_optimize",
-		.data		= &xprt_rdma_pad_optimize,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 	{ },
 };
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index aaec3c9be8db..d8650a3563ef 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -205,14 +205,12 @@ static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
 	unsigned int rsize, wsize;
 
 	/* Default settings for RPC-over-RDMA Version One */
-	ep->re_implicit_roundup = xprt_rdma_pad_optimize;
 	rsize = RPCRDMA_V1_DEF_INLINE_SIZE;
 	wsize = RPCRDMA_V1_DEF_INLINE_SIZE;
 
 	if (pmsg &&
 	    pmsg->cp_magic == rpcrdma_cmp_magic &&
 	    pmsg->cp_version == RPCRDMA_CMP_VERSION) {
-		ep->re_implicit_roundup = true;
 		rsize = rpcrdma_decode_buffer_size(pmsg->cp_send_size);
 		wsize = rpcrdma_decode_buffer_size(pmsg->cp_recv_size);
 	}
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index d91f54eae00b..137866a83a3a 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -74,7 +74,6 @@ struct rpcrdma_ep {
 	struct ib_pd		*re_pd;
 	unsigned int		re_max_rdma_segs;
 	unsigned int		re_max_fr_depth;
-	bool			re_implicit_roundup;
 	enum ib_mr_type		re_mrtype;
 	struct completion	re_done;
 	unsigned int		re_send_count;
@@ -441,11 +440,6 @@ rpcrdma_portstr(const struct rpcrdma_xprt *r_xprt)
 	return r_xprt->rx_xprt.address_strings[RPC_DISPLAY_PORT];
 }
 
-/* Setting this to 0 ensures interoperability with early servers.
- * Setting this to 1 enhances certain unaligned read/write performance.
- * Default is 0, see sysctl entry and rpc_rdma.c rpcrdma_convert_iovs() */
-extern int xprt_rdma_pad_optimize;
-
 /* This setting controls the hunt for a supported memory
  * registration strategy.
  */
-- 
2.27.0

