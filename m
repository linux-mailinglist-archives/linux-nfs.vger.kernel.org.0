Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7667312CB
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 10:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbjFOIzy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 04:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbjFOIzw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 04:55:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9EA171F
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 01:55:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9827bd8e0afso191573666b.1
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 01:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686819350; x=1689411350;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lV7QLu3dQCxU7BpztxvUiYaqzC4koTpfwg/H3VXhuQw=;
        b=F5LzRUtkbc+owwF0fBE5WC4VBb0fae9atAHmdJ5eiah/rOsQ4J6MyeumPDtP5L6o9X
         qk7o3f9VO3uDYH5U8sufXvpuf/GZ3nUT2XFcAlMfXfyhl28LqkkQz75QYxccDaLqTngi
         r3gyRKkekQB4Ksm74vDEQaEqhuaegeVW5XrN2Rvf/3jJGI6QGW5JhP9BtJpwtYmFGjaz
         6GJi42drqAvF5RMsmV8k2qwYEM9EAEAtMDR6mPWHQpi7tMETWDxcOlRUNdHTHcyW9vG4
         JEcQAVZKrAVCyBYjAZohcs2RdybcIzeV+Nv7dwYwcqIxY5tf5RaAV+yYVsVLqWuTxqPM
         PqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686819350; x=1689411350;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lV7QLu3dQCxU7BpztxvUiYaqzC4koTpfwg/H3VXhuQw=;
        b=XEf8hMaOfYQGHXWUwfFMQrclUm2OvQvLfoC0RwMXuokHFblF+Pt1g9rRc1cFQ8luc0
         AyvLtMhBusDS4FP2fIkGS2yuB/kNIqXVkdXueNOZHOE8aM91CxNv9DPMr16kVNa4hRjb
         cw7m/0OqNlfCDCSM4TD0JKADf5/ifpJMRqR6/sGs4hRt6btlsleY6x3JCSVAmXV1qwv9
         b+O5TWi8ZwtWI9Bwf/Ta9sj42Tys87lAI2/Z/lUIMo9g3vz8/JYS2Eetb3L0SsKVt3WT
         eQ6zIELTbspAhYymRp6Pm0B72Pl2QVZ7Zh/yrwSkfBugWZ0nSvKDxBKxELmOpwPByruu
         oWrg==
X-Gm-Message-State: AC+VfDyBGo2316qftVhoUp7Qx8r8A1lDDoXqcyz/StoPVseHeRzd/0+Z
        BrR9KCeO2uEwgfy4eRdAEC8cKQ==
X-Google-Smtp-Source: ACHHUZ72V9SYWFf+LtAZvutrD0Tp0XqxJCIY+D2Td80wBJ9YF2VHhGposHwZvllf8xiTuwtTblssVw==
X-Received: by 2002:a17:907:26ca:b0:974:1e0e:9bd4 with SMTP id bp10-20020a17090726ca00b009741e0e9bd4mr17990075ejc.16.1686819349690;
        Thu, 15 Jun 2023 01:55:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090617c300b009788dfde0b2sm9157169eje.12.2023.06.15.01.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 01:55:49 -0700 (PDT)
Message-ID: <c8d454b0-d355-f599-f720-b7e64374fb56@linaro.org>
Date:   Thu, 15 Jun 2023 10:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
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
 <86d8e252-975f-5d48-4567-0911d5ef9a44@linaro.org>
 <CAFX2Jfn_DSs38WQYsRs2ifLi5w+T3BhZfSU2W80T6dK48_Bb5g@mail.gmail.com>
 <e8d31e48-df6a-fde4-4c6b-c4ccf1664ded@linaro.org>
In-Reply-To: <e8d31e48-df6a-fde4-4c6b-c4ccf1664ded@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 15/06/2023 10:52, Krzysztof Kozlowski wrote:
> On 14/06/2023 22:55, Anna Schumaker wrote:
>>>>> Still null ptr (built on 420b2d4 with your patch):
>>>>
>>>> We're through the merge window and at rc1 now, so I can spend more
>>>> time scratching my head over your bug again. We've come up with a
>>>> patch (attached) that adds a bunch of printks to show us what the
>>>> kernel thinks is going on. Do you mind trying it out and letting us
>>>> know what gets printed out? You'll need to make sure
>>>> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.
>>>
>>> The patch does not apply. I tried: v6.4-rc1, v6.4-rc5, next-20230609.
>>
>> Can you try the attached patch on top of my 3-patch series from the
>> other day, and let me know what gets printed out? It adds a bunch of
>> printk()s at strategic points to print out what is going on with the
>> xdr scratch buffer since it's suddenly a bad memory address after
>> working for a bit on your machine.
>>
> 
> Here you have entire log - attached (113 kB, I hope goes past mailing
> lists/spam filters).

As expected this bounced from the mailing lists, but I hope you got it.
If not, let me know.

Best regards,
Krzysztof

