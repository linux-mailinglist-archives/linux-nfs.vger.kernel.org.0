Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8AB507B1A
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Apr 2022 22:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357701AbiDSUmq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Apr 2022 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357358AbiDSUmp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Apr 2022 16:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9CB912AF4
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650400798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1M8i6yEH4s+M5E8X+swryMTIILtd3RLhbcc1Z58Awr8=;
        b=ZBiX1e1JgofsTCPq/GkTITRdy9xCB8oY0tZVSFL1zavGjES1wDnhhuyasVCrvUpczkiVyH
        kVGFrnp5Js9r/ShhcAdo+MldlJW9VMOUJ0WcHQUx2bnd0wa5OBCRvxOiK77uFtXflXN6Eq
        Rm7w8cGggDCRsjQkTHpNB2kLPpUgt18=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-7gAwJQXqPI2m_c1Hj6R7zw-1; Tue, 19 Apr 2022 16:39:55 -0400
X-MC-Unique: 7gAwJQXqPI2m_c1Hj6R7zw-1
Received: by mail-qk1-f199.google.com with SMTP id h8-20020a05620a244800b00699fb28d5e4so13215142qkn.22
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 13:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1M8i6yEH4s+M5E8X+swryMTIILtd3RLhbcc1Z58Awr8=;
        b=BluzLHRLfg9qBEZGf1GZv1fRguJa3Xp9QMLIYfHJBjFDqiUCc4bcFI6fzPwvaTy6FT
         QUSwGWZYt1ncVY0F+XI5fz61j8iJgy8sj4foiydLvfIxWxgasRaTNZ26sX9FFbU63C4T
         6A+3VkMR8JO5qniszDHVZtUzfKUVO/dHeH83B2lZHqVz5GCKrd0YNRec219bwhMlV0Bm
         7B09l0JoiIp28b/xmDaN2WQvAvEOZ/4OvqGizwtwg/X5624qPEOCL+6SJMrnUFAxMJ7T
         SmB04W5a7lq9mdLA23hncGNuZUA62Pi8wdbW4dh3v+MXCBxiA9J8VUyJ70xEMJgcQAc1
         yexA==
X-Gm-Message-State: AOAM533zk45hIWGNpBP9oKavQE0eqwypQCBHXuX5fs/q6G/pfqyFTXbU
        LWXheToOSXhL5eFNmu6eQZy3Cpn0KzUAxXtGpIlUqpTvG1M13Q6vGzyB7N9OkOIQ6aMv/69MQid
        /lajppNWoK9frVhXkEPj1
X-Received: by 2002:ac8:5851:0:b0:2e1:eba3:3beb with SMTP id h17-20020ac85851000000b002e1eba33bebmr11668452qth.20.1650400795238;
        Tue, 19 Apr 2022 13:39:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzckRvgt6B1An7pz2MEXn0TbK2Wm1H3XZZ3AES/0gGvujnt4yNK5IwR/sTDPYj1N7o2WJWRBA==
X-Received: by 2002:ac8:5851:0:b0:2e1:eba3:3beb with SMTP id h17-20020ac85851000000b002e1eba33bebmr11668437qth.20.1650400794935;
        Tue, 19 Apr 2022 13:39:54 -0700 (PDT)
Received: from [172.31.1.6] ([71.168.80.171])
        by smtp.gmail.com with ESMTPSA id u13-20020a05622a010d00b002f0c6664db1sm557000qtw.49.2022.04.19.13.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 13:39:54 -0700 (PDT)
Message-ID: <d147ea7e-6504-4b23-fa82-e9f9a0fa7de5@redhat.com>
Date:   Tue, 19 Apr 2022 16:39:53 -0400
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
 <af22ce3e-2cc0-b32a-87da-204360cd1b4a@redhat.com>
 <Yl8T3Y5adggNfwa2@eldamar.lan>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <Yl8T3Y5adggNfwa2@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/19/22 3:56 PM, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Tue, Apr 19, 2022 at 03:17:45PM -0400, Steve Dickson wrote:
>> Hey!
>>
>> Sorry for the delay...
>>
>> On 4/17/22 4:21 AM, Salvatore Bonaccorso wrote:
>>> Hi Steve,
>>>
>>> On Tue, Apr 12, 2022 at 09:25:28PM +0200, Salvatore Bonaccorso wrote:
>>>> Hi Steve,
>>>>
>>>> On Tue, Apr 12, 2022 at 10:28:50AM -0400, Steve Dickson wrote:
>>>>> Hello,
>>>>>
>>>>> On 4/12/22 3:00 AM, Salvatore Bonaccorso wrote:
>>>>>
>>>>> My mailer was unable to process the attachment
>>>>> Please in-line the patch and resend it.
>>>>
>>>> That is very strange, I used git send-email to submit it, and I do not
>>>> see where it got mangled, as it is present as well in
>>>>
>>>> https://lore.kernel.org/linux-nfs/20220412070016.720489-1-carnil@debian.org/
>>>>
>>>> Any idea what happened?
>>>>
>>>> Here it is again, inlined in this message.
>>>>
>>>> Regards,
>>>> Salvatore
>>>>
>>>>   From da390ced58885b0ed80be3722d4d913909e7c543 Mon Sep 17 00:00:00 2001
>>>> From: Ben Hutchings <benh@debian.org>
>>>> Date: Mon, 14 Mar 2022 00:19:33 +0100
>>>> Subject: [PATCH] nfsidmap.man: Fix section number
>>>>
>>>> The nfsidmap manual page is supposed to be in section 8, but calls the
>>>> .TH macro with a section argument of 5.  This results in an incorrect
>>>> header and causes debhelper (in Debian) to install it in the section 5
>>>> directory. Fix that.
>>>>
>>>> Signed-off-by: Ben Hutchings <benh@debian.org>
>>>> [Salvatore Bonaccorso: Slightly modify commit message to mention that
>>>> the Problem is found in Debian through installing the manpage via
>>>> debhelper]
>>>> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
>>>> ---
>>>>    utils/nfsidmap/nfsidmap.man | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/utils/nfsidmap/nfsidmap.man b/utils/nfsidmap/nfsidmap.man
>>>> index 2af16f3157ff..1911c41be6f9 100644
>>>> --- a/utils/nfsidmap/nfsidmap.man
>>>> +++ b/utils/nfsidmap/nfsidmap.man
>>>> @@ -2,7 +2,7 @@
>>>>    .\"@(#)nfsidmap(8) - The NFS idmapper upcall program
>>>>    .\"
>>>>    .\" Copyright (C) 2010 Bryan Schumaker <bjschuma@netapp.com>
>>>> -.TH nfsidmap 5 "1 October 2010"
>>>> +.TH nfsidmap 8 "1 October 2010"
>>>>    .SH NAME
>>>>    nfsidmap \- The NFS idmapper upcall program
>>>>    .SH SYNOPSIS
>>>> -- 
>>>> 2.35.1
>>>
>>> Was this version now correctly processed by your mailer?
>> Yeah I got it... thanks... but...
>> Are you saying that this man page should be in chapter 5
>> or it is fact Debian installs into chapter 5?
>>
>> In RHEL and Fedora we install it in chapter 8... If it
>> belongs in a different chapter I have no problem changing
>> it... I just need to know why.
> 
> Apologies, so this was apparently not very clear. That it belongs into
> section 8 is right. Debian installed it into the wrong section because
> the section in the manpage itself refers to 5. This is what the patch
> tries to inline, and fix the wrong argument to the .TH macro.
> 
> Because the manpage incorrectly calls the .TH macro with a section
> argument of 5 the debhelper program in Debian installs the manpage
> into section 5.
> 
> Does this clarifies?Yes it does... Thank you!

Committed... (re-tagged: nfs-utils-2-6-2-rc4)

steved.

