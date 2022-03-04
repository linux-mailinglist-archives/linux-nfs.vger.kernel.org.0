Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304044CD85C
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Mar 2022 16:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiCDPz3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Mar 2022 10:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiCDPz2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Mar 2022 10:55:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFC201BBF59
        for <linux-nfs@vger.kernel.org>; Fri,  4 Mar 2022 07:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646409280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aG4rLtP2kJb2yp237WIgfka/xS4Ld0GgBvfRU9ske9M=;
        b=VzM9XosZHraC2lRGuuqenU/IGGQJuJb9fjGwrei2FvuG1PWTjD9SNCumTa5Cdxc4MuinHA
        EzQsKN211gVxY6rFOXoS5wpI5fuiicwOpFAAqxogrvJxpvJqCiXOEcy2lgTOEHj5oP63MC
        zNG94wsZFF8rTyELMivzSGalvDGpK18=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-KDi-fZrINB6DGEtsaNk9Kw-1; Fri, 04 Mar 2022 10:54:39 -0500
X-MC-Unique: KDi-fZrINB6DGEtsaNk9Kw-1
Received: by mail-qk1-f200.google.com with SMTP id c19-20020a05620a0cf300b005f17891c015so5788193qkj.18
        for <linux-nfs@vger.kernel.org>; Fri, 04 Mar 2022 07:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aG4rLtP2kJb2yp237WIgfka/xS4Ld0GgBvfRU9ske9M=;
        b=myrhr3X00yqWGqIXFwcvXT3VUP+pLPqMRkzGPB86QrZLYuIEAB2xgRIW/ilA/G/h9y
         r7HVM483czeIkMaLn1jlnt+s+ZEpDqI6+ZGjRsMI03kA/BLJFtPUy3RukmbUztPu+Zxl
         iusa58N7pKHlGpwn//2tBoOc+8rH7JU3B88KSznece0+fJ4Jd1ikcwFfT88VVKpp95Rz
         ys8gE5mKEnImML+BlJ5jMpEJ9ZGPnc9E+070IkawDJKqEuXD3zvc1RD1sm0s33ZnoXDf
         5gbU+plFgIQaeJ59xfAGyqjGXffqxRmlweFIKv0P1ZNuSRZSrym/SsKWoEVYd0WG460n
         sHSg==
X-Gm-Message-State: AOAM532jb3jgPb90skkEcnsQC31WFOscAtcm4oAI2xQWXyJ8ONrH94up
        7qMktAe66hSlpsXoU68YbOx+on2D1x7LLbZxaJd95ZFTDWJJgpK+3xqQP77X/S1iIt7qS2yA6R1
        HgDy5T0huMJRKKvZO0KdM
X-Received: by 2002:a37:f518:0:b0:663:a53:8a5b with SMTP id l24-20020a37f518000000b006630a538a5bmr2939778qkk.546.1646409278540;
        Fri, 04 Mar 2022 07:54:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHytsLHgci5aOOX83ZcFpxyVV1zx+k7tk6T9y4CIhGmGy3+X1KiIKFct2ueRT+jlaSVIs5Vg==
X-Received: by 2002:a37:f518:0:b0:663:a53:8a5b with SMTP id l24-20020a37f518000000b006630a538a5bmr2939762qkk.546.1646409278299;
        Fri, 04 Mar 2022 07:54:38 -0800 (PST)
Received: from [172.31.1.6] ([71.161.196.139])
        by smtp.gmail.com with ESMTPSA id i20-20020ac85c14000000b002de4b6004a7sm3605612qti.27.2022.03.04.07.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 07:54:38 -0800 (PST)
Message-ID: <3d4467af-e6f7-694b-e711-6fafb6490fc8@redhat.com>
Date:   Fri, 4 Mar 2022 10:54:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
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
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <164635642445.13165.9587906660448735526@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hey!

On 3/3/22 8:13 PM, NeilBrown wrote:
> On Fri, 04 Mar 2022, Trond Myklebust wrote:
>> On Thu, 2022-03-03 at 14:26 +1100, NeilBrown wrote:
>>> On Wed, 02 Mar 2022, Chuck Lever III wrote:
>>>
>>>
>>>>
>>>>
>>>> The remaining part of this text probably should be
>>>> part of the man page for Ben's tool, or whatever is
>>>> coming next.
>>>
>>> My position is that there is no need for any tool.  The total amount
>>> of
>>> code needed is a couple of lines as presented in the text below.  Why
>>> provide a wrapper just for that?
>>> We *cannot* automatically decide how to find a name or where to store
>>> a
>>> generated uuid, so there is no added value that a tool could provide.
>>>
>>> We cannot unilaterally fix container systems.  We can only tell
>>> people
>>> who build these systems of the requirements for NFS.
>>>
>>
>> I disagree with this position. The value of having a standard tool is
>> that it also creates a standard for how and where the uniquifier is
>> generated and persisted.
>>
>> Otherwise you have to deal with the fact that you may have a systemd
>> script that persists something in one file, a Dockerfile recipe that
>> generates something at container build time, and then a home-made
>> script that looks for something in a different location. If you're
>> trying to debug why your containers are all generating the same
>> uniquifier, then that can be a problem.
> 
> I don't see how a tool can provide any consistency.
> Is there some standard that say how containers should be built, and
> where tools can store persistent data?  If not, the tool needs to be
> configured, and that is not importantly different from bash being
> configured with a 1-line script to write out the identifier.
> 
> I'm not strongly against a tools, I just can't see the benefit.
I think I agree with this... Thinking about it... having a command that
tries to manipulate different containers in different ways just
seems like a recipe for disaster... I just don't see how a command would
ever get it right... Hell we can't agree on its command's name
much less what it will do. :-)

So I like idea of documenting when needs to happen in the
different types of containers... So I think the man page
is the way to go... and I think it is the safest way to go.

Chuck, if you would like tweak the verbiage... by all means.

Neil, will be a V2 for man page patch from this discussion
or should I just take the one you posted? If you do post
a V2, please start a new thread.

steved.

