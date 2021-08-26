Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B843F8F12
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbhHZTpi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 15:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243339AbhHZTph (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 15:45:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F3C061757
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 12:44:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc21so8727801ejc.7
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwwkMWIgg3nqRZp7WD+vQNNzIFPjoEf/ck/6jdBVtkQ=;
        b=XqUgaaXQpdC7CvOOK76vy+wBUTDxo8XlVCjT/kja3zkk1hgVyAvGvZ2sNnEaXfeRrC
         fYaZ+2lxnDINXSoAbSgEr0QxWjNKQXKXel39Kitd8EO4oLRovT4vjd24b5uJMZuI7gSD
         7mZjtfmMPD3JHhsgldOa0fWJ0IPUg3fHwKhIugxGmJ5k54tXVdD4kuV08JczkeeSIxhb
         93OnPQy2pe2F1Boq7EUQhZOqUodB7EGzSfmidHxIpxr7FLb+FEJt6YEeYf1jd15WyH8q
         RSlxglS60f2lmYkuuNGpOsWjw8DoDtTDKj7R0UbmSwbUSYwX4zL5PwDYtXYG6x4LUJtW
         bYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwwkMWIgg3nqRZp7WD+vQNNzIFPjoEf/ck/6jdBVtkQ=;
        b=VN2krHopxQtipXkosBu2cMsyaFwORMreOA7KtBhY6ywWILpTDitdvYCe6n+k7ArMnt
         U1rfQ3YcIX0q14Z1i2Qw15/KrlxMBKFt/px0brUPUkXK1PS75oT7us8BrBaA+ZZ3Ln6c
         TivzUtIo2Bj1ijgBl7fftqNazQI6povCz1XB/OzUIq545nMzI6mWrBDYMg3Th1xt9FOQ
         YqYTB6YJ23RU2ZAqTCZW0o/dlXm/laZoTI8D1ZG+b3RbbabM20WpYH1qfzExJkcxkfl3
         hKAHUQshnqtEdRIxVLqH4Td7tJu3lZZhPfy9lgOB/99VdbLJRPi2f71TfuuHv8Bx/WXZ
         eL5A==
X-Gm-Message-State: AOAM531aG1fMiRd0vK7AaLhm1uBZOUkdvuIWypBy3hHFn0NyMrVKWS0k
        njBVs4wXvQfeTHQC1JQT8UPOZVoW9KCs8GpSl7VF/8yV4Ho=
X-Google-Smtp-Source: ABdhPJy49YYfxHmhtwSerH7HoVjS2jmcK7Bjtk6ZC39erq7ndMVRIC/q43vrZg0il5fq+6ZGune1C7hAPBizPFIwe34=
X-Received: by 2002:a17:906:9be4:: with SMTP id de36mr5829145ejc.436.1630007088261;
 Thu, 26 Aug 2021 12:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210609210729.254578-1-Anna.Schumaker@Netapp.com>
 <20210614231440.GD16500@fieldses.org> <20210812203248.GA907@fieldses.org>
In-Reply-To: <20210812203248.GA907@fieldses.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 26 Aug 2021 15:44:32 -0400
Message-ID: <CAFX2Jf=b1JwPRaC35rKbX5bD821h1dsEj6opYW9eZET171Zd6A@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: Avoid a KASAN slab-out-of-bounds bug in xdr_set_page_base()
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <Trond.Myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 12, 2021 at 4:32 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jun 14, 2021 at 07:14:40PM -0400, bfields wrote:
> > On Wed, Jun 09, 2021 at 05:07:29PM -0400, schumaker.anna@gmail.com wrote:
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > This seems to happen fairly easily during READ_PLUS testing on NFS v4.2.
> >
> > Yep, I hit a KASAN warning here every time, and this fixes it,
> > thanks.--b.
>
> By the way, config NFS_V4_2_READ_PLUS still says:
>
>         This is intended for developers only. The READ_PLUS operation
>         has been shown to have issues under specific conditions and
>         should not be used in production.
>
> But this warning was the only thing I was seeing.  Is there another
> known issue remaining?

I think it was an issue around using lseek to generate the reply. The
file contents could change between each call, leading to inconsistent
results (and a new failing xfstest that previously passed)

Anna

>
> --b.
>
> >
> > > I found that we could end up accessing xdr->buf->pages[pgnr] with a pgnr
> > > greater than the number of pages in the array. So let's just return
> > > early if we're setting base to a point at the end of the page data and
> > > let xdr_set_tail_base() handle setting up the buffer pointers instead.
> > >
> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > ---
> > >  net/sunrpc/xdr.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > > index 3964ff74ee51..ca10ba2626f2 100644
> > > --- a/net/sunrpc/xdr.c
> > > +++ b/net/sunrpc/xdr.c
> > > @@ -1230,10 +1230,9 @@ static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
> > >     void *kaddr;
> > >
> > >     maxlen = xdr->buf->page_len;
> > > -   if (base >= maxlen) {
> > > -           base = maxlen;
> > > -           maxlen = 0;
> > > -   } else
> > > +   if (base >= maxlen)
> > > +           return 0;
> > > +   else
> > >             maxlen -= base;
> > >     if (len > maxlen)
> > >             len = maxlen;
> > > --
> > > 2.32.0
