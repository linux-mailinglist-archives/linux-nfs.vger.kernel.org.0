Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6831E5EC58C
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Sep 2022 16:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiI0OKp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Sep 2022 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiI0OKR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Sep 2022 10:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6794F1B2
        for <linux-nfs@vger.kernel.org>; Tue, 27 Sep 2022 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664287804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27Won3la/vriqDoHRbVs4DtIxrwQEFQF+S0WVWs1yJY=;
        b=WliBiIwIq/nEQCDPCbBr9Ye2tHQt6fE75kLuU9jJs7s8j8RIZE1HIxhDkXWspwNV6vs1E/
        yRX33CFv/4DxEDoIGBH8r8w1O4FVFJQYogYRfYe0AWzV4v3np7ZixYVqHDmdXQKGHEXZCn
        VCSX4dcO3TXfNl1ULF07Gn414W8KusY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-oPAD3WsYPaa9JPKQm-cQ0g-1; Tue, 27 Sep 2022 10:09:39 -0400
X-MC-Unique: oPAD3WsYPaa9JPKQm-cQ0g-1
Received: by mail-wm1-f69.google.com with SMTP id p24-20020a05600c1d9800b003b4b226903dso8665376wms.4
        for <linux-nfs@vger.kernel.org>; Tue, 27 Sep 2022 07:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=27Won3la/vriqDoHRbVs4DtIxrwQEFQF+S0WVWs1yJY=;
        b=hBeMup6ow/jE15GoRFSbnpIyQiFuYWh5oyi4IKT39v1gC6ZIcToidkg766U9edvgTQ
         s2t1B2yFbFxhf7H6XvSQrJJdGPksaEZVdno/h/+S8IfNDeT6Z9gQLcpywEJfZTcJoDOG
         3e17SmSKMQAviA0qeCxVSK6m07q4Nzn3rUoGNzUKHuqnjwnr7wzSoCrpe3T3/MOR3gJ4
         Ro0YUnGr3lzsGMF7AUzhF2JndJTuaYnpZNmyeLmAKceij3FSWvfcmFesa4HP1jaN/1IO
         8JlfC9oVdN1z7XUNkNwcSTqogogqMmGtFADP/2frB2Cg5VSDomo2QHztD5TZA1UI1KuD
         j38w==
X-Gm-Message-State: ACrzQf3MKSw1rYY4yKzZhSu3gs3biEovkJ3VVwYGbXKk6nW8NY73Dp+Q
        aDA8azAspkutUy3r6s+SDjad9KO9BcV33No+P2GATqucvKM18UcqZRkQGK3OrNDetTBGrYGKD1F
        wby1RU00eiqlmc4cEUNp6
X-Received: by 2002:adf:fcce:0:b0:22c:c3e8:41db with SMTP id f14-20020adffcce000000b0022cc3e841dbmr730120wrs.353.1664287770295;
        Tue, 27 Sep 2022 07:09:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4K/9g3yv/s9ycMvvK/0i3438Rmyct4IvYvmWQldKQj5eCAHaBHT+6j86kAGGdJtmIIjFsByg==
X-Received: by 2002:adf:fcce:0:b0:22c:c3e8:41db with SMTP id f14-20020adffcce000000b0022cc3e841dbmr730088wrs.353.1664287769940;
        Tue, 27 Sep 2022 07:09:29 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b003a541d893desm1966619wmb.38.2022.09.27.07.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:09:29 -0700 (PDT)
Message-ID: <d1e17fe0-947b-ccd1-44d2-bfa251f379f3@redhat.com>
Date:   Tue, 27 Sep 2022 10:09:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] Fix more function prototypes
Content-Language: en-US
To:     Sam James <sam@gentoo.org>, linux-nfs@vger.kernel.org
References: <20220916214300.2820117-1-sam@gentoo.org>
 <5C0273D4-1BC4-4B1A-BB6E-D16BA30113C3@gentoo.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <5C0273D4-1BC4-4B1A-BB6E-D16BA30113C3@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/25/22 12:10 AM, Sam James wrote:
> 
> 
>> On 16 Sep 2022, at 22:43, Sam James <sam@gentoo.org> wrote:
>>
>> ```
>> regex.c:545:43: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>> struct trans_func *libnfsidmap_plugin_init()
>>                                           ^
>>                                            void
>> 1 error generated.
>> ```
>>
>> See: 167f2336b06e1bcbf26f45f2ddc4a535fed4d393
>> Signed-off-by: Sam James <sam@gentoo.org>
>> ---
>> support/nfsidmap/regex.c | 2 +-
>> utils/idmapd/idmapd.c    | 2 +-
>> 2 files changed, 2 insertions(+), 2 deletions(-)
> 
> ping
Thanks! Committed!

steved.

