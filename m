Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7313A3B6968
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhF1UD7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 16:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237180AbhF1UD4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 16:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624910488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FCnFFtHeXQ/6Oorr9CoocD0lcQHZWj2Cpb8HGWqaYr4=;
        b=Zmhobbd/VbDlASgBoQbxGMpj+Yrs87qhnW+dmSe5tb/zOfp7tIl5eKvbgGthATFDoULAFF
        YoGsBbiyuoqbCdbcmtY6uZrQsh77V8XKJlJobM3rOUq3yGcU7R1TuOZOd/Is0Ijx4Xgg6r
        4xbcAlc0OV84LjVPG0xmYmjTZaupJ6o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-Y95p-083MfWI5DT46WUfeQ-1; Mon, 28 Jun 2021 16:01:26 -0400
X-MC-Unique: Y95p-083MfWI5DT46WUfeQ-1
Received: by mail-ed1-f70.google.com with SMTP id w1-20020a0564022681b0290394cedd8a6aso10200622edd.14
        for <linux-nfs@vger.kernel.org>; Mon, 28 Jun 2021 13:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCnFFtHeXQ/6Oorr9CoocD0lcQHZWj2Cpb8HGWqaYr4=;
        b=ZyvBU0od0jLN6UtN5i9d3yWelXUoYnHlTbPj2V+SjwZ3HjhOFqTHIGXo0RuCqFfrzP
         pT77MuAOIgawHvjwR2n3KF9D5DCRejU3uSl1bIOvVUvE1tURa++4iLJ6Dl7DhdNXEbd6
         l7sAHVDZ6s1Q9VHQWowyDDT+hNusR5pQ0hAECn5prxgtHPlB1Ms6zHhTIXZqYHdr81vx
         AxVBqpOmUk31dcfCTs+Q5p/aON3bQoekJqdvBznL1y64EIElS5ulLzDOWehKIrDdGvjG
         KxeM78J/q/Br6TqUy966rci7fPMrcMiL/52g+19DMXu/BujGjLZQN4oLzjaKzrcznLp+
         XCnQ==
X-Gm-Message-State: AOAM533hQVJ3udz8uXjT3G1IteTLfddmayK7a6S35o4BAmOJf40XRnyC
        9fYpvfDlLLHPp1lq2H1SeBI04dxLWj9FOT2OJVR7tcPZU/AcENRaJV63FZxLUdVNb6WYv0KAsre
        PpdxyHAm3hpPlVhhNPU8O6qp3vFxqNNu3q4P5
X-Received: by 2002:a17:906:1681:: with SMTP id s1mr25879828ejd.321.1624910485529;
        Mon, 28 Jun 2021 13:01:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLEtCdVhS1qq8I5EujU0l6Apouf5TIXKj20uuluQbsjlO0LT+tQwW1alrxdvHm1uJkAyoedEzR/J5Sd0FcBQg=
X-Received: by 2002:a17:906:1681:: with SMTP id s1mr25879803ejd.321.1624910485333;
 Mon, 28 Jun 2021 13:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
 <1624901943-20027-3-git-send-email-dwysocha@redhat.com> <2561b4f973e14eba413f648b657a7945830af202.camel@hammerspace.com>
In-Reply-To: <2561b4f973e14eba413f648b657a7945830af202.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 28 Jun 2021 16:00:48 -0400
Message-ID: <CALF+zOn7jTduKYRX_fpNjV+qRat+4qqocVLa=dMfQeUU+RmVaw@mail.gmail.com>
Subject: Re: [PATCH 2/4] NFS: Ensure nfs_readpage returns promptly when
 internal error occurs
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 28, 2021 at 3:17 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2021-06-28 at 13:39 -0400, Dave Wysochanski wrote:
> > A previous refactoring of nfs_readpage() might end up calling
> > wait_on_page_locked_killable() even if readpage_async_filler() failed
> > with an internal error and pg_error was non-zero (for example, if
> > nfs_create_request() failed).  In the case of an internal error,
> > skip over wait_on_page_locked_killable() as this is only needed
> > when the read is sent and an error occurs during completion handling.
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  fs/nfs/read.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > index 684a730f6670..b0680351df23 100644
> > --- a/fs/nfs/read.c
> > +++ b/fs/nfs/read.c
> > @@ -74,7 +74,7 @@ void nfs_pageio_init_read(struct
> > nfs_pageio_descriptor *pgio,
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
> >
> > -static void nfs_pageio_complete_read(struct nfs_pageio_descriptor
> > *pgio)
> > +static int nfs_pageio_complete_read(struct nfs_pageio_descriptor
> > *pgio)
> >  {
> >         struct nfs_pgio_mirror *pgm;
> >         unsigned long npages;
> > @@ -88,6 +88,8 @@ static void nfs_pageio_complete_read(struct
> > nfs_pageio_descriptor *pgio)
> >         NFS_I(pgio->pg_inode)->read_io += pgm->pg_bytes_written;
> >         npages = (pgm->pg_bytes_written + PAGE_SIZE - 1) >>
> > PAGE_SHIFT;
> >         nfs_add_stats(pgio->pg_inode, NFSIOS_READPAGES, npages);
> > +
> > +       return pgio->pg_error < 0 ? pgio->pg_error : 0;
> >  }
> >
> >
> > @@ -373,16 +375,17 @@ int nfs_readpage(struct file *file, struct page
> > *page)
> >                              &nfs_async_read_completion_ops);
> >
> >         ret = readpage_async_filler(&desc, page);
> > +       if (ret)
> > +               goto out;
> >
> > -       if (!ret)
>
> Can't this patch basically be reduced to the above 2 changes? The rest
> appears just to be shifting code around. I'm seeing nothing in the
> remaining patches that actually depends on nfs_pageio_complete_read()
> returning a value.
>

Originally I was thinking there was a benefit to having
nfs_pageio_complete_read return a success/failure
similar to readpage_async_filler() which is why I moved
it.

You mean just this right?  If so, yes I agree this would be a minimal patch.
Want this as a v2?

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 684a730f6670..eb390eb618b3 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -373,10 +373,10 @@ int nfs_readpage(struct file *file, struct page *page)
                             &nfs_async_read_completion_ops);

        ret = readpage_async_filler(&desc, page);
+       if (ret)
+               goto out;

-       if (!ret)
-               nfs_pageio_complete_read(&desc.pgio);
-
+       nfs_pageio_complete_read(&desc.pgio);
        ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
        if (!ret) {
                ret = wait_on_page_locked_killable(page);

