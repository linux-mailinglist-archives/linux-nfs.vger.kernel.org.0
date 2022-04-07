Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95CF4F71A9
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 03:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbiDGBpH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 21:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241490AbiDGBl5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 21:41:57 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D72179BD
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 18:33:27 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w134so7077814ybe.10
        for <linux-nfs@vger.kernel.org>; Wed, 06 Apr 2022 18:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTHjpcwhhVO92ZOTpQbW467iF+ZpHNJTG966ZwvBdA8=;
        b=gV2yhy61chyrCdw6VDXeVi4fUIBJECwaEMTVBgzd6mXnI3xUgUj5PBOiJ2AqyewqOC
         xbr7fSulnK+4kim9O3I/wRQuURGPaLpNOc7JrC00QLowmPIWcaQbWCo+G9VlU969HNSP
         05aVmDAJVvZByZ7eH6s+vydMKlkO6JRvBejUahucBarKDi76urcJ5chB7D/Uop1JOMNt
         egsWHM6x2m7KdaC2SpV+MgBBK69fM0sprwjeYZXf0g1lpY4e+8XwCmTgGe363NmGILbV
         dU5Lpfd8iyX5YjvX0rZ6p7yHtrTbReNtk9Cm6T1U5jx/eda9mXqDSzqZ769RJk/VKqj5
         zRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTHjpcwhhVO92ZOTpQbW467iF+ZpHNJTG966ZwvBdA8=;
        b=me3rChu5EsLZEYbiJtwnitqmPX9/WnwBRQlLDK9I9X9HxNwzeQQ+vYpguksdqDq50d
         OM4Hcv+6NON5kMSiZzaYVKrEa4clli2ZhTV8OcR7MtXpYoLv/DSAzYPAlhHTZYpJs+6A
         hkNODw1Pw5Yj0rm2/bH+hVUUsC1Rf6c5skT+Oma6G6hE2jTd4HTJdboVDeOON9k86Zub
         ZlibKABHgSXQunNXfb9vb/4+bOYt+JKVDfMx600WzrnZ00QUTQ5BAG9Jbl63MVRPOMqN
         jQ+gzGddX2/k2AtLP0HUd9hZgK2d4QUTv+ijLkl0P/CQOFk3VB6jr2KbWs4BssTj5COj
         a3qQ==
X-Gm-Message-State: AOAM531nAxYG8LOgEuZuKeIzqRlJjxeBHUprRoigVZ3ZoEeBL8bQUcFw
        fI+XOVb13tEiniiVykPx9XClGFYV/VKnvllKbBfy9ZMRgX7jRQ==
X-Google-Smtp-Source: ABdhPJz1ffgonB0lX7guxLRq5TXVt7qiDifdKZCiiOeU9EsmRs9iitvUGjdpva/ND+eisxtWqlmTgDfJXBgzcJSdFgY=
X-Received: by 2002:a25:cc92:0:b0:63d:b330:e8a4 with SMTP id
 l140-20020a25cc92000000b0063db330e8a4mr8255501ybf.427.1649295206223; Wed, 06
 Apr 2022 18:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220406142541.eouf7ryfbd7aooye@basti-XPS-13-9310>
 <23f11c6151f9bbfbb09d2699f4388d4a09a87127.camel@hammerspace.com> <164929188775.10985.17822469281433754130@noble.neil.brown.name>
In-Reply-To: <164929188775.10985.17822469281433754130@noble.neil.brown.name>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Apr 2022 09:32:50 +0800
Message-ID: <CAMZfGtUKmTS51G+SGSLCyCXsae-Z7OD2yo35G7FD5UD9rewerw@mail.gmail.com>
Subject: Re: Possible NFS4 regression on 5.18-rc1
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 7, 2022 at 8:38 AM NeilBrown <neilb@suse.de> wrote:
>
> On Thu, 07 Apr 2022, Trond Myklebust wrote:
> > On Wed, 2022-04-06 at 16:25 +0200, Sebastian Fricke wrote:
> > > [You don't often get email from sebastian.fricke@collabora.com. Learn
> > > why this is important at
> > > http://aka.ms/LearnAboutSenderIdentification.]
> > >
> > > Hello folks,
> > >
> > > I am currently developing a V4L2 driver with support on GStreamer,
> > > for
> > > that purpose I am mounting the GStreamer repository via NFS from my
> > > development machine to the target ARM64 hardware.
> > >
> > > I just switched to the latest kernel and got a sudden hang up of my
> > > system.
> > > What I did was a rebase of the GStreamer repository and then I wanted
> > > to
> > > build it with ninja on the target, this failed with a segmentation
> > > fault:
> > > ```
> > > gstreamer| Configuring libgstreamer-1.0.so.0.2100.0-gdb.py using
> > > configurat=
> > > ion
> > > Segmentation fault
> ....
>
> > > [ 4595.209552] pc : list_lru_add+0xd4/0x180
> > > [ 4595.209907] lr : list_lru_add+0x15c/0x180
>
> This is almost certainly fixed by the patch at
>
> https://lore.kernel.org/all/164876616694.25542.14010655277238655246@noble.neil.brown.name/
>
> which almost landed in -mm, but didn't quite.
>
> The subsequent email
>
> https://lore.kernel.org/all/CAMZfGtUMyag7MHxmg7E1_xmyZ7NDPt62e-qXbqa8nJHFC72=3w@mail.gmail.com/
>
> suggests a one-line change.
>
> Trond: maybe you could queue this?
>
Hi NeilBrown,

The complete patch could be found here. Please
queue this one.

[1] https://lore.kernel.org/all/20220401025905.49771-1-songmuchun@bytedance.com/

Thanks.
