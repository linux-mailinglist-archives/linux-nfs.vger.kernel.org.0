Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECA664C38D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Dec 2022 06:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiLNFhR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Dec 2022 00:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbiLNFhL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Dec 2022 00:37:11 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2862826AFA
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 21:37:10 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B37255C00B0;
        Wed, 14 Dec 2022 00:37:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Dec 2022 00:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1670996227; x=
        1671082627; bh=dqLeGFn3R9n+xYWNHy0ZAsHkVpD2FDp4GHaU/2qqnlo=; b=t
        OQc86KCmlJdfvcYD4efNRxGYcTDfHbrfGiYXPXXZJMQ+sgyyu6+AmWXH7HBsE4Pv
        S299jIhaCx5WGUoZ1nK62HklpzuW5V8aUgS+w2PKHztfgGJ6SeboNL+pYUKETHxl
        Vdpd5w2g7hgb2tt8ez8taJ6p8lGJc+L6yQmSka8t8XXFssT0M2g2czZYPxiz8t54
        3nRlNSR7BHIXs4vws6n5et5PViygL3qoMoy2zAeginEz+giRaqPbSJP78f7R0Nva
        +rheGy/j98FcHJmSSVXd9zdXvhsjKvp5zmRlZA0D1mIAyhU1o3JBMf6kg00kYT2K
        bk5DlXg9QbUVo7I4VlMBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670996227; x=
        1671082627; bh=dqLeGFn3R9n+xYWNHy0ZAsHkVpD2FDp4GHaU/2qqnlo=; b=C
        3ZiF4d++DDzCtUJOrAKZEkaL63jUxlORjNvTZnL+agcbZQ8pn5LK0W113m1IB8aJ
        AhkoWCnLQRPEClvqGELgWRzGTjWY3tbTJ5bBnbPiTkEcus9I0UZOfjWnNaZizPxA
        kykoFtDv6sHOesOGN4j/kbzeBt6gUvT1l/IYgRI7IgbhvZqJaX4+r9vtPK40rxou
        /hSPKaI2e+iHxqREV6Ay9Z2lRrNZFYFRsR+B8s6PZW3Dz42Zcx3mRi2r10mgvL/b
        Jnfv41Ws+C1lOJInvaZYC+2AnYf6wp24L0ZzgiJZuFvFSHY6n14cbD87PjUfRSJo
        4IrTid4eUsb2tQT/TBOnw==
X-ME-Sender: <xms:A2GZY0jqHp8uevzmVtY0gJaRITnh4ozJENDqm1EzuPb8miQfP_4A-A>
    <xme:A2GZY9CM_DhQ4EfzlpA3axSio0xXKN8jQU7gyMHSIAErE1AQtY96lwnhDlLfiTx3m
    862sa5F3I21>
X-ME-Received: <xmr:A2GZY8EsK1EDBFir4ANGR4Cb4k9IQJJiQfgBd6hp1uH5wun0iHluC46XicJRU_2xtwFrstZN9ztMYhMkSfzjZeit874AFMLrVvAqcEGB-7Fqbc09Ak_2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:A2GZY1TgZj53Cv_LWw3N5UBPrjuWVhzzk_e3KaESjs3F6juQGdsCig>
    <xmx:A2GZYxzADOFbGgeGYlSsCWiWH2cyg9_WVjrLDCjongdQQQ4GK8GJ2A>
    <xmx:A2GZYz6QvSnFV-opXBn8p0o76WCe9hnvv54KyiIoFzLaH1lNuefXFw>
    <xmx:A2GZY59_pF460axsmFIMb9lUpWaR6zc_jOqpQcCIAq8ISRpKLNL3ww>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 00:37:04 -0500 (EST)
Message-ID: <b2593a91-0957-5203-b556-f93bdd2dc0dd@themaw.net>
Date:   Wed, 14 Dec 2022 13:37:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
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
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <0d6deecbe0dff95ebbe061914ddb00ca04d1f3c1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 14/12/22 08:39, Jeff Layton wrote:
> On Wed, 2022-12-14 at 07:14 +0800, Ian Kent wrote:
>> On 14/12/22 04:02, Jeff Layton wrote:
>>> On Tue, 2022-12-13 at 19:00 +0000, Chuck Lever III wrote:
>>>>> On Dec 13, 2022, at 1:08 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>
>>>>> If v4 READDIR operation hits a mountpoint and gets back an error,
>>>>> then it will include that entry in the reply and set RDATTR_ERROR for it
>>>>> to the error.
>>>>>
>>>>> That's fine for "normal" exported filesystems, but on the v4root, we
>>>>> need to be more careful to only expose the existence of dentries that
>>>>> lead to exports.
>>>>>
>>>>> If the mountd upcall times out while checking to see whether a
>>>>> mountpoint on the v4root is exported, then we have no recourse other
>>>>> than to fail the whole operation.
>>>> Thank you for chasing this down!
>>>>
>>>> Failing the whole READDIR when mountd times out might be a bad idea.
>>>> If the mountd upcall times out every time, the client can't make
>>>> any progress and will continue to emit the failing READDIR request.
>>>>
>>>> Would it be better to skip the unresolvable entry instead and let
>>>> the READDIR succeed without that entry?
>>>>
>>> Mounting doesn't usually require working READDIR. In that situation, a
>>> readdir() might hang (until the client kills), but a lookup of other
>>> dentries that aren't perpetually stalled should be ok in this situation.
>>>
>>> If mountd is that hosed then I think it's unlikely that any progress
>>> will be possible anyway.
>> The READDIR shouldn't trigger a mount yes, but if it's a valid automount
>>
>> point (basically a valid dentry in this case I think) it should be listed.
>>
>> It certainly shouldn't hold up the READDIR, passing into it is when a
>>
>> mount should occur.
>>
>>
>> That's usually the behavior we want for automounts, we don't want mount
>>
>> storms on directories full of automount points.
>>
>
> We only want to display it if it's a valid _exported_ mountpoint.
>
> The idea here is to only reveal the parts of the namespace that are
> exported in the nfsv4 pseudoroot. The "normal" contents are not shown --
> only exported mountpoints and ancestor directories of those mountpoints.
>
> We don't want mountd triggering automounts, in general. If the
> underlying filesystem was exported, then it should also already be
> mounted, since nfsd doesn't currently trigger automounts in
> follow_down().

Umm ... must they already be mounted?


Can't it be a valid mount point either not yet mounted or timed out

and umounted. In that case shouldn't it be listed, I know that's

not the that good an outcome because its stat info will change when

it gets walked into but it's usually the only sane choice.


>
> There is also a separate patchset by Richard Weinberger to allow nfsd to
> trigger automounts if the parent filesystem is exported with -o
> crossmnt. That should be ok with this patch, since the automount will be
> triggered before the upcall to mountd. That should ensure that it's
> already mounted by the time we get to upcalling for its export.

Yep, saw that, ;)


Ian

