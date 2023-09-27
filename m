Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A065C7AFEDF
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjI0Ipk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjI0Ipk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 04:45:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C34EB
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 01:45:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9adb9fa7200so2349596266b.0
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695804336; x=1696409136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ft39eXrTN09xRSWXAlhFJWPCRsocPXYDKxU+rW0BfIA=;
        b=WLLk1tH7Fv+LB0BJZy7Z7Pu3cXCkBErPVCnFBh8WQu84x1LGUzO8yyYnzxdVBD6hSE
         uu+0ohcg5nM/bGeT1Qxq+21TvGeOv43x5aLBXuGgjT8rDZjPg/SImI4DDt9WCpBiqW8o
         SHdIFJErxzPWQPjO6s28JqZIa43sdGDaui1kiNbOGKcS3GZzPT3Q+cUwt2aDtUdmR3op
         o9HDU0Csk5npfQI7fMAdlR6ZSoY3Sfdel3Qvj6nFWOO+qJlAjdg4zIDeO/wWAx9pimnh
         Fo24AxxKupALB6AfO5jHcCJW4TARIjf+vteVVHgeI0PLm3mzohiLhKGyHpWBS+hCXnwj
         16+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804336; x=1696409136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft39eXrTN09xRSWXAlhFJWPCRsocPXYDKxU+rW0BfIA=;
        b=Kc7ym9UdzxUvvTmjL/4qjGcaKw2QE/MA9szMd2Ihud1ian008/eBza8l0s2EEWbuAd
         13GIju2TYM0vz/eLXIOSuk2oWO03M2p40zyse7xir84tUnzRcnsBr+on1rcdhqZyMILC
         cNcUVAQutDWraAu+f3h+k7SHvSokLly6SQCnz3DPQEspo0xrRjewJq2lEB3A7IFukVj5
         HDMLqImshCVaro2YqgmtM4EmlfhcTbADs7Ow7kW/1o+JqnFob+4m03mZ0jxl5bLBkh3/
         ioOfUCw0yG3tBrvXIiSvXOpzseHVL/JmAUHNzH8Q11opkeh7PKAAufFQ4bJYpgoluqWl
         3ayA==
X-Gm-Message-State: AOJu0YwHSvZyLlMY86jAyZMVoj3a0soXYazBqGwHYY6rDexTtie5fT5y
        QiPzWCb6n73St4yx4o6jd5PKWEcUPj4=
X-Google-Smtp-Source: AGHT+IFJ/X9EUYN41YTnChrvv/saAsl5fNbh1QhuCJirTUrMJzK32lporN/7Fub2V0Np8pGNqzH+hQ==
X-Received: by 2002:a17:906:99c7:b0:9b2:a783:3d0 with SMTP id s7-20020a17090699c700b009b2a78303d0mr4704956ejn.37.1695804336267;
        Wed, 27 Sep 2023 01:45:36 -0700 (PDT)
Received: from ?IPV6:2001:778:e27f:a23:36c4:e19f:3c1:8a8? ([2001:778:e27f:a23:36c4:e19f:3c1:8a8])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906168c00b009737b8d47b6sm8874412ejd.203.2023.09.27.01.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:45:34 -0700 (PDT)
Message-ID: <5048a7a0-d2fe-41f3-be3b-4eead930c414@gmail.com>
Date:   Wed, 27 Sep 2023 11:45:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
Content-Language: en-US, lt-LT
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
 <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com>
 <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
 <9691788F-2B62-4EB5-8879-CEDABD1B9D4B@oracle.com>
 <78c81a97-4324-c2df-27c0-917436ddee07@gmail.com>
 <6908E735-6912-4AEC-8AD7-995F2F8A144A@oracle.com>
 <CA1D7203-72FB-4681-AD60-F1D80A57C154@oracle.com>
 <8cb19861-7fd2-4d12-bd76-78bbb8fcee7c@gmail.com>
 <2660F09A-5823-4581-8977-4F41153724D6@oracle.com>
From:   =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
In-Reply-To: <2660F09A-5823-4581-8977-4F41153724D6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 26/09/2023 16.57, Chuck Lever III wrote:
> I'm wondering if I can get you to bisect the server kernel using
> your v5.10 client to test? good = v6.4, bad = v6.5 should do it.
>> Yeah, I will try to bisect but it'll probably take a day or two.

I'm *nearly* done with bisect (most of the builds with distro config 
took over an hour on this aging Xeon), and I'm currently in the middle of:

518f375 [refs/bisect/bad] nfsd: don't provide pre/post-op attrs if 
fh_getattr fails
df56b38 NFSD: Remove nfsd_readv()
703d752 [HEAD] NFSD: Hoist rq_vec preparation into nfsd_read() [step two]
507df40 NFSD: Hoist rq_vec preparation into nfsd_read()
ed4a567 [refs/bisect/good-XX] NFSD: Update rq_next_page between COMPOUND 
operations


