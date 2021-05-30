Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4623952CA
	for <lists+linux-nfs@lfdr.de>; Sun, 30 May 2021 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhE3TxK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 May 2021 15:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhE3TxJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 May 2021 15:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622404290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvVv0Nt9oUZd2n1LFljPV9luWpSfXCCcrskJ3554xfQ=;
        b=Tu8f94sR3HnOk5QjOGDoxOFYvXFkJys399OlyZgKQe1AOM4lFdfsNu/FRZIxg+EhFKqGGN
        ntpx3UrSsmWSG0gB9+boRhlExhwoWPJKjAiaboSRV+AYpatt+ciX6KSGWz8LUBRCAGCT4O
        q2GAYTMNThHdSM8spjNA4gz7tItt5SM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-iTx2cObAOR6NvyL8brCvPw-1; Sun, 30 May 2021 15:51:29 -0400
X-MC-Unique: iTx2cObAOR6NvyL8brCvPw-1
Received: by mail-qk1-f197.google.com with SMTP id y201-20020a3764d20000b02903a95207e6a4so1484417qkb.2
        for <linux-nfs@vger.kernel.org>; Sun, 30 May 2021 12:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvVv0Nt9oUZd2n1LFljPV9luWpSfXCCcrskJ3554xfQ=;
        b=oiZolz2texfI2YClRAI3ivWFOmwrbWojP/wY93nmo0CT2UGEal9Nlme1Y3D1aJX+ZY
         wgKTEe1/WWUIPIi1Dcksvzq0Di5uLpcVmk49zlSF8yF0YdQ5Qf2SzVmrY0uCxqQgXnYI
         dbfiAaOS8x9w8B7NmBfKpbYXyJKyUfF0mKOfEPfoBpKV22RZjbJT8lkYCfBHa0zms/CY
         cGYMDLLxqDh6poM+G7JmapigG/DTekF6OwS1HM2vqyqw2qRacPqN//K/PWBj55OJKsua
         +aSbpK3R6fUuSQcnI9ErkFwxGGteV1ttKkfi89UjR1BJuhRvxToykQFNvlfeRcTHq/yX
         WXXw==
X-Gm-Message-State: AOAM533xEbefIQhSO6CKGQi08UIq+rZgVfQ5Pvt74GQQKRZK5xAloE9b
        avpsvEOydFQAAQGXSnRf+pbShtbzS1Lr8eh/tI29bbUlK+TkcH1LNfYQOdZQAr0LjJNtZeeaWUM
        sW/3eAQjkmffgL/KLjFjP1ZEtk/3XfQbTgE217czKC/FesXv1gZSzeWtQjG5eqW9hd2CQQA==
X-Received: by 2002:ac8:1304:: with SMTP id e4mr5397873qtj.328.1622404288783;
        Sun, 30 May 2021 12:51:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhld3RndNoZ0Cq4BWXf/cxKMiH8eRapgwmvK32KoQvKlz0fvKopdpSwWVkn6hnJxFURFuaHw==
X-Received: by 2002:ac8:1304:: with SMTP id e4mr5397860qtj.328.1622404288513;
        Sun, 30 May 2021 12:51:28 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.93.112])
        by smtp.gmail.com with ESMTPSA id e19sm7247812qtr.45.2021.05.30.12.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 12:51:28 -0700 (PDT)
Subject: Re: [nfs-utils RFC PATCH 2/2] gssd: add timeout for upcall threads
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <20210525180033.200404-1-smayhew@redhat.com>
 <20210525180033.200404-3-smayhew@redhat.com>
 <490b45eb-0142-24de-e05f-79751891ddf9@RedHat.com>
 <YK+FH7T/ljFbuIsH@aion.usersys.redhat.com>
 <dbb64855-5ca5-0928-eda4-705a9f45c71b@RedHat.com>
 <CAN-5tyFG2douMOvKcERHa24hWp7VvgYB9XAN1c84JLsL+81pCA@mail.gmail.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <7cd3b3b9-5e69-5067-841b-782b0c679883@redhat.com>
Date:   Sun, 30 May 2021 15:54:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyFG2douMOvKcERHa24hWp7VvgYB9XAN1c84JLsL+81pCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

Sorry for the delay... Red Hat just rejiggered my
entire email world... fun fun! ;-)

On 5/27/21 12:47 PM, Olga Kornievskaia wrote:
> On Thu, May 27, 2021 at 8:52 AM Steve Dickson <SteveD@redhat.com> wrote:
>>
>>
>>
>> On 5/27/21 7:40 AM, Scott Mayhew wrote:
>>> On Wed, 26 May 2021, Steve Dickson wrote:
>>>> If people are going to used the -C flag they are saying they want
>>>> to ignore hung threads so I'm thinking with printerr(0) we would
>>>> be filling up their logs about messages they don't care about.
>>>> So I'm thinking we should change this to a printerr(1)
>>>
>>> Note that message could pop multiple times per thread even without the
>>> -C flag because cancellation isn't immediate (a thread needs to hit a
>>> cancellation point, which it won't actually do that until it comes back
>>> from wherever it's hanging).  My thinking was leaving it with
>>> printerr(0) would make it blatantly obvious when something was wrong and
>>> needed to be investigated.  I have no issue with changing it to
>>> printerr(1) though.
>> It would... but I've craft the debugging for a single -v
>> is errors only... Maybe I should mention that in the
>> man page... And looking at what you mention in the
>> man page for -C, it does say it will cause an error
>> to be logged... So I guess it makes sense to leave
>> it as is.
>>
>>>
>>> Alternatively we could add another flag to struct upcall_thread_info to
>>> ensure that message only gets logged once per thread.
>>>
>> I think it is good as is...
>>
>>>>
>>>> Overall I think the code is very well written with
>>>> one exception... The lack of comments. I think it
>>>> would be very useful to let the reader know what
>>>> you are doing and why.... But by no means is
>>>> that a show stopper. Nice work!
>>>
>>> I can go back and add some comments.
>> Well there aren't that many comments to
>> begin with.... So you are just following
>> the format... ;-)
>>
>> Don't worry about it... How I will finish my testing
>> today... and do the commit with what we got..
> 
> Hi Steve,
> 
> Can you please provide a bit more time for review to happen?
Fair enough... Scott a V3 version on last Thur.

> 
>> Again... Nice work!!
> 
> Yes, nice work. But, I object to the current code that sets canceling
> threads as default. This way the code hides the problems that occur
> instead of forcing people to fix them.
Scott correct me if I'm wrong...

If the upcall is canceled (which is the default) the
upcall is failed causing the mount to fail and
a message is logged.

If the upcall is not canceled (using the -C flag)
the upcall continues to hang, but only on message
is logged about the hang... and the mount will
continue to hang.

See 'scan_active_thread_list()' the 'case EBUSY:' case.

So in both cases a the problem will be logged.

steved.

