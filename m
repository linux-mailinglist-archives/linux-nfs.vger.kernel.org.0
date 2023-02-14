Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41566961AF
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjBNLCe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 06:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjBNLCd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 06:02:33 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C3B2595B
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 03:02:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m10so6285361wrn.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 03:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GyYmuT9oCq5RlZcWRx289g/0VqIzW0PBoPe9h0OuCA=;
        b=SchNoKYx0XwBApl3tzOte3aPZhi1WPtLMnON4zzV7ZKQMioDhX3oxBD9f8dBQuR6cL
         tZSMDg9FHlq8dH/Z3IEsXHzJNAKiwBuQh/XgkIelk/44CbbM7TaeXaDsd0iXbymAtKLL
         tG6ZDfhPXrj3DTFWP21q0enf1jVIB8Cw9pFq0QTBlXqsUkf9bz3sc+LHLnN2+eW//oiJ
         BlrwcpRDqb4E6+35sF6PRqm4kUk9aW5hpfxcpxarbRq4XfFiXdUgg5uIggFnfHYgsHGh
         KboSoZB+Av+ZGPC0aAayWJdNINZ6wTkuoGHuJV9d1hT+Vb5jqEw3PF7zJ5vUvl7ulT+w
         XbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GyYmuT9oCq5RlZcWRx289g/0VqIzW0PBoPe9h0OuCA=;
        b=B0Fy5R+K20lIEwKHBywDVIv3t8fdUQeqcUYg0B+XFeb5nY3Jv+VTN3sBjfJzsSXorQ
         gP1QQFBtBWypNeRQc1UAM4SR7wA8V0EFIWPXcrTwcw9cwiJ3IYtQKm2L+9ADvMeeUjfh
         nacBYBcsalBx8L9hMfj8EBVZ2g26TSz7aYQgzSSxliup4+YhYQAay5KCf0iKLZmGVW6J
         EXgbYdj7k4nDzgRd/5qtT6hcnYrXzK3yiw76C3VsUACIei5P0+kWNIFQ/7gYnv0PTG/4
         vRThPswsAXJCuF6QgKnAJdqQRypnZEbPU9c2eLJZMCZRAb+6tQxcR/0JaqcHu0Tr6512
         mKEA==
X-Gm-Message-State: AO0yUKVQ5VDBtiyxP5l8EH2WIDCGggxtS/k0tnRQf7JRUeZe+zqSXE8m
        Re5G1CokWf9RD4oZ5sYO2Q+RBw==
X-Google-Smtp-Source: AK7set8Nj6+EvVha7NBFQkFwfOy3wGH1H6dJfRCkNb9nZLdZPdv5yzmTgtDpLDSY1pfqYRDJuxTbiQ==
X-Received: by 2002:adf:e984:0:b0:2c5:584b:4f65 with SMTP id h4-20020adfe984000000b002c5584b4f65mr1912228wrm.32.1676372538984;
        Tue, 14 Feb 2023 03:02:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b16-20020adfe650000000b002c5534db60bsm6501810wrn.71.2023.02.14.03.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:02:18 -0800 (PST)
Message-ID: <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org>
Date:   Tue, 14 Feb 2023 12:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12/02/2023 15:05, Anna Schumaker wrote:
>>> From ac2d6c501dbcdb306480edaee625b5496f1fb4f5 Mon Sep 17 00:00:00 2001
>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>> Date: Fri, 10 Feb 2023 15:50:22 -0500
>>> Subject: [PATCH] NFSv4.2: Rework scratch handling for READ_PLUS
>>>
>>
>> Patch is corrupted - maybe mail program reformatted it when sending:
>>
>> Applying: NFSv4.2: Rework scratch handling for READ_PLUS
>> error: corrupt patch at line 12
>> Patch failed at 0001 NFSv4.2: Rework scratch handling for READ_PLUS
> 
> That's weird. I wasn't expecting gmail to reformat the patch but I
> guess it did. I've added it as an attachment so that shouldn't happen
> again.

Still null ptr (built on 420b2d4 with your patch):

[  144.690844] mmiocpy from xdr_inline_decode (net/sunrpc/xdr.c:1419 net/sunrpc/xdr.c:1454) 
[  144.695950] xdr_inline_decode from nfs4_xdr_dec_read_plus (fs/nfs/nfs42xdr.c:1063 fs/nfs/nfs42xdr.c:1147 fs/nfs/nfs42xdr.c:1360 fs/nfs/nfs42xdr.c:1341) 
[  144.702452] nfs4_xdr_dec_read_plus from call_decode (net/sunrpc/clnt.c:2595) 
[  144.708429] call_decode from __rpc_execute (include/asm-generic/bitops/generic-non-atomic.h:128 net/sunrpc/sched.c:954) 
[  144.713538] __rpc_execute from rpc_async_schedule (include/linux/sched/mm.h:336 net/sunrpc/sched.c:1035) 
[  144.719170] rpc_async_schedule from process_one_work (include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/workqueue.h:108 kernel/workqueue.c:2294) 
[  144.725238] process_one_work from worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[  144.730782] worker_thread from kthread (kernel/kthread.c:378) 
[  144.735547] kthread from ret_from_fork (arch/arm/kernel/entry-common.S:149)



Best regards,
Krzysztof

