Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C45754BEB
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jul 2023 22:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjGOUFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jul 2023 16:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGOUFm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jul 2023 16:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6062B10E6
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jul 2023 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689451494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GFhV0yWbMTAtinBm1EaiQYStXkJmyEZjWsGY5dLmYTQ=;
        b=JA05vCP2BqAmN7Xw6nBS8klwkOrUyZikBN0x6N1tq2KR0PmcuaOtFETOkddhFI56cEiAqf
        Sv/u1x/CGl9R0Q0kfybhlSuy5V6Gw3pB3YyAzPSYjZMNd2XkytWy1AO05eLqCibHfP1yqf
        ciSO4/9iORJBOhYLEElJ7ATdSRhY+T4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-fl1uAAOBN4iJhVoLHj7sJg-1; Sat, 15 Jul 2023 16:04:53 -0400
X-MC-Unique: fl1uAAOBN4iJhVoLHj7sJg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4034b144d3bso7705931cf.0
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jul 2023 13:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689451492; x=1690056292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFhV0yWbMTAtinBm1EaiQYStXkJmyEZjWsGY5dLmYTQ=;
        b=KRTPJ9PkVS7tW7uMvd6HWwRTO/Rq6s2F+fQVuw6X2zZKyCxpT3q8rtruRNtuOugXfG
         bgJGDsfbqPcQidf/W4TxxkNj1w4XAW6QKOErOz2jIY0FH6EJy0d/s8UB9UTlb7TwRzk5
         mbKSq5oBUXPuyeFWbDuuJ6SJ3pTE/CZdNNUOxW6J85mJNZus0maQu5osR5pynC79EENj
         7CAhK8pqrNbb9w48i1bdQtnPckdQ1qDhBSDt+xNG35ZImGP79mwaru/8/pikEKpUEEaS
         2ni/Af+llwL1+5cKcAlXaE2KLuSk8A0o8MATYQORdBdV36PdXH2qjIOJqYXrBcJAGo4+
         ZV5Q==
X-Gm-Message-State: ABy/qLZI3q9NORlI9sMCu2uEx5Qs0BLAbMwxo2syT/wvUGle7nYOfLIj
        N819M2neQE/jvHZEdPQWToyGJQp15iXd7Bxl6xIECphCFx0Z6lcgOuev9rqJwFKL4vZ4uXd/Fof
        pzn6ycZXl3/L7dMoaP8KX0ydxPECP
X-Received: by 2002:a05:622a:1a89:b0:3f6:a8e2:127b with SMTP id s9-20020a05622a1a8900b003f6a8e2127bmr3951725qtc.5.1689451492526;
        Sat, 15 Jul 2023 13:04:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEg5e0gNokhi9NiwAdJSJVUIbBlVqUeIMsok5PYv56S8Q2YLiIiOZUgraejYYH2WGR83UJVLg==
X-Received: by 2002:a05:622a:1a89:b0:3f6:a8e2:127b with SMTP id s9-20020a05622a1a8900b003f6a8e2127bmr3951707qtc.5.1689451492213;
        Sat, 15 Jul 2023 13:04:52 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.31])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87318000000b00402364e77dcsm5056619qto.7.2023.07.15.13.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 13:04:51 -0700 (PDT)
Message-ID: <f656bc22-caf6-1068-b284-91da258227c0@redhat.com>
Date:   Sat, 15 Jul 2023 16:04:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] nfs(5): Document the new "xprtsec=" mount option
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>
References: <168935977873.1850.8214830433103692090.stgit@bazille.1015granger.net>
 <a6e861a1-1609-11fc-219c-88dd8d90b526@redhat.com>
 <697F49D8-938A-426D-A4DF-8077247AE90E@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <697F49D8-938A-426D-A4DF-8077247AE90E@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/15/23 2:53 PM, Chuck Lever III wrote:
> 
> 
>> On Jul 15, 2023, at 2:07 PM, Steve Dickson <SteveD@redhat.com> wrote:
>>
>> Hey!
>>
>> On 7/14/23 2:36 PM, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>> More information about RPC-with-TLS and some brief set-up guidance
>>> are to be provided in a separate man page in Section 7.
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Question: commit b5e4539f already add this RPC-with-TLS
>> update to the man page. So do you want me to revert b5e4539f
>> and replace it with this patch?
> 
> Hrm, I didn't remember sending you a client-side man page update.
> I thought I was waiting for the in-kernel parts of the client
> TLS work to land, which they've done now in v6.5-rc.
> 
> If it's no trouble, go ahead and replace that one.
Not a problem... I'll make it work....

steved.
> 
> 
>> steved.
>>
>>> ---
>>>   utils/mount/nfs.man |   38 +++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 37 insertions(+), 1 deletion(-)
>>> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
>>> index d9f34df36b42..dfc31a5dad26 100644
>>> --- a/utils/mount/nfs.man
>>> +++ b/utils/mount/nfs.man
>>> @@ -574,7 +574,43 @@ The
>>>   .B sloppy
>>>   option is an alternative to specifying
>>>   .BR mount.nfs " -s " option.
>>> -
>>> +.TP 1.5i
>>> +.BI xprtsec= policy
>>> +Specifies the use of transport layer security to protect NFS network
>>> +traffic on behalf of this mount point.
>>> +.I policy
>>> +can be one of
>>> +.BR none ,
>>> +.BR tls ,
>>> +or
>>> +.BR mtls .
>>> +.IP
>>> +If
>>> +.B none
>>> +is specified,
>>> +transport layer security is forced off, even if the NFS server supports
>>> +transport layer security.
>>> +If
>>> +.B tls
>>> +is specified, the client uses RPC-with-TLS to provide in-transit
>>> +confidentiality.
>>> +If
>>> +.B mtls
>>> +is specified, the client uses RPC-with-TLS to authenticate itself and
>>> +to provide in-transit confidentiality.
>>> +If either
>>> +.B tls
>>> +or
>>> +.B mtls
>>> +is specified and the server does not support RPC-with-TLS or peer
>>> +authentication fails, the mount attempt fails.
>>> +.IP
>>> +If the
>>> +.B xprtsec=
>>> +option is not specified,
>>> +the default behavior depends on the kernel version,
>>> +but is usually equivalent to
>>> +.BR "xprtsec=none" .
>>>   .SS "Options for NFS versions 2 and 3 only"
>>>   Use these options, along with the options in the above subsection,
>>>   for NFS versions 2 and 3 only.
>>
>>
> 
> --
> Chuck Lever
> 
> 

