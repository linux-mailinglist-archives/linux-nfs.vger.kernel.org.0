Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C272369BA93
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Feb 2023 16:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBRPJq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Feb 2023 10:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBRPJq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Feb 2023 10:09:46 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817B14481
        for <linux-nfs@vger.kernel.org>; Sat, 18 Feb 2023 07:09:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id t19so2822154edi.13
        for <linux-nfs@vger.kernel.org>; Sat, 18 Feb 2023 07:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgJb9gVH88PGc08H2WjK2lb5uIuxbgsWahfg6NJGgvc=;
        b=NOf7dxPFDZRhzPkx6GyGPyfikWbRviwRTkr22smpaRGvLecdj4iSZZSIA63iROUmKu
         KDMFx0ABUHjiCNq9PAEaf3ynIwc18NRBzzmfgJuqUAFwRLtQddIwzEW94TQlmjR8bTel
         Ko6twuH3hrKskeFGYt9zwMIOOTegVc6hhRj94Rewr9BJBOyjfDABZxsAtSjdQ+CLl+cB
         s00y5eiDQtESQmO8O2A2Yn+K/dIU4XHO23Br/v0RpLCrvlt0TzEiFzx3RYFj28erzzEX
         XfCukIayTfFche3Ff72u29qMT6d3unJ/UEp5laHioHdnw4GTiKXeaZ0CzmDUke3hF4vV
         rEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgJb9gVH88PGc08H2WjK2lb5uIuxbgsWahfg6NJGgvc=;
        b=eFvjCfRU2e+Mtk4FR8omgSRijCjjsYrUioFLHGaac7qHtVs61Ms1OHFctMvGjG4t6y
         +T/vL8UftOVHcr0y1ZBLR43Qjp7QSThS3nziKX/yjfSAlKM2BuenkKQYqd7cpghRump5
         U+ujdIAnYKHHFRV9gPAj6bkG9xWlKc4eZFbyA4bszPbioC2dllIxh9+19w006VoM5/l/
         Xd2tB9aTjBPIr5vqIMyZn/4ubrMbMllXeX5YTAcCH2GcT4CjqOqM8BdGO/O1IleYeeJU
         z3lZiMtKV6blJQwjcHlxgkefVeKxS7eoAUHw4Ud0hZTcBWaQllEsU2632oUY+XxJjwHa
         sk4w==
X-Gm-Message-State: AO0yUKUZ4xJBuGC9epnuwXat47DdTzUa4W7aELF9GB4v8PVUmwEFuQ0S
        qS3EDupLZENwyTYIzv9JExcR9gcVKO56Xbib
X-Google-Smtp-Source: AK7set8B7ASOT9ahO5mmjKrhEN8TOQur8B2zQbAphdp95C/MToAcBLZ2OShTFKDaR7If0BvEHlCIaw==
X-Received: by 2002:a05:6402:556:b0:4ac:b32e:b65 with SMTP id i22-20020a056402055600b004acb32e0b65mr5588099edx.3.1676732983283;
        Sat, 18 Feb 2023 07:09:43 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j17-20020a508a91000000b004a21c9facd5sm3685608edj.67.2023.02.18.07.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 07:09:42 -0800 (PST)
Message-ID: <78806040-5725-103f-fe55-8c6d9ced6e63@linaro.org>
Date:   Sat, 18 Feb 2023 16:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <65ae10cd-a086-47c6-c881-d1385d7fcf42@leemhuis.info>
 <5150343c-e13d-ed15-e59a-bc14f0db89da@leemhuis.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5150343c-e13d-ed15-e59a-bc14f0db89da@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 18/02/2023 05:42, Linux regression tracking #update (Thorsten
Leemhuis) wrote:
> [TLDR: This mail in primarily relevant for Linux regression tracking. A
> change or fix related to the regression discussed in this thread was
> posted or applied, but it did not use a Link: tag to point to the
> report, as Linus and the documentation call for. Things happen, no
> worries -- but now the regression tracking bot needs to be told manually
> about the fix. See link in footer if these mails annoy you.]
> 
> On 08.01.23 09:52, Linux kernel regression tracking (#adding) wrote:
>> On 07.01.23 16:44, Krzysztof Kozlowski wrote:
>>>
>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
>>> KConfig value for READ_PLUS") as one leading to NULL pointer exception
>>> when mounting NFS root on NFSv4 client:
>> [...]
>> Thanks for the report. To be sure the issue doesn't fall through the
>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>> tracking bot:
>>
>> #regzbot ^introduced 7fd461c47
>> #regzbot title nfs: NULL pointer dereference since NFS_V4_2_READ_PLUS is
>> enabled by default
>> #regzbot ignore-activity
> 
> #regzbot fix: 896e090eefedeb8a715ea19938a2791c32679

I see it was posted and merged as "Revert "NFSv4.2: Change the default
KConfig value for READ_PLUS"". It's nice to give credits to people who
report bugs with "Reported-by" tag.

Best regards,
Krzysztof

