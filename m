Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA2065AD78
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 07:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjABGei (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 01:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjABGeh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 01:34:37 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59DDD42
        for <linux-nfs@vger.kernel.org>; Sun,  1 Jan 2023 22:34:33 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 79FDF5C0115;
        Mon,  2 Jan 2023 01:34:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 02 Jan 2023 01:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1672641271; x=
        1672727671; bh=U2qH7gJ2oF2yEUD2Wf4Pa7XzCkdZPzY6QV9Q8IaIqoQ=; b=B
        XfX/Z1r3I6wbW3+0Z9gwb7SO813tMmHPxJBR7adFQpiM+KXdT2t3/AwsgNKgzIiz
        2+ZF+fxgB4Lp32Wy9/sbbozRPFnfJ2NbZ3iAqikYZeOYQgJe0DfGW9L/DcDKdJDn
        XpO+PJiBFjzhnIH8Yv7PsPCL61Wgg8mzjFGEGjLUz1VBbzPxXRKPyK0hRiMgkKKV
        THIQY8SFYx4/fG5cp8TufqGQ518crSXRHPgGaJ9vkg6k95QxuqVUkjoEAPyR+ANA
        TFcc2guxFQnxP8Xk6G4gCDj7pX77pYMcHtFHTE38tf+Xgczd3bpwgfB2HtDGLxSW
        1A5IhyEIUoL9aeQ7uILSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672641271; x=
        1672727671; bh=U2qH7gJ2oF2yEUD2Wf4Pa7XzCkdZPzY6QV9Q8IaIqoQ=; b=n
        FTQU9OZ6B6OM7lh38R56C1aj3dYw7xHEPS5NnOwaJPw0NIaNgfbXUHwoU84VS6Nt
        eP/LwjwuPNbEz0LZy25a4oLv8vFtF+7SgnPiKb1bQbjiwPp3w6gU5keOUwzjtrGf
        m9DmRdpJu6fLi7qF6pmtTUdAUaWhnLMQxgH/4Oii93j4y32M1pbjn39mFTLR3hus
        anghhJqkzHkkv4Rr5RMQrng6IJgNb9X2dWWzxaRQ7Mqw4mUaoup9TovymPpOq67G
        UaJ0U5EEEw3YE6oB0jvZmmyUmePUq9CrFxc0lyfI34ZRw7e7KbrKj8v/YQBkW2li
        od9bhSrPy+H49mXxvpFLw==
X-ME-Sender: <xms:9nqyYzc3aZP4nrJ66DGjh8cV8TnaOWliwZ30xmmcqXnjmwdlZXUpOQ>
    <xme:9nqyY5MIEiy0OGgtNFoldzyp6P8nkKCIl7d14vfWhWvDrDKh2d4MvWJBwfZtRLKGi
    pyWKNbbxVB8>
X-ME-Received: <xmr:9nqyY8gQRlDzuc06PYfzjTho_hiunmHfccD0XCKyVRVmB1GzWlNyFuLjgyAjYjDar6EphnEktTwBXspOci1rj2h4_LyKz2tGWXNKdBibw2jHz_lLgmke>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedugdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:9nqyY09BLE4NwLZKkbbbTonk1yRJJCj43-SZTgr2_Tem3UkKFb5Xrg>
    <xmx:9nqyY_uMnP5sx-2HzhBGGXcquSw0YrRonO_IcnSyO2f4peNiABUBAQ>
    <xmx:9nqyYzElnDGePxtnHg2JoBkxmcg5YrKxJsbJUyp3FMxIco15yz9BZg>
    <xmx:93qyY_Kf9xRckLDLiQh5fJUcq1WBiQ54ILA5JIFZeZCLQaBy0vMB7Q>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 01:34:27 -0500 (EST)
Message-ID: <77ed2f3a-0fbb-ddec-6c93-2a7ea44f5f9f@themaw.net>
Date:   Mon, 2 Jan 2023 14:34:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] nfsd: fix handling of readdir in v4root vs. mount upcall
 timeout
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        JianHong Yin <yin-jianhong@163.com>,
        Richard Weinberger <richard@nod.at>
References: <20221213180826.216690-1-jlayton@kernel.org>
 <0918676C-124C-417F-B8DE-DA1946EE91CC@oracle.com>
 <988799bd54c391259cfeff002660a4002adb96d2.camel@kernel.org>
 <81f891ef-b498-24b0-12e3-4ddda8062dc0@themaw.net>
 <0d6deecbe0dff95ebbe061914ddb00ca04d1f3c1.camel@kernel.org>
 <b2593a91-0957-5203-b556-f93bdd2dc0dd@themaw.net>
 <940934D4-7896-4C0D-93F1-26170C49CBE4@oracle.com>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <940934D4-7896-4C0D-93F1-26170C49CBE4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/1/23 02:09, Chuck Lever III wrote:
>
>> On Dec 14, 2022, at 12:37 AM, Ian Kent <raven@themaw.net> wrote:
>>
>> On 14/12/22 08:39, Jeff Layton wrote:
>>> On Wed, 2022-12-14 at 07:14 +0800, Ian Kent wrote:
>>>> On 14/12/22 04:02, Jeff Layton wrote:
>>>>> On Tue, 2022-12-13 at 19:00 +0000, Chuck Lever III wrote:
>>>>>>> On Dec 13, 2022, at 1:08 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>>
>>>>>>> If v4 READDIR operation hits a mountpoint and gets back an error,
>>>>>>> then it will include that entry in the reply and set RDATTR_ERROR for it
>>>>>>> to the error.
>>>>>>>
>>>>>>> That's fine for "normal" exported filesystems, but on the v4root, we
>>>>>>> need to be more careful to only expose the existence of dentries that
>>>>>>> lead to exports.
>>>>>>>
>>>>>>> If the mountd upcall times out while checking to see whether a
>>>>>>> mountpoint on the v4root is exported, then we have no recourse other
>>>>>>> than to fail the whole operation.
>>>>>> Thank you for chasing this down!
>>>>>>
>>>>>> Failing the whole READDIR when mountd times out might be a bad idea.
>>>>>> If the mountd upcall times out every time, the client can't make
>>>>>> any progress and will continue to emit the failing READDIR request.
>>>>>>
>>>>>> Would it be better to skip the unresolvable entry instead and let
>>>>>> the READDIR succeed without that entry?
>>>>>>
>>>>> Mounting doesn't usually require working READDIR. In that situation, a
>>>>> readdir() might hang (until the client kills), but a lookup of other
>>>>> dentries that aren't perpetually stalled should be ok in this situation.
>>>>>
>>>>> If mountd is that hosed then I think it's unlikely that any progress
>>>>> will be possible anyway.
>>>> The READDIR shouldn't trigger a mount yes, but if it's a valid automount
>>>>
>>>> point (basically a valid dentry in this case I think) it should be listed.
>>>>
>>>> It certainly shouldn't hold up the READDIR, passing into it is when a
>>>>
>>>> mount should occur.
>>>>
>>>>
>>>> That's usually the behavior we want for automounts, we don't want mount
>>>>
>>>> storms on directories full of automount points.
>>>>
>>> We only want to display it if it's a valid _exported_ mountpoint.
>>>
>>> The idea here is to only reveal the parts of the namespace that are
>>> exported in the nfsv4 pseudoroot. The "normal" contents are not shown --
>>> only exported mountpoints and ancestor directories of those mountpoints.
>>>
>>> We don't want mountd triggering automounts, in general. If the
>>> underlying filesystem was exported, then it should also already be
>>> mounted, since nfsd doesn't currently trigger automounts in
>>> follow_down().
>> Umm ... must they already be mounted?
>>
>>
>> Can't it be a valid mount point either not yet mounted or timed out
>>
>> and umounted. In that case shouldn't it be listed, I know that's
>>
>> not the that good an outcome because its stat info will change when
>>
>> it gets walked into but it's usually the only sane choice.
>>
>>
>>> There is also a separate patchset by Richard Weinberger to allow nfsd to
>>> trigger automounts if the parent filesystem is exported with -o
>>> crossmnt. That should be ok with this patch, since the automount will be
>>> triggered before the upcall to mountd. That should ensure that it's
>>> already mounted by the time we get to upcalling for its export.
>> Yep, saw that, ;)
> I'm not sure if there is consensus on this patch.
>
> It's been pushed to nfsd's for-rc branch for wider testing, but if
> there's a strong objection I can pull it out before the next -rc PR.


I don't have any objections, my original comment about it breaking

existing behavior has been addressed.


The only reason I've commented further is because of my time with

automounting but, as Jeff kind-off points out nfsd is not quite the

same as what I'm used to, specifically the way exports are implemented

in nfsd.


Still you never know, my comments may trigger a thought in someone along

the way, ;)


Ian

