Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869A244014D
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhJ2RdJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 13:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhJ2RdJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 13:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635528639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0O7zj4PuQwIAOnylupRdQU4BlqvM08g5Yo5D1KyZOLQ=;
        b=LV1pFuIQUi6/3T8SVuX6Yb84Dtl2Q5+t2nkYT6ImZvzHHWz1KmX8wlDnPWqL9r5U568G+J
        YdSb2y9KqBBHwVFgSVLBv5IEIBZIX/zBxtY8WRxb+sv1ivyAKTP3S5S3Ijd5HibvOs2AKJ
        AbgD19mRuXbHZGwSXb5shGgGubTMzms=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-V2cBXKtFNf-hbnGZMt2ejA-1; Fri, 29 Oct 2021 13:30:38 -0400
X-MC-Unique: V2cBXKtFNf-hbnGZMt2ejA-1
Received: by mail-qv1-f69.google.com with SMTP id z8-20020a0cd788000000b00384d92a0f11so8308238qvi.17
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 10:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0O7zj4PuQwIAOnylupRdQU4BlqvM08g5Yo5D1KyZOLQ=;
        b=o7y5BgIeCNbe2zYHBDOgWLw7NZsEBty9GKukTGMDdKnOcoapGSrgUccYeEmePCtT6A
         aTap7g6J4tBp9INhlvqBH7aozAXtaMvrmC9vsh9pvwiaJUX53AeSd7A1hNF5vqCAt3lQ
         QOA3W2hcemgbY+RIdUZgcjxpstF7OrzNd6Ek3Yu4nCzfzSd0ORZuXVf4JgshMrOtTU24
         yx1Fde7zs+DRfIfAUl195goZ2uuA1fD1qTZTYpXs652U2i+FLBmJEUKySXdTlZz096yt
         2zgtfk/1fqZYaEoyrO/uawew6dY4tBZfFuXnQl/HkpEGS062nMU0igeUnNKddqqVPZwi
         knPQ==
X-Gm-Message-State: AOAM530QNPbjjYyKW8UatfbuZM1XHkODP9Dezl6wT/I8KD5eqKC0nAHK
        k+VV+p3htB4Kks8fqO6dg0uOSuPYruwZxDKMzT5IIFllJnV4VhgMqZ9CgQFyghdd63CfrlQV9I4
        0TIv3pFpb3Vy4JeGR4y/l
X-Received: by 2002:a37:6c83:: with SMTP id h125mr9959987qkc.486.1635528637736;
        Fri, 29 Oct 2021 10:30:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2yTfONuXy5XGvlg8eTWihPgMrwTUQ5X+sCCQKXNbSGvn6IxHW6J31aUZqCu6fO0lPrgLZOA==
X-Received: by 2002:a37:6c83:: with SMTP id h125mr9959968qkc.486.1635528637524;
        Fri, 29 Oct 2021 10:30:37 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id o6sm4803479qta.2.2021.10.29.10.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 10:30:37 -0700 (PDT)
Message-ID: <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
Date:   Fri, 29 Oct 2021 13:30:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20211029164058.GE19967@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/29/21 12:40, J. Bruce Fields wrote:
> On Fri, Oct 29, 2021 at 10:56:24AM -0400, Steve Dickson wrote:
>> On 10/29/21 09:45, J. Bruce Fields wrote:
>>> Really, first I think we should try to identify what the problem is that
>>> we're trying to solve.
>> I'm not trying to solve any problem... I'm just trying to enable a
>> feature in a sane and safe way. By only have one module param it
>> is on all the time on all copies... With an export opt, admins
>> can pick and choose which exports use it. I'm thinking that
>> is a bit less risky.
> 
> So, I'm not sure which risk you're thinking about.
Now, I don't know how often a client copies files
from one server to another... but change the path on
all those copies... without making the admins aware
that is happening... is the risk I'm thinking about.

> 
> If it's the risk of the client telling the destination server to copy
> from a rogue server--I'm kind of regretting bringing that up.  If there
> are bugs in that area, I'd rather they be fixed, than that we introduce
> new configuration to work around bugs that may or may not exist.  They'd
> need to be fixed anyway, for other reasons.  I think Dai has volunteered
> to look through the code that handles replies to the small number of
> operations concerned, and I think that's good enough due diligence.  And
> I'm not getting the impression Trond is particularly worried about the
> client code here either.
I agree we should fix the bugs is better than working around them.
But having the bug effect all these types of copies verses
a few of them on a select number of exports... We still
would see the bugs.

> 
> If the risk is performance--like I say, I'm not sure exactly what those
> cases look like.
Well Jorge seem to show there was a was a big performance gain [1]

> 
> I've been thinking about it in terms of bandwidth, but maybe that's
> wrong--the bigger problem may be when the source server is only
> accessible to the client for some reason (like, you're copying from a
> local server to a destination server that's outside a firewall).  Maybe
> the destination server will end up waiting a long time trying to reach
> the source.
> 
> But, again, I'm not sure an export option helps, because I don't see why
> that problem would necessarily be per-destination-server-export.
It helps enabling the technology without out the big hammer approach.
Allowing these type of copies on a couple exports verses all
exports would still show any problem.

> 
> Instead, we may just need to make sure the destination server is quick
> to timeout, or has some mechanism to blacklist source servers so it's
> not repeatedly timing out trying to copy from the same server.  I don't
> know, I'm just thinking out loud.
This sounds like you not happy with the design... And it appears
where is there today is what the RPC specified...
Again... I'm just trying to enable it...

> 
>> The option of setting the inter_copy_offload_enable is still
>> there... if admins want to go that route.
> 
> Let's just stick with that for now, and leave it off by default until
> we're sure it's mature enough.  Let's not introduce new configuration to
> work around problems that we haven't really analyzed yet.
How is this going to find problems? At least with the export option
it is documented and it more if a stick you toe in the pool verses
jumping in...

steved.
> 
> It's not as though turning on a module option is any more difficult than
> setting an export option.
> 


[1] https://marc.info/?l=linux-nfs&m=149201305018467&w=2

