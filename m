Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2C64B13EB
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 18:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbiBJRLi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 12:11:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244818AbiBJRLh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 12:11:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C648E6C
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644513097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPAqQG4+jAdXtdO8h1GYCiTDHuaCIYvU9rCULIsm1+8=;
        b=XEuWoieB2CD6Y8o6Clz4MWqurKhGApfhsnTVyDRYnWuW5NcF7NGccuiTAW59k3CQDNWfP9
        mtIu9wJF0A28Gy3apXaSq5nXY9fCymMc8amuz94lxJurBiu1//a1tNMmr6t/tzRfWWaY/K
        Y2tJKhiVt+mm+C3KTA67fBAGW8igmvI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-YxjxHtvbPWSkCdUZq4_KNA-1; Thu, 10 Feb 2022 12:11:36 -0500
X-MC-Unique: YxjxHtvbPWSkCdUZq4_KNA-1
Received: by mail-qt1-f199.google.com with SMTP id g18-20020ac84b72000000b002cf274754c5so4860367qts.14
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 09:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lPAqQG4+jAdXtdO8h1GYCiTDHuaCIYvU9rCULIsm1+8=;
        b=UQel8ELtD6UzNshmfbSPwzhQGRWRWylOcuI7Rgmcre66Fu4FnJJcL7Lq3UmCPvKMOo
         KZQdEYmqMt1V2VneJqzOEypwl7lfJ4aOwJECTB0WcR207naWk3faTS97wqy+rFVZPG8k
         Xsddo+myHWn6nif2ylt+nLrLPUJ0BowygZpxF+ZzWU47mjfF3klpJ3BWqlzUrglkfD/M
         4ohnRQ8XFXEQl9987h/oviNegABZ8NLtJNhWAH1HB8zQJu7DinWnA07V3EqdLxtzJIgH
         9TvB17QKRiOvT8BhRWFmRoeRYLJWwSvOORfCyedwqstE/f4rUPaNk2wnHw0SS8ZFjaBm
         IYPA==
X-Gm-Message-State: AOAM531QCkhWpM2vAMJmo6Z/kYr1zQ79GJb71vDCT9AqfmTjEmsxTXUa
        L/ET5a+fVDUFuBaus9xoo6QUkn8TOqoLL0LLi3qxpzzxQ/QVfPCyLQNuutqC8ilgW9pmm7/0pL5
        VtOliz1Xsq+8EDXv4Vde6
X-Received: by 2002:a05:622a:612:: with SMTP id z18mr5398667qta.517.1644513095753;
        Thu, 10 Feb 2022 09:11:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvQj684N3ic26WhMF3gOJBi4A4DVuiQSbA0KoQaEq9hPL56OazDTO2m6uyvfyCognU9X2ebg==
X-Received: by 2002:a05:622a:612:: with SMTP id z18mr5398643qta.517.1644513095484;
        Thu, 10 Feb 2022 09:11:35 -0800 (PST)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a6sm11568553qta.91.2022.02.10.09.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 09:11:35 -0800 (PST)
Message-ID: <b66bf645-5740-df6e-5fa0-2d9c081a4575@redhat.com>
Date:   Thu, 10 Feb 2022 12:11:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Content-Language: en-US
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <33B10EBB-3DD1-45FE-B7D2-D5EA21DFB172@oracle.com>
 <839b09ed-fd21-bda1-0502-d7c6f1fa9e88@redhat.com>
 <32D8EBC9-652A-49D7-B763-A82E2AEF6282@oracle.com>
 <281b1976-9b40-fc53-301a-2846c2ead5aa@redhat.com>
 <13069AB1-28EB-43F6-83BF-41E9B9501C75@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <13069AB1-28EB-43F6-83BF-41E9B9501C75@redhat.com>
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



On 2/10/22 8:28 AM, Benjamin Coddington wrote:
> On 8 Feb 2022, at 17:39, Steve Dickson wrote:
> 
>> On 2/8/22 4:18 PM, Chuck Lever III wrote:
>>>
>>>
>>>> On Feb 8, 2022, at 2:29 PM, Steve Dickson <steved@redhat.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2/8/22 11:21 AM, Chuck Lever III wrote:
>>>>>> On Feb 8, 2022, at 11:04 AM, Steve Dickson <steved@redhat.com> wrote:
>>>>>>
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
>>>>> nfs4id is pretty generic, too.
>>>>> Can we go with nfs-client-id ?
>>>> I'm never been big with putting '-'
>>>> in command names... nfscltid would
>>>> be better IMHO... if we actually
>>>> need the 'clt' in the name.
>>>
>>> We have nfsidmap already. IMO we need some distinction
>>> with user ID mapping tools... and some day we might
>>> want to manage server IDs too (see EXCHANGE_ID).
>> Hmm... So we could not use the same tool to do
>> both the server and client, via flags?
>>
>>>
>>> nfsclientid then?
>> You like to type more than I do... You always have... :-)
>>
>> But like I started the conversation... the naming is
>> a nit... but I would like to see one tool to set the
>> ids for both the server and client... how about
>> nfsid -s and nfsid -c
> 
> The tricky thing here is that this little binary isn't going to set
> anything, and we probably never want people to run it from the command 
> line.
> 
> A 'nfsid -s' and 'nfsid -c' seem to want to do much more.  I feel they are
> out of scope for the problem I'm trying to solve:  I need something that
> will generate a unique value, and persist it, suitable for execution in a
> udevd rule.
> 
> Perhaps we can stop worrying so much about the name of this as I don't 
> think
> it should be a first-class nfs-utils command, rather just a helper for 
> udev.
> 
> And maybe the name can reflect that - "nfsuuid" ?
I can live with this....

steved


> 
> Ben
> 

