Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BFD52FA7A
	for <lists+linux-nfs@lfdr.de>; Sat, 21 May 2022 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348911AbiEUJvR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 May 2022 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347510AbiEUJvQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 May 2022 05:51:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793A2DF48
        for <linux-nfs@vger.kernel.org>; Sat, 21 May 2022 02:51:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bg25so5663596wmb.4
        for <linux-nfs@vger.kernel.org>; Sat, 21 May 2022 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=s1vus2rdwR7P0fsSXZMTC41+cEEo+RRlTohs3sSevnM=;
        b=If5SkiH0fHJCSN8wGXx+HF1VQZVEvdFywYIDT0ykW3cyxws7BucWEvUVmrjxLBRBli
         +VJaDQ+VKbwTU6RdKm7rUCX1Y/z/Q4wseGFiO515mHuDNANw/Rmab9KXBf9hmFRZf5LD
         xc9M6H1rge0mdEQDjOaeBM9dfaf7fK/9UgViPIQxnhUxDSiK4WcyDRqJfGySWTM6/Bn5
         svmnPOOVNf8evzkOpHq7VeOOgfIuj1hMqNzAmxV5bxbLRH1XHjqsboPlnGTK9GCSTREL
         UNGAaJ+RAVuPffPF6pRxkWLykKoq7u1+2Txa8vQrFolZ0MEhENR6pN0wJWG0Zp5BOxa8
         tnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=s1vus2rdwR7P0fsSXZMTC41+cEEo+RRlTohs3sSevnM=;
        b=l2maxrCxqju8vqjnCOwmRSeBJRUZLo92gc7b/kjlYeR66UbCv1xR5c1tupqoZ3cRIw
         8McFVfkrwj02hGQzG0IvT26gqtP4A0mXk2UobW5rDZlaOaxo276MB3cuzckeVW1dlwcS
         75OkEYJKhHcCsEHaQBzsIN/P15nvTSE7GfVyap01gBD04Tll1cR5qghoo2JhDVRF2oIQ
         qA397sXh9oG0wyU9mH0aUTGGxGt6ktZ6xYndjkkC2FnBGIM/KoGTM/H4eTul9lPiD+Ko
         ZVs0wuUFXsAE86O25/VQqwiBY1Cvc7CYCnsodwjfA7wY6m1zEysIK7EbxYF8p5uYUa21
         PxeA==
X-Gm-Message-State: AOAM530ewWXYxbqmYeYT2fjGZQpZNZeM+uFdAMAlI1AwPGEyoHgUzcnZ
        I9tAZ+d71ou+RO+SaYrQorjeCajtXognUw==
X-Google-Smtp-Source: ABdhPJwALO0RRNbAETIo6cyDkHNsb2mMD9mgRODbxXMM6oLO5GXjoA29w7onWy0HrQgcWP28pZP+/A==
X-Received: by 2002:a05:600c:3542:b0:394:6e2f:ffa2 with SMTP id i2-20020a05600c354200b003946e2fffa2mr11864554wmq.132.1653126671946;
        Sat, 21 May 2022 02:51:11 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id g22-20020adfa496000000b0020c5253d907sm4551584wrb.83.2022.05.21.02.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 02:51:11 -0700 (PDT)
Message-ID: <3d65c9a2-6c3e-7224-5701-c3e0060b6df6@gmail.com>
Date:   Sat, 21 May 2022 17:51:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:101.0)
 Gecko/20100101 Thunderbird/101.0
Content-Language: en-US
To:     Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
From:   Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] xprtrdam: Don't treat a call as bcall when bc_serv is NULL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When rdma server returns a fault reply, rpcrdma may treats it as a bcall.
As using NFSv3, a bc server is never exist.
rpcrdma_bc_receive_call will meets NULL pointer as,

[  226.057890] BUG: unable to handle kernel NULL pointer dereference at 
00000000000000c8
...
[  226.058704] RIP: 0010:_raw_spin_lock+0xc/0x20
...
[  226.059732] Call Trace:
[  226.059878]  rpcrdma_bc_receive_call+0x138/0x327 [rpcrdma]
[  226.060011]  __ib_process_cq+0x89/0x170 [ib_core]
[  226.060092]  ib_cq_poll_work+0x26/0x80 [ib_core]
[  226.060257]  process_one_work+0x1a7/0x360
[  226.060367]  ? create_worker+0x1a0/0x1a0
[  226.060440]  worker_thread+0x30/0x390
[  226.060500]  ? create_worker+0x1a0/0x1a0
[  226.060574]  kthread+0x116/0x130
[  226.060661]  ? kthread_flush_work_fn+0x10/0x10
[  226.060724]  ret_from_fork+0x35/0x40
...

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
  net/sunrpc/xprtrdma/rpc_rdma.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 281ddb87ac8d..9486bb98eb2f 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1121,9 +1121,14 @@ static bool
  rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
  #if defined(CONFIG_SUNRPC_BACKCHANNEL)
  {
+	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
  	struct xdr_stream *xdr = &rep->rr_stream;
  	__be32 *p;

+	/* no bc service, not a bcall. */
+	if (xprt->bc_serv == NULL)
+		return false;
+
  	if (rep->rr_proc != rdma_msg)
  		return false;

-- 
2.27.0

