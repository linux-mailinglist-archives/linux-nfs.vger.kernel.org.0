Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C504F812F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiDGOCv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 10:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343881AbiDGOCt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 10:02:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD831A0BD3
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 07:00:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so3773301wme.0
        for <linux-nfs@vger.kernel.org>; Thu, 07 Apr 2022 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PstgRJqpTI5AJmD3QhJu2nbGpxUTttGAX4fZFszw8tE=;
        b=qrNIzSYFO8Ah7PSUoFIGX1mpzZE3zqPUTi0Iggy5Ks23cclsUnppR/xr9EcfyhOsFQ
         D7Sq3vaWJkoNvsjd+P+Q3y0be2NaHRKjeJuMfBriETVr4jP7+6Moim67dW7x3pJOe2Oc
         cx2nuwHD0lj4DeXe/QbtU7ZaUxXotudErDGFVVnxgRmSmXluWHpiibxRmHkjPXoka9+F
         CnIcaAPOuHq9q5lw5HGPDAvczr4/NkGWKdA94n6TMewI90XBbwYYPy0XwWI0iLV/dHe1
         TG6sjKUSzQXlxnPjuXE5BynxORw5EY4PGkWGgo9oh3MII/iKOXtHhVc0ZF/NxA0g9hFM
         PNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PstgRJqpTI5AJmD3QhJu2nbGpxUTttGAX4fZFszw8tE=;
        b=rzfDfhUz4dGEI0clhyZvYzwwCASjXbpAt+7AsIYqigHRTo+gvVpGDQ7eItpof+64dI
         AfO300Fgg5A7ThFYJz10a92MSaIxlDKWD/fuP0zsm9TgIqlkvTrN5QiO5Ya1yoh8u3N0
         DB2zW94rDGS5J8vcTVXcoOfhhXFFDhCkHcpvunctA3NmTfTA2k+7EuXdL9nUbX6nvdKx
         62kyVR8EYtm2vPSkiM1NQss4CXOGUjI0ub5N6AGP8s2WByPu0ffJQUgkUAjmdlFUD/eK
         JdZ4LRPJUY5+eoU+VHkhmgOMqbt4z0UCWrx+cr/S/bwriCORv9huvyh4yXrOI8fd0aq1
         recg==
X-Gm-Message-State: AOAM533mS+gGKi1zIHco3ptA5i5MSk15RWgFwcf+Lbf69JNVEvOBI4Lz
        XuwpMFOu3eRPRU6e4XMTN/X4zvFZGuRMB365Dp8Oo3l9
X-Google-Smtp-Source: ABdhPJx04ljIipl4dC6DIa2XZotFY1vrVbT804mEKNXGrfKJZFJBSkVu1xXoKDdOdLF2Bkq4u69rqcj2fcST1jwffcg=
X-Received: by 2002:a05:600c:3d0f:b0:38e:6bbc:6a7c with SMTP id
 bh15-20020a05600c3d0f00b0038e6bbc6a7cmr12610088wmb.23.1649340047134; Thu, 07
 Apr 2022 07:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220406142541.eouf7ryfbd7aooye@basti-XPS-13-9310>
 <23f11c6151f9bbfbb09d2699f4388d4a09a87127.camel@hammerspace.com>
 <164929188775.10985.17822469281433754130@noble.neil.brown.name> <CAMZfGtUKmTS51G+SGSLCyCXsae-Z7OD2yo35G7FD5UD9rewerw@mail.gmail.com>
In-Reply-To: <CAMZfGtUKmTS51G+SGSLCyCXsae-Z7OD2yo35G7FD5UD9rewerw@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 7 Apr 2022 10:00:30 -0400
Message-ID: <CAFX2Jf=ze2QcUeRMkWi8imFhmQY816z9dOhEpT8O-dA7Gx7y-Q@mail.gmail.com>
Subject: Re: Possible NFS4 regression on 5.18-rc1
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I started seeing the same problem when I rebased on rc1, and the
suggested patch fixes it for me.

Anna

On Wed, Apr 6, 2022 at 11:23 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, Apr 7, 2022 at 8:38 AM NeilBrown <neilb@suse.de> wrote:
> >
> > On Thu, 07 Apr 2022, Trond Myklebust wrote:
> > > On Wed, 2022-04-06 at 16:25 +0200, Sebastian Fricke wrote:
> > > > [You don't often get email from sebastian.fricke@collabora.com. Learn
> > > > why this is important at
> > > > http://aka.ms/LearnAboutSenderIdentification.]
> > > >
> > > > Hello folks,
> > > >
> > > > I am currently developing a V4L2 driver with support on GStreamer,
> > > > for
> > > > that purpose I am mounting the GStreamer repository via NFS from my
> > > > development machine to the target ARM64 hardware.
> > > >
> > > > I just switched to the latest kernel and got a sudden hang up of my
> > > > system.
> > > > What I did was a rebase of the GStreamer repository and then I wanted
> > > > to
> > > > build it with ninja on the target, this failed with a segmentation
> > > > fault:
> > > > ```
> > > > gstreamer| Configuring libgstreamer-1.0.so.0.2100.0-gdb.py using
> > > > configurat=
> > > > ion
> > > > Segmentation fault
> > ....
> >
> > > > [ 4595.209552] pc : list_lru_add+0xd4/0x180
> > > > [ 4595.209907] lr : list_lru_add+0x15c/0x180
> >
> > This is almost certainly fixed by the patch at
> >
> > https://lore.kernel.org/all/164876616694.25542.14010655277238655246@noble.neil.brown.name/
> >
> > which almost landed in -mm, but didn't quite.
> >
> > The subsequent email
> >
> > https://lore.kernel.org/all/CAMZfGtUMyag7MHxmg7E1_xmyZ7NDPt62e-qXbqa8nJHFC72=3w@mail.gmail.com/
> >
> > suggests a one-line change.
> >
> > Trond: maybe you could queue this?
> >
> Hi NeilBrown,
>
> The complete patch could be found here. Please
> queue this one.
>
> [1] https://lore.kernel.org/all/20220401025905.49771-1-songmuchun@bytedance.com/
>
> Thanks.
