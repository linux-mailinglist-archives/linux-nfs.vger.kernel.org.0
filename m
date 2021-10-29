Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1802E43FEC7
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhJ2O65 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 10:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229607AbhJ2O64 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 10:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635519387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjDBEjIyvFQwr4tcdRI4YJak6sJHebOnK7pruRQmWG8=;
        b=f7OgFuY/c6r3oBgzIbwn7DcOm3dwF1uX6NXW6fzE/sKbCbMLLL5fPlA57He2b9yHwJ8x0V
        cXRokXl9j4oEJ/vUtHwoOH0cxdOUV7T85aJ1Yhnale36LteoCX3YveOH5/7zYI+z+Sn5Ab
        qL4hGyoi7C8tuWlYljmWBInVzBNFXqg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-wiMZyw0gM9ix2XPlGN4-OA-1; Fri, 29 Oct 2021 10:56:26 -0400
X-MC-Unique: wiMZyw0gM9ix2XPlGN4-OA-1
Received: by mail-qt1-f200.google.com with SMTP id b9-20020ac87fc9000000b002ac69ae062bso137419qtk.7
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 07:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rjDBEjIyvFQwr4tcdRI4YJak6sJHebOnK7pruRQmWG8=;
        b=06fzdCblcvk1LIKB4SEJZW93DXoorbNJdX4kV9GR+jqF4WrxEptVLKCcw/wp7fAWyT
         iosxtBzBNk27XUAysW4amVJAS7uMXzsnq5rnhua5jHw3fKwHYFpP2I4xg4374JM2IzrK
         E9DD5Vo3rjVZ9xSP+Pc522yUFH+zt6xPDxC882hDp4pQKn2JKuM8HcWe8SeBssSFgi2K
         CByh2socAByzDfv0EwK6LeNSzuJAWh92piQb1mLwC/1mVcrgltZ9TFvTntAf60daPsWd
         sJpGGtEZtFghCJc46gQ11IqvU/cG8IaEkbInEnZMNeC7UoR+dLbfL5Og1Ff4yar9QYbt
         r46g==
X-Gm-Message-State: AOAM532xhHGU+RB6IZgHR7C4ZyJzb1fD/i+TJuf++3pCDNI3y/MhAFPV
        rkz91iedbvjpZCmrrzER2Zd89MQW1xvsFWdfmDKA/olidBr6JXUT32DJ3lQ6C2dEXt00Z9B2qNm
        iaLnjjR7tUOKhNgnz5Atl
X-Received: by 2002:a05:622a:1788:: with SMTP id s8mr12484619qtk.116.1635519385797;
        Fri, 29 Oct 2021 07:56:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP8O8SwNNIJDzX4Hf8y8MG4W/9ATyR35FYiJ9saNirDZ859FeQ0vz8zWsxbgyBUefpSYdMJg==
X-Received: by 2002:a05:622a:1788:: with SMTP id s8mr12484594qtk.116.1635519385496;
        Fri, 29 Oct 2021 07:56:25 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id h11sm4352551qkp.46.2021.10.29.07.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 07:56:25 -0700 (PDT)
Message-ID: <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
Date:   Fri, 29 Oct 2021 10:56:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20211029134534.GA19967@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 10/29/21 09:45, J. Bruce Fields wrote:
> On Thu, Oct 28, 2021 at 10:48:50AM -0400, Steve Dickson wrote:
>> This kernel patch and an upcoming nfs-utils patch
>> adds a new export option 's2sc' which will allow
>> inter server to server copies.
> 
> They're already allowed by a module option.  Why is an export option
> better?  
I was talking with an old admin... that you might know :-)
and he was suggestion he would what to control which
export used these types of copies... And I agreed with him.

> And why should it be set on the destination server and not the
> source server?
Maybe I'm missing something... but I believe nfsd4_copy() is only
called on the destination server since it is the only
function that looks at the inter_copy_offload_enable param.

> 
> Really, first I think we should try to identify what the problem is that
> we're trying to solve.
I'm not trying to solve any problem... I'm just trying to enable a
feature in a sane and safe way. By only have one module param it
is on all the time on all copies... With an export opt, admins
can pick and choose which exports use it. I'm thinking that
is a bit less risky.

The option of setting the inter_copy_offload_enable is still
there... if admins want to go that route.

steved.
> 
> --b.
> 
>>
>> The option needs to be set on the destination server.
>>
>> The idea behind the option is to allow admins the
>> ability to control which export can do these
>> types of copies.
>>
>> Steve Dickson (1):
>>    nfsd4_copy: Adds the ability to do inter server to server on an export
>>
>>   fs/nfsd/nfs4proc.c               | 3 ++-
>>   include/uapi/linux/nfsd/export.h | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.31.1
> 

