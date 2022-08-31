Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CAF5A878D
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 22:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiHaUcQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiHaUcP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 16:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C3DF0B0
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 13:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661977934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDvnL7iwjHbaaK8cBedl2pypt0raOsAfKjcUtL7shH4=;
        b=SR3CcCEY6PK2EiGY2FrQkFI8sXsd29sHSNKTY6BN0f+L1B9f12r3glr2levIE2xF9t95yR
        W45fBC0U2DEPaIHpUrCw3A+71eLbrsMB5k8tN/WuPW4w7tZ3s1SZIeRatTJYbca54DwSyy
        j5iLBiWwlocU0hfGxfkgBgi24lcqo8E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-Xeoa5Eg5NBmK8TbDiVQO4w-1; Wed, 31 Aug 2022 16:32:13 -0400
X-MC-Unique: Xeoa5Eg5NBmK8TbDiVQO4w-1
Received: by mail-qk1-f199.google.com with SMTP id g6-20020a05620a40c600b006bbdeb0b1f2so12788018qko.22
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 13:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wDvnL7iwjHbaaK8cBedl2pypt0raOsAfKjcUtL7shH4=;
        b=OENBQvLZ3qO41NUERfnTGW5LsFgcXbexQuS2occNP1JPXBiEOHdu9/i5C0ynISpYBR
         h87JKcMhBp3XPxmwVBvIvziv6tWt7yx6vrZJXU0Hbi9J+0CUTOwrk4KoS4fn/+cWiEVx
         LmTnz1fLdGacxfrI6c8PeMwwy8H6AEtFN9vmmnk5rEPwBmaMjXnYqICV8k8hWgP/+e7D
         XPSXagJO9CM+5BerSG47J0r8pjSuom7RePVtTd1yufZjwQnXmdjqmaBJiod0tDIvQOXu
         KERmL6Acx7cZftXpkeqDqUlLnLSlgt48iU/BUT9jtCSsxuwziZ1P1Hh0hoU+Ctru63zr
         Coow==
X-Gm-Message-State: ACgBeo3L4dWSsrJw29E1ta2LOlM5c90f+12xreNGTBtiES1bAzHZEgY8
        12tqxYZUVddy8joCMwMfr+bClWoFopVnFz2ZgMdqXN3CwG5GhW7B4c2kb6MtSCrADIACuDBtMfo
        k8jH3Zoy9riZxa0CAWsGuzw6ULAAfekP6EOW4MBLL/d4pBj0H00OP8yOxY0PQElsu0L9t2Q==
X-Received: by 2002:a05:620a:ecf:b0:6bb:a38:43cb with SMTP id x15-20020a05620a0ecf00b006bb0a3843cbmr16972975qkm.742.1661977932383;
        Wed, 31 Aug 2022 13:32:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7HjBBRBrkPIYSxsae+LunIyi1I88HafEf3rm6Wm2H348+2md3sAp5TXK/YxCjnwl8nliPRow==
X-Received: by 2002:a05:620a:ecf:b0:6bb:a38:43cb with SMTP id x15-20020a05620a0ecf00b006bb0a3843cbmr16972949qkm.742.1661977932076;
        Wed, 31 Aug 2022 13:32:12 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.94.45])
        by smtp.gmail.com with ESMTPSA id c6-20020a05620a268600b006b945519488sm11256548qkp.88.2022.08.31.13.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 13:32:11 -0700 (PDT)
Message-ID: <c0d059fc-a41c-ca24-59f8-ad7f780f91f0@redhat.com>
Date:   Wed, 31 Aug 2022 16:32:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: Announcing the Fall 2022 Bakeathon
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>
References: <480ddad3-f93a-dab3-0f50-b4b7ebacd6e9@redhat.com>
In-Reply-To: <480ddad3-f93a-dab3-0f50-b4b7ebacd6e9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

Just a quick reminder... The Bakeathonn is a
little over a month out... I know a lot of the
Red Haters planning on intending F2F...

I sounds like Netapp plan on being there in person as
well as virtual. I have heard rumors that Oracle
plan on attending F2F.

Still looking to hear from HammerSpace, Amazon,
Google, Vmware, CEA and HP. I'm hoping they
will be attending... one way or another.

I would like to set up talks Tue, Wed and
Thur at 2pm EST. So you are interested in
hearing about something or if you want to
talk about something or just status on
things (RDMA, TLS, QUIC, Session Trunking)
Just let me know. I'll set up a google
doc to sign up....

I'm pretty sure I will be able to set things up so
the remote  people can participate.

As usual, Red Hat will be having a few
"pops" with hors d'oeuvres starting
around 4ish each day...

steved.


On 7/13/22 10:59 AM, Steve Dickson wrote:
> Hello,
> 
> Red Hat is pleased to announce that we'll be hosting the
> Fall 2022 Bakeathon at our Westford office in Massachusetts, US.
> 
> The event will be F2F as well as virtual. Hoping to
> draw as many participants as possible.
> 
> Date: Mon Oct 10 to Fri Oct 14
> Address: Red Hat, 314 Littleton Rd, Westford, MA
> 
> Details, registration and hotel info are here [1].
> Any questions please send them to bakeathon-contact@googlegroups.com
> 
> I hope to see you there... One way or the other!
> 
> steved.
> 
> [1] http://www.nfsv4bat.org/Events/2022/Oct/BAT/index.html
> 

