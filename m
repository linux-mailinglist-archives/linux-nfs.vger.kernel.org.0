Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97B544206E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 20:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhKATFe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 15:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhKATFc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 15:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635793379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGGmg0B7YF8vob3Fucww4hz+i1y7tZbYtt9IBy91Ruo=;
        b=ASkZkX/cEypzMDF9MQx9JhVY9KP/5VEuir0jVT8wzVCk0vPxlpNdxv76t1spTXQtRzkKCD
        Qyg+LcW98UwA7xhXhpuAW1D8RrWlR5/Q3T0b8t1yZbTbUZ/LDPyYmbC+Ad9wAxm/pjG4Xa
        0XxL48o7xuvskgdhZOqfpAipp+oU8kc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-Jl7i6Pn7OICgmenHSEMe3g-1; Mon, 01 Nov 2021 15:02:57 -0400
X-MC-Unique: Jl7i6Pn7OICgmenHSEMe3g-1
Received: by mail-qv1-f70.google.com with SMTP id ke1-20020a056214300100b003b5a227e98dso1558599qvb.14
        for <linux-nfs@vger.kernel.org>; Mon, 01 Nov 2021 12:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aGGmg0B7YF8vob3Fucww4hz+i1y7tZbYtt9IBy91Ruo=;
        b=rVFg7UtAaJsYxKXvDd/qtuWU+pf5M8XNzEJSPAy0x6WACIz4FRoZHH1FrOhyQ06y3X
         jHTkfu9KrJfCbrEgFWPMWpFdPWs3pr6VG+y5CE+nuNF7fBbFtbbUdOPcUV804UI4ToaU
         qUVlt9yqtx2w9fiJ3iG2P7ZNiTxg5i0H7uygXoERt/xt3HAnzJHmAVGD9tqn0HBcj1JF
         lpQK7HY9p6lZP9YyG1qEGK7U06OUvU2VxpocDeRkOvIpD5sn0C5YhzDs7Fs3P5cUlPas
         CpLiYTIK046ZKrrGQKsyMP8GueYhjvrAIlyR9Tj5y56cZlWYe3liTVbLoR9tjoNuoDgw
         2VvQ==
X-Gm-Message-State: AOAM530AHxbr9/tzOuktFr5qVhIkheK1CkkGA9bmbAnxQs/yt7qeGGr8
        foxhuHAiroho1ZLVb9TU4vo40PsFcWpqVM3fBB7h6SbeNfqQFeVI0xQoZ76WerW8SiiqEqDjwUG
        QsyUcYHgj9jQd9jrbI91H
X-Received: by 2002:a05:620a:28cc:: with SMTP id l12mr17142521qkp.423.1635793377239;
        Mon, 01 Nov 2021 12:02:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdFFooMfdbwlvK9W+L6oNGQeY90nW1XffXgUaQ8heFPB9CO5F2TGFCJ5kyqF01OCsWteXxzg==
X-Received: by 2002:a05:620a:28cc:: with SMTP id l12mr17142499qkp.423.1635793377014;
        Mon, 01 Nov 2021 12:02:57 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id f66sm6056735qkj.76.2021.11.01.12.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 12:02:56 -0700 (PDT)
Message-ID: <badaecc5-2936-4ab7-53e9-fabee0b51493@redhat.com>
Date:   Mon, 1 Nov 2021 15:02:38 -0400
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
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20211101154046.GA12965@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/1/21 11:40, J. Bruce Fields wrote:
> On Mon, Nov 01, 2021 at 11:30:48AM -0400, Steve Dickson wrote:
>> Hey!
>>
>> On 10/29/21 15:14, J. Bruce Fields wrote:
>>> On Fri, Oct 29, 2021 at 01:30:36PM -0400, Steve Dickson wrote:
>>>> On 10/29/21 12:40, J. Bruce Fields wrote:
>>>>> Let's just stick with that for now, and leave it off by default until
>>>>> we're sure it's mature enough.  Let's not introduce new configuration to
>>>>> work around problems that we haven't really analyzed yet.
>>>> How is this going to find problems? At least with the export option
>>>> it is documented
>>>
>>> That sounds fixable.  We need documentation of module parameters anyway.
>> Yeah I just took I don't see any documentation of module
>> parameters anywhere for any of the modules. But by documentation
>> I meant having the feature in the exports(5) manpage.
> 
> I think I'd probably create a new page for sysctls (this isn't the only
> one needing documentation), and make sure it's listed in the "SEE ALSO"
> section of the other man pages.
> 
>>>> and it more if a stick you toe in the pool verses
>>>> jumping in...
>>>
>>> If we want more fine-grained control, I'm not yet seeing the argument
>>> that an export option on the destination server side is the way to do
>>> it.
>>>
>>> Let's document the module parameter and go with that for now.
>> Now that cp will use copy_file_range() when available,
>> what are the steps needed to enable these fast copies?
> 
> 1) Make sure client and both servers support NFSv4.2 and
> server-to-server copy.
Something is already figuring this out... The only time
the client sends a COPY_NOTIFY and COPY is when both
mounts are 4.2. I have not looked into but that is what
the network traces are showing.

> 
> 2) Make sure destination server can access (at least for read) any
> exports on the source that you want to be able to copy from.
How can one server know what the other server has exported
or access to??

> 
> 3) echo 1 >/sys/module/nfsd/parameters/inter_copy_offload_enable on the
> destination server.
Who would be doing this? Plus this would not survive over a reboot.
An export would as well a /etc/modprobe.d/ file.

I can see the admin setting up the export but I really
don't see the admin doing the echo or creating the file
esp since the neither would is documented.

steved.

