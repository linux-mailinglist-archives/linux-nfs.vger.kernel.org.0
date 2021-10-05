Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D84228E8
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhJENyy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 09:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235476AbhJENxt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 09:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633441918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Sq+vV3R3P7TQ0AM4JCbd3k08zMbakaHsPP7Xk3nGbs=;
        b=glChNxZ2PKNPXbE268FadtyNhZdppffwkkV5iL0c7yQFCzvAM1KlSkEybOLK9zugnyqGZY
        b7lWhQe2eGureJm9VLOWNFtqsecd/YWzW6P/WXYfLIoYoUZlG3NwYz7y9zek3N/JFyuBo0
        /rNIl8Q/gPz52q6VrsO29FPn7piDGwM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-pKeyjEY1NOSsiqedh5Kj_A-1; Tue, 05 Oct 2021 09:51:57 -0400
X-MC-Unique: pKeyjEY1NOSsiqedh5Kj_A-1
Received: by mail-ed1-f71.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso6162290edn.4
        for <linux-nfs@vger.kernel.org>; Tue, 05 Oct 2021 06:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Sq+vV3R3P7TQ0AM4JCbd3k08zMbakaHsPP7Xk3nGbs=;
        b=3GpY+Ul1Kyk/zFM1+fDTv9SF9Wv4GQxmFFpO210rGZlvPn8NBj9kSLU5cvBBNyGKGs
         e249cmAJEpEyEhfIQa8KUZpyrXsx7T/pUQfnHLqlrk/dq6ovnsSsxmwrKCZOZ83PXu/k
         h2r9hlWpewFEC5YguvLx1NZ6cs9GwXrzI8x/XL7PNkY43QKdSdNjcfcKLkgw4G/IRFR/
         jUK4scDu2k1YYfxUvoxyvzPetfYBFZ/54K85U8HKXf+XMZSTTgeKjQBuZ5HkKYRSkATV
         wCphjXKEscVzB5FJZhBkUdKgy6VIGGddgNa4KFdZ6PEXJPdotGoGcjz/J39oQ19lXiLP
         rvmw==
X-Gm-Message-State: AOAM533/gWNGU8gc6Zu20hdixgHUhvYlnQpni6PMLMQf7QrUXELRd3xB
        8A0eT13AseRyiSROkc2WxBcdeRetdzLWqI3vblA/oJ89ziZeGWKZ3J9dp8xgBIURQ3lvnpt3ryH
        YizpEvFaH8+i95DaTbbPnO8HjKHyfDQIyjmL4
X-Received: by 2002:a17:906:5e17:: with SMTP id n23mr22244009eju.258.1633441915960;
        Tue, 05 Oct 2021 06:51:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL6wEA9YAWMunwkkS/VUTXjx+I2mT9GQRM0DPKN/EeeZlMmwcjfLRDyQFDf4hyyBsldiJXbt5FEDnfKDYHMbw=
X-Received: by 2002:a17:906:5e17:: with SMTP id n23mr22243984eju.258.1633441915769;
 Tue, 05 Oct 2021 06:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <1633288958-8481-1-git-send-email-dwysocha@redhat.com>
 <1633288958-8481-8-git-send-email-dwysocha@redhat.com> <5fe74c4fb9d54c775c07d0f94d0ea187f72e15fe.camel@hammerspace.com>
In-Reply-To: <5fe74c4fb9d54c775c07d0f94d0ea187f72e15fe.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 5 Oct 2021 09:51:18 -0400
Message-ID: <CALF+zOk=KNmBZ4MoW+Gas0JMvVRJJaQRbBRfnW-sm3NVnekygg@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] NFS: Remove remaining usages of NFSDBG_FSCACHE
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 4, 2021 at 11:57 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Sun, 2021-10-03 at 15:22 -0400, Dave Wysochanski wrote:
> > The NFS fscache interface has removed all dfprintks so remove the
> > NFSDBG_FSCACHE defines.
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  fs/nfs/fscache-index.c      | 2 --
> >  fs/nfs/fscache.c            | 2 --
> >  include/uapi/linux/nfs_fs.h | 2 +-
> >  3 files changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
> > index 4bd5ce736193..71bb4270641f 100644
> > --- a/fs/nfs/fscache-index.c
> > +++ b/fs/nfs/fscache-index.c
> > @@ -17,8 +17,6 @@
> >  #include "internal.h"
> >  #include "fscache.h"
> >
> > -#define NFSDBG_FACILITY                NFSDBG_FSCACHE
> > -
> >  /*
> >   * Define the NFS filesystem for FS-Cache.  Upon registration FS-
> > Cache sticks
> >   * the cookie for the top-level index object for NFS into here.  The
> > top-level
> > diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> > index d199ee103dc6..016e6cb13d28 100644
> > --- a/fs/nfs/fscache.c
> > +++ b/fs/nfs/fscache.c
> > @@ -21,8 +21,6 @@
> >  #include "fscache.h"
> >  #include "nfstrace.h"
> >
> > -#define NFSDBG_FACILITY                NFSDBG_FSCACHE
> > -
> >  static struct rb_root nfs_fscache_keys = RB_ROOT;
> >  static DEFINE_SPINLOCK(nfs_fscache_keys_lock);
> >
> > diff --git a/include/uapi/linux/nfs_fs.h
> > b/include/uapi/linux/nfs_fs.h
> > index 3afe3767c55d..caa8d2234958 100644
> > --- a/include/uapi/linux/nfs_fs.h
> > +++ b/include/uapi/linux/nfs_fs.h
> > @@ -52,7 +52,7 @@
> >  #define NFSDBG_CALLBACK                0x0100
> >  #define NFSDBG_CLIENT          0x0200
> >  #define NFSDBG_MOUNT           0x0400
> > -#define NFSDBG_FSCACHE         0x0800
> > +#define NFSDBG_UNUSED          0x0800 /* unused; was FSCACHE */
>
> Please leave the name and value unchanged. I'm fine with adding the
> comment telling people not to bother using it, but this is supposed to
> be part of a user API so it can't be modified unless we're absolutely
> certain it isn't being used by anyone.
>
Ok I will post a v2 and leave NFSDBG_FSCACHE defined for now but add
the comment.  But once there's no more usages in the kernel, I'm not sure
what the proper way to deprecate and remove it would be though.

I can post a nfs-utils patch to deprecate (or remove) the usage of fscache
in rpcdebug too. What's the proper way to deprecate and remove rpcdebug
flags, or is there some reason we don't ever want to do it?


> The other changes are fine.
>
Thanks for the review.

