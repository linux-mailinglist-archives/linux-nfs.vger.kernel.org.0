Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5BB507A13
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Apr 2022 21:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbiDSTUh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Apr 2022 15:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbiDSTUg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Apr 2022 15:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EED903B2A6
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650395869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjLt0UcxwJgJ4e7pEQxd4qdpPAKIj8zuAHvIU6sWDhE=;
        b=DsuDs/pZA6liIVgbb01AduFPK3zyBApPKerxqQzGRSK2gvL6r4R84rBDWwRou2hw6Y2Bgw
        NyYbLe1rDYbYNTb2BKTa7s5sFINhHNo3RIxTOpBM3xZdwVSZpVIACACju+5Qou2Hcpbp1k
        wKfOSiAA+6rpN8CoQd1r1KGd3urUgJU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-mFvIeUSGOR-xo0GpNbAnvw-1; Tue, 19 Apr 2022 15:17:48 -0400
X-MC-Unique: mFvIeUSGOR-xo0GpNbAnvw-1
Received: by mail-qv1-f72.google.com with SMTP id es4-20020a056214192400b004461a0b8e91so14203666qvb.14
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 12:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tjLt0UcxwJgJ4e7pEQxd4qdpPAKIj8zuAHvIU6sWDhE=;
        b=bMoeI88NzBHfpy6OvqD/7RUsOuyuo7pV3p3ZiuCcV+EgypUq4GztcJNtZCuYGLp4UI
         3OzavgSaFdlRi2eVe7sAt9zuprIHx04B73Ye/lqymKCNFy+wTgH1W7EBf/SNOJFJI3GB
         Uu7SlEk6LXBD77zgSko+uH0CvUsoDCgUDADJWYwpDSGqdvPIg0mtGEWR2VjcSIpAvbUh
         xhpdn1fSe3/x9rFnCNn2zhAL9h/VmvwKWzAu9TKu1HHARDNkZXPqUEUGEhcUEn3xXV8D
         H7k8R+6gjtEvjhUsd7fh0nrPR1E1gFDmTVfzyMtEDpxfmH6SCTAlC3t/6hhhEH1yvSMr
         AFhQ==
X-Gm-Message-State: AOAM532FmUt85HzVHRwrCRQdlZ4TubJwpxOyOjFMJIV45rJ3a+iqIYAD
        4VKohgJneWTOD658K8rexd+bO274G3DL4DqM05UIQzyqp61unhVCS/jlx7XPRCeOyH9kTSsd5oN
        Aa3BF7mElQG/8+xMnoKCU
X-Received: by 2002:a05:620a:bc6:b0:67d:1870:8b35 with SMTP id s6-20020a05620a0bc600b0067d18708b35mr10509983qki.85.1650395867158;
        Tue, 19 Apr 2022 12:17:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD4sF8tcMnjDAirgUw5nf5n/u+YrY1WUBpEkoumCAXpBFq65wRDXuUG19/Lq5aeO3AW4HYyg==
X-Received: by 2002:a05:620a:bc6:b0:67d:1870:8b35 with SMTP id s6-20020a05620a0bc600b0067d18708b35mr10509963qki.85.1650395866766;
        Tue, 19 Apr 2022 12:17:46 -0700 (PDT)
Received: from [172.31.1.6] ([71.168.80.171])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm505439qta.76.2022.04.19.12.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 12:17:46 -0700 (PDT)
Message-ID: <af22ce3e-2cc0-b32a-87da-204360cd1b4a@redhat.com>
Date:   Tue, 19 Apr 2022 15:17:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nfs-utils: nfsidmap.man: Fix section number
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Bryan Schumaker <bjschuma@netapp.com>,
        Ben Hutchings <benh@debian.org>
References: <20220412070016.720489-1-carnil@debian.org>
 <f9ec727f-e616-4af8-ac09-2d0fd1f2ae0a@redhat.com>
 <YlXSJspEFVtBvJk0@eldamar.lan> <YlvOH5CA+Bvl5yQC@eldamar.lan>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <YlvOH5CA+Bvl5yQC@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

Sorry for the delay...

On 4/17/22 4:21 AM, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Tue, Apr 12, 2022 at 09:25:28PM +0200, Salvatore Bonaccorso wrote:
>> Hi Steve,
>>
>> On Tue, Apr 12, 2022 at 10:28:50AM -0400, Steve Dickson wrote:
>>> Hello,
>>>
>>> On 4/12/22 3:00 AM, Salvatore Bonaccorso wrote:
>>>
>>> My mailer was unable to process the attachment
>>> Please in-line the patch and resend it.
>>
>> That is very strange, I used git send-email to submit it, and I do not
>> see where it got mangled, as it is present as well in
>>
>> https://lore.kernel.org/linux-nfs/20220412070016.720489-1-carnil@debian.org/
>>
>> Any idea what happened?
>>
>> Here it is again, inlined in this message.
>>
>> Regards,
>> Salvatore
>>
>>  From da390ced58885b0ed80be3722d4d913909e7c543 Mon Sep 17 00:00:00 2001
>> From: Ben Hutchings <benh@debian.org>
>> Date: Mon, 14 Mar 2022 00:19:33 +0100
>> Subject: [PATCH] nfsidmap.man: Fix section number
>>
>> The nfsidmap manual page is supposed to be in section 8, but calls the
>> .TH macro with a section argument of 5.  This results in an incorrect
>> header and causes debhelper (in Debian) to install it in the section 5
>> directory. Fix that.
>>
>> Signed-off-by: Ben Hutchings <benh@debian.org>
>> [Salvatore Bonaccorso: Slightly modify commit message to mention that
>> the Problem is found in Debian through installing the manpage via
>> debhelper]
>> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
>> ---
>>   utils/nfsidmap/nfsidmap.man | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/utils/nfsidmap/nfsidmap.man b/utils/nfsidmap/nfsidmap.man
>> index 2af16f3157ff..1911c41be6f9 100644
>> --- a/utils/nfsidmap/nfsidmap.man
>> +++ b/utils/nfsidmap/nfsidmap.man
>> @@ -2,7 +2,7 @@
>>   .\"@(#)nfsidmap(8) - The NFS idmapper upcall program
>>   .\"
>>   .\" Copyright (C) 2010 Bryan Schumaker <bjschuma@netapp.com>
>> -.TH nfsidmap 5 "1 October 2010"
>> +.TH nfsidmap 8 "1 October 2010"
>>   .SH NAME
>>   nfsidmap \- The NFS idmapper upcall program
>>   .SH SYNOPSIS
>> -- 
>> 2.35.1
> 
> Was this version now correctly processed by your mailer?
Yeah I got it... thanks... but...
Are you saying that this man page should be in chapter 5
or it is fact Debian installs into chapter 5?

In RHEL and Fedora we install it in chapter 8... If it
belongs in a different chapter I have no problem changing
it... I just need to know why.

steved.


steved.

