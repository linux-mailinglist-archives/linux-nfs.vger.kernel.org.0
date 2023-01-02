Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64B65AD83
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 07:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjABGl4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 01:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjABGlz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 01:41:55 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADAAD79
        for <linux-nfs@vger.kernel.org>; Sun,  1 Jan 2023 22:41:53 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E70345C0124;
        Mon,  2 Jan 2023 01:41:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 02 Jan 2023 01:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1672641712; x=
        1672728112; bh=2K/vdmP3tdzLm99zVd7TyRf64wKLxBJvBdRtnMOSevg=; b=L
        7WLSs5ZM7G8LrUWENS72dWC87ZVdKMK8Dyz2vvAYX1WYWs+ef7H3dX4FkDz0Vh5M
        q3iq2ZopUf9YAZLA+JvvxWEKtBDIC2Klx8WE7XHVA5pdnGxil6onPMS8YZTqxMdK
        h1viLvE7vn6Y4XE2uy+C7/UbDCzZ4PPF8cpqOqg+4qPd5nS65KmywvAJz1xdRvlN
        kGcl85xSHO+zU+lBI22PNQh6pL+47YTkPycrk/KMX4G1/dEFUvaBJheT4PsNtwp7
        iAK9CWRzzv8jrQ6ziyazDmsBdozch1AqSoCbngAejk3Bpg7GuCCqfYPNTB9e2IBN
        /7BgAychozM1g1UkjU2Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672641712; x=
        1672728112; bh=2K/vdmP3tdzLm99zVd7TyRf64wKLxBJvBdRtnMOSevg=; b=W
        MOKJ14Sj00FY0u62ztqH8d90MrdQNOem1yZNGAgKlb9IwZc1LHQ/50aW3hlHULDS
        +Yg7sq2lrQ1rg33GeXI4AtB9l9BHRQbfRmGauwTs0gu+1gSGi7JpxXLWpdMI0cSz
        a8vQXtO3ym9vAlOTP1rMGXNrCynXD8k54oeJTIJ06cjFPMmZ3SBuDejY+OAXP/CU
        UdfdOtt72dKlJ3/mhhe8QKMM8fChBh71L3HBjaq/B5JsuUU24ic4ZarudSzlJjb4
        Ck0z4nFc7G94cYt8X4ccKV2POZXOGMnrfKCJT+Nwi6TyWZ/1uy7CvMgX8EZIPGoz
        a4HB5+qPVMwD5KwtnnRMw==
X-ME-Sender: <xms:sHyyY9IWirE0uW9jqJMP3sODA2DRancRfR7l1BVCmdc0C-5I6ZwetA>
    <xme:sHyyY5J_2hXB4Wu0KfF12LHqkmqMlT3cM-WJ23yXKA9ei4fNXdndUoXu8Ha_Cf7I2
    ytrRIbujFXm>
X-ME-Received: <xmr:sHyyY1vVncpHoDInEjwfPtoS_2F6u7MpucH-WErbniq7PszJ1JGhrpxaH3J6cTk8-yqpNXnW_sCxX47nCkSEpoeo5BqFfR6O69zdIcSufG-m2LamZzJW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:sHyyY-YFq_Fmp7ZjHeAYcIcm0WAT1qlFgcX3oaip0MhiK8Rt7qyrig>
    <xmx:sHyyY0braa1iL4T561b-8ldJLKa__OTsnbPR7kDloirlysmlSJfI0A>
    <xmx:sHyyYyCt6BjODFVMp-QlBXWAqqRsSrypdTeSUO2bikm5i4Lc8I6oVA>
    <xmx:sHyyY8GWzYTw_VFjwtG71wpKMimLEva_0Ye51DEMkViSG3N3X9Vr7w>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 01:41:49 -0500 (EST)
Message-ID: <d214d283-a9dc-092e-2be5-ad847ecaf871@themaw.net>
Date:   Mon, 2 Jan 2023 14:41:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] nfsd: fix handling of readdir in v4root vs. mount upcall
 timeout
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
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
 <4fbce57518a3870e82411b31e026ffdd8ea1c98d.camel@kernel.org>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <4fbce57518a3870e82411b31e026ffdd8ea1c98d.camel@kernel.org>
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


On 2/1/23 05:16, Jeff Layton wrote:
> On Wed, 2022-12-14 at 13:37 +0800, Ian Kent wrote:
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
> Yes, it does need to already be mounted.
>
> The proposed kernel patches from Richard only trigger an automount if
> the parent mount is exported with -o crossmnt. I think this is necessary
> to avoid nfs client activity triggering automounts of filesystems that
> are not exported.

I'll be interested to see how this goes.


Over the years I've had a lot of difficulty with automount unwanted

mounting ...


Still nfsd exports are a bit like invisible dentry trees to the local

system aren't they ... so this situation is very different to what

I've worked on ...


Ian

>
>>> There is also a separate patchset by Richard Weinberger to allow nfsd to
>>> trigger automounts if the parent filesystem is exported with -o
>>> crossmnt. That should be ok with this patch, since the automount will be
>>> triggered before the upcall to mountd. That should ensure that it's
>>> already mounted by the time we get to upcalling for its export.
