Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83C74421A3
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 21:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhKAU1u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 16:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhKAU1u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 16:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635798316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ob3sIgqP4IvXWqBbNRAUblQNgrtVFSiwlJARNm25Mjg=;
        b=IberOOyJMeiSpMjFBGg/t8pEW94zyGBr2zgbr1lD86wCSA7EPM4Pb592XGhW9ymwZl6Fst
        RqtgOUAyzWIvHrkMoZIZumIEqfw8xmOJj+tjJDlY9cAJp1kowExa+UfiwCQiCwnEPGXMrM
        7c0l69v+vOW0gU5qWLM4KfpkDG1K2LU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-KLI8lX-YOj-SIkRXRjXtsw-1; Mon, 01 Nov 2021 16:25:15 -0400
X-MC-Unique: KLI8lX-YOj-SIkRXRjXtsw-1
Received: by mail-qt1-f199.google.com with SMTP id 90-20020aed3163000000b002a6bd958077so12921119qtg.6
        for <linux-nfs@vger.kernel.org>; Mon, 01 Nov 2021 13:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ob3sIgqP4IvXWqBbNRAUblQNgrtVFSiwlJARNm25Mjg=;
        b=U0YMVJDg24N7tKGYvOFvapyUKXK8GjI3/4jyewSOPEYeHACteBxowlc0M2Nkj2WG4+
         1qFAHAQ7rlO7juvhL2+L0DcRLmf6feQuj4c+58/Xi255clJm734tBS+8RPZCEugzFhHY
         G2ssHvpGw7GHJgYhARvGRTujx0B8jjzSq3b2EhArq6GqNiTtW03H5Cv7/uDeOr5DjynS
         3FbWj9PP0abs2h4ceGzd0LDYZy3SYODPm4nFSBO3mODQ+RNM6oHR4kmSrbdI0wboVsBT
         uK3DYFOhYZ9lmj09j2kVWqVspGk/TzZdh+nmklD4bpdyXi+hxqjGdes+XZcmrmIOJDc9
         jCOQ==
X-Gm-Message-State: AOAM532bsLFotGVrGukS96PbCWRqvKdycFKJuryxlwuPKX6QGRU0QQw2
        0NXKfIFygKwTusIa1yjeDq/jRUoNHrU5pqlDRYhJd+kAIW50iMZkHK/wVFO5ViwoitjcWNpmoT+
        M+qboTHtRLEKPo3Vm/DID
X-Received: by 2002:a05:620a:258a:: with SMTP id x10mr24742116qko.263.1635798314891;
        Mon, 01 Nov 2021 13:25:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkJkxXnWseQHlyG639V1zxtJSvXGZtOaqekNR8+u/Ucwgqwb64iHYn6h2crpSGep2N2SBztA==
X-Received: by 2002:a05:620a:258a:: with SMTP id x10mr24742099qko.263.1635798314661;
        Mon, 01 Nov 2021 13:25:14 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id p15sm5517059qkp.93.2021.11.01.13.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 13:25:14 -0700 (PDT)
Message-ID: <58571dd3-a711-d720-0411-951a78bd62de@redhat.com>
Date:   Mon, 1 Nov 2021 16:25:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>, dai.ngo@oracle.com
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
 <badaecc5-2936-4ab7-53e9-fabee0b51493@redhat.com>
 <93c09b22-9439-3404-ed07-e99cbbc12052@oracle.com>
 <20211101192519.GB14427@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20211101192519.GB14427@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/1/21 15:25, J. Bruce Fields wrote:
> On Mon, Nov 01, 2021 at 12:22:15PM -0700, dai.ngo@oracle.com wrote:
>>
>> On 11/1/21 12:02 PM, Steve Dickson wrote:
>>>
>>>
>>> On 11/1/21 11:40, J. Bruce Fields wrote:
>>>> On Mon, Nov 01, 2021 at 11:30:48AM -0400, Steve Dickson wrote:
>>>>> Now that cp will use copy_file_range() when available,
>>>>> what are the steps needed to enable these fast copies?
>>>>
>>>> 1) Make sure client and both servers support NFSv4.2 and
>>>> server-to-server copy.
>>> Something is already figuring this out... The only time
>>> the client sends a COPY_NOTIFY and COPY is when both
>>> mounts are 4.2. I have not looked into but that is what
>>> the network traces are showing.
> 
> Right.  I was thinking what I'd tell an admin who wanted to set up
> server-to-server copy.  The first thing they'd need to do was check that
> their clients and servers were new enough.
Well the code went in over two years ago
ce0887ac96d35 (Olga Kornievskaia 2019-10-09 11:50:48 -0400 1663)
so most modern kernel will have the feature.

The real question is does the cp command have the
copy_file_range() support which didn't go in until
Mar of this year
* Wed Mar 24 2021 Kamil Dudka <kdudka@redhat.com> - 8.32-20
- cp: use copy_file_range if available

> 
>>>> 2) Make sure destination server can access (at least for read) any
>>>> exports on the source that you want to be able to copy from.
>>> How can one server know what the other server has exported
>>> or access to??
> 
> And the second is to make sure that the destination server is able to
> read from the source.
> 
>>>> 3) echo 1 >/sys/module/nfsd/parameters/inter_copy_offload_enable on the
>>>> destination server.
>>> Who would be doing this? Plus this would not survive over a reboot.
>>> An export would as well a /etc/modprobe.d/ file.
>>
>> You can add a line in /etc/modprobe.d/nfsd.conf:
>>
>> options nfsd inter_copy_offload_enable=Y
>>
>> to enable the option.
Yes... This is what I meant by "a /etc/modprobe.d/ file"

> 
> Yep, it would be better to document it that way, thanks.
But the question is who would create this file?
nfs-utils or the admin?

If it is nfs-utils, it is a global switch unbeknown by
the admin (but documented). If by the admin, the person
would know about but it still will not documented.

With a export option, it would be per export switch
and documented. Just saying... :-)

steved.

