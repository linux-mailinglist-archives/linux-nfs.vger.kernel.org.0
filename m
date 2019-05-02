Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0392011944
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2019 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEBMof (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 May 2019 08:44:35 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34198 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfEBMof (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 May 2019 08:44:35 -0400
Received: by mail-vk1-f196.google.com with SMTP id r68so497163vkf.1
        for <linux-nfs@vger.kernel.org>; Thu, 02 May 2019 05:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSMOuhcl4qZ6qtmXXdBgJGlG4iPHHj9Zd7PRNU6RoTM=;
        b=SHgProuDp2jOkJAii43CC2TiiSAA0Ke+Yoix//WcDF9BNbrmMr3ZkI2gvJhFmeXMYQ
         /eaIcKeXu0tqEWCYKrOA1vQ1+X8YJpu6htL09gK6frnLgFWyKc8OIoC2ytO3M6qbYGYR
         7uNceAgXNpSavphag9K886ZEBZ27KahUy/0lW+sQY4YCI7iTSQKmHsb6+HGkHZzFJ96G
         1DEpmmBcUGPm2jkAgwl22FGBhYzqxEpLkh+ePLgVJyphxJQCqETJmUFia/nIFmL6qMaq
         MIPFp42JlyUraH9xJ1dc7puUFCwBmQ8kzRyob2gUmRYm1rffYhg3anZXh8iRMJwT3UtL
         U9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSMOuhcl4qZ6qtmXXdBgJGlG4iPHHj9Zd7PRNU6RoTM=;
        b=j6vxQw6d2y0w1tCHxjYMdqBcTybCgCf6c5cW7ZKdCW2DbmQ1CScPH77ihjDOa5gSLe
         ijAYjXUlBr/r0FUFgUbhf+yGACNYfHG5G2RaEjEytg4ewFUXt7Rm/KG5coMxkYgRxI2g
         L2G0N2NhUzHjunHRZjoxwxpBMjkc2DVkpmp+YPMU8C0npPUiIJ4CyhA+UPSf2hEsx7kT
         2yw7PNiZoxJrsUOA7iFcf9CcaWJxe5KC/QSS7xFQyznVaqaMWT62LpO8cJ831ITqPqs7
         kK/qM8+z4ZCRKYzui8u0Sh9tv2w21wRcOJmyPVAFrDWmUfxRPYRnvjfnKT1u4s5DEwqv
         ZXFg==
X-Gm-Message-State: APjAAAVdYwhyqAGXn+uP6cmS2xrJ2Oevg2jYJ1JaFOyAZaLGWRLmIVCC
        57pxmjNXNfvHj7rSgZvSXWmr54JKETepmFEHiA0lYQ==
X-Google-Smtp-Source: APXvYqzERNCrav0CDD238i+V21m9BYSjbBMuQ3E3qq5SsDtItkxmwmKvM+1bSXc7dGcUmhCOJuIVL8BqxLm8x8ZRuiY=
X-Received: by 2002:a1f:8dcc:: with SMTP id p195mr1610371vkd.31.1556800914897;
 Thu, 02 May 2019 05:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyG+ueNJapc-JGRsi=Tr5rKY6QxrHrouWgVo=6j8p5BeAA@mail.gmail.com>
 <f0a414683132a3084e6bce1da7c0d6b5bcd80fe6.camel@hammerspace.com>
In-Reply-To: <f0a414683132a3084e6bce1da7c0d6b5bcd80fe6.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 2 May 2019 08:41:43 -0400
Message-ID: <CAN-5tyGnvVV_o8vVyBSMY4uiQiNFhWn8oqBMb=61fCrtzqkqXg@mail.gmail.com>
Subject: Re: question about pnfs logic
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 1, 2019 at 7:10 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Hi Olga,
>
> On Tue, 2019-04-30 at 17:25 -0400, Olga Kornievskaia wrote:
> > Hi Trond,
> >
> > I'm trying to figure existing code in order to fix a problem. Can you
> > please help?
> >
> > Say there was an IO to the DS and it timeouts. Pnfs code in the
> > filelayout_async_handle_error() marks the device unavailable and
> > marks
> > the layout to be returned. Timed out IO is retried against the MDS.
> > The new IO tries to do the pnfs and because the device is marked
> > unavailable (returning EINVAL) it propagates back all the way to the
> > pg_init setup and fails the IO with EINVAL. But IO shouldn't fail.
> >
> > My question is why are we returning the status of the
> > filelayout_check_deviceid(), I propose that instead we at that point
> > set lseg=NULL and then the IO would be redirected to the MDS.
> >
> > Or maybe I'm missing something else?
> >
> > My proposed fix would be:
> > diff --git a/fs/nfs/filelayout/filelayout.c
> > b/fs/nfs/filelayout/filelayout.c
> > index 61f46facb39c..b3e8ba3bd654 100644
> > --- a/fs/nfs/filelayout/filelayout.c
> > +++ b/fs/nfs/filelayout/filelayout.c
> > @@ -904,7 +904,7 @@ fl_pnfs_update_layout(struct inode *ino,
> >         status = filelayout_check_deviceid(lo, fl, gfp_flags);
> >         if (status) {
> >                 pnfs_put_lseg(lseg);
> > -               lseg = ERR_PTR(status);
> > +               lseg = NULL;
> >         }
> >  out:
> >         return lseg;
>
> I fully agree with your assessment. The objective of the code there
> should indeed be to fall back to doing I/O through the MDS rather than
> failing it altogether.
>
> Given that the 5.2 merge window is likely to open next week, and that
> we haven't seen any urgent reports of this bug before now, I suggest
> that you add the signed-off-by line to the above patch and send it to
> Anna for inclusion in that tree.
> Please also add a 'Fixes:' line so that the patch can be automatically
> backported to older kernel.

Thanks Trond for the confirmation. I'll do this as soon as I'll chase
down one more element that I can't explain in this failing scenario.

>
> Cheers
>   Trond
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
