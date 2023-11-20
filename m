Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61E77F182F
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 17:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjKTQJQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 11:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKTQJN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 11:09:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BAF100
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 08:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700496548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Spiqq2OL+vnRzgcrZCHUUFIJjFBih8BTqYCaDysHueY=;
        b=b6V4E+dw4o7h2e2nPgI5AeoJjvb1B+NayAJ0gh4o3BMxLgvf75z4F1gjDtIObnD4mspDjv
        tzHgBCrqrN/brrxqOq/EUizqoVvchBkEQywpub+WmrmcQPLUcxURYS1YZpNeA4Y0bRSyMW
        xS+Bt9ItUgv0xbKB7tLxLhn7RKSPLXw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-r8n0efjUPweyOWrPLQybVg-1; Mon, 20 Nov 2023 11:09:03 -0500
X-MC-Unique: r8n0efjUPweyOWrPLQybVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 621C9101A550;
        Mon, 20 Nov 2023 16:09:03 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9139F1C060AE;
        Mon, 20 Nov 2023 16:09:02 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        steved@redhat.com
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Date:   Mon, 20 Nov 2023 11:09:01 -0500
Message-ID: <C8F0DC72-BBB0-4D2C-A4DF-770B65CE0FAF@redhat.com>
In-Reply-To: <ec326d7e13d12c02fabf8a5fe46f2ad8bf66d368.camel@hammerspace.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
 <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
 <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
 <35ffafefb1596f4941513bc8dd51470fbee842d4.camel@hammerspace.com>
 <F12175F2-9CA3-4C6A-9089-BF5E62A196D0@oracle.com>
 <ec326d7e13d12c02fabf8a5fe46f2ad8bf66d368.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 19 Nov 2023, at 21:03, Trond Myklebust wrote:

> On Mon, 2023-11-20 at 01:07 +0000, Chuck Lever III wrote:
>>
>>
>>> On Nov 19, 2023, at 7:16 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>
>>> On Sat, 2023-11-18 at 15:45 -0500, Steve Dickson wrote:
>>>>
>>>>
>>>> On 11/18/23 12:03 PM, Chuck Lever III wrote:
>>>>>
>>>>>> On Nov 18, 2023, at 11:49 AM, Trond Myklebust
>>>>>> <trondmy@hammerspace.com> wrote:
>>>>>>
>>>>>> On Sat, 2023-11-18 at 16:41 +0000, Chuck Lever III wrote:
>>>>>>>
>>>>>>>> On Nov 18, 2023, at 1:42 AM, Cedric Blancher
>>>>>>>> <cedric.blancher@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Fri, 17 Nov 2023 at 08:42, Cedric Blancher
>>>>>>>> <cedric.blancher@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> How owns bugzilla.linux-nfs.org?
>>>>>>>>
>>>>>>>> Apologies for the type, it should be "who", not "how".
>>>>>>>>
>>>>>>>> But the problem remains, I still did not get an account
>>>>>>>> creation
>>>>>>>> token
>>>>>>>> via email for *ANY* of my email addresses. It appears
>>>>>>>> account
>>>>>>>> creation
>>>>>>>> is broken.
>>>>>>>
>>>>>>> Trond owns it. But he's already showed me the SMTP log from
>>>>>>> Sunday night: a token was sent out. Have you checked your
>>>>>>> spam folders?
>>>>>>
>>>>>> I'm closing it down. It has been run and paid for by me, but
>>>>>> I
>>>>>> don't
>>>>>> have time or resources to keep doing so.
>>>>>
>>>>> Understood about lack of resources, but is there no-one who can
>>>>> take over for you, at least in the short term? Yanking it out
>>>>> without warning is not cool.
>>>>>
>>>>> Does this announcement include git.linux-nfs.org
>>>>> <http://git.linux-nfs.org/> and
>>>>> wiki.linux-nfs.org <http://wiki.linux-nfs.org/> as well?
>>>>>
>>>>> As this site is a long-time community-used resource, it would
>>>>> be fair if we could come up with a transition plan if it truly
>>>>> needs to go away.
>>>>
>>>> If you need resources and time... Please reach out...
>>>>
>>>> This is a community... I'm sure we can figure something out.
>>>> But please turn it back on.
>>>>
>>>
>>> So far, I've heard a lot of 'we should', and a lot of 'we could'.
>>>
>>> What I have yet to hear are the magic words "I volunteer to help
>>> maintain these services".
>>
>> I volunteer to help. I can do as much or as little as you prefer.
>> And I volunteer to lead an effort to either:
>>
>> a) find a replacement issue tracking service, or
>>
>> b) find a way to archive the content of the bugzilla if we agree
>> there is no more need for a bugzilla.linux-nfs.
>>
>> Or both.
>>
>> There is no way for us to know how much effort it takes if you
>> suffer in silence, my friend.
>
> The point is that email has evolved over the 18 years since I set up
> the very first linux-nfs.org. I have not had time to keep up with the
> requirements of adding support for DMARC, SPF, etc. which is why
> Cedric's account setup email is probably in his spam folder, assuming
> that the gmail server even accepted it at all.
>
> Furthermore, both the wikimedia and bugzilla instances are far from
> running the most recent code versions and I'm sure there are plenty of
> well known security holes etc to exploit. So both code bases have been
> needing an upgrade for a while now.
>
> Finally, the VM itself is still running RHEL/CentOS 7, and I'd like to
> see it migrated to a platform that is is still maintained.
>
> All these tasks would need help from the person (or people?) who
> volunteers to maintain the bugzilla + wiki services. Some of them would
> need to be 100% owned by that person, and others (like the platform
> upgrade) would need a lot of coordination with me.
>
> IOW: I'm not advocating either way. I can understand wanting to migrate
> away from the current setup to something that is maintained by someone
> else. However if anyone does wants to take on the job of helping to
> maintain the current setup, then they need to know that it will involve
> real work.

I'm late to this thread, but I also volunteer to help with this work.

The nfsv4.dev infra uses mailgun for SMTP delivery, the flex plan is free
for up to 1000 msg/month, +1$US for +1001, at $.001/msg.

Ben

