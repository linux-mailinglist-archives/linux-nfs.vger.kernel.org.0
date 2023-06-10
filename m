Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BD372AAD4
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jun 2023 12:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjFJKPc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Jun 2023 06:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJKPb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Jun 2023 06:15:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E01358E
        for <linux-nfs@vger.kernel.org>; Sat, 10 Jun 2023 03:15:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5162d2373cdso4599609a12.3
        for <linux-nfs@vger.kernel.org>; Sat, 10 Jun 2023 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686392129; x=1688984129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocEa74Vi89cO2z8zXldBEe8uWhsWcgE3EnruaUyyG6A=;
        b=iSskDd85C+HHzGDa4RdZtW28HtNbYcY25JR/exMSVHFY8SBHJU5j5WgJDz02bLK/u/
         /IdE5incZ3qS8hAKZFNeYNzykmJPPDQkzXts3wJBOt9GfXnljNUsLb2GQhnvk9CHT9ZQ
         LzpTro3TjXqfg0Kx+cGH4VlFelA1xCXbS5Y/IQRSoyrgl9lpXTFDXxkAINmNt+OTy8mA
         6UGYqOyIhk8b8XiTQl7DcaOIxg1LOrOEUC5CGJ6iSzdMDtKYVXCmaJ1r/LUbr8WMsP5M
         n4EdFN4QwTASmn3grJdr8N8d285mZmJ7NA62Yy228+VIWYyVlq9emYztq/4aYu4t5iu8
         4nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686392129; x=1688984129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocEa74Vi89cO2z8zXldBEe8uWhsWcgE3EnruaUyyG6A=;
        b=hAFMj80FPo7unzU/V1SUz3QeFYHTPAeraOWhE4sHURL6/anayZdDbDGNbs9EivI/Uo
         q4/2Z5rUpT4KvtjJUdsipSteGS7/gAWkh6qlzirmZkEpnaXYctazeG3rE+TYXuANXNOL
         VxdqydoGnGzd30aoh9FcrWoMC5BvPjf4V2W0wCNt8cVdCwBsKvdq1682ogW+YkXn7aQ9
         DvPKdm9RrkSVBsQBnnH3Y4XA/VwpLrCEl8BFWJPwbTMgZMGJq4WmW+47uYU1ppBqi/MZ
         zrw7tLgwJIVGQK7czgDQU72Nufe6bS/NxOEoStSKGjztVQDLuDr075VvcVTr7bNL1fyE
         3izg==
X-Gm-Message-State: AC+VfDwU3ngxp8QwJdtQ4fdaDcaFljag/TnxDErrxAsoR+k2NoyM2C5F
        5pPCHfx/rfOWTL8TwwpXdWItZQ==
X-Google-Smtp-Source: ACHHUZ66HNdTn1UvKSjw6g9AWCTfaohbUacL1urDb1l3SqjgCzYuLKbLr2rnfvNY7TZayL953coajw==
X-Received: by 2002:a05:6402:455:b0:510:ddad:fae6 with SMTP id p21-20020a056402045500b00510ddadfae6mr1066249edw.3.1686392128860;
        Sat, 10 Jun 2023 03:15:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g16-20020aa7d1d0000000b0050bc4600d38sm2711556edp.79.2023.06.10.03.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 03:15:28 -0700 (PDT)
Message-ID: <86d8e252-975f-5d48-4567-0911d5ef9a44@linaro.org>
Date:   Sat, 10 Jun 2023 12:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Content-Language: en-US
To:     Anna Schumaker <schumaker.anna@gmail.com>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 06/03/2023 18:09, Anna Schumaker wrote:
> Hi Krzysztof,
> 
> On Tue, Feb 14, 2023 at 6:02 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 12/02/2023 15:05, Anna Schumaker wrote:
>>>>> From ac2d6c501dbcdb306480edaee625b5496f1fb4f5 Mon Sep 17 00:00:00 2001
>>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>> Date: Fri, 10 Feb 2023 15:50:22 -0500
>>>>> Subject: [PATCH] NFSv4.2: Rework scratch handling for READ_PLUS
>>>>>
>>>>
>>>> Patch is corrupted - maybe mail program reformatted it when sending:
>>>>
>>>> Applying: NFSv4.2: Rework scratch handling for READ_PLUS
>>>> error: corrupt patch at line 12
>>>> Patch failed at 0001 NFSv4.2: Rework scratch handling for READ_PLUS
>>>
>>> That's weird. I wasn't expecting gmail to reformat the patch but I
>>> guess it did. I've added it as an attachment so that shouldn't happen
>>> again.
>>
>> Still null ptr (built on 420b2d4 with your patch):
> 
> We're through the merge window and at rc1 now, so I can spend more
> time scratching my head over your bug again. We've come up with a
> patch (attached) that adds a bunch of printks to show us what the
> kernel thinks is going on. Do you mind trying it out and letting us
> know what gets printed out? You'll need to make sure
> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.

The patch does not apply. I tried: v6.4-rc1, v6.4-rc5, next-20230609.

Best regards,
Krzysztof

