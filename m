Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD395B7765
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiIMRLl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiIMRLZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 13:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E385FDA
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663084777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KARhchcnmyxpKQVcKDMjwE/KLDdmE86JLITX7Xw37Qo=;
        b=FLjhshnZ+iPnIam/lEXOupYgOAAjPuB2c1ya5Wf58PwmcrDwXImiN9ZjZ/gao4Q2BEkI+P
        3JVPlS6TkMZfEEIWYaoKqP4rvxhStEK8Hs0lJC07viyq2i7QgmRFj3P29pGD2wql//92Ak
        igufBF5Mp72NdKX5qzW9fFyJHGEU7dY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-547-BPmS9ywqO-u9jWBL4xucCA-1; Tue, 13 Sep 2022 11:59:36 -0400
X-MC-Unique: BPmS9ywqO-u9jWBL4xucCA-1
Received: by mail-qt1-f198.google.com with SMTP id o21-20020ac87c55000000b00344646ea2ccso10099329qtv.11
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 08:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KARhchcnmyxpKQVcKDMjwE/KLDdmE86JLITX7Xw37Qo=;
        b=GIyjy5ARnsSrmW0fpYs/sgeNluNSTDjAzJ6TLzr6xkvAzGNboMFB7nCjNLH3Q4atsV
         QRPdsysDDvE8mj+RL56MVKO0qpKTb1kXd911WDTlk21S7nR6Oe9W68kH999F7u2TVXFk
         S4jExME/BeYFO6tLvODh9oKEm9UvTTSUZq8yKi40q4rZSpC27Fbyfz1O18UeXirY8nUw
         mCoHP85Bu/+XZq7Cv8Qf7R+ku7Jtv5QblsGKqLxXoUspsdCRcivEdyp1YzfJO0WzbCmS
         fCP8/IwJ0nqk06kAlTACzzHgjJ15dtM8G8CnWkiMSTRGMLfGPiZ/vqU+BoW8tWZ7UJQd
         QuXQ==
X-Gm-Message-State: ACgBeo1Vqke+BAEY7UClGST2A5Xf1AHBAMixKF/YbPkJbTaHDcn4ipyl
        p53D4kqJlVklKC3OMoAKvrSeVX8xClbvQAQCLg775gpdqMdHU6C/KjT8kkggreijs7Jhbysc0iy
        L9UmsihR9LPxE1idJ0J0h
X-Received: by 2002:a05:622a:3d0:b0:35b:b4d4:8d99 with SMTP id k16-20020a05622a03d000b0035bb4d48d99mr9240770qtx.516.1663084773560;
        Tue, 13 Sep 2022 08:59:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7L6UOB4IoilQjpeHi9JuWSTE4rcl7yLZrWIb4hpuQ057VpGE+klwBMcPewNM26euUQFtyflg==
X-Received: by 2002:a05:622a:3d0:b0:35b:b4d4:8d99 with SMTP id k16-20020a05622a03d000b0035bb4d48d99mr9240722qtx.516.1663084773012;
        Tue, 13 Sep 2022 08:59:33 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a28d300b006ce622e6c96sm1936520qkp.30.2022.09.13.08.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 08:59:32 -0700 (PDT)
Message-ID: <fcb3e029-5754-d8d4-cc3c-a8b833db03c0@redhat.com>
Date:   Tue, 13 Sep 2022 11:59:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] nfs4_setfacl: add a specific option for indexes
Content-Language: en-US
To:     Pierguido Lambri <plambri@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220815083908.65720-1-plambri@redhat.com>
 <dff91106-4869-c20b-502b-4d3e0e9ac536@redhat.com>
 <20220825074345.cexc7kgaljnuqf66@plambri-t490s>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220825074345.cexc7kgaljnuqf66@plambri-t490s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/25/22 3:43 AM, Pierguido Lambri wrote:
> On Wed, Aug 24, 2022 at 04:10:40PM -0400, Steve Dickson wrote:
>> Hello,
>>
>> I'll go ahead and que this patch.. but there needs to be
>> an manpage update for me to commit to it...
> 
> Thanks Steve.
> I wasn't sure this would be accepted, I'll send another patch for the man
> page.
FYI... I'm going to wait for the man page before I
do the commit.

steved.

> 
> Pier
> 

