Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205646D57FB
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Apr 2023 07:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjDDF3y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Apr 2023 01:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjDDF3x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Apr 2023 01:29:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D021FEF
        for <linux-nfs@vger.kernel.org>; Mon,  3 Apr 2023 22:29:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn12so125865501edb.4
        for <linux-nfs@vger.kernel.org>; Mon, 03 Apr 2023 22:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680586189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+AH8+cRT9BzttlXhbJKMohkajScydtqlMaLV4AFHi40=;
        b=QKWeindqfEx1BF38SzIlBd2rEEYgGUAilkrgqgQ9f0nVVPBK6++GHMDg5Xq4D1FQZl
         8wTjvXWFvQa9J1WJ6lJNtCi4ROndzyAOYNYrIbZCNsJgyxSHKHaXSooT2IBZnmG/SGal
         nu5kN1Gcwhd9iTj08/nZ2zzK9NX8QaW+pWk8gZfiqIYAz/acgo95/pTfkw6txTzIuXZN
         WvZUr0iffL/TRmzP+HLUGfNy1eDR3Ikep49Aa9IF7U6ZQ1mL3Obksw8ySyAsz6ON76Iq
         L4C8Wk3HULwxKm/wzuy33Bsq9MqW8aLHlKHPN43V4C1EWOiO9PUpS2xbgnt5jFUP/UJU
         PsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680586189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AH8+cRT9BzttlXhbJKMohkajScydtqlMaLV4AFHi40=;
        b=thU2qyhrfoJ1Ikutgh3tQuzUVY7AUdH+GBIP4fKMp04fUHrXju1Vy3gVQ1WpFAknwh
         Q+0JdTBdeAiQPnaKnzoCHGBizJOSAZ8nf7YT695UEafHoyAEKnsQ03bSbWakZyKk5xcV
         9umszK78jQsvz4z1E943Y/mpzzP/lgS2NjDFJ4l+9edJYI2UpOdmN1ljY/LG671wOjv8
         eHLQLGMWEJfqzfC6nFjCVdKP6Ly+QnUYRWLMKOoix8oLYVZ7j3FDlJ+ViRGRuQMqFf1E
         yk/+CZvDYRTf7elSZUO6elfiaqsLGurmIS89UoSkrwKXEZ7mfJpARmw4Hj6sHoiaqmOx
         cw+w==
X-Gm-Message-State: AAQBX9e2OVmpEJTnxhTGdmy8gWs6B99ZTPdTdOuKl3ZF0MA6bT/nv1M5
        ngt5FqdBgqCayQ6OYflEPMpDKA==
X-Google-Smtp-Source: AKy350YRXj8JF5zknuqNdy3NJB91LmgMzOsPkxGo3TnfJkmyu6Z2nM2PaayhN73Eu9alOckxw0GanA==
X-Received: by 2002:a17:906:b044:b0:944:49ee:aea2 with SMTP id bj4-20020a170906b04400b0094449eeaea2mr1157530ejb.71.1680586188869;
        Mon, 03 Apr 2023 22:29:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id k26-20020a1709062a5a00b009331450d04esm5514550eje.178.2023.04.03.22.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 22:29:48 -0700 (PDT)
Message-ID: <50fa11f1-35bf-fa93-bc96-d1e0a05abc0f@linaro.org>
Date:   Tue, 4 Apr 2023 07:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
 <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
 <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org>
 <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
 <32530c36-91d0-d351-0689-aed6a0975a4b@linaro.org>
 <2f285607-cbf9-6abc-f436-edb6e9a3938b@linaro.org>
 <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com>
 <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org>
 <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org>
 <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
 <CAN-5tyGUBB0zoPbdJ=3yCE+eJJyP2qH3uobFP+XEMsFNex_LEA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAN-5tyGUBB0zoPbdJ=3yCE+eJJyP2qH3uobFP+XEMsFNex_LEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 04/04/2023 03:01, Olga Kornievskaia wrote:
> On Mon, Mar 6, 2023 at 12:12 PM Anna Schumaker <schumaker.anna@gmail.com> wrote:
>>
>> Hi Krzysztof,
>>
>> On Tue, Feb 14, 2023 at 6:02 AM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 12/02/2023 15:05, Anna Schumaker wrote:
>>>>>> From ac2d6c501dbcdb306480edaee625b5496f1fb4f5 Mon Sep 17 00:00:00 2001
>>>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>> Date: Fri, 10 Feb 2023 15:50:22 -0500
>>>>>> Subject: [PATCH] NFSv4.2: Rework scratch handling for READ_PLUS
>>>>>>
>>>>>
>>>>> Patch is corrupted - maybe mail program reformatted it when sending:
>>>>>
>>>>> Applying: NFSv4.2: Rework scratch handling for READ_PLUS
>>>>> error: corrupt patch at line 12
>>>>> Patch failed at 0001 NFSv4.2: Rework scratch handling for READ_PLUS
>>>>
>>>> That's weird. I wasn't expecting gmail to reformat the patch but I
>>>> guess it did. I've added it as an attachment so that shouldn't happen
>>>> again.
>>>
>>> Still null ptr (built on 420b2d4 with your patch):
>>
>> We're through the merge window and at rc1 now, so I can spend more
>> time scratching my head over your bug again. We've come up with a
>> patch (attached) that adds a bunch of printks to show us what the
>> kernel thinks is going on. Do you mind trying it out and letting us
>> know what gets printed out? You'll need to make sure
>> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.
> 
> Hi Krzystof,
> 
> Since you are the only one hitting the problem, could you be so kind
> as to help with getting this resolved.
> 

My setup is not special. It is regular ARMv7 board using a regular ARMv8
NFS server. Anyway my farm is since some time offline due to relocation
and will be online in June, so I cannot test anything.

Best regards,
Krzysztof

