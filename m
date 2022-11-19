Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22D9631086
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Nov 2022 20:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiKSTuV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Nov 2022 14:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiKSTuU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Nov 2022 14:50:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFF3E6A
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 11:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668887362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHzgdB+059qn9iRhgC6gAwtu+aIFrdY9hsPT76aY/Dg=;
        b=VEsYtAk5OZ9IblqXLD9IL76mtTwpymNjlc6UjPXPvmMpH+dCfKiC5z03EH6a0va+aQju4D
        P/p6bf4WhYB1V+vvMaoB2OTtUNSw7BKMbT4dto6oa1JtcE+XtfA02xiZcyBUHti9CSOvyA
        py+A/h/lg9w7GuNFtGw77o81M6mn2pk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-119-DVXl2LIbPZWazsG24eOciA-1; Sat, 19 Nov 2022 14:49:19 -0500
X-MC-Unique: DVXl2LIbPZWazsG24eOciA-1
Received: by mail-qk1-f197.google.com with SMTP id bj1-20020a05620a190100b006fa12a05188so10672331qkb.4
        for <linux-nfs@vger.kernel.org>; Sat, 19 Nov 2022 11:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHzgdB+059qn9iRhgC6gAwtu+aIFrdY9hsPT76aY/Dg=;
        b=MFH6QR0Eu13LQchgbukC1X3NOAFr4RpcLXkvGm3k+yzjRc6rMX5jO+O8G1+SN8wSwA
         CrZ2h0cynZ8o2lzaVSxOOBLJ/vTK3gnzeLGupanDJVJ+xbKsY5pcOQk8R139XG8Wi59Z
         srtz976gxaHZB8w9hhwXPBJv6eUUkfRLZmqSvkf/La4f+qdGRpvoyvekyl0+M4u0+jt+
         5tJUJb8Q6pUPMSd4h/PI680SAk0bK/pK2V9yS0UjYuqWbj7Od2geXoLOsJj0um6L+vjy
         FOx6CpY8kPZI5d0QR6NZ2RtUu0l6sABqRD2Oex7BIVb/sSfMWTVv/RmKGqUYYVY9Jmxr
         rl1g==
X-Gm-Message-State: ANoB5pkwVArvtwExmbKS4N60g61eGbAAPTj3NfbfZ9S88O4oWN1qnPrp
        KX/Rwju6JDBsKjDRtweOeCVFqvIQHhJERZSQ8tEKye4UJRV0d6vWLCvt+udpvcpOLLNFE86rFD8
        m2LQjyMmYgehICedG9SHB
X-Received: by 2002:a05:620a:1e9:b0:6f9:fe9e:8920 with SMTP id x9-20020a05620a01e900b006f9fe9e8920mr10903684qkn.154.1668887359395;
        Sat, 19 Nov 2022 11:49:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7JAHtPgV1fc438nYfo8I0LxGL4jq3R4dD/fJaQnKYu4JNoyTXkvr0qwo/FCEmPdgoDz7KWxg==
X-Received: by 2002:a05:620a:1e9:b0:6f9:fe9e:8920 with SMTP id x9-20020a05620a01e900b006f9fe9e8920mr10903673qkn.154.1668887359127;
        Sat, 19 Nov 2022 11:49:19 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id t7-20020a37ea07000000b006fa2cc1b0fbsm5027070qkj.11.2022.11.19.11.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 11:49:14 -0800 (PST)
Message-ID: <3abb5a3b-d800-3c22-5793-0ce20e71343a@redhat.com>
Date:   Sat, 19 Nov 2022 14:49:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] README: fix typos and grammar
Content-Language: en-US
To:     yegorslists@googlemail.com, linux-nfs@vger.kernel.org
References: <20221115103116.11038-1-yegorslists@googlemail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221115103116.11038-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/15/22 5:31 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Also remove unneeded spaces.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Committed...

steved.
> ---
>   README | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/README b/README
> index 5e982409..0b62a4f1 100644
> --- a/README
> +++ b/README
> @@ -25,7 +25,7 @@ Unpack the sources and run these commands:
>       # ./configure
>       # make
>   
> -To install binaries and documenation, run this command:
> +To install binaries and documentation, run this command:
>   
>       # make install
>   
> @@ -40,7 +40,7 @@ Updating to the latest head after you've already got it.
>   
>   	git pull
>   
> -Building requires that autotools be installed.  To invoke them
> +Building requires that autotools be installed. To invoke them
>   simply
>   
>   	sh autogen.sh
> @@ -95,27 +95,27 @@ scripts can be written to work correctly.
>   
>      D/ rpc.statd --no-notify
>          It is best if statd is started before nfsd though this isn't
> -       critical.  Certainly it should be at most a few seconds after
> +       critical. Certainly, it should be at most a few seconds after
>          nfsd.
>          When nfsd starts it will start lockd. If lockd then receives a
> -       lock request it will communicate with statd.  If statd is not
> +       lock request, it will communicate with statd. If statd is not
>          running lockd will retry, but it won't wait forever for a
>          reply.
>          Note that if statd is started before nfsd, the --no-notify
> -       option must be used.  If notify requests are sent out before
> +       option must be used. If notify requests are sent out before
>          nfsd start, clients may try to reclaim locks and, on finding
>          that lockd isn't running, they will give up and never reclaim
>          the lock.
>          rpc.statd is only needed for NFSv2 and NFSv3 support.
>   
>      E/ rpc.nfsd
> -       Starting nfsd will automatically start lockd.  The nfs server
> +       Starting nfsd will automatically start lockd. The nfs server
>          will now be fully active and respond to any requests from
>          clients.
>          
>      F/ sm-notify
>          This will notify any client which might have locks from before
> -       a reboot to try to reclaim their locks.  This should start
> +       a reboot to try to reclaim their locks. This should start
>          immediately after rpc.nfsd is started so that clients have a
>          chance to reclaim locks within the 90 second grace period.
>          sm-notify is only needed for NFSv2 and NFSv3 support.

