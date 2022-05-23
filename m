Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF99530730
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 03:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245388AbiEWBkD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 May 2022 21:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbiEWBkC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 May 2022 21:40:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2AB36B57
        for <linux-nfs@vger.kernel.org>; Sun, 22 May 2022 18:40:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r23so19235345wrr.2
        for <linux-nfs@vger.kernel.org>; Sun, 22 May 2022 18:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZSE99MDhxXECIOf2lp88/DFWqh8y0h7ZP2pHk1OziX8=;
        b=jCjeeFYBXzA1x+H829bA9z2zhzatNBh5h76eq4IiKZ4G5PD1DFQIrtzV8Du4Ohy6j1
         eICZYsA5WiUs3wJYUfRVQoMV94EdhYfCv4vR8hXJoh7XiKA+nvX0G7eZwVLBCPLZiLgo
         SdntAt17aa+WDBpqkoTWCJXPb8pI7W830Y2bEHEBR3ZFYLHpZ3vQ2s7Zlvj/OWPIW3XZ
         3O4yIUyHnngUE2RF763hgwxlrwGWvVFT068ygc3wsYUHnQzzaLTj7YH3k1uopcrPeOQv
         LY2brg9KLZSeHEg0D6ZWMbRjSvi4RGz5J6maqmTFY9rrLs5FIupqz8XXj8DKl8mup5lG
         1b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZSE99MDhxXECIOf2lp88/DFWqh8y0h7ZP2pHk1OziX8=;
        b=7xXnk4I7bh3x+fLdaDC+/BNfIHZoW1KlPToGSfj38Ee0dQe+9kwSTdZZx2RTOUFITO
         R4hdu8j/enBPlbhyOQdCnpy49oBdWKtD9LlPSVhSD7gOj/p3nUoLMPBm7dfysgt3YVpM
         meB504dQto3GDNYypFPJ+6VxuQre7SfwHw31LI6rzqSbdica/R7LOl/T8ptpdXt3ElIk
         fk8p1zpdOu40RSofMQm/nTBbRAWnlFJZQOQ5qjWekzsb9j6NTTXGu7+TqickZZoInxrV
         g4tgCbGajUTUy9YTclXo6WiB0xfzbT7/lhS6NS6XxZ4XnsIERFX5aYNH1UDikl5Dcj6C
         BClw==
X-Gm-Message-State: AOAM531sRQ4+ht4+2Bg90CfB7zfGt7CRa4FVr7Yy5NtkeE6W+1T0JjqM
        2+tbYBwYhhvgbtB0BSmVXm4=
X-Google-Smtp-Source: ABdhPJxrfuWkFOUpLnxTZXjerI6Ft4n8XXQWQIAuK4gYeoEl7PXt2agOiTixES3xZLgZWcuNhmKPOw==
X-Received: by 2002:a05:6000:1a8d:b0:20f:e61b:5203 with SMTP id f13-20020a0560001a8d00b0020fe61b5203mr484208wry.109.1653269999688;
        Sun, 22 May 2022 18:39:59 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id z5-20020a7bc145000000b003974a00697esm1944884wmi.38.2022.05.22.18.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 18:39:59 -0700 (PDT)
Message-ID: <9917406b-1cdb-17c6-fc98-4f05266b25f8@gmail.com>
Date:   Mon, 23 May 2022 09:39:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:101.0)
 Gecko/20100101 Thunderbird/101.0
Subject: Re: [PATCH v2] xprtrdma: treat all calls not a bcall when bc_serv is
 NULL
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <3d65c9a2-6c3e-7224-5701-c3e0060b6df6@gmail.com>
 <FE1A00F7-3CAF-4B62-9DD6-0EADF44D3059@oracle.com>
 <09f0b58c-37d7-4b8d-0285-01ec11601d01@gmail.com>
 <9F4E9614-9891-4787-86DC-944BEB45C960@oracle.com>
 <906dd00c-7999-4d36-0cf1-155ceb595ba9@gmail.com>
 <5123D71E-986C-41FB-A562-D38856AA436B@oracle.com>
From:   Kinglong Mee <kinglongmee@gmail.com>
In-Reply-To: <5123D71E-986C-41FB-A562-D38856AA436B@oracle.com>
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



On 2022/5/22 11:52 PM, Chuck Lever III wrote:
> 
> 
>> On May 22, 2022, at 8:36 AM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>>
>> When a rdma server returns a fault format reply, nfs v3 client may
>> treats it as a bcall when bc service is not exist.
>>
>> The debug message at rpcrdma_bc_receive_call are,
>>
>> [56579.837169] RPC:       rpcrdma_bc_receive_call: callback XID 00000001, length=20
>> [56579.837174] RPC:       rpcrdma_bc_receive_call: 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04
>>
>> After that, rpcrdma_bc_receive_call will meets NULL pointer as,
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
> 
> Patch is good, Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Commentary (no changes to v2 needed):
> 
> The description still suggests we are adapting the client to
> work around a broken server. I don't feel this is the right
> reason to accept this change. Instead: we really don't want
> the client to be vulnerable to bad input for any reason.
> After this fix is applied, bad RPC messages are eventually
> dropped rather than processed, which is the desired behavior.
> 
> Anna, I recommend adding Cc: stable for this fix.
> 
> Kinglong, please ensure that client Receive resources are not
> leaked in this case. If they are, send along an additional
> patch; if not, let us know and we can close this issue. 

I have double check of the code.
I think client Receive resources are not leaked here.
We can close it.

Thanks,
Kinglong Mee

> 
> 
>> ---
>> net/sunrpc/xprtrdma/rpc_rdma.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
>> index 281ddb87ac8d..190a4de239c8 100644
>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>> @@ -1121,6 +1121,7 @@ static bool
>> rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
>> #if defined(CONFIG_SUNRPC_BACKCHANNEL)
>> {
>> +	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
>> 	struct xdr_stream *xdr = &rep->rr_stream;
>> 	__be32 *p;
>>
>> @@ -1144,6 +1145,10 @@ rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
>> 	if (*p != cpu_to_be32(RPC_CALL))
>> 		return false;
>>
>> +	/* No bc service. */
>> +	if (xprt->bc_serv == NULL)
>> +		return false;
>> +
>> 	/* Now that we are sure this is a backchannel call,
>> 	 * advance to the RPC header.
>> 	 */
>> -- 
>> 2.27.0
>>
> 
> --
> Chuck Lever
> 
> 
> 
