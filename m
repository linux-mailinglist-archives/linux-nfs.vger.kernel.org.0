Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4DF4AE390
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387341AbiBHWXC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386252AbiBHTwz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 14:52:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3883C0613CB
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 11:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644349972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIjgk7muE8MdUq9Jlp1TQVS8rSX7nOW/kNd8jhbDRoM=;
        b=VmG6RP4hCTl9wrDd7SjdrIwUaSkmzRRWfqP7/NWF8TkeDSjhtjdmUk1f3SNFkA2vpYGsOq
        uugKMiJlULqnO96WDOF6wvReZ29mSG3hT9/99lywAZI4i7YjL2kvkxItvgxAJvEzuhW6RB
        u2PeyKhh0GZ2PC5NURUGw/GTzdhYZAE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-9XmsgpcGOTCRfS6da9gc0g-1; Tue, 08 Feb 2022 14:52:49 -0500
X-MC-Unique: 9XmsgpcGOTCRfS6da9gc0g-1
Received: by mail-qk1-f198.google.com with SMTP id u12-20020a05620a0c4c00b00475a9324977so11735116qki.13
        for <linux-nfs@vger.kernel.org>; Tue, 08 Feb 2022 11:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YIjgk7muE8MdUq9Jlp1TQVS8rSX7nOW/kNd8jhbDRoM=;
        b=N82fcGPutfHKcJzK77H/5s53MkCyd6w4ri1M79bUwGa9l/P25/GD8vN3D3YavaBrgY
         gt82c8Y5i9Kb986Qb/i3rg+tdJlDmPtEXT0uX3ssZRDS2l0ZYoqUE2T5LW+CmddG4O6O
         PDqPSr/seIYbnwDILZuarQXfKXfYtY4hRyS/xmY/0AkSZv2ICFayykhO17rsOk2gBVVC
         RZdY0C/oRVH1dVE/fThcIlX3yr8Q46o/Z89pAVCScd34IPgGgNTf8uQmXEqPCeovmFZ7
         EAK3RVimzixUeWt+vCJaRO9LyuPL8MqpCs+opLN0rclMQ6xers9z5yU9SONAxvuSmzDo
         EW5A==
X-Gm-Message-State: AOAM532w0mK35jAJ5XbhkyiTIFddFC9VJrRrIzFMeeJ86TvteSJSBg2B
        xsyBl7vud7uMf1/iK6p21YG+3UoaYWNw+60vwUuCZ98MqJPUx9PuMASfPyHRnwp0ME3dH1Tmy10
        WN1qoNLZxRB3Nk8/0aBB2
X-Received: by 2002:ac8:5f48:: with SMTP id y8mr4047999qta.284.1644349968567;
        Tue, 08 Feb 2022 11:52:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcU5aXQkEHTXHRBcNBgopBWVFl/Yvmh7TV0fgvyDc/one6g3KDAEJ5kf9vSsIdpxYV5GeFRQ==
X-Received: by 2002:ac8:5f48:: with SMTP id y8mr4047990qta.284.1644349968296;
        Tue, 08 Feb 2022 11:52:48 -0800 (PST)
Received: from [172.31.1.6] ([70.105.253.180])
        by smtp.gmail.com with ESMTPSA id v19sm7740321qkp.131.2022.02.08.11.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 11:52:48 -0800 (PST)
Message-ID: <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
Date:   Tue, 8 Feb 2022 14:52:47 -0500
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
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>
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



On 2/8/22 11:22 AM, Benjamin Coddington wrote:
> On 8 Feb 2022, at 11:04, Steve Dickson wrote:
> 
>> Hello,
>>
>> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>>> The nfs4id program will either create a new UUID from a random source or
>>> derive it from /etc/machine-id, else it returns a UUID that has already
>>> been written to /etc/nfs4-id.  This small, lightweight tool is 
>>> suitable for
>>> execution by systemd-udev in rules to populate the nfs4 client 
>>> uniquifier.
>>>
>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>> ---
>>>   .gitignore               |   1 +
>>>   configure.ac             |   4 +
>>>   tools/Makefile.am        |   1 +
>>>   tools/nfs4id/Makefile.am |   8 ++
>>>   tools/nfs4id/nfs4id.c    | 184 +++++++++++++++++++++++++++++++++++++++
>>>   tools/nfs4id/nfs4id.man  |  29 ++++++
>>>   6 files changed, 227 insertions(+)
>>>   create mode 100644 tools/nfs4id/Makefile.am
>>>   create mode 100644 tools/nfs4id/nfs4id.c
>>>   create mode 100644 tools/nfs4id/nfs4id.man
>> Just a nit... naming convention... In the past
>> we never put the protocol version in the name.
>> Do a ls tools and utils directory and you
>> see what I mean....
>>
>> Would it be a problem to change the name from
>> nfs4id to nfsid?
> 
> Not at all.. 
Good...

> and I think there's a lot of room for naming discussions about
> the file to store the id too:
> 
> Trond sent /etc/nfs4_uuid
> Neil suggests /etc/netns/NAME/nfs.conf.d/identity.conf
> Ben sent /etc/nfs4-id (to match /etc/machine-id)
Question... is it kosher to be writing /etc which is
generally on the root filesystem?

By far Neil suggestion is the most intriguing... but
on the containers I'm looking at there no /etc/netns
directory.

I had to install the iproute package to do the
"ip netns identify" which returns NULL...
also adds yet another dependency on nfs-utils.

So if "ip netns identify" does return NULL what directory
path should be used?

I'm all for making things container friendly but I'm
also a fan of keeping things simple... So
how about /etc/nfs.conf.d/identity.conf or
/etc/nfs.conf.d/nfsid.conf?

> 
> Maybe the tool wants an option to specify the file?
This is probably not a bad idea... It is a common practice

steved.

> 
> Ben
> 

