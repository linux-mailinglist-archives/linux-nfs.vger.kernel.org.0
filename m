Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAEB72D016
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjFLUEs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 16:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjFLUEh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 16:04:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6CA10FC
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 13:04:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-97881a996a0so844470766b.0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686600274; x=1689192274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euaVp0YqDcucWkUVSOBsl3OVy6SOn1DPaJZY5WOv6GU=;
        b=EUa3xPPj+JFq+Nx6WfSxe34cX09aywKeTJai1I4P/Ttko2lnRqN33SaEbbSnZMRbjK
         KaLn2mh8IvK4YmYqmuK1Dpse8Ho5oAmDOD5jewjzE0yGWvxqm0FqGcpWXVuL7XMlu5Xo
         ca/EopEjTQA+38kT+s7/TPVQsVrEKyg0CspWpjn5w332BBC61H+LYXr8JQudRjwK0HoS
         mLCA3IQdS3Re8MFVsQ3WoMAoOjp9UKGTUMPTcilDlW9rD+PQ2lnuNDZwSXubSY1T13Y1
         JJ7LlqQgC73nCqdKSiaO3I9gaUJvamDy8OknJhOc0UmMsJLbEyRze91wum1cTxOy+wmg
         +hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686600274; x=1689192274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euaVp0YqDcucWkUVSOBsl3OVy6SOn1DPaJZY5WOv6GU=;
        b=SRSyfSpOI04MgDKT1NmfbrM8ZGHlr5pEreubr9YyP95xyyII/vCTrvVR28+LoH4xia
         OY5gBtQEWRbDCnt8lPyU7aDDKaE6+nOypQwgJwOF7v1/YJ74rSwVo891BEtGrWt2r7Tc
         352By/x7FH1TN2UdZPm0fbM+nhxNb1ihfUbMJfE9zEsc2EUd4Ozlx2orP0+ugBLpnwDZ
         OQDaNU3JEzlGZCLDYCf9j2M+g0WjuTX1I0+FbEz3EfS7wygJ7kfkc79EoLvkXnEQWPXm
         AluIR/AJmzT1Fof2yE2ByXMrB3m37YlogsDez1wfAekGUtPvMtJI9ED2jzEvFrRb+//B
         y1Bw==
X-Gm-Message-State: AC+VfDxQNZDyqvbnsqPv15/hQj6vSvY7kLy3Yq1MnB16ZsV2qxI1jZu9
        NMnQ95eW1dqV5w+padQtyYmfCU64Ell/VUDYCQc=
X-Google-Smtp-Source: ACHHUZ54Xn9620ofk0Kc89t0JQEazQzFiSC3HBsY91ZoMN+1XZgi0c7ShFFy6yHYV//yx/TjEo6qqw==
X-Received: by 2002:a17:907:748:b0:974:5ce6:f9f6 with SMTP id xc8-20020a170907074800b009745ce6f9f6mr11080277ejb.10.1686600274390;
        Mon, 12 Jun 2023 13:04:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m25-20020a1709062b9900b0096637a19dccsm5557721ejg.210.2023.06.12.13.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 13:04:33 -0700 (PDT)
Message-ID: <df8e11df-79b6-28a7-05d4-818dbcd5326b@linaro.org>
Date:   Mon, 12 Jun 2023 22:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 3/3] NFSv4.2: Rework scratch handling for READ_PLUS
 (again)
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
References: <20230609200013.849882-1-anna@kernel.org>
 <20230609200013.849882-3-anna@kernel.org>
 <c6e8ecea-d85c-dc12-34c0-6070f104d61b@linaro.org>
 <CAFX2Jf=dnTL2_Sv4-uw1uJm0_JCjOCOS2vbQ4kJjU9-3fYcXZg@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFX2Jf=dnTL2_Sv4-uw1uJm0_JCjOCOS2vbQ4kJjU9-3fYcXZg@mail.gmail.com>
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

On 12/06/2023 21:57, Anna Schumaker wrote:

>>> I fix this by moving scratch handling into the pageio read code. I
>>> provide a function to allocate scratch space for decoding read replies,
>>> and free the scratch buffer when the nfs_pgio_header is freed.
>>>
>>> Krzysztof Kozlowski hit a bug a while ago with similar symptoms,
>>> and I'm hopeful that this patch fixes his issue.
>>
>> Unfortunately it does not help. Same NULL ptr, next-20230609 with this
>> patchset:
> 
> That's unfortunate. I was really hoping between patch #2 and #3 that
> it would finally address the issue. I think you said your client is
> ARM v7, that's 32-bit right? I'll try to do some 32-bit testing to see

Yes, it's 32-bit ARM.

> if that uncovers anything on my end. In the meantime, I'll try to
> update the debugging printk() patch based on what I learned while
> working patch #3 last week. I'll try to get that to you in the next
> day or two.
> 



Best regards,
Krzysztof

