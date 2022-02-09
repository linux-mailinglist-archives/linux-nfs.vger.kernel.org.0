Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56974AF361
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 14:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiBINzZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 08:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiBINzY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 08:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC66BC0613C9
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 05:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644414925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4d7x1p7bgG5pDkLa5th8L6gk1Sbf0ijAeY0HtoDkR0=;
        b=Oha+zP914dnp/zQ5Gu17eVM+U7xPEIWNbim5FJz5ra3O2GgYYLsdW8KQyU3m+dn5WM6L40
        c+2snkaJO1IykTJkTUbI5fG2RBdJfXXeF0rREH13W5TuCheTqPlPZWnUwCcr2XY7FurtDu
        y6z5KDt/ERLZ6mzEHoorzCXMlzCJqwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-Xj1S3fczNj2RiGaHIcKuRw-1; Wed, 09 Feb 2022 08:55:24 -0500
X-MC-Unique: Xj1S3fczNj2RiGaHIcKuRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4892886A062
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 13:55:23 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA0B56F94E;
        Wed,  9 Feb 2022 13:55:22 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Date:   Wed, 09 Feb 2022 08:55:21 -0500
Message-ID: <E646BDFC-0422-4052-AC7A-9103696013A9@redhat.com>
In-Reply-To: <778c3e11-62e1-00b1-0cbc-514abe1d1eac@redhat.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
 <E013276C-7605-4E2B-A650-C61C6FC5BADF@redhat.com>
 <778c3e11-62e1-00b1-0cbc-514abe1d1eac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Feb 2022, at 17:30, Steve Dickson wrote:

> Hey!
>
> On 2/8/22 3:00 PM, Benjamin Coddington wrote:
>> On 8 Feb 2022, at 14:52, Steve Dickson wrote:
>>
>>> On 2/8/22 11:22 AM, Benjamin Coddington wrote:
>>>> On 8 Feb 2022, at 11:04, Steve Dickson wrote:
>>>>
>>>>> Hello,
>>>>>
>>>>> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>>>>>> The nfs4id program will either create a new UUID from a random 
>>>>>> source or
>>>>>> derive it from /etc/machine-id, else it returns a UUID that has 
>>>>>> already
>>>>>> been written to /etc/nfs4-id.  This small, lightweight tool is 
>>>>>> suitable for
>>>>>> execution by systemd-udev in rules to populate the nfs4 client 
>>>>>> uniquifier.
>>>>>>
>>>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>>>> ---
>>>>>>   .gitignore               |   1 +
>>>>>>   configure.ac             |   4 +
>>>>>>   tools/Makefile.am        |   1 +
>>>>>>   tools/nfs4id/Makefile.am |   8 ++
>>>>>>   tools/nfs4id/nfs4id.c    | 184 
>>>>>> +++++++++++++++++++++++++++++++++++++++
>>>>>>   tools/nfs4id/nfs4id.man  |  29 ++++++
>>>>>>   6 files changed, 227 insertions(+)
>>>>>>   create mode 100644 tools/nfs4id/Makefile.am
>>>>>>   create mode 100644 tools/nfs4id/nfs4id.c
>>>>>>   create mode 100644 tools/nfs4id/nfs4id.man
>>>>> Just a nit... naming convention... In the past
>>>>> we never put the protocol version in the name.
>>>>> Do a ls tools and utils directory and you
>>>>> see what I mean....
>>>>>
>>>>> Would it be a problem to change the name from
>>>>> nfs4id to nfsid?
>>>>
>>>> Not at all..
>>> Good...
>>
>> I didn't orginally do that because I thought it might be confusing 
>> for some
>> folks who want `nfsid` to display their kerberos identity.  There's 
>> a BZ
>> open for that!
>>
>> Do you think that's a problem?  I feel like it's a problem.
>>
>>>> and I think there's a lot of room for naming discussions about
>>>> the file to store the id too:
>>>>
>>>> Trond sent /etc/nfs4_uuid
>>>> Neil suggests /etc/netns/NAME/nfs.conf.d/identity.conf
>>>> Ben sent /etc/nfs4-id (to match /etc/machine-id)
>>> Question... is it kosher to be writing /etc which is
>>> generally on the root filesystem?
>>
>> Sure, why not?
> In general, writes to /etc are only happen when packages
> are installed and removed... any real time writes go
> to /var or /run (which is not persistent).

I use `passwd` and `usermod`, which write to etc.  I can think of other
examples.  For me, /etc is fair game.

There's three of us that think /etc is a good place.  You're the 
maintainer
though, tell us what's acceptable.  If we add an -f option to specify 
the
file, I'd like there to be a sane default if -f is absent.

>>> By far Neil suggestion is the most intriguing... but
>>> on the containers I'm looking at there no /etc/netns
>>> directory.
>>
>> Not yet -- you can create it.
> "you" meaning who? the nfs-utils install or network
> namespace env? Or is it, when /etc/netns exists
> there is a network namespace and we should use
> that dir?

Anyone that wants to create network namespace specific configuration can
create /etc/netns/NAME, and the iproute2 tools will bind-mount 
configuration
from there over /etc/ when doing `ip netns exec`.

Ben

