Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED1864C054
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Dec 2022 00:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiLMXOo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 18:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbiLMXOm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 18:14:42 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007D064F1
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 15:14:41 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6FD825C00EE;
        Tue, 13 Dec 2022 18:14:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 13 Dec 2022 18:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1670973279; x=
        1671059679; bh=LI3AhddGkLiDgMeuN1rs+FPChtQCCHR5VbC+o5/ay24=; b=n
        0vv843uqRS/dmP5+A0dL3H3ATzk3D3/Vxyu/JJNXED/jliML/sM1lgAJpg25Rghs
        0EKhgHgECNeCHGYv7qlGC88WWwWcenrcI087ANBsdqmJ99CYB48JASUuOmEKzqWe
        GUoZDlF5bvxJhl+leDlJtfl4Ip2f/PEjahUg5T46dO3Wi1NjKtuOw1qcHuz0NXY1
        TMzJ54XDfI5RQOUDdXOWcQ+PIp6LFSt2zjCZXNY/gIIJxZMMRGInEAxYZOffmbzo
        6xgpKqUlKtZeBNTtn5aK8P6ZHXSynNmx2+3cfcXf3AnIHz5jNcPjygpgAFCQeJsU
        OBC2D03XEgu8BeFCYE+2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670973279; x=
        1671059679; bh=LI3AhddGkLiDgMeuN1rs+FPChtQCCHR5VbC+o5/ay24=; b=w
        rzV4u6iLDVgNoQZdYOtmpZCLpNBfPsKaJQXpUh4s+6XpehsZ4whpMQ7/7/XP4SVY
        /FU5jf3u8UekZ74sCF6Y5pwE9slzSM6qdh2UcpKeRuXlIaGCTlhatPMGXdTnvh6R
        ZWowV8HyjyG6ON6cWJtLJS77zCyOv11dgRqlWz9nXzLQyjFrJg14Pay7kv7O1dYp
        2ol1TeQEMjF6J56VH7aRnREWmHA54Oa5PdJaAXBCZ16y8W8zniVncrOR1SGnHehU
        5LpWXNYxBwFo1N8Pz/84fveMx+FaznlOeoCTq0isQa8DiSJAM+R9xysDDWDBxzsY
        XEbLAxtrqIP9Ro9VG0Z5g==
X-ME-Sender: <xms:XweZYwtVwlvi8kM3SW8W8ZM94-d_hyIkQ6xuiUZbk7BcYtPc0u9Chg>
    <xme:XweZY9czQOItXrGm7qZ_b0h3BZnunba4RKjRrpjrt1G1P0_5uOtyRiWqTQAEx67AN
    dD4ulb-y-fi>
X-ME-Received: <xmr:XweZY7yUfTfsfSwzuzyX4dDTi7HxF0ldIRnRVwV0UATFaW1Dg-Bjfiaqbny0urB2y9Oefl2pNM9E_JTxlorHvGh9Mh8Sq3YlT-n9lcppLgYkmMV4Q4J2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:XweZYzOoTN5bbNeM-Fb8xouNeflsCfeyKbfppYzRfSxpOJHEKmll8A>
    <xmx:XweZYw80CQtyxL9MAc6kCNcyaK5K2ZctkNNZh7lRGNyThIOa65svjA>
    <xmx:XweZY7VAa3hzHwG_-78fCVxvcXoCgFU0xP4C7g5geU0zEIetMEJ1Kg>
    <xmx:XweZYyIUe7fMcRD2CCsE2i5VHNizGeZdA4ZeNNeeUo9qH2fQavm0yQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Dec 2022 18:14:36 -0500 (EST)
Message-ID: <81f891ef-b498-24b0-12e3-4ddda8062dc0@themaw.net>
Date:   Wed, 14 Dec 2022 07:14:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] nfsd: fix handling of readdir in v4root vs. mount upcall
 timeout
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        JianHong Yin <yin-jianhong@163.com>
References: <20221213180826.216690-1-jlayton@kernel.org>
 <0918676C-124C-417F-B8DE-DA1946EE91CC@oracle.com>
 <988799bd54c391259cfeff002660a4002adb96d2.camel@kernel.org>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <988799bd54c391259cfeff002660a4002adb96d2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 14/12/22 04:02, Jeff Layton wrote:
> On Tue, 2022-12-13 at 19:00 +0000, Chuck Lever III wrote:
>>> On Dec 13, 2022, at 1:08 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> If v4 READDIR operation hits a mountpoint and gets back an error,
>>> then it will include that entry in the reply and set RDATTR_ERROR for it
>>> to the error.
>>>
>>> That's fine for "normal" exported filesystems, but on the v4root, we
>>> need to be more careful to only expose the existence of dentries that
>>> lead to exports.
>>>
>>> If the mountd upcall times out while checking to see whether a
>>> mountpoint on the v4root is exported, then we have no recourse other
>>> than to fail the whole operation.
>> Thank you for chasing this down!
>>
>> Failing the whole READDIR when mountd times out might be a bad idea.
>> If the mountd upcall times out every time, the client can't make
>> any progress and will continue to emit the failing READDIR request.
>>
>> Would it be better to skip the unresolvable entry instead and let
>> the READDIR succeed without that entry?
>>
> Mounting doesn't usually require working READDIR. In that situation, a
> readdir() might hang (until the client kills), but a lookup of other
> dentries that aren't perpetually stalled should be ok in this situation.
>
> If mountd is that hosed then I think it's unlikely that any progress
> will be possible anyway.

The READDIR shouldn't trigger a mount yes, but if it's a valid automount

point (basically a valid dentry in this case I think) it should be listed.

It certainly shouldn't hold up the READDIR, passing into it is when a

mount should occur.


That's usually the behavior we want for automounts, we don't want mount

storms on directories full of automount points.


Ian

