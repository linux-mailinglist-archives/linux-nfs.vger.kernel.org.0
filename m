Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96D57D628
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 23:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGUViT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 17:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUViT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 17:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7683793639
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658439497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bs1bPEu4HJGPzcfhdblEYR++KJECOk9bu1ssP81ytBw=;
        b=dVC7rpFkEBkplTV/QXI7Gqos1FxaROReccyMGPpo3mQJ6mOtBRIzee6ta1ycihUE8ewFiO
        088N/fQyFosHU7H0pUHX7szUJvwv/mhFY00LeZduQc1CDnh18PvT66PlcSBgDrqUT4AT1O
        qiRDxPfAEhVjsjIxghgMVHXVtp+X7f0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-4oo0TUZ2MPizE37RYwh5Jw-1; Thu, 21 Jul 2022 17:38:13 -0400
X-MC-Unique: 4oo0TUZ2MPizE37RYwh5Jw-1
Received: by mail-qk1-f199.google.com with SMTP id j16-20020a05620a411000b006b5fb8e5d95so2275606qko.19
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 14:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bs1bPEu4HJGPzcfhdblEYR++KJECOk9bu1ssP81ytBw=;
        b=d+oNRWP6cXUUjRz34aYoYYeIT7dqEmTa+eadKsPZzrdukBzP4TT6/80OVc8VukiEhl
         CTfvP8D7lwIOMO5NfitQgVHkek+yNAfkD7xf5uinN3PEI1Hd/Eq1rKdEDbbWj4pAktoP
         LWvsH6AVAVk8fDgm7BRJGjDt/X8l0/0nWEcoCYfJ2vJx2pop5xsbs0THTTYOTcb0LKzi
         xWmEdx7YW9jPyyX497L+hCeQ6fZ9QkZpYTUY2mjRj1QBxih2hSiHypc+YhAA06ddNpNw
         l/x/qMKqOrd6xyPVuaYYRe4w3R90ZSk9cL5Ai+rXB4QMYR5ighU0uSTg/R1+AL02B3xV
         RetA==
X-Gm-Message-State: AJIora9omphiw/DqywQitS31ZWkV9mxAptPOytbXAmlydAqv3i9StN6u
        Du6uXaCxFhtjhIh6sPVt1R7iJQuRm5JhnN/Mul9DsGfzOyrgBUPCPfghph/BOhnwPe76Vo2yP2c
        e4qtEB/eCYIYX+52Po9B4
X-Received: by 2002:ac8:59c8:0:b0:31a:576f:13f9 with SMTP id f8-20020ac859c8000000b0031a576f13f9mr565360qtf.596.1658439492237;
        Thu, 21 Jul 2022 14:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOr8V0Hd0RwVgvCWBGNX1YrZO+9NfXR1sSuYtnIrEskYGTuBDGPh5ZkFNwfvxB12lfAF5Dxw==
X-Received: by 2002:ac8:59c8:0:b0:31a:576f:13f9 with SMTP id f8-20020ac859c8000000b0031a576f13f9mr565337qtf.596.1658439491853;
        Thu, 21 Jul 2022 14:38:11 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.98.133])
        by smtp.gmail.com with ESMTPSA id g25-20020ac842d9000000b0031ede43512bsm1930708qtm.44.2022.07.21.14.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 14:38:11 -0700 (PDT)
Message-ID: <3c506b75-30c1-5cc4-595d-0656d05a7a9b@redhat.com>
Date:   Thu, 21 Jul 2022 17:38:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Thread safe client destruction
Content-Language: en-US
To:     Attila Kovacs <attila.kovacs@cfa.harvard.edu>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
References: <53af8ec6-4ece-09b2-9499-d46d0fdfaa15@cfa.harvard.edu>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <53af8ec6-4ece-09b2-9499-d46d0fdfaa15@cfa.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 7/21/22 2:41 PM, Attila Kovacs wrote:
> Hi again,
> 
> 
> I found yet more potential MT flaws in clnt_dg.c and clnt_vg.c.
> 
> 1. In clnt_dg.c in clnt_dg_freeres(), cu_fd_lock->active is set to TRUE, 
> with no corresponding clearing when the operation (*xdr_res() call) is 
> completed. This would leave other waiting operations blocked 
> indefinitely, effectively deadlocked. For comparison, clnt_vd_freeres() 
> in clnt_vc.c does not set the active state to TRUE. I believe the vc 
> behavior is correct, while the dg behavior is a bug.
> 
> 2. If clnt_dg_destroy() or clnt_vc_destroy() is awoken with other 
> blocked operations pending (such as clnt_*_call(), clnt_*_control(), or 
> clnt_*_freeres()) but no active operation currently being executed, then 
> the client gets destroyed. Then, as the other blocked operations get 
> subsequently awoken, they will try operate on an invalid client handle, 
> potentially causing unpredictable behavior and stack corruption.
> 
> The proposed fix is to introduce a simple mutexed counting variable into 
> the client lock structure, which keeps track of the number of pending 
> blocking operations on the client. This way, clnt_*_destroy() can check 
> if there are any operations pending on a client, and keep waiting until 
> all pending operations are completed, before the client is destroyed 
> safely and its resources are freed.
> 
> Attached is a patch with the above fixes.
There is a problem here... This patch does contain the first patch
you posted. So when I apply this patch it fails.

So Please apply your first patch, then apply the fixes from
your second patch... test... then when all is good...
Resent the second patch which will apply, cleanly,
with the first patch.

steved.

> 
> -- A.

