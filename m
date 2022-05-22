Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B4153031D
	for <lists+linux-nfs@lfdr.de>; Sun, 22 May 2022 14:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbiEVMhD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 May 2022 08:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiEVMhC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 May 2022 08:37:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B524BF8
        for <linux-nfs@vger.kernel.org>; Sun, 22 May 2022 05:37:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z17so80050wmf.1
        for <linux-nfs@vger.kernel.org>; Sun, 22 May 2022 05:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=T3OKYkdawc/Qv7Sr/wS1OUZnYgD7LqG6s4hO4EaNS0s=;
        b=Py3P2X4FzeVl/WxdkUu/WuZ0zhEwvb/l07sNqbrBxWFowoAB9aXvV2nBjP1nA0tByA
         dP75JkqSqxtiUHsuluRLkf6PV265IqUPCPBt7Mzyx4/MrvIcjd0sbXLy8OoedTMqWGc3
         Y182PqffwQ+9/QYKjB7VeO0nCmzYSkJJOjq3nrMotPD3Ohu44ArgRtWvTbfoapM/7x/b
         lc50/VltFR01BLiE5y0nrVvdRG7IMieuWWrWrdZAH31b68MMeEcfdkld0KrsTPwBbfuf
         F1GuXdAB2NVBJmYZomfgGud/2B1OZTW5hgWq0bybOORPeJANaj0EqMvokOx1vneYvdmU
         GOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T3OKYkdawc/Qv7Sr/wS1OUZnYgD7LqG6s4hO4EaNS0s=;
        b=G5llH3YAI2NpaMYiseS09zMmlgJFP2/7USy/0vWP7bjwjNTQfvNLtquVdhLN31ZGdl
         D6ZYPwydexQXuIbTw8npZjSUsDYBaflOw4TZNhgP3toDrXC1AXQG5vK6yE+dzuQbCWTG
         W6K196Ug1nbjFwAkBPAWSC/WGyY6mq5Sdl0yl7eNwTJWobySKP2Qiqg4YWQVNzcT0AnF
         Whw/+mDWhD7ZTQ/lcL3909CUACV3LPA93/wSQZH0/IxpJlokeFPYrKGyxjCEmPNCXvVi
         LjL9V9fByL+KF0I6lICmw9i/vQgFZXWNbeC+hea+/BcGajDusOdBiMSFOYYfOkTBEdKA
         jLOA==
X-Gm-Message-State: AOAM531Qi3f0glfRHXKzSuisfN0wo/lgMhuZ6evdIGSDe+MLvM+7kVu2
        fQ5g1Tl6hTfuKabYbLy2UjY=
X-Google-Smtp-Source: ABdhPJy6ybzjR7hixmdLVJXC1ozKvTYJX2mbR84cpG8nKchjR7fMnMNNFPwUf75jDLYNRTYlnPkTlA==
X-Received: by 2002:a05:600c:3487:b0:397:ca9:c98b with SMTP id a7-20020a05600c348700b003970ca9c98bmr16986552wmq.51.1653223019740;
        Sun, 22 May 2022 05:36:59 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id l15-20020adfbd8f000000b0020e65d7d36asm7519688wrh.11.2022.05.22.05.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 05:36:59 -0700 (PDT)
Message-ID: <906dd00c-7999-4d36-0cf1-155ceb595ba9@gmail.com>
Date:   Sun, 22 May 2022 20:36:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:101.0)
 Gecko/20100101 Thunderbird/101.0
Subject: [PATCH v2] xprtrdma: treat all calls not a bcall when bc_serv is NULL
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <3d65c9a2-6c3e-7224-5701-c3e0060b6df6@gmail.com>
 <FE1A00F7-3CAF-4B62-9DD6-0EADF44D3059@oracle.com>
 <09f0b58c-37d7-4b8d-0285-01ec11601d01@gmail.com>
 <9F4E9614-9891-4787-86DC-944BEB45C960@oracle.com>
From:   Kinglong Mee <kinglongmee@gmail.com>
In-Reply-To: <9F4E9614-9891-4787-86DC-944BEB45C960@oracle.com>
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

When a rdma server returns a fault format reply, nfs v3 client may
treats it as a bcall when bc service is not exist.

The debug message at rpcrdma_bc_receive_call are,

[56579.837169] RPC:       rpcrdma_bc_receive_call: callback XID 
00000001, length=20
[56579.837174] RPC:       rpcrdma_bc_receive_call: 00 00 00 01 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 04

After that, rpcrdma_bc_receive_call will meets NULL pointer as,

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
index 281ddb87ac8d..190a4de239c8 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1121,6 +1121,7 @@ static bool
  rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
  #if defined(CONFIG_SUNRPC_BACKCHANNEL)
  {
+	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
  	struct xdr_stream *xdr = &rep->rr_stream;
  	__be32 *p;

@@ -1144,6 +1145,10 @@ rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, 
struct rpcrdma_rep *rep)
  	if (*p != cpu_to_be32(RPC_CALL))
  		return false;

+	/* No bc service. */
+	if (xprt->bc_serv == NULL)
+		return false;
+
  	/* Now that we are sure this is a backchannel call,
  	 * advance to the RPC header.
  	 */
-- 
2.27.0

