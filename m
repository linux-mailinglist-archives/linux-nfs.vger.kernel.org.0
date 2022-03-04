Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4387B4CD986
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Mar 2022 17:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbiCDQzr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Mar 2022 11:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiCDQzq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Mar 2022 11:55:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8479BDE61
        for <linux-nfs@vger.kernel.org>; Fri,  4 Mar 2022 08:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646412893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xzb3causaHluykq1L85onNxEZIaPDq527lHgKpHojQ4=;
        b=RLk5NN1PVNi+47XE33lbPJ8DmR8fP8vz8v0ZAHFxF5PqZKTwGwRPHCVnEtW7RoArXF+ox/
        Xp1yt6ZhkF82UKQETo5DRfmOtogdnPzpAgLxz2aM2w7MdGQ/vFVXlTea+/KL2g5tAIowe4
        rcWfmpD58nkFpuglLwqfFWkNXl1nqCs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-Z0AxleaAMtq0ceNrlLpGlw-1; Fri, 04 Mar 2022 11:54:51 -0500
X-MC-Unique: Z0AxleaAMtq0ceNrlLpGlw-1
Received: by mail-qk1-f200.google.com with SMTP id f17-20020a05620a069100b0060dfbbb52cfso5970904qkh.1
        for <linux-nfs@vger.kernel.org>; Fri, 04 Mar 2022 08:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xzb3causaHluykq1L85onNxEZIaPDq527lHgKpHojQ4=;
        b=DsRoZDQPa0kN1dwB0YbVGfnfmsRCSCvKFcl9D9Iijt4/G37SZ5EW+yX+fULesLBYy4
         iL3wLJrQ2wDu5o+nNGLUVJXHwnyavK8sico0yGSYluydj/1FmbyY7OVwBnayITn4dVfp
         gygTfZ/EIPRl5f2Iq/G5i4OauMaCtNiznMz1BiG5x8zBckQ4INacL9DuT5VIWCj+3Gwi
         RCGmGZCA+hGqROMQQuKJf173DtDH+mFLhl4sb5OkMbMltiNn9IG1j6FTVBJaNFGn1feL
         UJuZVBwSpmuglO35Qq/sly4pHez6MlKPUiyBLNejREQwLs+SiI1Wo9sbkkrDS741CzNR
         MIrA==
X-Gm-Message-State: AOAM533u7/cPlbS6Ugr/kXJ8orwV8pAsJd5h7nFq35uLgG4hM8Og/37m
        bqAJdXSk9fJCCnkfNxmZ1hXcjdarzW+NA8hEwuj7d9LMYMelsTo0spyGBYvhw4tyyeAXdu0fHWl
        C/Q8a13NgA5D0OJNLnihL
X-Received: by 2002:a37:9dd6:0:b0:662:ef54:5647 with SMTP id g205-20020a379dd6000000b00662ef545647mr3078016qke.636.1646412891274;
        Fri, 04 Mar 2022 08:54:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcKXbroCr3KKB/yS2/nxzaYHade1j0DLebLa3WwiZli/krM/KnZyCEkAs6RhfFGSKhXhbMdw==
X-Received: by 2002:a37:9dd6:0:b0:662:ef54:5647 with SMTP id g205-20020a379dd6000000b00662ef545647mr3078001qke.636.1646412891000;
        Fri, 04 Mar 2022 08:54:51 -0800 (PST)
Received: from [172.31.1.6] ([71.161.196.139])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm2587687qkc.73.2022.03.04.08.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 08:54:50 -0800 (PST)
Message-ID: <013e65dd-e072-e86d-8bad-c6058fbd86fe@redhat.com>
Date:   Fri, 4 Mar 2022 11:54:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>
 <164505339057.10228.4638327664904213534@noble.neil.brown.name>
 <164610623626.24921.6124450559951707560@noble.neil.brown.name>
 <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>
 <164627798608.17899.14049799069550646947@noble.neil.brown.name>
 <fe1527f96f5b8f6280b24985603bbf99cde58864.camel@hammerspace.com>
 <164635642445.13165.9587906660448735526@noble.neil.brown.name>
 <3d4467af-e6f7-694b-e711-6fafb6490fc8@redhat.com>
 <C534D3E3-C706-4128-B05A-9131207EEAAE@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <C534D3E3-C706-4128-B05A-9131207EEAAE@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/4/22 11:15 AM, Chuck Lever III wrote:
> 
> 
>> On Mar 4, 2022, at 10:54 AM, Steve Dickson <steved@redhat.com> wrote:
>>
>> Hey!
>>
>> On 3/3/22 8:13 PM, NeilBrown wrote:
>>> On Fri, 04 Mar 2022, Trond Myklebust wrote:
>>>> On Thu, 2022-03-03 at 14:26 +1100, NeilBrown wrote:
>>>>> On Wed, 02 Mar 2022, Chuck Lever III wrote:
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> The remaining part of this text probably should be
>>>>>> part of the man page for Ben's tool, or whatever is
>>>>>> coming next.
>>>>>
>>>>> My position is that there is no need for any tool.  The total amount
>>>>> of
>>>>> code needed is a couple of lines as presented in the text below.  Why
>>>>> provide a wrapper just for that?
>>>>> We *cannot* automatically decide how to find a name or where to store
>>>>> a
>>>>> generated uuid, so there is no added value that a tool could provide.
>>>>>
>>>>> We cannot unilaterally fix container systems.  We can only tell
>>>>> people
>>>>> who build these systems of the requirements for NFS.
>>>>>
>>>>
>>>> I disagree with this position. The value of having a standard tool is
>>>> that it also creates a standard for how and where the uniquifier is
>>>> generated and persisted.
>>>>
>>>> Otherwise you have to deal with the fact that you may have a systemd
>>>> script that persists something in one file, a Dockerfile recipe that
>>>> generates something at container build time, and then a home-made
>>>> script that looks for something in a different location. If you're
>>>> trying to debug why your containers are all generating the same
>>>> uniquifier, then that can be a problem.
>>> I don't see how a tool can provide any consistency.
> 
> It seems to me that having a tool with its own man page directed
> towards Linux distributors would be the central place for this
> kind of configuration and implementation. Otherwise, we will have
> to ensure this is done correctly for each implementation of
> mount.
> 
> 
>>> Is there some standard that say how containers should be built, and
>>> where tools can store persistent data?  If not, the tool needs to be
>>> configured, and that is not importantly different from bash being
>>> configured with a 1-line script to write out the identifier.
> 
> IMO six of one, half dozen of another. I don't see this being
> any more or less safe than changing each implementation of mount
> to deal with an NFS-specific setting.
> 
> 
>>> I'm not strongly against a tools, I just can't see the benefit.
>> I think I agree with this... Thinking about it... having a command that
>> tries to manipulate different containers in different ways just
>> seems like a recipe for disaster... I just don't see how a command would
>> ever get it right... Hell we can't agree on its command's name
>> much less what it will do. :-)
> 
> To be clear what you are advocating, each implementation of mount.nfs,
> including the ones that are not shipped with nfs-utils (like Busybox
> and initramfs) will need to provide a mechanism for setting the client
> uniquifier. Just to confirm that is what is behind door number one.
Well I can't speak for mount.nfs that are not in nfs-utils.
I'm assuming they are going to do... what are going to do...
regardless of what we do. At least we will give them a
guideline of what needs to be done.


> 
> Since it is just a line or two of code, it might be of little
> harm just to go with separate implementations for now and stop
> talking about it. If it sucks, we can fix the suckage.
Right I see documenting what needs to happen is the
first step. Heck don't we even know how accurate that
documentation is... yet! Once we vet the doc to make
sure it is accurate... Maybe then we could come up
with a auto-configuration solution that has been
proposed.

> 
> Who volunteers to implement this mechanism in mount.nfs ?Well, there has been 3 implementations shot down
which tells me, as a community, we need to get
more of an idea of what needs to happen and how.
That's why I think Neil's man page additions
is a good start.

> 
> 
>> So I like idea of documenting when needs to happen in the
>> different types of containers... So I think the man page
>> is the way to go... and I think it is the safest way to go.
>>
>> Chuck, if you would like tweak the verbiage... by all means.
> 
> I stand ready.
That I have confidence in. :-) Thank you!

steved.
> 
> 
>> Neil, will be a V2 for man page patch from this discussion
>> or should I just take the one you posted? If you do post
>> a V2, please start a new thread.
>>
>> steved.
> 
> --
> Chuck Lever
> 
> 
> 

