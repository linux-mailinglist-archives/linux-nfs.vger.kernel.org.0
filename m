Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369D44AF529
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 16:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiBIPXp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 10:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiBIPXo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 10:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F703C0613C9
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 07:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644420226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPOQPL3LVsCtZsnW6MwBH0oDhNAkd01tDs0N/m1ShBU=;
        b=Pj1Le5yozb+8LKDYHHnxxBiuGSyZtkpTw0UvEaaUhuI2bEEiay0h9rkNK0e5WDyzK+XpsE
        jL1R8k7JZqyKI2bWaemDlwxEnp1eackLOkzwCK11iWH3A+txbbAGJ4qVWIG6ZxGxd1GcNL
        2gA6IDRrKThmmd6GHWzTbTgR+chCVvE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-jyxT9A7oPeypHZDpiNki4A-1; Wed, 09 Feb 2022 10:23:45 -0500
X-MC-Unique: jyxT9A7oPeypHZDpiNki4A-1
Received: by mail-qt1-f198.google.com with SMTP id y1-20020ac87041000000b002c3db9c25f8so1960825qtm.5
        for <linux-nfs@vger.kernel.org>; Wed, 09 Feb 2022 07:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iPOQPL3LVsCtZsnW6MwBH0oDhNAkd01tDs0N/m1ShBU=;
        b=p5eehPIt13pkoJMypnKWdEPNG+/vTXv+zUgqtKe8FzYY4t9QBJvugKvPedeDk+iyE4
         PALael8v3REjLhM+Yv3/wcVfHTSPMCsMRH5nbpmT4RGD32gJ2c1k9fkxNB3P7Y1JFuvK
         7en30snUDUBHS3plDvFxoVPbAj1NYEpFu5Xq7ic7goM/tjafEZe4KvXkNdzn2WD/Zbhe
         M+yBsGYiNlDuTMMvDycSUpW14j9vFd6jGDipDI47gSbLQuBgelmWuTH7S70+W0JL05wJ
         1JHcp0XqhlBARiMR7c2Jy5Fm9konWN16QCJwHBQ+V086IsTwes9RFv3IxclXvxQMo371
         84lA==
X-Gm-Message-State: AOAM531VoKBecmvvTrpNQA0GDynf3C6i+4jwrlobCu63seQrES3VH9ka
        p4rU9CLePy5DcuBFC/mkCcBdsv2JQZp0aqAq0ZXELDgUv+eFPiKgQQ0DM8TBAvzai7NJuB2qZ7J
        p30vLYHZOPdoGAGHp9z/O
X-Received: by 2002:a05:6214:2a49:: with SMTP id jf9mr1847988qvb.127.1644420223925;
        Wed, 09 Feb 2022 07:23:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4Liapky7mw+QLftSPxrfmq+D3Z6Pi7hXDG8guFqVPnbhv1nLf7TKPB2hXSbn1VzboGNvOKQ==
X-Received: by 2002:a05:6214:2a49:: with SMTP id jf9mr1847978qvb.127.1644420223668;
        Wed, 09 Feb 2022 07:23:43 -0800 (PST)
Received: from [172.31.1.6] ([70.105.253.180])
        by smtp.gmail.com with ESMTPSA id v14sm9480219qtk.5.2022.02.09.07.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 07:23:43 -0800 (PST)
Message-ID: <8e374243-e4c8-3131-07e6-24bae8714d15@redhat.com>
Date:   Wed, 9 Feb 2022 10:23:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Content-Language: en-US
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
 <E013276C-7605-4E2B-A650-C61C6FC5BADF@redhat.com>
 <778c3e11-62e1-00b1-0cbc-514abe1d1eac@redhat.com>
 <E646BDFC-0422-4052-AC7A-9103696013A9@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <E646BDFC-0422-4052-AC7A-9103696013A9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/9/22 8:55 AM, Benjamin Coddington wrote:
> On 8 Feb 2022, at 17:30, Steve Dickson wrote:
> 
>> Hey!
>>
>> On 2/8/22 3:00 PM, Benjamin Coddington wrote:
>>> On 8 Feb 2022, at 14:52, Steve Dickson wrote:
>>>
>>>> On 2/8/22 11:22 AM, Benjamin Coddington wrote:
>>>>> On 8 Feb 2022, at 11:04, Steve Dickson wrote:
>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>>>>>>> The nfs4id program will either create a new UUID from a random 
>>>>>>> source or
>>>>>>> derive it from /etc/machine-id, else it returns a UUID that has 
>>>>>>> already
>>>>>>> been written to /etc/nfs4-id.  This small, lightweight tool is 
>>>>>>> suitable for
>>>>>>> execution by systemd-udev in rules to populate the nfs4 client 
>>>>>>> uniquifier.
>>>>>>>
>>>>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>>>>> ---
>>>>>>>   .gitignore               |   1 +
>>>>>>>   configure.ac             |   4 +
>>>>>>>   tools/Makefile.am        |   1 +
>>>>>>>   tools/nfs4id/Makefile.am |   8 ++
>>>>>>>   tools/nfs4id/nfs4id.c    | 184 
>>>>>>> +++++++++++++++++++++++++++++++++++++++
>>>>>>>   tools/nfs4id/nfs4id.man  |  29 ++++++
>>>>>>>   6 files changed, 227 insertions(+)
>>>>>>>   create mode 100644 tools/nfs4id/Makefile.am
>>>>>>>   create mode 100644 tools/nfs4id/nfs4id.c
>>>>>>>   create mode 100644 tools/nfs4id/nfs4id.man
>>>>>> Just a nit... naming convention... In the past
>>>>>> we never put the protocol version in the name.
>>>>>> Do a ls tools and utils directory and you
>>>>>> see what I mean....
>>>>>>
>>>>>> Would it be a problem to change the name from
>>>>>> nfs4id to nfsid?
>>>>>
>>>>> Not at all..
>>>> Good...
>>>
>>> I didn't orginally do that because I thought it might be confusing 
>>> for some
>>> folks who want `nfsid` to display their kerberos identity.  There's a BZ
>>> open for that!
>>>
>>> Do you think that's a problem?  I feel like it's a problem.
>>>
>>>>> and I think there's a lot of room for naming discussions about
>>>>> the file to store the id too:
>>>>>
>>>>> Trond sent /etc/nfs4_uuid
>>>>> Neil suggests /etc/netns/NAME/nfs.conf.d/identity.conf
>>>>> Ben sent /etc/nfs4-id (to match /etc/machine-id)
>>>> Question... is it kosher to be writing /etc which is
>>>> generally on the root filesystem?
>>>
>>> Sure, why not?
>> In general, writes to /etc are only happen when packages
>> are installed and removed... any real time writes go
>> to /var or /run (which is not persistent).
> 
> I use `passwd` and `usermod`, which write to etc.  I can think of other
> examples.  For me, /etc is fair game.
> 
> There's three of us that think /etc is a good place.  You're the maintainer
> though, tell us what's acceptable.  If we add an -f option to specify the
> file, I'd like there to be a sane default if -f is absent.
/etc is fine...

steved,

> 
>>>> By far Neil suggestion is the most intriguing... but
>>>> on the containers I'm looking at there no /etc/netns
>>>> directory.
>>>
>>> Not yet -- you can create it.
>> "you" meaning who? the nfs-utils install or network
>> namespace env? Or is it, when /etc/netns exists
>> there is a network namespace and we should use
>> that dir?
> 
> Anyone that wants to create network namespace specific configuration can
> create /etc/netns/NAME, and the iproute2 tools will bind-mount 
> configuration
> from there over /etc/ when doing `ip netns exec`.
> 
> Ben
> 

