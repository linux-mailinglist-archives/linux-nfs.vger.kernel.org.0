Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FDF442003
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 19:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhKAS1k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 14:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232017AbhKAS1h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 14:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635791103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RhcI8f6H9jU7xDJeOPgIhViEuyjczTdQghvnRAXzs6Y=;
        b=C3iEJAM1j0K5FCBpMFePu7rk7oTolIUusqfNMiwsr+Juo+kVBqCJ76WHmrx9XbDsjNhMNY
        wL8A0sOk64a9afFOOj3qH/BMYsrP7Moq6cOPrsppLYzzutUYNa6nH0+WuPgmpcvNT++C5X
        d/cPmQQ9iBKZtKuOjrrWD5tH8YfbkCM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-RY455viDM1uA6JdjDkyEmQ-1; Mon, 01 Nov 2021 14:25:01 -0400
X-MC-Unique: RY455viDM1uA6JdjDkyEmQ-1
Received: by mail-qv1-f72.google.com with SMTP id c15-20020a0cd60f000000b0038509b60a93so17183028qvj.20
        for <linux-nfs@vger.kernel.org>; Mon, 01 Nov 2021 11:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RhcI8f6H9jU7xDJeOPgIhViEuyjczTdQghvnRAXzs6Y=;
        b=5wbip5VWxc2x0X1N/BCM1ZJF4RNqX8rRV43V/YYWg8z52Sam51+R689ViqlHpa14+x
         X6+hJsPH/J2MQygNJF36z/pcYYyc0xUw5QqsUf1IK8to0r5ChAG93QXD3v1Y+JQ9fpkJ
         wBkQBv16YrIab50T2ePA9OZbhzXz47VieP66wBRkK5LpMNYFNccKFz4Q51FdlL4sy7GC
         xdNozKy5GUirqDoxq7+K6eAqDmXDcP8nSV9ZiR2JWGeQt9oXUl/QkClVLIl8XGzvT45g
         /Y3REGf7LRilohexhBVfbFvKhpcqSya3KPAZVrx4auSe7AaubjphTwXZFgHNwSs9BavP
         VQ5w==
X-Gm-Message-State: AOAM532qhdWS4YoHNmx0ZJbrWY3WmM6hk1zBwrsDMbuelAqTgmMlisJ8
        EOv7nsTcTYJvJpSM+WXReUN4m3me7jE+SUfoKe2ywNstqiYA0in9lNTAt3+4NjyfRvBq7GAVSfM
        nGH0ljnmtbs5TT1gtPEjC
X-Received: by 2002:ac8:4e42:: with SMTP id e2mr24386377qtw.102.1635791101304;
        Mon, 01 Nov 2021 11:25:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYWbwmRM6VaZBINOP07z6mLbUr/OiCjrsExQi4R3tTy7Xy9CxWl28Max9drvAG1A+cjrDWOg==
X-Received: by 2002:ac8:4e42:: with SMTP id e2mr24386344qtw.102.1635791101019;
        Mon, 01 Nov 2021 11:25:01 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id f23sm10412532qtq.40.2021.11.01.11.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 11:25:00 -0700 (PDT)
Message-ID: <53f62fd7-d906-1f3c-b1d6-15c1246f9ba9@redhat.com>
Date:   Mon, 1 Nov 2021 14:24:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
 <93DAB7C7-D0BB-48BA-9BFF-2821D88582EA@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <93DAB7C7-D0BB-48BA-9BFF-2821D88582EA@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/1/21 12:55, Chuck Lever III wrote:
> 
>> On Nov 1, 2021, at 11:40 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>
>> On Mon, Nov 01, 2021 at 11:30:48AM -0400, Steve Dickson wrote:
>>> Hey!
>>>
>>> On 10/29/21 15:14, J. Bruce Fields wrote:
>>>> On Fri, Oct 29, 2021 at 01:30:36PM -0400, Steve Dickson wrote:
>>>>> On 10/29/21 12:40, J. Bruce Fields wrote:
>>>>>> Let's just stick with that for now, and leave it off by default until
>>>>>> we're sure it's mature enough.  Let's not introduce new configuration to
>>>>>> work around problems that we haven't really analyzed yet.
>>>>> How is this going to find problems? At least with the export option
>>>>> it is documented
>>>>
>>>> That sounds fixable.  We need documentation of module parameters anyway.
>>> Yeah I just took I don't see any documentation of module
>>> parameters anywhere for any of the modules. But by documentation
>>> I meant having the feature in the exports(5) manpage.
>>
>> I think I'd probably create a new page for sysctls (this isn't the only
>> one needing documentation), and make sure it's listed in the "SEE ALSO"
>> section of the other man pages.
> 
> Aren't sysctls documented under Documentation/ ?No... there is a Documentation/admin-guide/sysctl/sunrpc.rst
but it talks about rpcdebug commands and there is nothing
that documents the module parameters under
Documentation/filesystems/nfs

steved.

> 
> 
>>>>> and it more if a stick you toe in the pool verses
>>>>> jumping in...
>>>>
>>>> If we want more fine-grained control, I'm not yet seeing the argument
>>>> that an export option on the destination server side is the way to do
>>>> it.
>>>>
>>>> Let's document the module parameter and go with that for now.
>>> Now that cp will use copy_file_range() when available,
>>> what are the steps needed to enable these fast copies?
>>
>> 1) Make sure client and both servers support NFSv4.2 and
>> server-to-server copy.
>>
>> 2) Make sure destination server can access (at least for read) any
>> exports on the source that you want to be able to copy from.
>>
>> 3) echo 1 >/sys/module/nfsd/parameters/inter_copy_offload_enable on the
>> destination server.
>>
>> --b.
> 
> --
> Chuck Lever
> 
> 
> 

