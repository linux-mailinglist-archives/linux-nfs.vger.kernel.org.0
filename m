Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C05E75BBC9
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 03:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGUB0p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 21:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUB0o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 21:26:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1B51982
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 18:26:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so1151907f8f.0
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 18:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689902801; x=1690507601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOqkJZlHF0HdcmY1OvxRWo8gX4FlV/RofXNPV7GXnic=;
        b=futrHgk++EFwdNRXLbFCPWUcPGuELORyqyuTT40kGj8azkIBWl+U8Kh3ZfpxBdPZfE
         qiGNdhiJI4SE6pqilyM1ewhsBA2S64hXYsFLV4/abC65H60Nh4EEj1Eqw2WP+28wM9cb
         u88S0M4c3aZGdbpqba/e/BCO9Kicvf3Y7CSdo4mT6IwZaxVdFsB74bBSo2+nCWHKpMpX
         fbZtqg4EoHx8VWa7MAxlTeznMMzreilinUveE8kPNgJt+IartK/n/I7kK6CbevYELK96
         EQxO7oL+BO4nRAa2kveRJAF94B5Zj/QIYJRKooqhYk130/+5AefaDebSnjWTd7xHp+yR
         1XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689902801; x=1690507601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOqkJZlHF0HdcmY1OvxRWo8gX4FlV/RofXNPV7GXnic=;
        b=XIbhFe/cGGcDYfFtxbi5HxwPuhJnjgAxTxJnpYPsfGQKRSo2yXoLYfzdNXxt2kxqan
         mj5owDzhBPZbeg2/wIlDCPVx/rPM5Nzq5YyqFVebz1cp4ltgOu7vVuZINgwgO7oO/k4h
         i9yMIDXnT+erY3+z2JYeTe1axaWc7oMRS3BDxcoVfqgc6vC310ijMXbiyi1jwpoucnDZ
         3ysOJbJ2RX6wm4U2ju0+uhNV/IwQVM8nVELHDZpb3W9YmeacL4Af2U/nZKx1BTHBbJ/3
         h5c8zGyrS6NJDVuWl9GdhuOQ5wH9P2gmmSvNZai4sxeh2MNVJ5DznEA/XDHNKZRckGx2
         ZzAg==
X-Gm-Message-State: ABy/qLax1sEAYEsyeiZXRdmlJ/lvm+ixM7qsRhLWiA97aCUQbML7EVPV
        2XW1jVGcvde3DLLk8PQXWZw=
X-Google-Smtp-Source: APBJJlHIYWGeW9DWmW/TosrIt2Rgd3OomXBBGEp4CHUi/9wOsirrvdruuIp3bjvBCnxZ1nNr6hHzVQ==
X-Received: by 2002:adf:d851:0:b0:315:8f4f:81b1 with SMTP id k17-20020adfd851000000b003158f4f81b1mr281414wrl.50.1689902801227;
        Thu, 20 Jul 2023 18:26:41 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d5145000000b00314145e6d61sm2745680wrt.6.2023.07.20.18.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 18:26:40 -0700 (PDT)
Message-ID: <d1634773-e30a-2ff2-4767-e9a8e688a27e@gmail.com>
Date:   Fri, 21 Jul 2023 09:26:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfs: fix redundant readdir request after get eof
Content-Language: en-US
To:     Anna Schumaker <anna@kernel.org>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
References: <CAB6yy374gQmrAjtLmFWGDVq9GBfxFoA-L95oELo=k+W9TF7cyg@mail.gmail.com>
 <ECE48590-218F-4304-A043-B9AEB04CD3DA@redhat.com>
 <6901cae4-a257-62dd-64fa-b4f201fc1b07@gmail.com>
 <CAFX2Jf=yNj-UPrbQWnZvz_SuggAYXdNUeAmDsV=rEkBtawkxGw@mail.gmail.com>
From:   Kinglong Mee <kinglongmee@gmail.com>
In-Reply-To: <CAFX2Jf=yNj-UPrbQWnZvz_SuggAYXdNUeAmDsV=rEkBtawkxGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2023/7/21 4:56 AM, Anna Schumaker wrote:
> On Wed, Jul 19, 2023 at 9:14 PM Kinglong Mee <kinglongmee@gmail.com> wrote:
>> On 2023/7/19 9:24 PM, Benjamin Coddington wrote:
>>> On 18 Jul 2023, at 8:44, Kinglong Mee wrote:
>>>
>>>> When a directory contains 17 files (except . and ..), nfs client sends
>>>> a redundant readdir request after get eof.
>>>>
>>>> A simple reproduce,
>>>> At NFS server, create a directory with 17 files under exported directory.
>>>>  # mkdir test
>>>>  # cd test
>>>>  # for i in {0..16}  ; do touch $i; done
>>>>
>>>> At NFS client, no matter mounting through nfsv3 or nfsv4,
>>>> does ls (or ll) at the created test directory.
>>>>
>>>> A tshark output likes following (for nfsv4),
>>>>
>>>>  # tshark -i eth0 tcp port 2049 -Tfields -e ip.src -e ip.dst -e nfs -e
>>>> nfs.cookie4
>>>>
>>>> srcip   dstip   SEQUENCE, PUTFH, READDIR        0
>>>> dstip   srcip   SEQUENCE PUTFH READDIR
>>>> 909539109313539306,2108391201987888856,2305312124304486544,2566335452463141496,2978225129081509984,4263037479923412583,4304697173036510679,4666703455469210097,4759208201298769007,4776701232145978803,5338408478512081262,5949498658935544804,5971526429894832903,6294060338267709855,6528840566229532529,8600463293536422524,9223372036854775807
>>>> srcip   dstip
>>>> srcip   dstip   SEQUENCE, PUTFH, READDIR        9223372036854775807
>>>> dstip   srcip   SEQUENCE PUTFH READDIR
>>>>
>>>> The READDIR with cookie 9223372036854775807(0x7FFFFFFFFFFFFFFF) is
>>>> redundant.
>>>>
>>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>>>
>>> Weird, I never got a copy from linux-nfs.   The plain-text version of this
>>> is whitespace damaged, but the HTML version looks right.
>>>
>>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>>
>> Anna,
>>
>> Sometimes my email client cannot send email correctly,
>> so I send this path at web gmail.
> 
> Ah, I bet that's why `b4 shazam` is having trouble finding the patch
> if I go to apply it.
> 
>>
>> Are you OK for this HTML version?
>> If not, I will resend it through my email client.
> 
> What email client are you using? I've had good luck using
> Documentation/process/email-clients.rst for setting up clients to send
> and receive patches.  Have you tried using `git send-email` at all? 

I use Thunderbird client.
Thanks for your advise, I will try using `git send-email`.

> It
> would be great if you can repost a plain-text version instead of html.

A new plain-text version path have been resend.

thanks,
Kinglong Mee
