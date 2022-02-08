Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9584AE4DE
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiBHWo6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387760AbiBHWoo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 17:44:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B789C036489
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644359422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/AGq6y9fwwWQ5Paoewl9hdqTYn/rggYJIWoUZv43Qw=;
        b=cUJ4VVY9CUFSBrfqsRXjCJg6cPInb+qqiteWd7NlMbYR+FzgoACeNDZq9vZIoqwWEhOkLd
        M3IzfEpSAoqPLpOIdHacb4srsY0NbY7JMgu8ugsbHfWCvPvwGNMAElPNKH+CBT2m+sQ5BW
        OZx2IDjb9Roc22CZlnW7sJtPLyY16Xg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-SBAQv3stNVGB7Q3b9u0K3Q-1; Tue, 08 Feb 2022 17:30:19 -0500
X-MC-Unique: SBAQv3stNVGB7Q3b9u0K3Q-1
Received: by mail-qt1-f197.google.com with SMTP id br10-20020a05622a1e0a00b002d37e07e79aso345082qtb.4
        for <linux-nfs@vger.kernel.org>; Tue, 08 Feb 2022 14:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e/AGq6y9fwwWQ5Paoewl9hdqTYn/rggYJIWoUZv43Qw=;
        b=g1jB178lZuqAgQgZP2a+f8s3i1RUIAMh5BV7cOXQ6xtBdGpQCIKOHXelQmrbjtb0WA
         4Ma2Zk94yFytMW2aB0MHWT0oX9Ru8v4eVnAqqzQ6uNE3SFSFmrZ/haJruyoQDco3VuQ6
         DxjzIvA0CUkG7VZZHh7Rp8mETdurl3xQ8WPy5WrLC7fWTm4VIcTp18W/7cLpTv3KesQh
         0yAtNGDAyMLZePgOi+nJREeGGkXu8bAc+ggfYCUfodsMd+ExC/fBg+t6vqoSfgebKo/Q
         uh+Djj3AA21IkF/PnTMJuP6pZLW1u6cheap59qGjvlsRcArJ+yCjsfdO7zrKvJ/zT/C0
         xS7g==
X-Gm-Message-State: AOAM533KVkfKM2klxo6EdEFBLvfzW2wTd+6zwL0wAi3UquujY4Q02AY9
        Q0dB43r7mqZjyIYZ0gu74gW4TLANGw9ipHMhmmCQfc7CL+cJcLZjQt7yexKfU0MenbkEMVXx5wD
        YL5MqbD7C22EKQepCgRfX
X-Received: by 2002:a05:622a:112:: with SMTP id u18mr4619027qtw.480.1644359418901;
        Tue, 08 Feb 2022 14:30:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxi2yl5AsPrgVMYFls2l+SlUNhCtzZTUXs0MUeXt1IgH1bSYX1UJou+2Mco9N1dZboITRzx0g==
X-Received: by 2002:a05:622a:112:: with SMTP id u18mr4619017qtw.480.1644359418610;
        Tue, 08 Feb 2022 14:30:18 -0800 (PST)
Received: from [172.31.1.6] ([70.105.253.180])
        by smtp.gmail.com with ESMTPSA id u16sm8105320qtx.46.2022.02.08.14.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 14:30:18 -0800 (PST)
Message-ID: <778c3e11-62e1-00b1-0cbc-514abe1d1eac@redhat.com>
Date:   Tue, 8 Feb 2022 17:30:17 -0500
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
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <E013276C-7605-4E2B-A650-C61C6FC5BADF@redhat.com>
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

Hey!

On 2/8/22 3:00 PM, Benjamin Coddington wrote:
> On 8 Feb 2022, at 14:52, Steve Dickson wrote:
> 
>> On 2/8/22 11:22 AM, Benjamin Coddington wrote:
>>> On 8 Feb 2022, at 11:04, Steve Dickson wrote:
>>>
>>>> Hello,
>>>>
>>>> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>>>>> The nfs4id program will either create a new UUID from a random 
>>>>> source or
>>>>> derive it from /etc/machine-id, else it returns a UUID that has 
>>>>> already
>>>>> been written to /etc/nfs4-id.  This small, lightweight tool is 
>>>>> suitable for
>>>>> execution by systemd-udev in rules to populate the nfs4 client 
>>>>> uniquifier.
>>>>>
>>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>>> ---
>>>>>   .gitignore               |   1 +
>>>>>   configure.ac             |   4 +
>>>>>   tools/Makefile.am        |   1 +
>>>>>   tools/nfs4id/Makefile.am |   8 ++
>>>>>   tools/nfs4id/nfs4id.c    | 184 
>>>>> +++++++++++++++++++++++++++++++++++++++
>>>>>   tools/nfs4id/nfs4id.man  |  29 ++++++
>>>>>   6 files changed, 227 insertions(+)
>>>>>   create mode 100644 tools/nfs4id/Makefile.am
>>>>>   create mode 100644 tools/nfs4id/nfs4id.c
>>>>>   create mode 100644 tools/nfs4id/nfs4id.man
>>>> Just a nit... naming convention... In the past
>>>> we never put the protocol version in the name.
>>>> Do a ls tools and utils directory and you
>>>> see what I mean....
>>>>
>>>> Would it be a problem to change the name from
>>>> nfs4id to nfsid?
>>>
>>> Not at all..
>> Good...
> 
> I didn't orginally do that because I thought it might be confusing for some
> folks who want `nfsid` to display their kerberos identity.  There's a BZ
> open for that!
> 
> Do you think that's a problem?  I feel like it's a problem.
> 
>>> and I think there's a lot of room for naming discussions about
>>> the file to store the id too:
>>>
>>> Trond sent /etc/nfs4_uuid
>>> Neil suggests /etc/netns/NAME/nfs.conf.d/identity.conf
>>> Ben sent /etc/nfs4-id (to match /etc/machine-id)
>> Question... is it kosher to be writing /etc which is
>> generally on the root filesystem?
> 
> Sure, why not?
In general, writes to /etc are only happen when packages
are installed and removed... any real time writes go
to /var or /run (which is not persistent).

> 
>> By far Neil suggestion is the most intriguing... but
>> on the containers I'm looking at there no /etc/netns
>> directory.
> 
> Not yet -- you can create it.
"you" meaning who? the nfs-utils install or network
namespace env? Or is it, when /etc/netns exists
there is a network namespace and we should use
that dir?

> 
>> I had to install the iproute package to do the
>> "ip netns identify" which returns NULL...
>> also adds yet another dependency on nfs-utils.
> 
> We don't need the dependency..this little binary is just a helper for a 
> udev
> rule.  Trond already wrote his version of this.  :)  This one's just trying
> to be a little lighter (whoa, we don't need all of bash!).
Fair enough.

> 
>> So if "ip netns identify" does return NULL what directory
>> path should be used?
> 
> I think thats out of scope..  if udevd is running in a container, and has a
> rule that uses this tool, then the container either is likely to have
> already customized its /etc.  Or perhaps we can make the udev rule 
> namespace
> aware (I need to look into what's available to udev's rule environment when
> it runs in a namespace).
With all do respect... that is a lot of hand waving :-)
I'll wait to see what comes you come up with.

> 
>> I'm all for making things container friendly but I'm
>> also a fan of keeping things simple... So
>> how about /etc/nfs.conf.d/identity.conf or
>> /etc/nfs.conf.d/nfsid.conf?
> 
> Really, because its not a configuration.  Its value persistence, and we 
> /really/
> don't want people configuring it.
Good point... and I got it... I was just trying to used
the parsing code we already have in place.

> 
>>>
>>> Maybe the tool wants an option to specify the file?
>> This is probably not a bad idea... It is a common practice
> 
> OK, I'll do that.
Thanks!

steved.

> 
> Ben
> 

