Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBDA5B774D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiIMRHV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiIMRG5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 13:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6714BC6503
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663084531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NAzxLDmW25IVMaKIyeJpUzNFmOyXmAgQ2sUcz2pq0k=;
        b=guQWZbKarTpYiDqTAeh3Do+jY76CkM2WQ2Ylx5EyhXhr+6CBK923L4SqWfRZfeOFR1CO2m
        Oxrsp/hc+QaYXV1emHIIeHDaSAmY/iTWOTco91Wi0Mfa80mkt0jh9qEIkNrAYbld+c8CG5
        mX9yIE3aebMy2c1yo4iVh1f62bEJGLY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-_NfmTmqXNgOc_lRyPTcxOA-1; Tue, 13 Sep 2022 11:55:30 -0400
X-MC-Unique: _NfmTmqXNgOc_lRyPTcxOA-1
Received: by mail-qk1-f199.google.com with SMTP id bq19-20020a05620a469300b006c097741d3dso10430608qkb.2
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 08:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6NAzxLDmW25IVMaKIyeJpUzNFmOyXmAgQ2sUcz2pq0k=;
        b=aUDjdKYP/ULJKXJIS38d9ItwIja6z+HocSTuzyAdGE3w0GariDLNMNo4mtGF1nylrN
         KlDkHnHfdPoCqUqepbTDz/7P82FZ6jY3RF5myO6Uxt0AByhGGZ952kpleKw+ihG60WXO
         ywV3wvNy6p42F4QSj9DQaMEZchcuXmRMG9xLA4hM+0PmcM715vT5RfOK24YluhXiVG+u
         o1ASW5peTr+BfxrMKWoY6FxWu3+0CLJ9hQlR/MSE8o9wI2nPt13mtzIQUR7n4Pr20ws/
         i0wW6Gl0A1GYlx+09P68+MGFTw0itpqk23yyt/JZSTYau+qtQuS2wUQX3e5LeywDwPwd
         xCxQ==
X-Gm-Message-State: ACgBeo2v/O9QnyEXdXM9ezhNJ1MZiPrqYzNd3JeRgSF/dEOek029Idm3
        Tf062UBo0l9uMGCWipJWqtjG1fQZAD425hsnQ6J7HOZyUSlREKca1at3PkUpcoXM3PdgMrowhbi
        I7bp9rmJ3jeNKFC8CYZCa
X-Received: by 2002:a05:622a:391:b0:344:9749:822d with SMTP id j17-20020a05622a039100b003449749822dmr29203638qtx.268.1663084529960;
        Tue, 13 Sep 2022 08:55:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7HzeU/n6o40bv0gB+BFgfYRlqS8a+fIIr8xgzgxGkuMn+wdk/on3wFpXjfm4MPk0NKcVzwew==
X-Received: by 2002:a05:622a:391:b0:344:9749:822d with SMTP id j17-20020a05622a039100b003449749822dmr29203613qtx.268.1663084529642;
        Tue, 13 Sep 2022 08:55:29 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bl4-20020a05620a1a8400b006ce30a5f892sm5692263qkb.102.2022.09.13.08.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 08:55:29 -0700 (PDT)
Message-ID: <42980d60-3b6d-4479-8c1a-a5fd7ba30f4c@redhat.com>
Date:   Tue, 13 Sep 2022 11:55:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] nfsrahead: fix linking while static linking
Content-Language: en-US
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org
References: <YvVkftYtIgFhYHKk@pevik>
 <881E6E82-812C-4BD8-849C-4DEE484AE4F0@benettiengineering.com>
 <12ece17b-b2d9-6621-0af7-26a12470bc99@redhat.com>
 <21969dec-4bbe-94ae-b317-1bc12300d6ca@benettiengineering.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <21969dec-4bbe-94ae-b317-1bc12300d6ca@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/22/22 4:33 PM, Giulio Benetti wrote:
> Hi Steve, Petr,
> 
> On 22/08/22 21:17, Steve Dickson wrote:
>>
>>
>> On 8/11/22 4:36 PM, Giulio Benetti wrote:
>>> Hi Petr,
>>>
>>>> Il giorno 11 ago 2022, alle ore 22:20, Petr Vorel <pvorel@suse.cz> 
>>>> ha scritto:
>>>>
>>>> ﻿Hi,
>>>>
>>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>>>
>>>> nit (not worth of reposting): I'm not a native speaker, but IMHO 
>>>> subject should
>>>> be without while, e.g. "fix order on static linking"
>>>
>>> Totally, it sounds awful as it is now.
>>> I ask maintainers if it’s possible to reword like Petr
>>> pointed.
>> Will do!
> 
> Thank you!
> 
> I will try to improve the pkg-config autotools because as it is now it 
> works but it’s not a good solution.
> 
> I should use what it’s been suggested to me here:
> https://lists.buildroot.org/pipermail/buildroot/2022-August/648926.html
> And I’ve given another solution:
> https://lists.buildroot.org/pipermail/buildroot/2022-August/648933.html
> but it’s still not ok:
> https://lists.buildroot.org/pipermail/buildroot/2022-August/649058.html
I don't have access to those list...

> 
> So for the moment it’s a decent solution indeed it’s been committed to 
> Buildroot
> but I’ll try to improve it once I’ll have time.
Sounds like a plan...

steved.

> 
> Kind regards
> —
> Giulio Benetti
> CEO/CTO@Benetti Engineering sas
> 
>> steved.
>>>
>>> Thank you all.
>>>
>>> Best regards
>>> Giulio
>>>
>>>>
>>>> Kind regards,
>>>> Petr
>>>
>>
> 

