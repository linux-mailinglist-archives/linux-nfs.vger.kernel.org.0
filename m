Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D1C530033
	for <lists+linux-nfs@lfdr.de>; Sun, 22 May 2022 03:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiEVBYN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 May 2022 21:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiEVBYM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 May 2022 21:24:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D831F35ABF
        for <linux-nfs@vger.kernel.org>; Sat, 21 May 2022 18:24:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i82-20020a1c3b55000000b00397391910d5so2965959wma.1
        for <linux-nfs@vger.kernel.org>; Sat, 21 May 2022 18:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=By6LLSB398aJAXLz3l1/IPzCcROqPF+KQfpEbBywwUQ=;
        b=PfBjnuNxP+80NTAK/fMH3ae91ZHlTZ8hpLmeeIDaFC8Gxqg9Deel2Zd15TFtxZ2NNA
         qGQP3kWy95YQ72uA7L4FlIDCtoSTZ15FoBX/yHYlW8R1WOK2D0Jc1oYwtlWrxtxmoDs9
         s3sVyGsdBiikW0Abv+x7tEwzZyl5X990jjS7pmxQZhLebTzoJBTXZlCSseayiPW/Ct5R
         ip8bM1STedPQddAlKhNOa57QuCUSlQ/HZ+gC5tJorPPs4XllneKIl1xpytVmUpJPlsiv
         iZlmmAgJawupaJ2DPMiOWJVpjtNFd25gOiuSApOH8O1z7Zir42Y8wZWeQMRZkIHMQc0W
         EtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=By6LLSB398aJAXLz3l1/IPzCcROqPF+KQfpEbBywwUQ=;
        b=JYUJTmasGIJKGvN0r0ICamqu4/N70cDQ9kezYoWmkRpbqKJXmN48YDduUBsyQGvJCR
         wOixAVio7xKs2KcZYCCpvKqOPBgYP+fvqF4Rjbcmrqu+mnPRRitzLvxtgmFwCt3kuUek
         jiAr9ipFCkKUlQ0V1LAxi19og4gPy45QtfDfXskR1Tynnci2falQTcMBlMp96U8cYuLc
         eDQZlMQefFqriHX3eC/xXu5Tpe/nzKV2Vr4i9QMB9TJ1qC4WQ84CRbfOXfLdTzDTjkdr
         YD/WfOPZGZIFhedKczVU5rIm/18RTCA7cmIG530vc82XtFiQOdOvogM7FBDBfK9D6iCm
         bDgA==
X-Gm-Message-State: AOAM530YeCwyTDsa4RhI7H8Zw1CsG5qdp08j4y6pT6fUsIS7xG9mGBsW
        8ppnadtf3GyKncWczy+wlijUnswrzz8rbg==
X-Google-Smtp-Source: ABdhPJzsSSSHq1FxXU6/8RiojHK4vzzmXuCoJ9RON0mw3zDE1ccdbmCJdJFapA78byAT8E96NwrXqw==
X-Received: by 2002:a05:600c:4207:b0:395:c855:2aba with SMTP id x7-20020a05600c420700b00395c8552abamr14765063wmh.66.1653182649231;
        Sat, 21 May 2022 18:24:09 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id d27-20020adfa41b000000b0020d012692dbsm7252001wra.18.2022.05.21.18.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 18:24:08 -0700 (PDT)
Message-ID: <09f0b58c-37d7-4b8d-0285-01ec11601d01@gmail.com>
Date:   Sun, 22 May 2022 09:24:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:101.0)
 Gecko/20100101 Thunderbird/101.0
From:   Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH] xprtrdam: Don't treat a call as bcall when bc_serv is
 NULL
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <3d65c9a2-6c3e-7224-5701-c3e0060b6df6@gmail.com>
 <FE1A00F7-3CAF-4B62-9DD6-0EADF44D3059@oracle.com>
Content-Language: en-US
In-Reply-To: <FE1A00F7-3CAF-4B62-9DD6-0EADF44D3059@oracle.com>
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

Hi Chuck,

On 2022/5/22 12:33 AM, Chuck Lever III wrote:
> 
> 
>> On May 21, 2022, at 5:51 AM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>>
>> When rdma server returns a fault reply, rpcrdma may treats it as a bcall.
>> As using NFSv3, a bc server is never exist.
>> rpcrdma_bc_receive_call will meets NULL pointer as,
>>
>> [  226.057890] BUG: unable to handle kernel NULL pointer dereference at 00000000000000c8
>> ...
>> [  226.058704] RIP: 0010:_raw_spin_lock+0xc/0x20
>> ...
>> [  226.059732] Call Trace:
>> [  226.059878]  rpcrdma_bc_receive_call+0x138/0x327 [rpcrdma]
>> [  226.060011]  __ib_process_cq+0x89/0x170 [ib_core]
>> [  226.060092]  ib_cq_poll_work+0x26/0x80 [ib_core]
>> [  226.060257]  process_one_work+0x1a7/0x360
>> [  226.060367]  ? create_worker+0x1a0/0x1a0
>> [  226.060440]  worker_thread+0x30/0x390
>> [  226.060500]  ? create_worker+0x1a0/0x1a0
>> [  226.060574]  kthread+0x116/0x130
>> [  226.060661]  ? kthread_flush_work_fn+0x10/0x10
>> [  226.060724]  ret_from_fork+0x35/0x40
>> ...
>>
>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>> ---
>> net/sunrpc/xprtrdma/rpc_rdma.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
>> index 281ddb87ac8d..9486bb98eb2f 100644
>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>> @@ -1121,9 +1121,14 @@ static bool
>> rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
>> #if defined(CONFIG_SUNRPC_BACKCHANNEL)
>> {
>> +	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
>> 	struct xdr_stream *xdr = &rep->rr_stream;
>> 	__be32 *p;
>>
>> +	/* no bc service, not a bcall. */
>> +	if (xprt->bc_serv == NULL)
>> +		return false;
>> +
>> 	if (rep->rr_proc != rdma_msg)
>> 		return false;
> 
> I'm not sure what you mean above by "fault reply".
> 
> The check here for whether the RPC/RDMA procedure is an RDMA_MSG
> is supposed to be enough to avoid any further processing of an
> RDMA_ERR type procedure.
> 
> What kind of fault has occurred? Can you share with us the
> actual RPC/RDMA transport header that triggers the BUG?

I have a nfs rdma server, but it handles drc reply wrongly sometimes,
it returns a bad format reply to nfs client.
Nfs rdma client treats the bad format reply as a bcall, and

Thanks,
Kinglong Mee
