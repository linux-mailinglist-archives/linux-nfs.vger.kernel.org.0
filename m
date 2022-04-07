Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E114F83FA
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 17:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiDGPsz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345108AbiDGPsw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 11:48:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9310AC12D8
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 08:46:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:b:203:2277:ba57:a2c0:3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 372511F467DA;
        Thu,  7 Apr 2022 16:46:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649346409;
        bh=eieaB43f4SIW0IvUmDbS/q+mzXtfuK462LMTnxyuBDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3zlMOBXakfUIs9OKDztU55KiUbd+8PgAcINgnDnnafhiERJGmX+jVGKXKjOVl10w
         wJ3rLMybkt1bmkjLMSKLLaG7o8tYOFV1jx4akknjQNYDTtksHyW4s4zAsBhYR9ZzbF
         ka1uTCGJnr1umd91P61gWp7D//f1heWXBZRvLl86Ui+rL4Lq3PJh/3Ar6TGJix9t42
         qEsm2TCjIZ3B8y1f4+ikcp9BJFzWQaZRt7JwGEbyi2x5YFmXXss6p7srFDEL5wiYKB
         Yd3vzbWnpUNNBashfGBQcNj96Nx6jBb5vADWnlGTMAKSWpIq6x2hsbF7u4v6fo9jsL
         O46pRYPx5ZN1A==
Date:   Thu, 7 Apr 2022 17:46:45 +0200
From:   "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Possible NFS4 regression on 5.18-rc1
Message-ID: <20220407154645.fhnog3fvubfgeglr@basti-XPS-13-9310>
References: <20220406142541.eouf7ryfbd7aooye@basti-XPS-13-9310>
 <23f11c6151f9bbfbb09d2699f4388d4a09a87127.camel@hammerspace.com>
 <164929188775.10985.17822469281433754130@noble.neil.brown.name>
 <CAMZfGtUKmTS51G+SGSLCyCXsae-Z7OD2yo35G7FD5UD9rewerw@mail.gmail.com>
 <CAFX2Jf=ze2QcUeRMkWi8imFhmQY816z9dOhEpT8O-dA7Gx7y-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFX2Jf=ze2QcUeRMkWi8imFhmQY816z9dOhEpT8O-dA7Gx7y-Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Ann, Trond, Neil & Muchun,

On 07.04.2022 10:00, Anna Schumaker wrote:
>I started seeing the same problem when I rebased on rc1, and the
>suggested patch fixes it for me.

Thanks, yes that patch fixes the problem for me as well.

>
>Anna

Greetings,
Sebastian
>
>On Wed, Apr 6, 2022 at 11:23 PM Muchun Song <songmuchun@bytedance.com> wrote:
>>
>> On Thu, Apr 7, 2022 at 8:38 AM NeilBrown <neilb@suse.de> wrote:
>> >
>> > On Thu, 07 Apr 2022, Trond Myklebust wrote:
>> > > On Wed, 2022-04-06 at 16:25 +0200, Sebastian Fricke wrote:
>> > > > [You don't often get email from sebastian.fricke@collabora.com. Learn
>> > > > why this is important at
>> > > > http://aka.ms/LearnAboutSenderIdentification.]
>> > > >
>> > > > Hello folks,
>> > > >
>> > > > I am currently developing a V4L2 driver with support on GStreamer,
>> > > > for
>> > > > that purpose I am mounting the GStreamer repository via NFS from my
>> > > > development machine to the target ARM64 hardware.
>> > > >
>> > > > I just switched to the latest kernel and got a sudden hang up of my
>> > > > system.
>> > > > What I did was a rebase of the GStreamer repository and then I wanted
>> > > > to
>> > > > build it with ninja on the target, this failed with a segmentation
>> > > > fault:
>> > > > ```
>> > > > gstreamer| Configuring libgstreamer-1.0.so.0.2100.0-gdb.py using
>> > > > configurat=
>> > > > ion
>> > > > Segmentation fault
>> > ....
>> >
>> > > > [ 4595.209552] pc : list_lru_add+0xd4/0x180
>> > > > [ 4595.209907] lr : list_lru_add+0x15c/0x180
>> >
>> > This is almost certainly fixed by the patch at
>> >
>> > https://lore.kernel.org/all/164876616694.25542.14010655277238655246@noble.neil.brown.name/
>> >
>> > which almost landed in -mm, but didn't quite.
>> >
>> > The subsequent email
>> >
>> > https://lore.kernel.org/all/CAMZfGtUMyag7MHxmg7E1_xmyZ7NDPt62e-qXbqa8nJHFC72=3w@mail.gmail.com/
>> >
>> > suggests a one-line change.
>> >
>> > Trond: maybe you could queue this?
>> >
>> Hi NeilBrown,
>>
>> The complete patch could be found here. Please
>> queue this one.
>>
>> [1] https://lore.kernel.org/all/20220401025905.49771-1-songmuchun@bytedance.com/
>>
>> Thanks.
