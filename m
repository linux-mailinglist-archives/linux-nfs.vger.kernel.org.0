Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8C5302F2
	for <lists+linux-nfs@lfdr.de>; Sun, 22 May 2022 14:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiEVMLy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 May 2022 08:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiEVMLx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 May 2022 08:11:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423A927FF1
        for <linux-nfs@vger.kernel.org>; Sun, 22 May 2022 05:11:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h14so17275511wrc.6
        for <linux-nfs@vger.kernel.org>; Sun, 22 May 2022 05:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bwEczOo/QA0mabyb0DvRaBqqX2ih4fxgXLajJW3Zj/Q=;
        b=j0kPndZvzlVaENBEUUpoDprsEV8Q2Qs4hTy9UTgFhcwLccg01IKJvGXLFcl9lifxwK
         wbHYHg3Narp2x3upPb2o/76dSUQFCkk4q3pVZ0UJi8fDMdKLbf1D6Chcq3JBPqnbwHHm
         usFUwJuFHmWwb08yTnAfRxM+vR38SFuqok4a3xCJ4+GAl8lyUjWpd3/PvbuHWMswEMI8
         gZkBX0+CIdIi35UaIzHvvI4UYiT3Y/kC67eO3dXmq3TuV3UfuXiVvlqSecrEu/EMjop3
         A28Ic+Q3CKAcPKfn7V0dc2uXo6ip0tJ3hlrPui9BH1D2JPEhWsK7GnyZb28SDuD//8Wt
         Lovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bwEczOo/QA0mabyb0DvRaBqqX2ih4fxgXLajJW3Zj/Q=;
        b=k+bfkPqUu9ZiInLf1xiNZ/Krg1ToEtLYagVw3GlHrsEJORerhpQQGw375ci7VgA80b
         sXFmldOlW8p3mrHsoUDlDopmUE62hrcbHjbjkzyzqbsDHX1NHS0xigWkH2EcwIDsD6fg
         FT1YrCW/bHRWfoU/pEomnS+CIeewfKkCNnlbUP31icSNf15ACjv24wXUsg0YbPI6QXba
         JEV/z0BS09eCnx9kuXPfDwvt0xHQwjHProlaOye6A+ymIpR7+U+R++75rXUMSJSKL0KQ
         WChDCBwmw2+1/TfD/NMdjWatJXQcLQMoERyZfJoRr2YimGj12RqhNbwfc7UyHlRhCebs
         HMnw==
X-Gm-Message-State: AOAM533aApYtPgiF2ldWMQTNJwQEVRW/WehExeNue5NRx0qB1OlqJLLk
        0/tC/F6B88o4xWvaYuKI4Xo=
X-Google-Smtp-Source: ABdhPJylO9KEx//S21uG/jgrKCtsPn1qsn6XrfMaFsNa55e6An96oBA5Y5UlEetWcU25MT07LQpsNg==
X-Received: by 2002:adf:ec8b:0:b0:20d:483:f271 with SMTP id z11-20020adfec8b000000b0020d0483f271mr15288062wrn.555.1653221510701;
        Sun, 22 May 2022 05:11:50 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id r17-20020adfb1d1000000b0020c5253d926sm7085277wra.114.2022.05.22.05.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 05:11:50 -0700 (PDT)
Message-ID: <20a2d635-d782-3d18-203b-22d6b1231f68@gmail.com>
Date:   Sun, 22 May 2022 20:11:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:101.0)
 Gecko/20100101 Thunderbird/101.0
Subject: Re: [PATCH] xprtrdam: Don't treat a call as bcall when bc_serv is
 NULL
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <3d65c9a2-6c3e-7224-5701-c3e0060b6df6@gmail.com>
 <FE1A00F7-3CAF-4B62-9DD6-0EADF44D3059@oracle.com>
 <09f0b58c-37d7-4b8d-0285-01ec11601d01@gmail.com>
 <9F4E9614-9891-4787-86DC-944BEB45C960@oracle.com>
From:   Kinglong Mee <kinglongmee@gmail.com>
In-Reply-To: <9F4E9614-9891-4787-86DC-944BEB45C960@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2022/5/22 9:41 AM, Chuck Lever III wrote:
> 
> 
>> On May 21, 2022, at 9:24 PM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>>
>> Hi Chuck,
>>
>> On 2022/5/22 12:33 AM, Chuck Lever III wrote:
>>>> On May 21, 2022, at 5:51 AM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>>>>
>>>> When rdma server returns a fault reply, rpcrdma may treats it as a bcall.
>>>> As using NFSv3, a bc server is never exist.
>>>> rpcrdma_bc_receive_call will meets NULL pointer as,
>>>>
>>>> [  226.057890] BUG: unable to handle kernel NULL pointer dereference at 00000000000000c8
>>>> ...
>>>> [  226.058704] RIP: 0010:_raw_spin_lock+0xc/0x20
>>>> ...
>>>> [  226.059732] Call Trace:
>>>> [  226.059878]  rpcrdma_bc_receive_call+0x138/0x327 [rpcrdma]
>>>> [  226.060011]  __ib_process_cq+0x89/0x170 [ib_core]
>>>> [  226.060092]  ib_cq_poll_work+0x26/0x80 [ib_core]
>>>> [  226.060257]  process_one_work+0x1a7/0x360
>>>> [  226.060367]  ? create_worker+0x1a0/0x1a0
>>>> [  226.060440]  worker_thread+0x30/0x390
>>>> [  226.060500]  ? create_worker+0x1a0/0x1a0
>>>> [  226.060574]  kthread+0x116/0x130
>>>> [  226.060661]  ? kthread_flush_work_fn+0x10/0x10
>>>> [  226.060724]  ret_from_fork+0x35/0x40
>>>> ...
>>>>
>>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>>>> ---
>>>> net/sunrpc/xprtrdma/rpc_rdma.c | 5 +++++
>>>> 1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
>>>> index 281ddb87ac8d..9486bb98eb2f 100644
>>>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>>>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>>>> @@ -1121,9 +1121,14 @@ static bool
>>>> rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
>>>> #if defined(CONFIG_SUNRPC_BACKCHANNEL)
>>>> {
>>>> +	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
>>>> 	struct xdr_stream *xdr = &rep->rr_stream;
>>>> 	__be32 *p;
>>>>
>>>> +	/* no bc service, not a bcall. */
>>>> +	if (xprt->bc_serv == NULL)
>>>> +		return false;
>>>> +
>>>> 	if (rep->rr_proc != rdma_msg)
>>>> 		return false;
>>> I'm not sure what you mean above by "fault reply".
>>> The check here for whether the RPC/RDMA procedure is an RDMA_MSG
>>> is supposed to be enough to avoid any further processing of an
>>> RDMA_ERR type procedure.
>>> What kind of fault has occurred? Can you share with us the
>>> actual RPC/RDMA transport header that triggers the BUG?
>>
>> I have a nfs rdma server, but it handles drc reply wrongly sometimes,
>> it returns a bad format reply to nfs client.
>> Nfs rdma client treats the bad format reply as a bcall, and
> 
> Doesn't this test return false:
> 
> 1144         if (*p != cpu_to_be32(RPC_CALL))
> 1145                 return false;

No, it doesn't return false here.

The debug message at rpcrdma_bc_receive_call are,

[56579.837169] RPC:       rpcrdma_bc_receive_call: callback XID 
00000001, length=20
[56579.837174] RPC:       rpcrdma_bc_receive_call: 00 00 00 01 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 04

> 
> But OK: a malicious NFSv3 server can trigger a client crash.
> That's a bug.
> 
> This is an additional conditional in a hot path. Would it make
> sense to move the new test to just after 1145? >
> Even then, it could be a bcall, the client simply isn't
> prepared to process it. So "/* no bc service */" by itself
> would be a more accurate comment.

Okay, I will update it and send a v2 patch after moving the checking
after 1145.

Thanks,
Kinglong Mee
